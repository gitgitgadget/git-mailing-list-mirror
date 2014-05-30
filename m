From: Pasha Bolokhov <pasha.bolokhov@gmail.com>
Subject: [PATCH alt-v1] Improve function dir.c:trim_trailing_spaces()
Date: Fri, 30 May 2014 13:20:33 -0700
Message-ID: <1401481233-14500-1-git-send-email-pasha.bolokhov@gmail.com>
Cc: pclouds@gmail.com, peff@peff.net, gitster@pobox.com,
	Pasha Bolokhov <pasha.bolokhov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 30 22:21:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqTIe-0002H7-4w
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 22:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934581AbaE3UVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 16:21:07 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:45998 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934559AbaE3UVF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 16:21:05 -0400
Received: by mail-pb0-f53.google.com with SMTP id md12so2090421pbc.40
        for <git@vger.kernel.org>; Fri, 30 May 2014 13:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=JMMmkPAuLWomvc2IEJcohsJnEDp3dUyuo4baXNvR5oc=;
        b=RkrKhftQPBOmJdikAvwuKAkmcWwsOYTJMJuhl8Xgz4zOQpp6e6/pQ0oKzrPKnTjtni
         bAXZMfdmhYzUvhvh3SINJ9CAeDD2Pxdrcu+uoV1ffkQQsLL/Ti9auH7xhziIF7XaLRpI
         8hb7cGLZOYkzWH9KXyESxmI8L96PGaorafTAVxX7QImWKmz/hz3NMuGTP02+IGpNKihL
         6gwHsnUf5i30CT6jL/XHUlmcge2cBVnUbQxsFh5I/bOGlD4iuMwqPByLqd5hp4jfMgmJ
         bCVDnq/POl/FEpC5JJ9FrmVi8ZT1AfkbjtGX49nb8VuclDGnpvsG9KQuSJ71OAVIxIxZ
         N5bQ==
X-Received: by 10.66.163.164 with SMTP id yj4mr21101270pab.91.1401481264760;
        Fri, 30 May 2014 13:21:04 -0700 (PDT)
Received: from ani.gv.shawcable.net (S0106586d8f8ca92a.gv.shawcable.net. [96.54.196.148])
        by mx.google.com with ESMTPSA id or4sm7843941pbb.17.2014.05.30.13.21.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 May 2014 13:21:04 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250476>

Discard unnecessary 'nr_spaces' variable and improve
the 'if' structure. Switch to pointers instead of integers

Slightly more rare occurrences of 'text  \    ' with a backslash
in between spaces are handled correctly. Namely, the code in
8ba87adad6 does not reset 'last_space' when a backslash is
encountered and the above line stays intact as
a result. Add a test at the end of t/t0008-ignores.sh to
exhibit this behavior

Signed-off-by: Pasha Bolokhov <pasha.bolokhov@gmail.com>
---
Instead of the "optimized" version, which had complaints about
reasonability, I am attaching the "correction" of the original version.
'last_space' was not reset after encountering a backslash, and
'nr_spaces' is an unnecessary variable.

I myself am still leaning towards the optimized version (which scans
backwards instead of forward), since it completely ignores strings
which do not have spaces at the end, while these forward implementations
(both the one being attached and the original one) always scan
all strings through. Again, I'm not attaching the optimized one
because its readability is indeed less

 dir.c              | 29 ++++++++++++++---------------
 t/t0008-ignores.sh | 21 +++++++++++++++++++++
 2 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/dir.c b/dir.c
index eb6f581..e67dcc2 100644
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
+			if (last_space == NULL)
+				last_space = p;
+		} else {
+			if (*p == '\\')
+				p++;
+			last_space = NULL;
+		}
+
+	if (last_space != NULL)
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
