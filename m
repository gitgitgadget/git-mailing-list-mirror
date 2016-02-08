From: Jeff King <peff@peff.net>
Subject: Re: git show doesn't work on file names with square brackets
Date: Mon, 8 Feb 2016 14:52:30 -0500
Message-ID: <20160208195230.GA30693@sigill.intra.peff.net>
References: <6A7D4447-AC25-4591-9DA7-CD153198EC64@jetbrains.com>
 <alpine.DEB.2.20.1602061518220.2964@virtualbox>
 <25D155FA-6F05-425C-AB2D-7F0B44E0D1C5@jetbrains.com>
 <alpine.DEB.2.20.1602061708220.2964@virtualbox>
 <CACsJy8ChZzYWXePSwF6D8vPZMuz3dQe1=jtw6rSG7M1oC+RiNw@mail.gmail.com>
 <32B9BD70-F06C-49C4-B672-24173E69B99F@jetbrains.com>
 <CACsJy8AMEgk8UXF==VmvLXsL4R67u0+U4MiUGPtO6HX0Y30oXg@mail.gmail.com>
 <20160208141552.GC27054@sigill.intra.peff.net>
 <20160208150709.GA13664@sigill.intra.peff.net>
 <xmqqpow7807l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 20:52:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSrrR-0004kZ-Ua
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 20:52:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753938AbcBHTwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 14:52:34 -0500
Received: from cloud.peff.net ([50.56.180.127]:39406 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753198AbcBHTwd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 14:52:33 -0500
Received: (qmail 14029 invoked by uid 102); 8 Feb 2016 19:52:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 14:52:33 -0500
Received: (qmail 8546 invoked by uid 107); 8 Feb 2016 19:52:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 14:52:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Feb 2016 14:52:30 -0500
Content-Disposition: inline
In-Reply-To: <xmqqpow7807l.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285796>

On Mon, Feb 08, 2016 at 11:35:10AM -0800, Junio C Hamano wrote:

> To be bluntly honest, I do not see the current "string containing
> wildcard characters are taken as path, not rev, unless you use the
> double dash to disambiguate." all bad.  Isn't it sort of crazy to
> have square brackets in paths and if it requires clarification by
> the user, I do not particulasrly see it as a problem.
> 
> Having said that, I do not think of a big reason to say this patch
> is a wrong thing to do, either.

To be honest, I think I am more concerned with ":/reg.*ex" than
"tree:path" using meta-characters. I agree that actual metacharacters in
file names are relatively rare.

> > +static int dwim_as_wildcard(const char *arg)
> > +{
> > +	const char *p;
> > +
> > +	if (no_wildcard(arg))
> > +		return 0;
> > +	if (strstr(arg, "^{"))
> > +		return 0; /* probably "^{something}" */
> > +	if (strstr(arg, "@{"))
> > +		return 0; /* probably "ref@{something}" */
> > +
> > +	/* catch "tree:path", but not ":(magic)" */
> > +	p = strchr(arg, ':');
> > +	if (p && p[1] != '(')
> > +		return 0;
> 
> You seem to reject ":(" specifically, but I am not sure whom is it
> designed to help to special case ":(".  Those who write ":(top)"
> would not have to disambiguate with "--", but their preference is to
> spell things in longhand for more explicit control, so I do not
> think they mind typing "--".  On the other hand, those who write
> ":/" and ":!" (":(top)" and ":(exclude)") would need to disambiguate
> with "--" with the change.
> 
> That somehow feels backwards.

Good point. I forgot about the short-hands, and I agree that there is
not much point in doing a sloppy match of the long-hands if we do not
cover the short-hands.

In retrospect, it is not worth trying to match magic pathspecs here at
all, as it generally requires "--" anyway. It is only ones with wildcard
which came along for the ride in 28fcc0b, and that was not the primary
focus of that patch. I.e., without my patch, we already have:

  $ git rev-list --count HEAD Makefile
  2028

  $ git rev-list --count HEAD ':(top)Makefile'
  fatal: ambiguous argument ':(top)Makefile': unknown revision or path
  not in the working tree.
  Use '--' to separate paths from revisions, like this:
  'git <command> [<revision>...] -- [<file>...]'

  $ git rev-list --count HEAD ':(top)M[a]kefile'
  2028

which is slightly ridiculous. With my patch, the final one behaves the
same as the second.

Here is my patch again, with that part removed, and the tests fixed up.
Though on reflection, I do think it would be better if we could simply
expand the wildcard globs to say "does this match anything in the file
system". That makes a nice, simple rule that follows the spirit of the
original. I'm not sure if it would be easy to apply magic like ":(top)"
there, but even if we don't, we're not worse off than we are today
(where that requires "--" unless it happens to have a wildcard, as
above).

-- >8 --
Subject: [PATCH] check_filename: tighten requirements for dwim-wildcards

Commit 28fcc0b (pathspec: avoid the need of "--" when
wildcard is used, 2015-05-02) introduced a convenience to
our dwim-parsing: when "--" is not present, we guess that
items with wildcard characters are probably pathspecs.

This makes a lot of cases simpler (e.g., "git log '*.c'"),
but makes others harder. While revision expressions do not
typically have wildcard characters in them (because they are
not valid in refnames), there are a few constructs where we
take more arbitrary strings, such as:

  - pathnames in tree:path syntax (or :0:path) for the
    index)

  - :/foo and ^{/foo} for searching commit messages;
    likewise "^{}" is extensible and may learn new formats
    in the future

  - @{foo}, which can take arbitrary approxidate text (which
    is not itself that likely to have wildcards, but @{} is
    also a potential generic extension mechanism).

When we see these constructs, they are almost certainly an
attempt at a revision, and not a pathspec; we should not
give them the magic "wildcard characters mean a pathspec"
treatment.

We can afford to be fairly slack in our parsing here. We are
not making a real decision on "this is or is not definitely
a revision" here, but rather just deciding whether or not
the extra "wildcards mean pathspecs" magic kicks in.

Note that we drop the tests in t2019 in favor of a more
complete set in t6133. t2019 was not the right place for
them (it's about refname ambiguity, not dwim parsing
ambiguity), and the second test explicitly checked for the
opposite result of the case we are fixing here (which didn't
really make any sense; as show by the test_must_fail in the
test, it would only serve to annoy people).

Signed-off-by: Jeff King <peff@peff.net>
---
 setup.c                           | 15 ++++++++++++++-
 t/t2019-checkout-ambiguous-ref.sh | 26 --------------------------
 t/t6133-pathspec-rev-dwim.sh      | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 27 deletions(-)
 create mode 100755 t/t6133-pathspec-rev-dwim.sh

diff --git a/setup.c b/setup.c
index 2c4b22c..eac1edc 100644
--- a/setup.c
+++ b/setup.c
@@ -130,6 +130,19 @@ int path_inside_repo(const char *prefix, const char *path)
 	return 0;
 }
 
+static int dwim_as_wildcard(const char *arg)
+{
+	if (no_wildcard(arg))
+		return 0;
+	if (strstr(arg, "^{"))
+		return 0; /* probably "^{something}" */
+	if (strstr(arg, "@{"))
+		return 0; /* probably "ref@{something}" */
+	if (strchr(arg, ':'))
+		return 0;
+	return 1;
+}
+
 int check_filename(const char *prefix, const char *arg)
 {
 	const char *name;
@@ -139,7 +152,7 @@ int check_filename(const char *prefix, const char *arg)
 		if (arg[2] == '\0') /* ":/" is root dir, always exists */
 			return 1;
 		name = arg + 2;
-	} else if (!no_wildcard(arg))
+	} else if (dwim_as_wildcard(arg))
 		return 1;
 	else if (prefix)
 		name = prefix_filename(prefix, strlen(prefix), arg);
diff --git a/t/t2019-checkout-ambiguous-ref.sh b/t/t2019-checkout-ambiguous-ref.sh
index 199b22d..b99d519 100755
--- a/t/t2019-checkout-ambiguous-ref.sh
+++ b/t/t2019-checkout-ambiguous-ref.sh
@@ -56,30 +56,4 @@ test_expect_success VAGUENESS_SUCCESS 'checkout reports switch to branch' '
 	test_i18ngrep ! "^HEAD is now at" stderr
 '
 
-test_expect_success 'wildcard ambiguation, paths win' '
-	git init ambi &&
-	(
-		cd ambi &&
-		echo a >a.c &&
-		git add a.c &&
-		echo b >a.c &&
-		git checkout "*.c" &&
-		echo a >expect &&
-		test_cmp expect a.c
-	)
-'
-
-test_expect_success !MINGW 'wildcard ambiguation, refs lose' '
-	git init ambi2 &&
-	(
-		cd ambi2 &&
-		echo a >"*.c" &&
-		git add . &&
-		test_must_fail git show :"*.c" &&
-		git show :"*.c" -- >actual &&
-		echo a >expect &&
-		test_cmp expect actual
-	)
-'
-
 test_done
diff --git a/t/t6133-pathspec-rev-dwim.sh b/t/t6133-pathspec-rev-dwim.sh
new file mode 100755
index 0000000..2ffebee
--- /dev/null
+++ b/t/t6133-pathspec-rev-dwim.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+test_description='test dwim of revs versus pathspecs in revision parser'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit base &&
+	echo content >"br[ack]ets" &&
+	git add . &&
+	test_tick &&
+	git commit -m brackets
+'
+
+test_expect_success 'wildcard dwims to pathspec' '
+	git log -- "*.t" >expect &&
+	git log    "*.t" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'tree:path dwims to rev' '
+	git show "HEAD:br[ack]ets" -- >expect &&
+	git show "HEAD:br[ack]ets"    >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '^{foo} dwims to rev' '
+	git log "HEAD^{/b.*}" -- >expect &&
+	git log "HEAD^{/b.*}"    >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '@{foo} dwims to rev' '
+	git log "HEAD@{now [or thereabouts]}" -- >expect &&
+	git log "HEAD@{now [or thereabouts]}"    >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.7.1.526.gd04f550
