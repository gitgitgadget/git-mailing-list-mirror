From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] remote.c: Fix overtight refspec validation
Date: Fri, 21 Mar 2008 15:17:28 -0700
Message-ID: <7vlk4boh6v.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0803202049090.19665@iabervon.org>
 <7v4pb0vhrg.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803210014100.19665@iabervon.org>
 <7vmyosskyu.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803210134070.19665@iabervon.org>
 <7v3aqksic6.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803211148120.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Samuel Tardieu <sam@rfc1149.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 23:18:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcpZ9-0007gZ-OB
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 23:18:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbYCUWRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 18:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753460AbYCUWRj
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 18:17:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33677 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193AbYCUWRi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 18:17:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2AA992096;
	Fri, 21 Mar 2008 18:17:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6C7932093; Fri, 21 Mar 2008 18:17:31 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77775>

We tightened the refspec validation code in an earlier ef00d15 (Tighten
refspec processing, 2008-03-17) per my suggestion, but the suggestion was
misguided to begin with and it broke this usage:

    $ git push origin HEAD~12:master

The syntax of push refspecs and fetch refspecs are similar in that they
are both colon separated LHS and RHS (possibly prefixed with a + to
force), but the similarity ends there.  For example, LHS in a push refspec
can be anything that evaluates to a valid object name at runtime (except
when colon and RHS is missing, or it is a glob), while it must be a
valid-looking refname in a fetch refspec.  To validate them correctly, the
caller needs to be able to say which kind of refspecs they are.  It is
unreasonable to keep a single interface that cannot tell which kind it is
dealing with, and ask it to behave sensibly.

This commit separates the parsing of the two into different functions, and
clarifies the code to implement the parsing proper (i.e. splitting into
two parts, making sure both sides are wildcard or neither side is).

This happens to also allow pushing a commit named with the esoteric "look
for that string" syntax:

    $ git push ../test.git ':/remote.c: Fix overtight refspec:master'

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

  Daniel Barkalow <barkalow@iabervon.org> writes:

  > ... (although the 
  > patch text made it hard to see; we really need some magic to make diff not 
  > bother to save 4 identifier-free lines and just show it as a complete 
  > replacement).

  Yeah, I tend to agree and some people seem to favor "diff -c" for this
  reason.

  In any case, here is an updated patch with a better description and
  necessary tests.  The "validly looking extended SHA-1 expression" check
  is wholly outside the scope of 1.5.5 regression fix so I did not even
  attempt to address it, but what this commit fixes needs to be addressed
  before -rc1.

 builtin-fetch.c     |    3 +-
 builtin-send-pack.c |    2 +-
 remote.c            |  122 ++++++++++++++++++++++++++++++++++-----------------
 remote.h            |    3 +-
 t/t5511-refspec.sh  |   67 ++++++++++++++++++++++++++++
 5 files changed, 153 insertions(+), 44 deletions(-)
 create mode 100755 t/t5511-refspec.sh

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
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 930e0fb..bb9c33a 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -537,7 +537,7 @@ static void verify_remote_names(int nr_heads, const char **heads)
 	int i;
 
 	for (i = 0; i < nr_heads; i++) {
-		const char *remote = strchr(heads[i], ':');
+		const char *remote = strrchr(heads[i], ':');
 
 		remote = remote ? (remote + 1) : heads[i];
 		switch (check_ref_format(remote)) {
diff --git a/remote.c b/remote.c
index 9700a33..4117bfc 100644
--- a/remote.c
+++ b/remote.c
@@ -393,58 +393,98 @@ static void read_config(void)
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
-		} else {
-			ep = sp + strlen(sp);
+
+		rhs = strrchr(lhs, ':');
+		if (rhs) {
+			rhs++;
+			rlen = strlen(rhs);
+			is_glob = (2 <= rlen && !strcmp(rhs + rlen - 2, "/*"));
+			rs[i].dst = xstrndup(rhs, rlen - is_glob * 2);
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
+		rs[i].src = xstrndup(lhs, llen);
 
-		if (*rs[i].src) {
+		/*
+		 * Do we want to validate LHS?
+		 *
+		 * - Fetch refspec must have LHS that names a valid
+		 *   looking ref (unless it is empty, which defaults to
+		 *   HEAD).
+		 *
+		 * - Push refspec "LHS" without ":RHS" is a synonym for
+		 *   "LHS:LHS", and LHS must be a valid looking ref
+		 *   (cannot be empty).
+		 *
+		 * - Push refspec "LHS:RHS" that is a glob must be
+		 *   a valid looking ref (unless it is empty to remove)
+		 *
+		 * Hence we check non-empty LHS for fetch, and
+		 * colonless or glob LHS for push here.
+		 *
+		 * Note that push refspec "LHS:RHS" that is not a glob
+		 * can have any valid extended SHA-1 expression (or
+		 * "empty" for removal) in LHS, and we cannot check
+		 * for error until it actually gets used.
+		 */
+		if (fetch ? (*rs[i].src) : (!rhs || is_glob)) {
 			st = check_ref_format(rs[i].src);
 			if (st && st != CHECK_REF_FORMAT_ONELEVEL)
-				die("Invalid refspec '%s'", refspec[i]);
+				goto invalid;
 		}
-		if (rs[i].dst && *rs[i].dst) {
+
+		/*
+		 * RHS: both push destination and fetch tracking ref
+		 * must name a valid looking ref, but in fetch, colon
+		 * followed by emptiness is the same as not having the
+		 * colon nor RHS.
+		 */
+		if (rs[i].dst && (!fetch || *rs[i].dst)) {
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
@@ -475,8 +515,8 @@ struct remote *remote_get(const char *name)
 		add_url_alias(ret, name);
 	if (!ret->url)
 		return NULL;
-	ret->fetch = parse_ref_spec(ret->fetch_refspec_nr, ret->fetch_refspec);
-	ret->push = parse_ref_spec(ret->push_refspec_nr, ret->push_refspec);
+	ret->fetch = parse_fetch_refspec(ret->fetch_refspec_nr, ret->fetch_refspec);
+	ret->push = parse_push_refspec(ret->push_refspec_nr, ret->push_refspec);
 	return ret;
 }
 
@@ -489,11 +529,11 @@ int for_each_remote(each_remote_fn fn, void *priv)
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
@@ -824,7 +864,7 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
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
diff --git a/t/t5511-refspec.sh b/t/t5511-refspec.sh
new file mode 100755
index 0000000..7360311
--- /dev/null
+++ b/t/t5511-refspec.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+
+test_description='refspec parsing'
+
+. ./test-lib.sh
+
+test_refspec () {
+
+	kind=$1 refspec=$2 expect=$3
+	git config remote.frotz.url "." &&
+	git config --remove-section remote.frotz &&
+	git config remote.frotz.url "." &&
+	git config "remote.frotz.$kind" "$refspec" &&
+	if test "$expect" != invalid
+	then
+		title="$kind $refspec"
+		test='git ls-remote frotz'
+	else
+		title="$kind $refspec (invalid)"
+		test='test_must_fail git ls-remote frotz'
+	fi
+	test_expect_success "$title" "$test"
+}
+
+
+test_refspec push 'refs/heads/*:refs/remotes/frotz/*'
+test_refspec push 'refs/heads/*:refs/remotes/frotz'		invalid
+test_refspec push 'refs/heads:refs/remotes/frotz/*'		invalid
+test_refspec push 'refs/heads/master:refs/remotes/frotz/xyzzy'
+
+
+# These have invalid LHS, but we do not have a formal "valid sha-1
+# expression syntax checker" so they are not checked with the current
+# code.  They will be caught downstream anyway, but we may want to
+# have tighter check later...
+
+: test_refspec push 'refs/heads/master::refs/remotes/frotz/xyzzy'	invalid
+: test_refspec push 'refs/heads/maste :refs/remotes/frotz/xyzzy'	invalid
+
+test_refspec fetch 'refs/heads/*:refs/remotes/frotz/*'
+test_refspec fetch 'refs/heads/*:refs/remotes/frotz'		invalid
+test_refspec fetch 'refs/heads:refs/remotes/frotz/*'		invalid
+test_refspec fetch 'refs/heads/master:refs/remotes/frotz/xyzzy'
+test_refspec fetch 'refs/heads/master::refs/remotes/frotz/xyzzy'	invalid
+test_refspec fetch 'refs/heads/maste :refs/remotes/frotz/xyzzy'	invalid
+
+test_refspec push 'master~1:refs/remotes/frotz/backup'
+test_refspec fetch 'master~1:refs/remotes/frotz/backup'		invalid
+test_refspec push 'HEAD~4:refs/remotes/frotz/new'
+test_refspec fetch 'HEAD~4:refs/remotes/frotz/new'		invalid
+
+test_refspec push 'HEAD'
+test_refspec fetch 'HEAD'
+test_refspec push 'refs/heads/ nitfol'				invalid
+test_refspec fetch 'refs/heads/ nitfol'				invalid
+
+test_refspec push 'HEAD:'					invalid
+test_refspec fetch 'HEAD:'
+test_refspec push 'refs/heads/ nitfol:'				invalid
+test_refspec fetch 'refs/heads/ nitfol:'			invalid
+
+test_refspec push ':refs/remotes/frotz/deleteme'
+test_refspec fetch ':refs/remotes/frotz/HEAD-to-me'
+test_refspec push ':refs/remotes/frotz/delete me'		invalid
+test_refspec fetch ':refs/remotes/frotz/HEAD to me'		invalid
+
+test_done
-- 
1.5.5.rc0.139.g9315d
