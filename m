From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Permit refspec source side to parse as a sha1
Date: Thu, 20 Mar 2008 21:10:59 -0700
Message-ID: <7v4pb0vhrg.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0803202049090.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Samuel Tardieu <sam@rfc1149.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 05:11:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcYbf-0001sy-Oj
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 05:11:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbYCUELL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 00:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbYCUELL
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 00:11:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62583 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbYCUELK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 00:11:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1E3941F0F;
	Fri, 21 Mar 2008 00:11:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9C3031F0C; Fri, 21 Mar 2008 00:11:01 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0803202049090.19665@iabervon.org> (Daniel
 Barkalow's message of "Thu, 20 Mar 2008 20:54:54 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77704>

Daniel Barkalow <barkalow@iabervon.org> writes:

> This fixes "git push origin HEAD~1:foo". "git fetch origin HEAD~1:foo"
> will report "Couldn't find remote ref HEAD~1", while
> "git fetch origin HEAD**1:foo" reports "Invalid refspec 'HEAD**1:foo'"
>
> That is, HEAD~1 is something you're not allowed to ask the remote for, 
> while HEAD**1 doesn't mean anything.
>
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
> Note that this actually tries to look up the source side, so "git 
> fetch origin HEAD^3:foo" usually gives a wrongish error message.

This is very wrong.  When you do not have anything on your own (i.e. HEAD
points at an unborn branch), "git fetch origin HEAD:master" would barf?
We should _never_ look at the refs we have; the check is about the syntax.

Why are fetch and push refspec parsing code share the same function and
enforce exactly the same error checking to begin with?  Is it because we
are too lazy to implement two semantics that has to be different and try
to "share" code by only implementing checks for "common denominator"?

I think that is the root of the problem, because their syntax are designed
to look similar, but their semantics are different [*1*].

For a fetch refspec, LHS is the remote end and you do not even know what
refs are available over there; the _only_ thing you care about is that it
is well formed.

On the other hand, for a push refspec, LHS is the local end and _must_
name a valid commit you are pushing (unless you are pushing empty to
delete the ref).

I really think we cannot afford piling hacks on top of hacks to hide the
broken interface forever.  We have two different things to validate, and
the callers all know what they have when calling us to validate.  We
should not have a single loose validation that only catches "it cannot be
either fetch nor push refspec" breakage.

        As a side note, I have a vague recollection that we used to treat
        a refspec from the command line and a refspec from the config
        differently in some contexts, and rules applied to them might have
        been different.  I do not think of what the context was offhand,
        but we might need to further split the implementation of the
        rules.

But at least I think something like this patch would lead us in the right
direction.

---

 builtin-fetch.c |    3 +-
 remote.c        |  114 +++++++++++++++++++++++++++++++++++-------------------
 remote.h        |    3 +-
 3 files changed, 78 insertions(+), 42 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index b2b9935..a11548c 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -652,5 +652,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	signal(SIGINT, unlock_pack_on_signal);
 	atexit(unlock_pack);
-	return do_fetch(transport, parse_ref_spec(ref_nr, refs), ref_nr);
+	return do_fetch(transport,
+			parse_fetch_refspec(ref_nr, refs), ref_nr);
 }
diff --git a/remote.c b/remote.c
index 9700a33..3225f07 100644
--- a/remote.c
+++ b/remote.c
@@ -393,58 +393,92 @@ static void read_config(void)
 	alias_all_urls();
 }
 
-struct refspec *parse_ref_spec(int nr_refspec, const char **refspec)
+static struct refspec *parse_refspec_internal(int nr_refspec, const char **refspec, int fetch)
 {
 	int i;
 	int st;
 	struct refspec *rs = xcalloc(sizeof(*rs), nr_refspec);
+
 	for (i = 0; i < nr_refspec; i++) {
-		const char *sp, *ep, *gp;
-		sp = refspec[i];
-		if (*sp == '+') {
+		size_t llen, rlen;
+		int is_glob;
+		const char *lhs, *rhs;
+
+		llen = rlen = is_glob = 0;
+
+		lhs = refspec[i];
+		if (*lhs == '+') {
 			rs[i].force = 1;
-			sp++;
+			lhs++;
 		}
-		gp = strstr(sp, "/*");
-		ep = strchr(sp, ':');
-		if (gp && ep && gp > ep)
-			gp = NULL;
-		if (ep) {
-			if (ep[1]) {
-				const char *glob = strstr(ep + 1, "/*");
-				if (glob && glob[2])
-					glob = NULL;
-				if (!glob)
-					gp = NULL;
-				if (gp)
-					rs[i].dst = xstrndup(ep + 1,
-							     glob - ep - 1);
-				else
-					rs[i].dst = xstrdup(ep + 1);
-			}
+
+		rhs = strrchr(lhs, ':');
+		if (rhs && *++rhs) {
+			/* Has RHS */
+			rlen = strlen(rhs);
+			is_glob = (2 <= rlen && !strcmp(rhs + rlen - 2, "/*"));
 		} else {
-			ep = sp + strlen(sp);
+			rhs = NULL;
 		}
-		if (gp && gp + 2 != ep)
-			gp = NULL;
-		if (gp) {
-			rs[i].pattern = 1;
-			ep = gp;
+
+		llen = (rhs ? (rhs - lhs - 1) : strlen(lhs));
+		if (is_glob != (2 <= llen && !memcmp(lhs + llen - 2, "/*", 2)))
+			goto invalid;
+
+		if (is_glob) {
+			llen -= 2;
+			rlen -= 2;
 		}
-		rs[i].src = xstrndup(sp, ep - sp);
+		rs[i].pattern = is_glob;
+		if (rlen)
+			rs[i].dst = xstrndup(rhs, rlen);
+		rs[i].src = xstrndup(lhs, llen);
 
-		if (*rs[i].src) {
+		/*
+		 * Do we want to validate LHS?
+		 *
+		 * Fetch refspec must have LHS that names a valid
+		 * looking ref (unless it is empty, which defaults to
+		 * HEAD).
+		 *
+		 * Push refspec "LHS" without ":RHS" is a synonym for
+		 * "LHS:LHS", and LHS must be a valid looking ref.
+		 *
+		 * For push with explicit RHS, LHS can be any valid
+		 * extended SHA-1 expression (or even "empty" for
+		 * removal) and we cannot check for error until it
+		 * actually gets used.
+		 */
+		if ((fetch && *rs[i].src) || (!fetch && !rhs)) {
 			st = check_ref_format(rs[i].src);
 			if (st && st != CHECK_REF_FORMAT_ONELEVEL)
-				die("Invalid refspec '%s'", refspec[i]);
+				goto invalid;
 		}
-		if (rs[i].dst && *rs[i].dst) {
+
+		/*
+		 * RHS: both push destination and fetch tracking ref
+		 * must name a valid looking ref.
+		 */
+		if (rs[i].dst) {
 			st = check_ref_format(rs[i].dst);
 			if (st && st != CHECK_REF_FORMAT_ONELEVEL)
-				die("Invalid refspec '%s'", refspec[i]);
+				goto invalid;
 		}
 	}
 	return rs;
+
+ invalid:
+	die("Invalid refspec '%s'", refspec[i]);
+}
+
+struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec)
+{
+	return parse_refspec_internal(nr_refspec, refspec, 1);
+}
+
+struct refspec *parse_push_refspec(int nr_refspec, const char **refspec)
+{
+	return parse_refspec_internal(nr_refspec, refspec, 0);
 }
 
 static int valid_remote_nick(const char *name)
@@ -475,8 +509,8 @@ struct remote *remote_get(const char *name)
 		add_url_alias(ret, name);
 	if (!ret->url)
 		return NULL;
-	ret->fetch = parse_ref_spec(ret->fetch_refspec_nr, ret->fetch_refspec);
-	ret->push = parse_ref_spec(ret->push_refspec_nr, ret->push_refspec);
+	ret->fetch = parse_fetch_refspec(ret->fetch_refspec_nr, ret->fetch_refspec);
+	ret->push = parse_push_refspec(ret->push_refspec_nr, ret->push_refspec);
 	return ret;
 }
 
@@ -489,11 +523,11 @@ int for_each_remote(each_remote_fn fn, void *priv)
 		if (!r)
 			continue;
 		if (!r->fetch)
-			r->fetch = parse_ref_spec(r->fetch_refspec_nr,
-					r->fetch_refspec);
+			r->fetch = parse_fetch_refspec(r->fetch_refspec_nr,
+						       r->fetch_refspec);
 		if (!r->push)
-			r->push = parse_ref_spec(r->push_refspec_nr,
-					r->push_refspec);
+			r->push = parse_push_refspec(r->push_refspec_nr,
+						     r->push_refspec);
 		result = fn(r, priv);
 	}
 	return result;
@@ -824,7 +858,7 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 	       int nr_refspec, const char **refspec, int flags)
 {
 	struct refspec *rs =
-		parse_ref_spec(nr_refspec, (const char **) refspec);
+		parse_push_refspec(nr_refspec, (const char **) refspec);
 	int send_all = flags & MATCH_REFS_ALL;
 	int send_mirror = flags & MATCH_REFS_MIRROR;
 
diff --git a/remote.h b/remote.h
index f1dedf1..7e9ae79 100644
--- a/remote.h
+++ b/remote.h
@@ -67,7 +67,8 @@ void free_refs(struct ref *ref);
  */
 void ref_remove_duplicates(struct ref *ref_map);
 
-struct refspec *parse_ref_spec(int nr_refspec, const char **refspec);
+struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec);
+struct refspec *parse_push_refspec(int nr_refspec, const char **refspec);
 
 int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 	       int nr_refspec, const char **refspec, int all);
