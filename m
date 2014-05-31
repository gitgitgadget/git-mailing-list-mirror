From: Pasha Bolokhov <pasha.bolokhov@gmail.com>
Subject: [PATCH] Improve function dir.c:trim_trailing_spaces()
Date: Sat, 31 May 2014 08:21:31 -0700
Message-ID: <1401549691-20788-1-git-send-email-pasha.bolokhov@gmail.com>
Cc: pclouds@gmail.com, peff@peff.net, gitster@pobox.com,
	Pasha Bolokhov <pasha.bolokhov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 31 17:21:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wql6T-0002oK-A9
	for gcvg-git-2@plane.gmane.org; Sat, 31 May 2014 17:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbaEaPVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2014 11:21:45 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:62803 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbaEaPVo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2014 11:21:44 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so2708027pad.23
        for <git@vger.kernel.org>; Sat, 31 May 2014 08:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=lGCnMrzaoqwJSpJud0xJ4mIgv4OhJ2GNd32RrUikA1c=;
        b=AFkaOc2YgUDsmwqkZzn/L9ejeKZusufbHwCJbZX61DA8Eiwg6JwpyF39mEe2ymDsh5
         p0NeMVO3fLiE9jtKrq6HqE5Ttj8p+OjTE0UsQ5NU0rX1STUVLfliwNPPdt3zzrsoDEuC
         Tbl7l23/d90Ez2+BhFDs3LNbieS3dh9lWOo2JrbJCoc1BljFqUgjtebzs205DsqqFR3i
         Dn+g/XT18MfQ8YDOsCP2pm0PkUzBetgM468TnbjcFleez/5NeU1kqxh8pZGYQIsg7QaB
         l/pN6P+8IYUxxhVHv4Or87o19G/zz9huePH53BQhwnNJvp7BxScX78uvDlhH2zuGNaci
         4YMw==
X-Received: by 10.68.202.194 with SMTP id kk2mr27159442pbc.156.1401549704526;
        Sat, 31 May 2014 08:21:44 -0700 (PDT)
Received: from ani.gv.shawcable.net (S0106586d8f8ca92a.gv.shawcable.net. [96.54.196.148])
        by mx.google.com with ESMTPSA id ei4sm11800834pbb.42.2014.05.31.08.21.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 31 May 2014 08:21:43 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250511>

Discard the unnecessary 'nr_spaces' variable, remove 'strlen()' and
improve the 'if' structure. Switch to pointers instead of integers

Slightly more rare occurrences of 'text  \    ' with a backslash
in between spaces are handled correctly. Namely, the code in
8ba87adad6 does not reset 'last_space' when a backslash is
encountered and the above line stays intact as a result.
Add a test at the end of t/t0008-ignores.sh to exhibit this behavior

Signed-off-by: Pasha Bolokhov <pasha.bolokhov@gmail.com>
---
Correct 'if()' statements to conform to the general style
which implies using 'if(ptr)' as an equivalent of 'if(ptr != NULL)'

 dir.c              | 29 ++++++++++++++---------------
 t/t0008-ignores.sh | 21 +++++++++++++++++++++
 2 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/dir.c b/dir.c
index eb6f581..98c81a8 100644
--- a/dir.c
+++ b/dir.c
@@ -508,21 +508,20 @@ void clear_exclude_list(struct exclude_list *el)
 
 static void trim_trailing_spaces(char *buf)
 {
-	int i, last_space = -1, nr_spaces, len = strlen(buf);
-	for (i = 0; i < len; i++)
-		if (buf[i] == '\\')
-			i++;
-		else if (buf[i] == ' ') {
-			if (last_space == -1) {
-				last_space = i;
-				nr_spaces = 1;
-			} else
-				nr_spaces++;
-		} else
-			last_space = -1;
-
-	if (last_space != -1 && last_space + nr_spaces == len)
-		buf[last_space] = '\0';
+	char *p, *last_space = NULL;
+
+	for (p = buf; *p; p++)
+		if (*p == ' ') {
+			if (!last_space)
+				last_space = p;
+		} else {
+			if (*p == '\\')
+				p++;
+			last_space = NULL;
+		}
+
+	if (last_space)
+		*last_space = '\0';
 }
 
 int add_excludes_from_file_to_list(const char *fname,
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 63beb99..7becf96 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -806,4 +806,25 @@ test_expect_success !MINGW 'quoting allows trailing whitespace' '
 	test_cmp err.expect err
 '
 
+test_expect_success NOT_MINGW,NOT_CYGWIN 'correct handling of backslashes' '
+	rm -rf whitespace &&
+	mkdir whitespace &&
+	>"whitespace/trailing 1  "	&&
+	>"whitespace/trailing 2 \\\\"	&&
+	>"whitespace/trailing 3 \\\\"	&&
+	>"whitespace/trailing 4   \\ "	&&
+	>"whitespace/trailing 5 \\ \\ "	&&
+	>whitespace/untracked &&
+	echo "whitespace/trailing 1 \\    "			>ignore  &&
+	echo "whitespace/trailing 2 \\\\\\\\\\\\\\\\"		>>ignore &&
+	echo "whitespace/trailing 3 \\\\\\\\\\\\\\\\ "		>>ignore &&
+	echo "whitespace/trailing 4   \\\\\\\\\\\\    "		>>ignore &&
+	echo "whitespace/trailing 5 \\\\\\\\ \\\\\\\\\\\\   "	>>ignore &&
+	echo whitespace/untracked >expect &&
+	: >err.expect &&
+	git ls-files -o -X ignore whitespace >actual 2>err &&
+	test_cmp expect actual &&
+	test_cmp err.expect err
+'
+
 test_done
-- 
1.9.1
