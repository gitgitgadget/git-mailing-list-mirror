From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 1/2] refs.c: optimize check_refname_component()
Date: Sun,  1 Jun 2014 01:17:44 -0400
Message-ID: <1401599865-14117-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 01 07:18:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqyA0-0002PG-8L
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jun 2014 07:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbaFAFSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2014 01:18:08 -0400
Received: from mail-qa0-f42.google.com ([209.85.216.42]:47756 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbaFAFSH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2014 01:18:07 -0400
Received: by mail-qa0-f42.google.com with SMTP id j5so1040806qaq.1
        for <git@vger.kernel.org>; Sat, 31 May 2014 22:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AOCVrNQ8WjXQz/9pAMLcIJZ1EV7dfLrMXWWf2Y9zTQY=;
        b=m93J1P215RBBGvLWAkIVGpPXQPqDwbMm3UCK0DCKELSasmq+9SJ0wuKBYSQTZiveUe
         WzLPVNxjttiFIWEVuTPa2yCV1+RyPoTulPKPE0vTaXnhqYkyf44NnlSF/3m6uAzzeKeZ
         sinUWGOd09wnW3o7lEgFoh4fwCck2XochBL+W5EiJqsZtu/Y5eavHQxGaCjpR0ALhAy4
         ZwaH7fRXX16XNYHZD0RpjO/HPUJEhrB5p6Gr+SMSH4/N3apJhOe7PD0RmcsghvkMETK5
         uTTORxwonhI7XcC6ZFDUXw4D+edMjNpLU3vLNKdcjA2uu/nKTT3WuHE6TzN5r5NNpLlO
         opUw==
X-Gm-Message-State: ALoCoQlPJQstd807HUDWVmGgNbJQAwI7CcFKrA7EWU4dCP2cIt6427Q1OxXUfVeMU/cXh/vkdF6g
X-Received: by 10.140.96.51 with SMTP id j48mr34896801qge.24.1401599885775;
        Sat, 31 May 2014 22:18:05 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.196.25])
        by mx.google.com with ESMTPSA id 7sm5746158qgj.27.2014.05.31.22.18.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 31 May 2014 22:18:05 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.rc1.18.gf763c0f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250520>

In a repository with many refs, check_refname_component can be a major
contributor to the runtime of some git commands. One such command is

git rev-parse HEAD

Timings for one particular repo, with about 60k refs, almost all
packed, are:

Old: 35 ms
New: 29 ms

Many other commands which read refs are also sped up.

Signed-off-by: David Turner <dturner@twitter.com>
---
 refs.c | 68 ++++++++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 27 deletions(-)

diff --git a/refs.c b/refs.c
index 28d5eca..62e2301 100644
--- a/refs.c
+++ b/refs.c
@@ -5,9 +5,32 @@
 #include "dir.h"
 #include "string-list.h"
 
+/* How to handle various characters in refnames:
+ * 0: An acceptable character for refs
+ * 1: End-of-component
+ * 2: ., look for a following . to reject .. in refs
+ * 3: @, look for a following { to reject @{ in refs
+ * 9: A bad character, reject ref
+ *
+ * See below for the list of illegal characters, from which
+ * this table is derived.
+ */
+static unsigned char refname_disposition[] = {
+	1, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
+	9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
+	9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 2, 1,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 9,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 0, 9, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 9, 9
+};
+
 /*
- * Make sure "ref" is something reasonable to have under ".git/refs/";
- * We do not like it if:
+ * Try to read one refname component from the front of refname.
+ * Return the length of the component found, or -1 if the component is
+ * not legal.  It is legal if it is something reasonable to have under
+ * ".git/refs/"; We do not like it if:
  *
  * - any path component of it begins with ".", or
  * - it has double dots "..", or
@@ -15,24 +38,7 @@
  * - it ends with a "/".
  * - it ends with ".lock"
  * - it contains a "\" (backslash)
- */
 
-/* Return true iff ch is not allowed in reference names. */
-static inline int bad_ref_char(int ch)
-{
-	if (((unsigned) ch) <= ' ' || ch == 0x7f ||
-	    ch == '~' || ch == '^' || ch == ':' || ch == '\\')
-		return 1;
-	/* 2.13 Pattern Matching Notation */
-	if (ch == '*' || ch == '?' || ch == '[') /* Unsupported */
-		return 1;
-	return 0;
-}
-
-/*
- * Try to read one refname component from the front of refname.  Return
- * the length of the component found, or -1 if the component is not
- * legal.
  */
 static int check_refname_component(const char *refname, int flags)
 {
@@ -40,17 +46,25 @@ static int check_refname_component(const char *refname, int flags)
 	char last = '\0';
 
 	for (cp = refname; ; cp++) {
-		char ch = *cp;
-		if (ch == '\0' || ch == '/')
+		unsigned char ch = (unsigned char) *cp;
+		char disp = refname_disposition[ch];
+		switch(disp) {
+		case 1:
+			goto out;
+		case 2:
+			if (last == '.')
+				return -1; /* Refname contains "..". */
 			break;
-		if (bad_ref_char(ch))
-			return -1; /* Illegal character in refname. */
-		if (last == '.' && ch == '.')
-			return -1; /* Refname contains "..". */
-		if (last == '@' && ch == '{')
-			return -1; /* Refname contains "@{". */
+		case 3:
+			if (last == '@')
+				return -1; /* Refname contains "@{". */
+			break;
+		case 9:
+			return -1;
+		}
 		last = ch;
 	}
+out:
 	if (cp == refname)
 		return 0; /* Component has zero length. */
 	if (refname[0] == '.') {
-- 
2.0.0.rc1.18.gf763c0f
