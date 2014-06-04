From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 1/2] refs.c: optimize check_refname_component()
Date: Tue,  3 Jun 2014 23:38:10 -0400
Message-ID: <1401853091-15535-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Jun 04 05:38:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ws225-0000VD-MZ
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 05:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087AbaFDDi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 23:38:29 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:63598 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbaFDDi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 23:38:28 -0400
Received: by mail-qg0-f50.google.com with SMTP id z60so14862471qgd.9
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 20:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qDdJgokKCNy0tPeJz7VZ1hQP5hVBCoK8jLVw43n/h9E=;
        b=nJeYKp/teKAZ5HZuGBtkcVn3C2oRji3GDLDrY51AyRrltW7spcgv/delXiKRHBil60
         x34Gj9GKCJNFkF/oCqUmmB8qTNCoMfR5/oOEsfcn6W8gDXt+zfpCG2bMNtQIUXS/yTX4
         dlTRv3sFKbW8hx99WqoPgfe4VBuSECepkB6MUspEtkhS5DAIxjZGErf2sbxF2b83vxyT
         9L1gA6GBwTfoEhVJVrR5agLWTELZu8ELSoIQ1qziggOYnhA2qQuyXK9tCkub6wXHXDAp
         R/Gr9QF16IQIwajIeDOh4KM5vAI6vlvoPoyGYOepNmEFC/q2pqemAWV7y8gRYnFa+ltl
         v7IQ==
X-Gm-Message-State: ALoCoQmI9olZEBIM/HZ5sLEpAZ8p13ACzeq4pK7SD9arTezAkVZ6lVCNp7GNTfOBRs38bzsbsyF3
X-Received: by 10.224.127.131 with SMTP id g3mr1667611qas.31.1401853107852;
        Tue, 03 Jun 2014 20:38:27 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.196.25])
        by mx.google.com with ESMTPSA id m2sm2141188qac.3.2014.06.03.20.38.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 20:38:27 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.rc1.18.gf763c0f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250713>

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
 refs.c             | 67 +++++++++++++++++++++++++++++++-----------------------
 t/t5511-refspec.sh |  6 ++++-
 2 files changed, 44 insertions(+), 29 deletions(-)

diff --git a/refs.c b/refs.c
index 28d5eca..46139d2 100644
--- a/refs.c
+++ b/refs.c
@@ -6,8 +6,29 @@
 #include "string-list.h"
 
 /*
- * Make sure "ref" is something reasonable to have under ".git/refs/";
- * We do not like it if:
+ * How to handle various characters in refnames:
+ * 0: An acceptable character for refs
+ * 1: End-of-component
+ * 2: ., look for a preceding . to reject .. in refs
+ * 3: {, look for a preceding @ to reject @{ in refs
+ * 4: A bad character: ASCII control characters, "~", "^", ":" or SP
+ */
+static unsigned char refname_disposition[256] = {
+	1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
+	4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
+	4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 2, 1,
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
  *
  * - any path component of it begins with ".", or
  * - it has double dots "..", or
@@ -16,41 +37,31 @@
  * - it ends with ".lock"
  * - it contains a "\" (backslash)
  */
-
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
- */
 static int check_refname_component(const char *refname, int flags)
 {
 	const char *cp;
 	char last = '\0';
 
 	for (cp = refname; ; cp++) {
-		char ch = *cp;
-		if (ch == '\0' || ch == '/')
+		int ch = *cp & 255;
+		unsigned char disp = refname_disposition[ch];
+		switch(disp) {
+		case 1:
+			goto out;
+		case 2:
+			if (last == '.')
+				return -1; /* Refname contains "..". */
+			break;
+		case 3:
+			if (last == '@')
+				return -1; /* Refname contains "@{". */
 			break;
-		if (bad_ref_char(ch))
-			return -1; /* Illegal character in refname. */
-		if (last == '.' && ch == '.')
-			return -1; /* Refname contains "..". */
-		if (last == '@' && ch == '{')
-			return -1; /* Refname contains "@{". */
+		case 4:
+			return -1;
+		}
 		last = ch;
 	}
+out:
 	if (cp == refname)
 		return 0; /* Component has zero length. */
 	if (refname[0] == '.') {
diff --git a/t/t5511-refspec.sh b/t/t5511-refspec.sh
index c289322..de6db86 100755
--- a/t/t5511-refspec.sh
+++ b/t/t5511-refspec.sh
@@ -5,7 +5,6 @@ test_description='refspec parsing'
 . ./test-lib.sh
 
 test_refspec () {
-
 	kind=$1 refspec=$2 expect=$3
 	git config remote.frotz.url "." &&
 	git config --remove-section remote.frotz &&
@@ -84,4 +83,9 @@ test_refspec push 'refs/heads/*/*/for-linus:refs/remotes/mine/*' invalid
 test_refspec fetch 'refs/heads/*/for-linus:refs/remotes/mine/*'
 test_refspec push 'refs/heads/*/for-linus:refs/remotes/mine/*'
 
+good=$(printf '\303\204')
+test_refspec fetch "refs/heads/${good}"
+bad=$(printf '\011tab')
+test_refspec fetch "refs/heads/${bad}"				invalid
+
 test_done
-- 
2.0.0.rc1.18.gf763c0f
