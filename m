From: Pasha Bolokhov <pasha.bolokhov@gmail.com>
Subject: [PATCH alt-v2] Improve function dir.c:trim_trailing_spaces()
Date: Mon,  2 Jun 2014 09:45:51 -0700
Message-ID: <1401727551-8871-1-git-send-email-pasha.bolokhov@gmail.com>
Cc: pclouds@gmail.com, peff@peff.net, gitster@pobox.com,
	Pasha Bolokhov <pasha.bolokhov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 02 18:46:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrVN6-0000h7-UV
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 18:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216AbaFBQqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 12:46:00 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:59979 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755484AbaFBQp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 12:45:59 -0400
Received: by mail-pa0-f51.google.com with SMTP id kx10so2114318pab.10
        for <git@vger.kernel.org>; Mon, 02 Jun 2014 09:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=TekJDFf7/5OqbSFyyv5CNQlfibeah7NBXEGHjOlmMxo=;
        b=XNZs/BlJaSAdpwbwSsdu44WFkodTLMg/WGb/dZf0qMqC1cFS111Mc7Cnn+N2AKZqig
         NrWkcjWOX0P8Lv0C6ur8bl7SexxgMlOQUHA8x/iLPkGDM89RkJcoG3eVuhQWMlXwhxNg
         Y+71gU8w/z7nLIQ5T0gdDevVsPcoGvRz+XQdgFXbEl6x9dcAHbTQ17Mea/gsS5BitsBM
         DWmaBRzBpGbtXfhYEWoYe/X7XTE1nLE9M9VTEUlywzZythmnn/5mcgNnS1uqRobfxIh5
         rCsaKjPyvl/gOcMt29QCEg9Y4iB4AO7dYhB/BFTXonXUendpZ+OKHJ216XKReBxdB+3g
         Qsgw==
X-Received: by 10.67.13.134 with SMTP id ey6mr42102573pad.44.1401727558989;
        Mon, 02 Jun 2014 09:45:58 -0700 (PDT)
Received: from ani.gv.shawcable.net (S0106586d8f8ca92a.gv.shawcable.net. [96.54.196.148])
        by mx.google.com with ESMTPSA id cj1sm66265729pac.40.2014.06.02.09.45.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jun 2014 09:45:58 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250573>

Discard the unnecessary 'nr_spaces' variable, remove 'strlen()' and
improve the 'if' structure. Switch to pointers instead of integers

Slightly more rare occurrences of 'text  \    ' with a backslash
in between spaces are handled correctly. Namely, the code in
8ba87adad6 does not reset 'last_space' when a backslash is
encountered and the above line stays intact as a result.
Add a test at the end of t/t0008-ignores.sh to exhibit this behavior

Signed-off-by: Pasha Bolokhov <pasha.bolokhov@gmail.com>
---
After correcting for the trailing backslash 'text\', a switch()
structure gives better readability than nested 'ifs', the way I see it.
Add a test to show that the trailing backslash 'text\' is handled
correctly

 dir.c              | 35 ++++++++++++++++++++---------------
 t/t0008-ignores.sh | 23 +++++++++++++++++++++++
 2 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/dir.c b/dir.c
index eb6f581..06483d4 100644
--- a/dir.c
+++ b/dir.c
@@ -508,21 +508,26 @@ void clear_exclude_list(struct exclude_list *el)
 
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
+		switch (*p) {
+		case ' ':
+			if (!last_space)
+				last_space = p;
+			break;
+
+		case '\\':
+			p++;
+			if (!*p)
+				return;
+
+		default:
+			last_space = NULL;
+		}
+
+	if (last_space)
+		*last_space = '\0';
 }
 
 int add_excludes_from_file_to_list(const char *fname,
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 63beb99..4cea858 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -806,4 +806,27 @@ test_expect_success !MINGW 'quoting allows trailing whitespace' '
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
+	>"whitespace/trailing 6 \\a\\"	&&
+	>whitespace/untracked &&
+	echo "whitespace/trailing 1 \\    "			>ignore  &&
+	echo "whitespace/trailing 2 \\\\\\\\\\\\\\\\"		>>ignore &&
+	echo "whitespace/trailing 3 \\\\\\\\\\\\\\\\ "		>>ignore &&
+	echo "whitespace/trailing 4   \\\\\\\\\\\\    "		>>ignore &&
+	echo "whitespace/trailing 5 \\\\\\\\ \\\\\\\\\\\\   "	>>ignore &&
+	echo "whitespace/trailing 6 \\\\\\\\a\\\\\\\\"		>>ignore &&
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
