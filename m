From: mhagger@alum.mit.edu
Subject: [RFC 03/13] Teach check_refname_format() to check full refnames
Date: Wed, 19 Oct 2011 22:55:06 +0200
Message-ID: <1319057716-28094-4-git-send-email-mhagger@alum.mit.edu>
References: <1319057716-28094-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 22:55:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGdB5-0003da-LE
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 22:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920Ab1JSUz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 16:55:27 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:60893 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858Ab1JSUzY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 16:55:24 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RGd4e-000423-Iv; Wed, 19 Oct 2011 22:49:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319057716-28094-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183956>

From: Michael Haggerty <mhagger@alum.mit.edu>

A full refname has to start with "refs/" or consist entirely of capital
letters and underscores.  Add an option REFNAME_FULL that causes
check_refname_format() and parse_refname_prefix() to verify that the
refname is a valid full refname.

Add a "--full" option to "git check-ref-format" that can be used to
access the new option.  Use this to add some tests involving "git
check-ref-format --full".

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/git-check-ref-format.txt |   14 +++++++++++
 builtin/check-ref-format.c             |    4 +++
 refs.c                                 |   39 ++++++++++++++++++-------------
 refs.h                                 |   12 ++++++---
 t/t1402-check-ref-format.sh            |   31 +++++++++++++++++++++++++
 5 files changed, 80 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index 103e7b1..9a8aafb 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -27,6 +27,11 @@ if refs are packed by `git gc`).
 
 git imposes the following rules on how references are named:
 
+. They must either start with `refs/` (e.g., `refs/heads/master`) or
+  consist entirely of capital letters and underscores (e.g., `HEAD` or
+  `MERGE_HEAD`).  This rule is enforced if the `--full` option is
+  used.
+
 . They can include slash `/` for hierarchical (directory)
   grouping, but no slash-separated component can begin with a
   dot `.` or end with the sequence `.lock`.
@@ -83,6 +88,15 @@ typed the branch name.
 
 OPTIONS
 -------
+--full::
+--no-full::
+	Controls whether the refname must represent a full refname
+	(i.e., starting with `refs/`).  If `--full` and
+	`--allow-onelevel` are both specified, then special top-level
+	refnames consisting of capital letters and underscored (like
+	`HEAD` or `MERGE_HEAD`) are also allowed.  The default is
+	`--no-full`.
+
 --allow-onelevel::
 --no-allow-onelevel::
 	Controls whether one-level refnames are accepted (i.e.,
diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index 28a7320..a73626d 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -64,6 +64,10 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 	for (i = 1; i < argc && argv[i][0] == '-'; i++) {
 		if (!strcmp(argv[i], "--normalize") || !strcmp(argv[i], "--print"))
 			normalize = 1;
+		else if (!strcmp(argv[i], "--full"))
+			flags |= REFNAME_FULL;
+		else if (!strcmp(argv[i], "--no-full"))
+			flags &= ~REFNAME_FULL;
 		else if (!strcmp(argv[i], "--allow-onelevel"))
 			flags |= REFNAME_ALLOW_ONELEVEL;
 		else if (!strcmp(argv[i], "--no-allow-onelevel"))
diff --git a/refs.c b/refs.c
index 387da83..8299e51 100644
--- a/refs.c
+++ b/refs.c
@@ -980,6 +980,11 @@ static int parse_refname_prefix(const char *ref, int len, int flags)
 		component_count++;
 		if (component_len == len || p[component_len] != '/')
 			break;
+		if (component_count == 1 && (flags & REFNAME_FULL)) {
+			/* That was the first of multiple components */
+			if (component_len != 4 || strncmp(p, "refs", 4))
+				return -1;
+		}
 		/* Skip to next component. */
 		p += component_len + 1;
 		len -= component_len + 1;
@@ -989,8 +994,22 @@ static int parse_refname_prefix(const char *ref, int len, int flags)
 
 	if (ref[valid_len - 1] == '.')
 		return -1; /* Refname ends with '.'. */
-	if (!(flags & REFNAME_ALLOW_ONELEVEL) && component_count < 2)
-		return -1; /* Refname has only one component. */
+
+	if (component_count == 1) {
+		if (!(flags & REFNAME_ALLOW_ONELEVEL))
+			return -1;
+
+		if (flags & REFNAME_FULL) {
+			/* Make sure that the refname is ALL_CAPS. */
+			int i;
+			for (i = 0; i < component_len; i++) {
+				char ch = p[i];
+				if (ch != '_' && (ch < 'A' || 'Z' < ch))
+					return -1;
+			}
+		}
+	}
+
 	return valid_len;
 }
 
@@ -1028,20 +1047,8 @@ const char *ref_fetch_rules[] = {
 
 static int refname_ok_at_root_level(const char *str, int len)
 {
-	if (len >= 5 && !memcmp(str, "refs/", 5))
-		return 1;
-
-	while (len--) {
-		char ch = *str++;
-
-		/*
-		 * Only accept likes of .git/HEAD, .git/MERGE_HEAD at
-		 * the root level as a ref.
-		 */
-		if (ch != '_' && (ch < 'A' || 'Z' < ch))
-			return 0;
-	}
-	return 1;
+	return parse_refname_prefix(str, len,
+				    REFNAME_ALLOW_ONELEVEL|REFNAME_FULL) == len;
 }
 
 int refname_match(const char *abbrev_name, const char *full_name, const char **rules)
diff --git a/refs.h b/refs.h
index 0229c57..7707cda 100644
--- a/refs.h
+++ b/refs.h
@@ -97,9 +97,10 @@ int for_each_recent_reflog_ent(const char *ref, each_reflog_ent_fn fn, long, voi
  */
 extern int for_each_reflog(each_ref_fn, void *);
 
-#define REFNAME_ALLOW_ONELEVEL 1
-#define REFNAME_REFSPEC_PATTERN 2
-#define REFNAME_DOT_COMPONENT 4
+#define REFNAME_ALLOW_ONELEVEL 01
+#define REFNAME_REFSPEC_PATTERN 02
+#define REFNAME_DOT_COMPONENT 04
+#define REFNAME_FULL 010
 
 /*
  * Return 0 iff ref has the correct format for a refname according to
@@ -110,7 +111,10 @@ extern int for_each_reflog(each_ref_fn, void *);
  * components.  No leading or repeated slashes are accepted.  If
  * REFNAME_DOT_COMPONENT is set in flags, then allow refname
  * components to start with "." (but not a whole component equal to
- * "." or "..").
+ * "." or "..").  If REFNAME_FULL is set in flags, then additionally
+ * verify that the refname is a valid full refname--that it either
+ * starts with "refs/" or that it consists of only capital letters and
+ * underscores (like "HEAD" or "MERGE_HEAD").
  */
 extern int check_refname_format(const char *ref, int flags);
 
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 1ae4d87..2f8a48e 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -70,6 +70,7 @@ invalid_ref "$ref" --refspec-pattern
 valid_ref "$ref" '--refspec-pattern --allow-onelevel'
 invalid_ref "$ref" --normalize
 valid_ref "$ref" '--allow-onelevel --normalize'
+invalid_ref "$ref" '--full'
 
 ref='foo/bar'
 valid_ref "$ref"
@@ -77,12 +78,19 @@ valid_ref "$ref" --allow-onelevel
 valid_ref "$ref" --refspec-pattern
 valid_ref "$ref" '--refspec-pattern --allow-onelevel'
 valid_ref "$ref" --normalize
+invalid_ref "$ref" '--full'
 
 ref='foo/*'
 invalid_ref "$ref"
 invalid_ref "$ref" --allow-onelevel
 valid_ref "$ref" --refspec-pattern
 valid_ref "$ref" '--refspec-pattern --allow-onelevel'
+invalid_ref "$ref" '--full'
+invalid_ref "$ref" '--refspec-pattern --full'
+
+ref='refs/*'
+invalid_ref "$ref" '--full'
+valid_ref "$ref" '--refspec-pattern --full'
 
 ref='*/foo'
 invalid_ref "$ref"
@@ -91,18 +99,23 @@ valid_ref "$ref" --refspec-pattern
 valid_ref "$ref" '--refspec-pattern --allow-onelevel'
 invalid_ref "$ref" --normalize
 valid_ref "$ref" '--refspec-pattern --normalize'
+invalid_ref "$ref" '--full'
+invalid_ref "$ref" '--refspec-pattern --full'
 
 ref='foo/*/bar'
 invalid_ref "$ref"
 invalid_ref "$ref" --allow-onelevel
 valid_ref "$ref" --refspec-pattern
 valid_ref "$ref" '--refspec-pattern --allow-onelevel'
+invalid_ref "$ref" '--full'
 
 ref='*'
 invalid_ref "$ref"
 invalid_ref "$ref" --allow-onelevel
 invalid_ref "$ref" --refspec-pattern
 valid_ref "$ref" '--refspec-pattern --allow-onelevel'
+invalid_ref "$ref" '--full'
+invalid_ref "$ref" '--refspec-pattern --full'
 
 ref='foo/*/*'
 invalid_ref "$ref" --refspec-pattern
@@ -126,6 +139,24 @@ valid_ref NOT_MINGW "$ref" '--allow-onelevel --normalize'
 invalid_ref NOT_MINGW "$ref" '--refspec-pattern --normalize'
 valid_ref NOT_MINGW "$ref" '--refspec-pattern --allow-onelevel --normalize'
 
+ref='HEAD'
+invalid_ref "$ref"
+valid_ref "$ref" --allow-onelevel
+invalid_ref "$ref" --full
+valid_ref "$ref" '--allow-onelevel --full'
+
+valid_ref FETCH_HEAD '--allow-onelevel --full'
+valid_ref refs/foo --full
+invalid_ref HEAD/ '--allow-onelevel --full'
+valid_ref HEAD/ '--allow-onelevel --full --normalize'
+invalid_ref refs '--full'
+invalid_ref refs '--allow-onelevel --full'
+invalid_ref refs/ '--allow-onelevel --full'
+invalid_ref HEAD/foo '--full'
+invalid_ref head '--allow-onelevel --full'
+valid_ref 'refs/foo/*' '--refspec-pattern --full'
+valid_ref 'refs/*/foo' '--refspec-pattern --full'
+
 test_expect_success "check-ref-format --branch @{-1}" '
 	T=$(git write-tree) &&
 	sha1=$(echo A | git commit-tree $T) &&
-- 
1.7.7
