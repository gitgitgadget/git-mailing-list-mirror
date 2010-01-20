From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] Teach @{upstream} syntax to strbuf_branchanme()
Date: Wed, 20 Jan 2010 01:38:42 -0800
Message-ID: <1263980322-4142-3-git-send-email-gitster@pobox.com>
References: <1263980322-4142-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 10:39:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXX1v-0004zI-8K
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 10:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296Ab0ATJjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 04:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752286Ab0ATJi6
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 04:38:58 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48179 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab0ATJi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 04:38:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BCE1992078;
	Wed, 20 Jan 2010 04:38:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Iz+f
	w2z6QHf757DXNIg+B0fTMqk=; b=T4RnDXd7NLtfyy9RaAZYC5tyBDdiobKzQczT
	zG9IaLxtlV1bev0sx5w8NEch21vFpugBylSblQNmrWzAq6OQRomgIIlakiP1La7R
	r3ZHbaOYs1+DQpArkaV15SxOJGhRaLLoM0Bw7YaI7jUgytWIzJLgZ5ASLLmfDyo7
	0RrgIjE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	JMth1T70fryKeEvG1382sxNY30RnOIpwlBa4ON2uhAunPGlEv6bgEYtXDLy+rja8
	67cuJ0Mw9b9zVtINTdEZqTfAbHhbKnKGzOeCC54I5GnGQ/y56xmDjxoYc8If6jHI
	vx47xWn8e13YyDGf+GaPFJ/BYTr7pz27OxyEHoRenQU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9618F92077;
	Wed, 20 Jan 2010 04:38:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9870C92073; Wed, 20 Jan
 2010 04:38:51 -0500 (EST)
X-Mailer: git-send-email 1.6.6.513.g63f4c
In-Reply-To: <1263980322-4142-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9FF7207E-05A7-11DF-BC79-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137530>

This teaches @{upstream} syntax to interpret_branch_name(), instead
of dwim_ref() machinery.

There are places in git UI that behaves differently when you give a local
branch name and when you give an extended SHA-1 expression that evaluates
to the commit object name at the tip of the branch.  The intent is that
the special syntax such as @{-1} can stand in as if the user spelled the
name of the branch in such places.

The name of the branch "frotz" to switch to ("git checkout frotz"), and
the name of the branch "nitfol" to fork a new branch "frotz" from ("git
checkout -b frotz nitfol"), are examples of such places.  These places
take only the name of the branch (e.g. "frotz"), and they are supposed to
act differently to an equivalent refname (e.g. "refs/heads/frotz"), so
hooking the @{upstream} and @{-N} syntax to dwim_ref() is insufficient
when we want to deal with cases a local branch is forked from another
local branch and use "forked@{upstream}" to name the forkee branch.

The "upstream" syntax "forked@{u}" is to specify the ref that "forked" is
configured to merge with, and most often the forkee is a remote tracking
branch, not a local branch.  We cannot simply return a local branch name,
but that does not necessarily mean we have to returns the full refname
(e.g. refs/remotes/origin/frotz, when returning origin/frotz is enough).
This update calls shorten_unambiguous_ref() to do so.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c                   |  116 ++++++++++++++++++++++++++---------------
 t/t1506-rev-parse-upstream.sh |    6 +-
 2 files changed, 77 insertions(+), 45 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index fb4e214..2376c6d 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -239,24 +239,10 @@ static int ambiguous_path(const char *path, int len)
 	return slash;
 }
 
-static inline int tracked_suffix(const char *string, int len)
-{
-	const char *suffix[] = { "@{upstream}", "@{u}" };
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(suffix); i++) {
-		int suffix_len = strlen(suffix[i]);
-		if (len >= suffix_len && !memcmp(string + len - suffix_len,
-					suffix[i], suffix_len))
-			return suffix_len;
-	}
-	return 0;
-}
-
 /*
  * *string and *len will only be substituted, and *string returned (for
- * later free()ing) if the string passed in is of the form @{-<n>} or
- * of the form <branch>@{upstream}.
+ * later free()ing) if the string passed in is a magic short-hand form
+ * to name a branch.
  */
 static char *substitute_branch_name(const char **string, int *len)
 {
@@ -270,21 +256,6 @@ static char *substitute_branch_name(const char **string, int *len)
 		return (char *)*string;
 	}
 
-	ret = tracked_suffix(*string, *len);
-	if (ret) {
-		char *ref = xstrndup(*string, *len - ret);
-		struct branch *tracking = branch_get(*ref ? ref : NULL);
-
-		if (!tracking)
-			die ("No tracking branch found for '%s'", ref);
-		free(ref);
-		if (tracking->merge && tracking->merge[0]->dst) {
-			*string = xstrdup(tracking->merge[0]->dst);
-			*len = strlen(*string);
-			return (char *)*string;
-		}
-	}
-
 	return NULL;
 }
 
@@ -354,6 +325,20 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 	return logs_found;
 }
 
+static inline int upstream_mark(const char *string, int len)
+{
+	const char *suffix[] = { "@{upstream}", "@{u}" };
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(suffix); i++) {
+		int suffix_len = strlen(suffix[i]);
+		if (suffix_len <= len
+		    && !memcmp(string, suffix[i], suffix_len))
+			return suffix_len;
+	}
+	return 0;
+}
+
 static int get_sha1_1(const char *name, int len, unsigned char *sha1);
 
 static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
@@ -371,7 +356,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	if (len && str[len-1] == '}') {
 		for (at = len-2; at >= 0; at--) {
 			if (str[at] == '@' && str[at+1] == '{') {
-				if (!tracked_suffix(str + at, len - at)) {
+				if (!upstream_mark(str + at, len - at)) {
 					reflog_len = (len-1) - (at+2);
 					len = at;
 				}
@@ -773,17 +758,10 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
 }
 
 /*
- * This reads "@{-N}" syntax, finds the name of the Nth previous
- * branch we were on, and places the name of the branch in the given
- * buf and returns the number of characters parsed if successful.
- *
- * If the input is not of the accepted format, it returns a negative
- * number to signal an error.
- *
- * If the input was ok but there are not N branch switches in the
- * reflog, it returns 0.
+ * Parse @{-N} syntax, return the number of characters parsed
+ * if successful; otherwise signal an error with negative value.
  */
-int interpret_branch_name(const char *name, struct strbuf *buf)
+static int interpret_nth_prior_checkout(const char *name, struct strbuf *buf)
 {
 	long nth;
 	int i, retval;
@@ -828,6 +806,60 @@ release_return:
 }
 
 /*
+ * This reads short-hand syntax that not only evaluates to a commit
+ * object name, but also can act as if the end user spelled the name
+ * of the branch from the command line.
+ *
+ * - "@{-N}" finds the name of the Nth previous branch we were on, and
+ *   places the name of the branch in the given buf and returns the
+ *   number of characters parsed if successful.
+ *
+ * - "<branch>@{upstream}" finds the name of the other ref that
+ *   <branch> is configured to merge with (missing <branch> defaults
+ *   to the current branch), and places the name of the branch in the
+ *   given buf and returns the number of characters parsed if
+ *   successful.
+ *
+ * If the input is not of the accepted format, it returns a negative
+ * number to signal an error.
+ *
+ * If the input was ok but there are not N branch switches in the
+ * reflog, it returns 0.
+ */
+int interpret_branch_name(const char *name, struct strbuf *buf)
+{
+	char *cp;
+	struct branch *upstream;
+	int namelen = strlen(name);
+	int len = interpret_nth_prior_checkout(name, buf);
+	int tmp_len;
+
+	if (!len)
+		return len; /* syntax Ok, not enough switches */
+	if (0 < len)
+		return len; /* consumed from the front */
+	cp = strchr(name, '@');
+	if (!cp)
+		return -1;
+	tmp_len = upstream_mark(cp, namelen - (cp - name));
+	if (!tmp_len)
+		return -1;
+	len = cp + tmp_len - name;
+	cp = xstrndup(name, cp - name);
+	upstream = branch_get(*cp ? cp : NULL);
+	if (!upstream
+	    || !upstream->merge
+	    || !upstream->merge[0]->dst)
+		return error("No upstream branch found for '%s'", cp);
+	free(cp);
+	cp = shorten_unambiguous_ref(upstream->merge[0]->dst, 0);
+	strbuf_reset(buf);
+	strbuf_addstr(buf, cp);
+	free(cp);
+	return len;
+}
+
+/*
  * This is like "get_sha1_basic()", except it allows "sha1 expressions",
  * notably "xyz^" for "parent of xyz"
  */
diff --git a/t/t1506-rev-parse-upstream.sh b/t/t1506-rev-parse-upstream.sh
index a2c7f92..95c9b09 100755
--- a/t/t1506-rev-parse-upstream.sh
+++ b/t/t1506-rev-parse-upstream.sh
@@ -76,7 +76,7 @@ test_expect_success 'checkout -b new my-side@{u} forks from the same' '
 )
 '
 
-test_expect_failure 'merge my-side@{u} records the correct name' '
+test_expect_success 'merge my-side@{u} records the correct name' '
 (
 	sq="'\''" &&
 	cd clone || exit
@@ -90,7 +90,7 @@ test_expect_failure 'merge my-side@{u} records the correct name' '
 )
 '
 
-test_expect_failure 'branch -d other@{u}' '
+test_expect_success 'branch -d other@{u}' '
 	git checkout -t -b other master &&
 	git branch -d @{u} &&
 	git for-each-ref refs/heads/master >actual &&
@@ -98,7 +98,7 @@ test_expect_failure 'branch -d other@{u}' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'checkout other@{u}' '
+test_expect_success 'checkout other@{u}' '
 	git branch -f master HEAD &&
 	git checkout -t -b another master &&
 	git checkout @{u} &&
-- 
1.6.6.513.g63f4c
