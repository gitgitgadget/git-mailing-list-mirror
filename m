From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 13/26] refs.c: move check_refname_format to the common code
Date: Thu, 15 Oct 2015 15:46:37 -0400
Message-ID: <1444938410-2345-14-git-send-email-dturner@twopensource.com>
References: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 15 21:48:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmoVR-0007RA-RW
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 21:48:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbbJOTr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 15:47:58 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:35681 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824AbbJOTrV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 15:47:21 -0400
Received: by qgt47 with SMTP id 47so80820832qgt.2
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 12:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QqAPo3Ys095SC2Ho8bJfTgdYVKVm1Ip3TBzTB44JCV8=;
        b=mx1Lv22uKjGRRa39NPuF+tnzv8ONkSPEMNxiyhMo8Ye9+9d0E3iNtIakKNMj4wR0+t
         Kz+bRo+EHmXc/B9JvIHxjTzTgHKxx0vexQ9aORsc5tbl69FG7lSojggT7cMHPl0ZgkQg
         nFhlWbQnHOlPBjFDV0vVxCiDYXvI8pLbLDOyi/gqqtSXcM8KVADcTS+BcLmcH4UszBca
         Akqxm+Hpf7MYRL8REHqKl7TS5w6+KDoMNozKL0SGsYwSojOoBeV0BgwWIXucADLclYQy
         xUYw2AsEFSN66hD2rkQ6kxO7gfAsPsWWZ89Sop1Ly6lO9Q0rTCVuEkGwjWTRabS1lXDk
         N+5A==
X-Gm-Message-State: ALoCoQnATIlnp0WVPF6XKNP6RQLF9ncXyVvY+QiqDnYWwXZtouDDt/5N3L9yntCPHaTB0tyHkZ/A
X-Received: by 10.141.28.69 with SMTP id f66mr14201239qhe.67.1444938441063;
        Thu, 15 Oct 2015 12:47:21 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p193sm6054142qha.29.2015.10.15.12.47.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Oct 2015 12:47:20 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279698>

From: Ronnie Sahlberg <sahlberg@google.com>

This function does not contain any backend specific code so we
move it to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs-be-files.c | 109 --------------------------------------------------------
 refs.c          | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+), 109 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 589e10d..345bee7 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -14,27 +14,6 @@ struct ref_lock {
 };
 
 /*
- * How to handle various characters in refnames:
- * 0: An acceptable character for refs
- * 1: End-of-component
- * 2: ., look for a preceding . to reject .. in refs
- * 3: {, look for a preceding @ to reject @{ in refs
- * 4: A bad character: ASCII control characters, and
- *    ":", "?", "[", "\", "^", "~", SP, or TAB
- * 5: *, reject unless REFNAME_REFSPEC_PATTERN is set
- */
-static unsigned char refname_disposition[256] = {
-	1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
-	4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
-	4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 2, 1,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 4,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 4, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 4, 4
-};
-
-/*
  * Flag passed to lock_ref_sha1_basic() telling it to tolerate broken
  * refs (i.e., because the reference is about to be deleted anyway).
  */
@@ -69,94 +48,6 @@ static unsigned char refname_disposition[256] = {
  * value to ref_update::flags
  */
 
-/*
- * Try to read one refname component from the front of refname.
- * Return the length of the component found, or -1 if the component is
- * not legal.  It is legal if it is something reasonable to have under
- * ".git/refs/"; We do not like it if:
- *
- * - any path component of it begins with ".", or
- * - it has double dots "..", or
- * - it has ASCII control characters, or
- * - it has ":", "?", "[", "\", "^", "~", SP, or TAB anywhere, or
- * - it has "*" anywhere unless REFNAME_REFSPEC_PATTERN is set, or
- * - it ends with a "/", or
- * - it ends with ".lock", or
- * - it contains a "@{" portion
- */
-static int check_refname_component(const char *refname, int *flags)
-{
-	const char *cp;
-	char last = '\0';
-
-	for (cp = refname; ; cp++) {
-		int ch = *cp & 255;
-		unsigned char disp = refname_disposition[ch];
-		switch (disp) {
-		case 1:
-			goto out;
-		case 2:
-			if (last == '.')
-				return -1; /* Refname contains "..". */
-			break;
-		case 3:
-			if (last == '@')
-				return -1; /* Refname contains "@{". */
-			break;
-		case 4:
-			return -1;
-		case 5:
-			if (!(*flags & REFNAME_REFSPEC_PATTERN))
-				return -1; /* refspec can't be a pattern */
-
-			/*
-			 * Unset the pattern flag so that we only accept
-			 * a single asterisk for one side of refspec.
-			 */
-			*flags &= ~ REFNAME_REFSPEC_PATTERN;
-			break;
-		}
-		last = ch;
-	}
-out:
-	if (cp == refname)
-		return 0; /* Component has zero length. */
-	if (refname[0] == '.')
-		return -1; /* Component starts with '.'. */
-	if (cp - refname >= LOCK_SUFFIX_LEN &&
-	    !memcmp(cp - LOCK_SUFFIX_LEN, LOCK_SUFFIX, LOCK_SUFFIX_LEN))
-		return -1; /* Refname ends with ".lock". */
-	return cp - refname;
-}
-
-int check_refname_format(const char *refname, int flags)
-{
-	int component_len, component_count = 0;
-
-	if (!strcmp(refname, "@"))
-		/* Refname is a single character '@'. */
-		return -1;
-
-	while (1) {
-		/* We are at the start of a path component. */
-		component_len = check_refname_component(refname, &flags);
-		if (component_len <= 0)
-			return -1;
-
-		component_count++;
-		if (refname[component_len] == '\0')
-			break;
-		/* Skip to next component. */
-		refname += component_len + 1;
-	}
-
-	if (refname[component_len - 1] == '.')
-		return -1; /* Refname ends with '.'. */
-	if (!(flags & REFNAME_ALLOW_ONELEVEL) && component_count < 2)
-		return -1; /* Refname has only one component. */
-	return 0;
-}
-
 struct ref_entry;
 
 /*
diff --git a/refs.c b/refs.c
index fcd5ddd..d79ba82 100644
--- a/refs.c
+++ b/refs.c
@@ -623,3 +623,112 @@ char *resolve_refdup(const char *refname, int resolve_flags,
 	return xstrdup_or_null(resolve_ref_unsafe(refname, resolve_flags,
 						  sha1, flags));
 }
+
+/*
+ * How to handle various characters in refnames:
+ * 0: An acceptable character for refs
+ * 1: End-of-component
+ * 2: ., look for a preceding . to reject .. in refs
+ * 3: {, look for a preceding @ to reject @{ in refs
+ * 4: A bad character: ASCII control characters, and
+ *    ":", "?", "[", "\", "^", "~", SP, or TAB
+ * 5: *, reject unless REFNAME_REFSPEC_PATTERN is set
+ */
+static unsigned char refname_disposition[256] = {
+	1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
+	4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
+	4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 2, 1,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 4,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 4, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 4, 4
+};
+
+/*
+ * Try to read one refname component from the front of refname.
+ * Return the length of the component found, or -1 if the component is
+ * not legal.  It is legal if it is something reasonable to have under
+ * ".git/refs/"; We do not like it if:
+ *
+ * - any path component of it begins with ".", or
+ * - it has double dots "..", or
+ * - it has ASCII control characters, or
+ * - it has ":", "?", "[", "\", "^", "~", SP, or TAB anywhere, or
+ * - it has "*" anywhere unless REFNAME_REFSPEC_PATTERN is set, or
+ * - it ends with a "/", or
+ * - it ends with ".lock", or
+ * - it contains a "@{" portion
+ */
+static int check_refname_component(const char *refname, int *flags)
+{
+	const char *cp;
+	char last = '\0';
+
+	for (cp = refname; ; cp++) {
+		int ch = *cp & 255;
+		unsigned char disp = refname_disposition[ch];
+		switch (disp) {
+		case 1:
+			goto out;
+		case 2:
+			if (last == '.')
+				return -1; /* Refname contains "..". */
+			break;
+		case 3:
+			if (last == '@')
+				return -1; /* Refname contains "@{". */
+			break;
+		case 4:
+			return -1;
+		case 5:
+			if (!(*flags & REFNAME_REFSPEC_PATTERN))
+				return -1; /* refspec can't be a pattern */
+
+			/*
+			 * Unset the pattern flag so that we only accept
+			 * a single asterisk for one side of refspec.
+			 */
+			*flags &= ~ REFNAME_REFSPEC_PATTERN;
+			break;
+		}
+		last = ch;
+	}
+out:
+	if (cp == refname)
+		return 0; /* Component has zero length. */
+	if (refname[0] == '.')
+		return -1; /* Component starts with '.'. */
+	if (cp - refname >= LOCK_SUFFIX_LEN &&
+	    !memcmp(cp - LOCK_SUFFIX_LEN, LOCK_SUFFIX, LOCK_SUFFIX_LEN))
+		return -1; /* Refname ends with ".lock". */
+	return cp - refname;
+}
+
+int check_refname_format(const char *refname, int flags)
+{
+	int component_len, component_count = 0;
+
+	if (!strcmp(refname, "@"))
+		/* Refname is a single character '@'. */
+		return -1;
+
+	while (1) {
+		/* We are at the start of a path component. */
+		component_len = check_refname_component(refname, &flags);
+		if (component_len <= 0)
+			return -1;
+
+		component_count++;
+		if (refname[component_len] == '\0')
+			break;
+		/* Skip to next component. */
+		refname += component_len + 1;
+	}
+
+	if (refname[component_len - 1] == '.')
+		return -1; /* Refname ends with '.'. */
+	if (!(flags & REFNAME_ALLOW_ONELEVEL) && component_count < 2)
+		return -1; /* Refname has only one component. */
+	return 0;
+}
-- 
2.4.2.644.g97b850b-twtrsrc
