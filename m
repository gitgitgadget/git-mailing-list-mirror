From: Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH] refs: loosen restrictions on wildcard '*' refspecs
Date: Tue,  7 Jul 2015 22:36:46 -0700
Message-ID: <1436333806-27076-1-git-send-email-jacob.keller@gmail.com>
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 07:37:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCi2j-0004Nn-Go
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 07:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbbGHFg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 01:36:59 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35786 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbbGHFg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 01:36:58 -0400
Received: by pactm7 with SMTP id tm7so125449163pac.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 22:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ZtPh9KoVJIYQH313QT11hn5GH0ITmn4xOGyYVxZlIJI=;
        b=j/sTna0B2M2fofAikMGkQf0WUtltjohVq1BnJczCcfxf2Tk2OlUBAYbSvAk/18WmGd
         r0gs2oOG/0Nk7iBivF6Vm52EDWKkbC6cZ1/mHPT1AYmmEEH/xyb6NiXCM6YSVOYPhvZ0
         vkQlG5FQyOhA7WJxsHk/HUCOcDpKCR9q9GNMr141pVGvnYEWwVqW4OfCSXieJoByq+7b
         dUd76bq7NCo7Wb+FWENkamHSmD/XiHw2063YOdp5umMlsEjIXLIMX2qbPvZy1/9HaidX
         R6DUdYTi28r3EUDaZn5eNdXOMd+xvkesvEIVEbl65Za9Mi8jGIlvqW5yXo+PM3WycE2k
         BnOg==
X-Received: by 10.68.200.100 with SMTP id jr4mr16322777pbc.168.1436333817522;
        Tue, 07 Jul 2015 22:36:57 -0700 (PDT)
Received: from localhost ([2601:1c0:4701:21d3:59db:35c9:a379:6117])
        by smtp.gmail.com with ESMTPSA id ql9sm967900pbc.65.2015.07.07.22.36.56
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 07 Jul 2015 22:36:56 -0700 (PDT)
X-Mailer: git-send-email 1.9.4.msysgit.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273638>

This patch updates the check_refname_component logic in order to allow for
a less strict refspec format in regards to REFNAME_REFSPEC_PATTERN.
Previously the '*' could only replace a single full component, and could
not replace arbitrary text. Now, refs such as `foo/bar*:foo/bar*` will be
accepted. This allows for somewhat more flexibility in references and does
not break any current users. The ref matching code already allows this but
the check_refname_format did not.

This patch also streamlines the code by making this new check part of
check_refname_component instead of checking after we error during
check_refname_format, which makes more sense with how we check other
issues in refname components.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.iabervon.org>
Cc: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-check-ref-format.txt |  4 ++--
 refs.c                                 | 39 +++++++++++++++++++---------------
 refs.h                                 |  4 ++--
 3 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index fc02959..9044dfa 100644
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
index 7ac05cf..8702644 100644
--- a/refs.c
+++ b/refs.c
@@ -20,11 +20,12 @@ struct ref_lock {
  * 2: ., look for a preceding . to reject .. in refs
  * 3: {, look for a preceding @ to reject @{ in refs
  * 4: A bad character: ASCII control characters, "~", "^", ":" or SP
+ * 5: check for patterns to reject unless REFNAME_REFSPEC_PATTERN is set
  */
 static unsigned char refname_disposition[256] = {
 	1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
 	4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
-	4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 2, 1,
+	4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 2, 1,
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 4,
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 4, 0,
@@ -71,11 +72,13 @@ static unsigned char refname_disposition[256] = {
  * - any path component of it begins with ".", or
  * - it has double dots "..", or
  * - it has ASCII control character, "~", "^", ":" or SP, anywhere, or
- * - it ends with a "/".
- * - it ends with ".lock"
- * - it contains a "\" (backslash)
+ * - it ends with a "/", or
+ * - it ends with ".lock", or
+ * - it contains a "\" (backslash), or
+ * - it contains a "@{" portion, or
+ * - it contains a '*' unless REFNAME_REFSPEC_PATTERN is set
  */
-static int check_refname_component(const char *refname, int flags)
+static int check_refname_component(const char *refname, int *flags)
 {
 	const char *cp;
 	char last = '\0';
@@ -96,6 +99,16 @@ static int check_refname_component(const char *refname, int flags)
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
@@ -120,18 +133,10 @@ int check_refname_format(const char *refname, int flags)
 
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
index 8c3d433..1fd1272 100644
--- a/refs.h
+++ b/refs.h
@@ -224,8 +224,8 @@ extern int for_each_reflog(each_ref_fn, void *);
  * to the rules described in Documentation/git-check-ref-format.txt.
  * If REFNAME_ALLOW_ONELEVEL is set in flags, then accept one-level
  * reference names.  If REFNAME_REFSPEC_PATTERN is set in flags, then
- * allow a "*" wildcard character in place of one of the name
- * components.  No leading or repeated slashes are accepted.
+ * allow a single "*" wildcard character in the refspec. No leading or
+ * repeated slashes are accepted.
  */
 extern int check_refname_format(const char *refname, int flags);
 
-- 
1.9.4.msysgit.2
