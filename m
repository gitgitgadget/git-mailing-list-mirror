From: mhagger@alum.mit.edu
Subject: [RFC 6/7] check_refname_format(): add REFNAME_FULL option
Date: Tue,  1 May 2012 01:02:54 +0200
Message-ID: <1335826975-3093-7-git-send-email-mhagger@alum.mit.edu>
References: <1335826975-3093-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 01:03:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOzcw-0000Ul-Jb
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 01:03:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757397Ab2D3XDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 19:03:19 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:41756 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757284Ab2D3XDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 19:03:16 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p4FC0D9D4.dip.t-dialin.net [79.192.217.212])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3UN2xbF028766;
	Tue, 1 May 2012 01:03:08 +0200
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335826975-3093-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196632>

From: Michael Haggerty <mhagger@alum.mit.edu>

Add a REFNAME_FULL option that causes check_refname_format() to
require full reference names.  A full refname has to start with
"refs/" or consist entirely of capital letters and underscores.  If
the REFNAME_FULL bit is set in the flags, check_refname_format() and
parse_refname_prefix() verify that the refname is a valid full
refname.

Add a "--full" option to "git check-ref-format" that can be used to
access the new option.  Use this to add some tests involving "git
check-ref-format --full".

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/git-check-ref-format.txt |   14 +++++++++++
 builtin/check-ref-format.c             |    4 +++
 refs.c                                 |   42 +++++++++++++++++++++-----------
 refs.h                                 |   12 ++++++---
 t/t1402-check-ref-format.sh            |   31 +++++++++++++++++++++++
 5 files changed, 85 insertions(+), 18 deletions(-)

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
index 70578ee..c4ab64d 100644
--- a/refs.c
+++ b/refs.c
@@ -105,28 +105,42 @@ static int parse_refname_prefix(const char *refname, int refnamelen, int flags)
 			}
 		}
 		component_count++;
-		/* See what terminated the component: */
-		if (component_len == len) {
-			/* We've parsed the whole string: */
+
+		if (component_len == len || p[component_len] != '/')
 			break;
-		} else if (p[component_len] == '/') {
-			/* Skip to the start of the next component: */
-			p += component_len + 1;
-			len -= component_len + 1;
-		} else {
+
+		if (component_count == 1 && flags & REFNAME_FULL) {
 			/*
-			 * The component was ended by something else
-			 * (something that cannot be part of a legal
-			 * refname).
+			 * That was the first of multiple components;
+			 * make sure that it is equal to "refs":
 			 */
-			break;
+			if (component_len != 4 || prefixcmp(p, "refs"))
+				return -1;
 		}
+
+		/* Skip to the start of the next component: */
+		p += component_len + 1;
+		len -= component_len + 1;
 	}
 
 	if (p[component_len - 1] == '.')
 		return -1; /* Refname ends with '.'. */
-	if (!(flags & REFNAME_ALLOW_ONELEVEL) && component_count < 2)
-		return -1; /* Refname has only one component. */
+	if (component_count == 1) {
+		if (!(flags & REFNAME_ALLOW_ONELEVEL))
+			return -1; /* Refname has only one component. */
+		if (flags & REFNAME_FULL) {
+			/*
+			 * Make sure that the (single-component)
+			 * refname is ALL_CAPS:
+			 */
+			int i;
+			for (i = 0; i < component_len; i++) {
+				char ch = p[i];
+				if (!(('A' <= ch && ch <= 'Z') || ch == '_'))
+					return -1;
+			}
+		}
+	}
 	return p + component_len - refname;
 }
 
diff --git a/refs.h b/refs.h
index d6c2fe2..efe13bb 100644
--- a/refs.h
+++ b/refs.h
@@ -111,9 +111,10 @@ int for_each_recent_reflog_ent(const char *refname, each_reflog_ent_fn fn, long,
  */
 extern int for_each_reflog(each_ref_fn, void *);
 
-#define REFNAME_ALLOW_ONELEVEL 1
-#define REFNAME_REFSPEC_PATTERN 2
-#define REFNAME_DOT_COMPONENT 4
+#define REFNAME_ALLOW_ONELEVEL 0x01
+#define REFNAME_REFSPEC_PATTERN 0x02
+#define REFNAME_DOT_COMPONENT 0x04
+#define REFNAME_FULL 0x08
 
 /*
  * Return 0 iff refname has the correct format for a refname according
@@ -124,7 +125,10 @@ extern int for_each_reflog(each_ref_fn, void *);
  * components.  No leading or repeated slashes are accepted.  If
  * REFNAME_DOT_COMPONENT is set in flags, then allow refname
  * components to start with "." (but not a whole component equal to
- * "." or "..").
+ * "." or "..").  If REFNAME_FULL is set in flags, then additionally
+ * verify that the refname is a valid full refname--that it either
+ * starts with "refs/" or that it consists of only capital letters and
+ * underscores (like "HEAD" or "MERGE_HEAD").
  */
 extern int check_refname_format(const char *refname, int flags);
 
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
1.7.10
