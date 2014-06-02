From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 1/2] refs.c: optimize check_refname_component()
Date: Mon,  2 Jun 2014 02:20:14 -0400
Message-ID: <1401690015-19191-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 02 08:22:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrLdT-0002vb-Rm
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 08:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbaFBGWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 02:22:16 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33383 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbaFBGWP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 02:22:15 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1566660pad.5
        for <git@vger.kernel.org>; Sun, 01 Jun 2014 23:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jRlmU/1p+3nKFJM8fj7tRz6HKkLgXSvXp0jcYiiWvQo=;
        b=R/cZzmMfDJFyWGFZkBaddVT4C6rezBW7jAnXcE5trMK3reRR/mf50ryLHx4GHra8ZC
         WmUK9I9CLIB9FsINmIjf5n7KkeyNYMPkJG87kkTZJYizxwi9ZOGlFExvVTmSPrAyV28K
         eGdAeH13OfwlYmV8UPsONRe5nPkwjTvTHIcmpJVNkDvaqz4fscdPNEWBBAnrnR1fYluz
         bQOVdksOt6c1e5cm1Vv4WkK7RnDk2CTD60fXpJ9wDNKadKlS0i4QXk/zE0zH7UhUK2m2
         PmOrDIKgUPXzA9uBMCVu0dPq3RpbZaeAFP1dBXjKp2qGAg2jAQlox6xJxzxesf+9ytCc
         WC4Q==
X-Gm-Message-State: ALoCoQkWc3rvQM+InohofDYwNDsVrHNnIi6JsIlH2GTCzncuzZbAesM+qPtpNRbADgXrniIk+XfZ
X-Received: by 10.68.196.202 with SMTP id io10mr37236577pbc.149.1401690134863;
        Sun, 01 Jun 2014 23:22:14 -0700 (PDT)
Received: from stross.twitter.corp (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id mt1sm18534676pbb.31.2014.06.01.23.22.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Jun 2014 23:22:13 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.rc1.18.gf763c0f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250551>

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
index 28d5eca..dd28f2a 100644
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
+		unsigned char ch = (unsigned char) *cp;
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
index c289322..1571176 100755
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
 
+good=$(echo -n '\0377')
+test_refspec fetch "refs/heads/${good}"
+bad=$(echo -n '\011')
+test_refspec fetch "refs/heads/${bad}"				invalid
+
 test_done
-- 
2.0.0.rc1.18.gf763c0f
