From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] make sure parsed wildcard refspec ends with slash
Date: Sat, 26 Jul 2008 23:15:51 -0700
Message-ID: <7vsktv3l9k.fsf_-_@gitster.siamese.dyndns.org>
References: <1216854795-51155-1-git-send-email-lee.marlow@gmail.com>
 <1216858043-53646-1-git-send-email-lee.marlow@gmail.com>
 <20080725204051.GB23202@spearce.org>
 <7v1w1hsmnc.fsf@gitster.siamese.dyndns.org>
 <20080726082405.GA10104@sigill.intra.peff.net>
 <7vvdysb2na.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 27 08:17:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMzZA-0002YP-K0
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 08:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998AbYG0GQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 02:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbYG0GQF
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 02:16:05 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44494 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998AbYG0GQB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 02:16:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EFDE03E5F7;
	Sun, 27 Jul 2008 02:15:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 57B583E5F6; Sun, 27 Jul 2008 02:15:53 -0400 (EDT)
In-Reply-To: <7vvdysb2na.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 26 Jul 2008 17:18:33 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7AD773DE-5BA3-11DD-A6D4-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90312>

A wildcard refspec is internally parsed into a refspec structure with src
and dst strings.  Many parts of the code assumed that these do not include
the trailing "/*" when matching the wildcard pattern with an actual ref we
see at the remote.  What this meant was that we needed to make sure not
just that the prefix matched, and also that a slash followed the part that
matched.

But a codepath that scans the result from ls-remote and finds matching
refs forgot to check the "matching part must be followed by a slash" rule.
This resulted in "refs/heads/b1" from the remote side to mistakenly match
the source side of "refs/heads/b/*:refs/remotes/b/*" refspec.

Worse, the refspec crafted internally by "git-clone", and a hardcoded
preparsed refspec that is used to implement "git-fetch --tags", violated
this "parsed widcard refspec does not end with slash" rule; simply adding
the "matching part must be followed by a slash" rule then would have
broken codepaths that use these refspecs.

This commit changes the rule to require a trailing slash to parsed
wildcard refspecs.  IOW, "refs/heads/b/*:refs/remotes/b/*" is parsed as
src = "refs/heads/b/" and dst = "refs/remotes/b/".  This allows us to
simplify the matching logic because we only need to do a prefixcmp() to
notice "refs/heads/b/one" matches and "refs/heads/b1" does not.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Junio C Hamano <gitster@pobox.com> writes:

> I have a nagging suspicion that it might be a simpler and cleaner change
> to change parse_refspec_internal() to keep the trailing slash, instead of
> dropping it.  Then the check you added is not needed (the trailing slash
> guarantees that the pattern matches at the hierarchy boundary), neither
> any of the change in this patch.

This is the other variant, and it turns out that I was right.  Among the
64-18 = 46 new lines, 30 are from the new test file.  Two existing
"matching part is followed by '/'" tests are removed.

 remote.c               |   52 +++++++++++++++++++++++++++++++----------------
 t/t5513-fetch-track.sh |   30 +++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 18 deletions(-)

diff --git a/remote.c b/remote.c
index 0d6020b..f61a3ab 100644
--- a/remote.c
+++ b/remote.c
@@ -427,6 +427,28 @@ static void read_config(void)
 	alias_all_urls();
 }
 
+/*
+ * We need to make sure the tracking branches are well formed, but a
+ * wildcard refspec in "struct refspec" must have a trailing slash. We
+ * temporarily drop the trailing '/' while calling check_ref_format(),
+ * and put it back.  The caller knows that a CHECK_REF_FORMAT_ONELEVEL
+ * error return is Ok for a wildcard refspec.
+ */
+static int verify_refname(char *name, int is_glob)
+{
+	int result, len = -1;
+
+	if (is_glob) {
+		len = strlen(name);
+		assert(name[len - 1] == '/');
+		name[len - 1] = '\0';
+	}
+	result = check_ref_format(name);
+	if (is_glob)
+		name[len - 1] = '/';
+	return result;
+}
+
 static struct refspec *parse_refspec_internal(int nr_refspec, const char **refspec, int fetch, int verify)
 {
 	int i;
@@ -434,11 +456,11 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 	struct refspec *rs = xcalloc(sizeof(*rs), nr_refspec);
 
 	for (i = 0; i < nr_refspec; i++) {
-		size_t llen, rlen;
+		size_t llen;
 		int is_glob;
 		const char *lhs, *rhs;
 
-		llen = rlen = is_glob = 0;
+		llen = is_glob = 0;
 
 		lhs = refspec[i];
 		if (*lhs == '+') {
@@ -458,12 +480,9 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 		}
 
 		if (rhs) {
-			rhs++;
-			rlen = strlen(rhs);
+			size_t rlen = strlen(++rhs);
 			is_glob = (2 <= rlen && !strcmp(rhs + rlen - 2, "/*"));
-			if (is_glob)
-				rlen -= 2;
-			rs[i].dst = xstrndup(rhs, rlen);
+			rs[i].dst = xstrndup(rhs, rlen - is_glob);
 		}
 
 		llen = (rhs ? (rhs - lhs - 1) : strlen(lhs));
@@ -471,7 +490,7 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 			if ((rhs && !is_glob) || (!rhs && fetch))
 				goto invalid;
 			is_glob = 1;
-			llen -= 2;
+			llen--;
 		} else if (rhs && is_glob) {
 			goto invalid;
 		}
@@ -488,7 +507,7 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 			if (!*rs[i].src)
 				; /* empty is ok */
 			else {
-				st = check_ref_format(rs[i].src);
+				st = verify_refname(rs[i].src, is_glob);
 				if (st && st != CHECK_REF_FORMAT_ONELEVEL)
 					goto invalid;
 			}
@@ -503,7 +522,7 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 			} else if (!*rs[i].dst) {
 				; /* ok */
 			} else {
-				st = check_ref_format(rs[i].dst);
+				st = verify_refname(rs[i].dst, is_glob);
 				if (st && st != CHECK_REF_FORMAT_ONELEVEL)
 					goto invalid;
 			}
@@ -518,7 +537,7 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 			if (!*rs[i].src)
 				; /* empty is ok */
 			else if (is_glob) {
-				st = check_ref_format(rs[i].src);
+				st = verify_refname(rs[i].src, is_glob);
 				if (st && st != CHECK_REF_FORMAT_ONELEVEL)
 					goto invalid;
 			}
@@ -532,13 +551,13 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 			 * - otherwise it must be a valid looking ref.
 			 */
 			if (!rs[i].dst) {
-				st = check_ref_format(rs[i].src);
+				st = verify_refname(rs[i].src, is_glob);
 				if (st && st != CHECK_REF_FORMAT_ONELEVEL)
 					goto invalid;
 			} else if (!*rs[i].dst) {
 				goto invalid;
 			} else {
-				st = check_ref_format(rs[i].dst);
+				st = verify_refname(rs[i].dst, is_glob);
 				if (st && st != CHECK_REF_FORMAT_ONELEVEL)
 					goto invalid;
 			}
@@ -687,8 +706,7 @@ int remote_find_tracking(struct remote *remote, struct refspec *refspec)
 		if (!fetch->dst)
 			continue;
 		if (fetch->pattern) {
-			if (!prefixcmp(needle, key) &&
-			    needle[strlen(key)] == '/') {
+			if (!prefixcmp(needle, key)) {
 				*result = xmalloc(strlen(value) +
 						  strlen(needle) -
 						  strlen(key) + 1);
@@ -966,9 +984,7 @@ static const struct refspec *check_pattern_match(const struct refspec *rs,
 			continue;
 		}
 
-		if (rs[i].pattern &&
-		    !prefixcmp(src->name, rs[i].src) &&
-		    src->name[strlen(rs[i].src)] == '/')
+		if (rs[i].pattern && !prefixcmp(src->name, rs[i].src))
 			return rs + i;
 	}
 	if (matching_refs != -1)
diff --git a/t/t5513-fetch-track.sh b/t/t5513-fetch-track.sh
new file mode 100755
index 0000000..9e74862
--- /dev/null
+++ b/t/t5513-fetch-track.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+test_description='fetch follows remote tracking branches correctly'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	>file &&
+	git add . &&
+	test_tick &&
+	git commit -m Initial &&
+	git branch b-0 &&
+	git branch b1 &&
+	git branch b/one &&
+	test_create_repo other &&
+	(
+		cd other &&
+		git config remote.origin.url .. &&
+		git config remote.origin.fetch "+refs/heads/b/*:refs/remotes/b/*"
+	)
+'
+
+test_expect_success fetch '
+	(
+		cd other && git fetch origin &&
+		test "$(git for-each-ref --format="%(refname)")" = refs/remotes/b/one
+	)
+'
+
+test_done
