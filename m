From: David Turner <dturner@twopensource.com>
Subject: [PATCH 13/43] refs.c: move check_refname_format to the common code
Date: Wed,  2 Sep 2015 21:54:43 -0400
Message-ID: <1441245313-11907-14-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twitter.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:57:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJmV-0007Mb-TO
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbbICB5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:57:31 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34874 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbbICBzj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:55:39 -0400
Received: by qkcj187 with SMTP id j187so15698277qkc.2
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8yCKENF2OcxfUDrW+fuXXtrfq4R4e+r2sYlMXehA6lI=;
        b=P8bsQzFS39o2Pyrnylt7RqyqHn3tjlvl1dcHLNukpYdCwdLVaKZM9R4MQNAU2jPkO8
         UyxPZn+G80VvrOlB+jaC/S5DcMs/PTJ8f0I/TQETkAlan01Gb971WO99l2Jh7G+MLuUr
         PJ4n0Yo2fY+NmySAczbljJkTky3ivzMm5xXmujQK2w7J790GIqDSp+z5lNocVoL0EIjJ
         piMH38WdMrjlSVWANK+HnvrZpbbmuc3Q1HNXp0YSHvxnUD8zJHVVPnGkcItAJR1MxlVU
         ctLIOXpLdDJhvh8mgSxJ5PpPe+vbq8RlVA7OOoxwKk5V7W8bbdtbZGVQBKeIPjGe1IjJ
         mb8Q==
X-Gm-Message-State: ALoCoQk2o3FGmyexn6DSHnX4a6NBCWM1bDfnHSy1aYkRqfEmzAe4OkE3W6tab9Ad3tWGmK6ik35Q
X-Received: by 10.55.221.142 with SMTP id u14mr32845039qku.78.1441245338674;
        Wed, 02 Sep 2015 18:55:38 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.55.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:55:38 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277176>

From: Ronnie Sahlberg <sahlberg@google.com>

This function does not contain any backend specific code so we
move it to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twitter.com>
---
 refs-be-files.c | 109 --------------------------------------------------------
 refs.c          | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+), 109 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 6328e75..3b06714 100644
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
index 039e5c0..e9cc2d4 100644
--- a/refs.c
+++ b/refs.c
@@ -658,3 +658,112 @@ char *resolve_refdup(const char *refname, int resolve_flags,
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
2.0.4.315.gad8727a-twtrsrc
