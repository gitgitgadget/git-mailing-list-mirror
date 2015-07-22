From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 2/2] refs: loosen restriction on wildcard "*" refspecs
Date: Wed, 22 Jul 2015 14:05:33 -0700
Message-ID: <1437599133-13012-3-git-send-email-jacob.e.keller@intel.com>
References: <1437599133-13012-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 22 23:05:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZI1D3-0004cH-A5
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 23:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbbGVVFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2015 17:05:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:56790 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751654AbbGVVFi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 17:05:38 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP; 22 Jul 2015 14:05:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,525,1432623600"; 
   d="scan'208";a="769372406"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.85])
  by orsmga002.jf.intel.com with ESMTP; 22 Jul 2015 14:05:36 -0700
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1437599133-13012-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274470>

From: Jacob Keller <jacob.keller@gmail.com>

Modify logic of check_refname_component and add a new disposition
regarding "*". Allow refspecs that contain a single "*" if
REFNAME_REFSPEC_PATTERN is set. Change the function to pass the flags as
a pointer, and clear REFNAME_REFSPEC_PATTERN after the first "*" so that
only a single "*" is accepted.

This loosens restrictions on refspecs by allowing patterns that have
a "*" within a component instead of only as the whole component. Also
remove the code that hangled refspec patterns in check_refname_format
since it is now handled via the check_refname_component logic.

Now refs such as `for/bar*:foo/bar*` and even `foo/bar*:foo/baz*` will
be accepted. This allows users more control over what is fetched where.
Since users must modify the default by hand to make use of this
functionality it is not considered a large risk. Any refspec which
functioned before shall continue functioning with the new logic.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.iabervon.org>
Cc: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-check-ref-format.txt |  4 ++--
 refs.c                                 | 36 +++++++++++++++++++---------------
 refs.h                                 |  4 ++--
 t/t1402-check-ref-format.sh            |  8 +++++---
 4 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index fc02959ba4ab..9044dfaadae1 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -94,8 +94,8 @@ OPTIONS
 	Interpret <refname> as a reference name pattern for a refspec
 	(as used with remote repositories).  If this option is
 	enabled, <refname> is allowed to contain a single `*`
-	in place of a one full pathname component (e.g.,
-	`foo/*/bar` but not `foo/bar*`).
+	in the refspec (e.g., `foo/bar*/baz` or `foo/bar*baz/`
+	but not `foo/bar*/baz*`).
 
 --normalize::
 	Normalize 'refname' by removing any leading slash (`/`)
diff --git a/refs.c b/refs.c
index 8c08fc0489eb..16a1d8305579 100644
--- a/refs.c
+++ b/refs.c
@@ -20,12 +20,13 @@ struct ref_lock {
  * 2: ., look for a preceding . to reject .. in refs
  * 3: {, look for a preceding @ to reject @{ in refs
  * 4: A bad character: ASCII control characters, and
- *    "*", ":", "?", "[", "\", "^", "~", SP, or TAB
+ *    ":", "?", "[", "\", "^", "~", SP, or TAB
+ * 5: *, reject unless REFNAME_REFSPEC_PATTERN is set
  */
 static unsigned char refname_disposition[256] = {
 	1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
 	4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
-	4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 2, 1,
+	4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 2, 1,
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 4,
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 4, 0,
@@ -72,12 +73,13 @@ static unsigned char refname_disposition[256] = {
  * - any path component of it begins with ".", or
  * - it has double dots "..", or
  * - it has ASCII control characters, or
- * - it has "*", ":", "?", "[", "\", "^", "~", SP, or TAB anywhere, or
+ * - it has ":", "?", "[", "\", "^", "~", SP, or TAB anywhere, or
+ * - it has "*" anywhere unless REFNAME_REFSPEC_PATTERN is set, or
  * - it ends with a "/", or
  * - it ends with ".lock", or
  * - it contains a "@{" portion
  */
-static int check_refname_component(const char *refname, int flags)
+static int check_refname_component(const char *refname, int *flags)
 {
 	const char *cp;
 	char last = '\0';
@@ -98,6 +100,16 @@ static int check_refname_component(const char *refname, int flags)
 			break;
 		case 4:
 			return -1;
+		case 5:
+			if (!(*flags & REFNAME_REFSPEC_PATTERN))
+				return -1; /* refspec can't be a pattern */
+
+			/*
+			 * Unset the pattern flag so that we only accept a single glob for
+			 * the entire refspec.
+			 */
+			*flags &= ~ REFNAME_REFSPEC_PATTERN;
+			break;
 		}
 		last = ch;
 	}
@@ -122,18 +134,10 @@ int check_refname_format(const char *refname, int flags)
 
 	while (1) {
 		/* We are at the start of a path component. */
-		component_len = check_refname_component(refname, flags);
-		if (component_len <= 0) {
-			if ((flags & REFNAME_REFSPEC_PATTERN) &&
-					refname[0] == '*' &&
-					(refname[1] == '\0' || refname[1] == '/')) {
-				/* Accept one wildcard as a full refname component. */
-				flags &= ~REFNAME_REFSPEC_PATTERN;
-				component_len = 1;
-			} else {
-				return -1;
-			}
-		}
+		component_len = check_refname_component(refname, &flags);
+		if (component_len <= 0)
+			return -1;
+
 		component_count++;
 		if (refname[component_len] == '\0')
 			break;
diff --git a/refs.h b/refs.h
index e82fca51f501..1809a1d57577 100644
--- a/refs.h
+++ b/refs.h
@@ -278,8 +278,8 @@ extern int for_each_reflog(each_ref_fn, void *);
  * to the rules described in Documentation/git-check-ref-format.txt.
  * If REFNAME_ALLOW_ONELEVEL is set in flags, then accept one-level
  * reference names.  If REFNAME_REFSPEC_PATTERN is set in flags, then
- * allow a "*" wildcard character in place of one of the name
- * components.  No leading or repeated slashes are accepted.
+ * allow a single "*" wildcard character in the refspec. No leading or
+ * repeated slashes are accepted.
  */
 extern int check_refname_format(const char *refname, int flags);
 
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index e5dc62e9efbf..0790edf60de2 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -62,9 +62,11 @@ invalid_ref 'heads/foo\bar'
 invalid_ref "$(printf 'heads/foo\t')"
 invalid_ref "$(printf 'heads/foo\177')"
 valid_ref "$(printf 'heads/fu\303\237')"
-invalid_ref 'heads/*foo/bar' --refspec-pattern
-invalid_ref 'heads/foo*/bar' --refspec-pattern
-invalid_ref 'heads/f*o/bar' --refspec-pattern
+valid_ref 'heads/*foo/bar' --refspec-pattern
+valid_ref 'heads/foo*/bar' --refspec-pattern
+valid_ref 'heads/f*o/bar' --refspec-pattern
+invalid_ref 'heads/f*o*/bar' --refspec-pattern
+invalid_ref 'heads/foo*/bar*' --refspec-pattern
 
 ref='foo'
 invalid_ref "$ref"
-- 
2.4.3
