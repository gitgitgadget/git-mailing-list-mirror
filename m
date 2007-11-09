From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] --pretty=format: on-demand format expansion
Date: Thu, 8 Nov 2007 23:50:40 -0500
Message-ID: <20071109045040.GC31760@sigill.intra.peff.net>
References: <4733AEA6.1040802@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Nov 09 05:51:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqLpe-0000H0-5t
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 05:51:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758955AbXKIEuq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2007 23:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753190AbXKIEuq
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 23:50:46 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1027 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758226AbXKIEuo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 23:50:44 -0500
Received: (qmail 20780 invoked by uid 111); 9 Nov 2007 04:50:42 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 08 Nov 2007 23:50:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2007 23:50:40 -0500
Content-Disposition: inline
In-Reply-To: <4733AEA6.1040802@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64127>

On Fri, Nov 09, 2007 at 01:49:42AM +0100, Ren=E9 Scharfe wrote:

> Another way is to use a callback based approach together with the
> strbuf library to keep allocations to a minimum and avoid string
> copies.  That's what this patch does.  It introduces a new strbuf
> function, strbuf_expand().

I think this is definitely the right approach, but there are some forma=
t
strings where the performance will be worse. Specifically:

  - formatting expensive items multiple times will incur work
    proportional to the number of times the item is used (in the old
    code, it was calculated just once).  e.g., "%h%h%h%h"

  - formatting some items goes to some work that can be re-used by othe=
r
    items (e.g., %ad and %ar both need to parse the author date)

And we could obviously overcome both by caching the results of expensiv=
e
operations.  I'm not sure if these will be a problem in practice. For
the first one, the new code is so much faster that I needed to do

  git-log --pretty=3Dformat:%h%h%h%h%h%h%h%h

to get a performance regression from the old code, which seems rather
unlikely. For the second, it is easy to imagine multiple "person" items
being used together, although their cost to produce is not all that
high. It looks like about .05 seconds to parse a date (over all commits
in git.git):

$ time ./git-log --pretty=3D'format:' >/dev/null
real    0m0.441s
user    0m0.424s
sys     0m0.004s

$ time ./git-log --pretty=3D'format:%ad' >/dev/null
real    0m0.477s
user    0m0.472s
sys     0m0.000s

$ time ./git-log --pretty=3D'format:%ad %aD' >/dev/null
real    0m0.527s
user    0m0.520s
sys     0m0.004s

where the last two could probably end up costing about the same if we c=
ached
the author parsing (but the caching will have a cost, too, so it might =
not end
up being a big win).

So it might make sense to cache some items as we figure them out. This
should be done by the calling code and not by strbuf_expand (since it
doesn't know which things are worth caching (and for fast things,
allocating memory for a cache entry is likely to be slower), or how the
expansions relate to each other).

A partial patch on top of yours is below (it caches commit and tree
abbreviations; parent abbreviations and person-parsing are probably
worth doing). Some timings:

Null format (these are average-looking runs; the differences got lost
in the noise):

# your patch
$ time git-log --pretty=3Dformat: >/dev/null
real    0m0.409s
user    0m0.384s
sys     0m0.012s

# with my patch
$ time ./git-log --pretty=3Dformat: >/dev/null
real    0m0.413s
user    0m0.404s
sys     0m0.004s

Single abbrev lookup (mine should be slightly slower because of
malloc/free of cache):

# your patch
$ time git-log --pretty=3Dformat:%h >/dev/null
real    0m0.536s
user    0m0.456s
sys     0m0.080s

# with my patch
$ time ./git-log --pretty=3Dformat:%h >/dev/null
real    0m0.553s
user    0m0.464s
sys     0m0.088s

Two abbrev lookups (I win by a little bit, but definitely not lost in
the noise):

# your patch
$ time git-log --pretty=3Dformat:%h%h >/dev/null
real    0m0.671s
user    0m0.496s
sys     0m0.144s

# my patch
$ time ./git-log  --pretty=3Dformat:%h%h >/dev/null
real    0m0.567s
user    0m0.480s
sys     0m0.080s

And of course I can make pathological cases where mine wins hands down
(on "%h%h%h%h%h%h%h%h", mine stays the same but yours bumps to 1.2s).

So I think this is probably worth doing. Even if doubled work isn't the
common case,
  1. It doesn't hurt the common case much at all (I think on average it
     is slower, but the timings were totally lost in the noise)
  2. It has a measurable impact on reasonable cases (like just using an
     expensive substitution twice)
  3. It has a huge impact on pathological cases (though I'm not sure we
     care about those that much)
  4. It's very little extra code, and it should be obvious to read. It
     also documents the technique for other users of strbuf_expand,
     where the "doubled" cases may be more common.

-Peff

---
 pretty.c |   47 ++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/pretty.c b/pretty.c
index 9fbd73f..8ae6fdd 100644
--- a/pretty.c
+++ b/pretty.c
@@ -282,6 +282,27 @@ static char *logmsg_reencode(const struct commit *=
commit,
 	return out;
 }
=20
+struct pretty_context {
+	const struct commit *commit;
+	char *abbrev_commit;
+	char *abbrev_tree;
+};
+
+static void pretty_context_init(struct pretty_context *p, const struct=
 commit *c)
+{
+	p->commit =3D c;
+	p->abbrev_commit =3D NULL;
+	p->abbrev_tree =3D NULL;
+}
+
+static void pretty_context_free(struct pretty_context *p)
+{
+	if (p->abbrev_commit)
+		free(p->abbrev_commit);
+	if (p->abbrev_tree)
+		free(p->abbrev_tree);
+}
+
 static void format_person_part(struct strbuf *sb, char part,
                                const char *msg, int len)
 {
@@ -355,9 +376,10 @@ static void format_person_part(struct strbuf *sb, =
char part,
 }
=20
 static void format_commit_item(struct strbuf *sb, const char *placehol=
der,
-                               void *context)
+                               void *vcontext)
 {
-	const struct commit *commit =3D context;
+	struct pretty_context *context =3D vcontext;
+	const struct commit *commit =3D context->commit;
 	struct commit_list *p;
 	int i;
 	enum { HEADER, SUBJECT, BODY } state;
@@ -394,15 +416,23 @@ static void format_commit_item(struct strbuf *sb,=
 const char *placeholder,
 		strbuf_addstr(sb, sha1_to_hex(commit->object.sha1));
 		return;
 	case 'h':		/* abbreviated commit hash */
-		strbuf_addstr(sb, find_unique_abbrev(commit->object.sha1,
-		                                     DEFAULT_ABBREV));
+		if (!context->abbrev_commit)
+			context->abbrev_commit =3D xstrdup(
+					find_unique_abbrev(
+						commit->object.sha1,
+						DEFAULT_ABBREV));
+		strbuf_addstr(sb, context->abbrev_commit);
 		return;
 	case 'T':		/* tree hash */
 		strbuf_addstr(sb, sha1_to_hex(commit->tree->object.sha1));
 		return;
 	case 't':		/* abbreviated tree hash */
-		strbuf_addstr(sb, find_unique_abbrev(commit->tree->object.sha1,
-		                                     DEFAULT_ABBREV));
+		if (!context->abbrev_tree)
+			context->abbrev_tree =3D xstrdup(
+					find_unique_abbrev(
+					commit->tree->object.sha1,
+					DEFAULT_ABBREV));
+		strbuf_addstr(sb, context->abbrev_tree);
 		return;
 	case 'P':		/* parent hashes */
 		for (p =3D commit->parents; p; p =3D p->next) {
@@ -505,7 +535,10 @@ void format_commit_message(const struct commit *co=
mmit,
 		"m",		/* left/right/bottom */
 		NULL
 	};
-	strbuf_expand(sb, format, placeholders, format_commit_item, (void *)c=
ommit);
+	struct pretty_context context;
+	pretty_context_init(&context, commit);
+	strbuf_expand(sb, format, placeholders, format_commit_item, &context)=
;
+	pretty_context_free(&context);
 }
=20
 static void pp_header(enum cmit_fmt fmt,
