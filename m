From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] fast-import: do not truncate exported marks file
Date: Tue, 17 May 2016 16:40:23 -0500
Message-ID: <1463521223-14565-1-git-send-email-felipe.contreras@gmail.com>
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: git-fc@googlegroups.com
X-From: git-owner@vger.kernel.org Tue May 17 23:40:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2mjE-0008F8-V2
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 23:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbcEQVkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 17:40:33 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35966 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbcEQVkc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 17:40:32 -0400
Received: by mail-oi0-f67.google.com with SMTP id i2so6038834oib.3
        for <git@vger.kernel.org>; Tue, 17 May 2016 14:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=sQn04zimoeTAvQByXrhKq++b1S2amOx0lRpSk6xNJgg=;
        b=RgyvwaGNGOp1NCQG8lqRH0+ml5VbMNwCfBzF3hwLPh9Beuz7BwFON1x++3tui8mSYJ
         zep6o8EOw8Wx6vp1j1w8831N97SnT6pAwkng8iIV5+K6w3ANYRFhSHtyH/TZeDphpBlb
         luoXzqXotdHHBTStx0dhFDuZjiA3nvRXbAsyQs1LGT0qHA6L2gRyXZRU+uNTmt42BukX
         kyZRuKmCrNvZfZ3eT+vurACBGD7ILrbzb2DAr/du6PBMrSQQYE305r1xU2Ox9Ok3PhA5
         mgcRdvHmoNJy414V+0yWLFyjAcGGLjeM4emg3Xx0l9t8BSC8pRFemd7bE88v87OeA6+l
         wRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sQn04zimoeTAvQByXrhKq++b1S2amOx0lRpSk6xNJgg=;
        b=acjBxYzVMq9aex9D0sp8IsanPxxzOYwSf1wR2xY0p+eud1sqCxJ3fLBd4u30LMYrxl
         vaq48dSSUOpan5kOZ6oW2iDCrVrA4oiMcnZQqQEQiRShZMiLlze0KHlnT4hHc4PpAYQG
         3qFBi5cmMxPovYkaQ7XICxIziU6rJOfBBYHJgecD5VuQOZDctJQZYbaXgV7gJSkCObB6
         kYOMmDcYz9v3bF3PowSJ4AFf0DBk4FbzMyD+p+0wCC8yrALJw/Ww5KYrvU7p79bQs0jh
         hC3jErn9AZ06Y9bYgJ0CEGtWmxAV5KsZrVsU6ZF1Tq3Z4iBs/cXUDLSbAVg1SU9ItWO2
         z+Pw==
X-Gm-Message-State: AOPr4FUgePuM9kVogVTlRbA6rWxbqaA8MuDkaSMTIMULs9jXmgDFRGgwYuZU3Vmwka+qig==
X-Received: by 10.157.32.161 with SMTP id x30mr2347086ota.28.1463521231512;
        Tue, 17 May 2016 14:40:31 -0700 (PDT)
Received: from localhost ([189.208.111.205])
        by smtp.gmail.com with ESMTPSA id mh8sm1363619obb.25.2016.05.17.14.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 May 2016 14:40:29 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294915>

Certain lines of the marks file might be corrupted (or the objects
missing due to a garbage collection), but that's no reason to truncate
the file and essentially destroy the rest of it.

Ideally missing objects should not cause a crash, we could just skip
them, but that's another patch.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 fast-import.c          |  7 +++++--
 t/t9300-fast-import.sh | 15 +++++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 9fc7093..a975c34 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -329,6 +329,7 @@ static const char *export_marks_file;
 static const char *import_marks_file;
 static int import_marks_file_from_stream;
 static int import_marks_file_ignore_missing;
+static int import_marks_file_done;
 static int relative_marks_paths;
 
 /* Our last blob */
@@ -1802,7 +1803,7 @@ static void dump_marks(void)
 	static struct lock_file mark_lock;
 	FILE *f;
 
-	if (!export_marks_file)
+	if (!export_marks_file || (import_marks_file && !import_marks_file_done))
 		return;
 
 	if (hold_lock_file_for_update(&mark_lock, export_marks_file, 0) < 0) {
@@ -1835,7 +1836,7 @@ static void read_marks(void)
 	if (f)
 		;
 	else if (import_marks_file_ignore_missing && errno == ENOENT)
-		return; /* Marks file does not exist */
+		goto done; /* Marks file does not exist */
 	else
 		die_errno("cannot read '%s'", import_marks_file);
 	while (fgets(line, sizeof(line), f)) {
@@ -1865,6 +1866,8 @@ static void read_marks(void)
 		insert_mark(mark, e);
 	}
 	fclose(f);
+done:
+	import_marks_file_done = 1;
 }
 
 
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 25bb60b..4bca35c 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2650,6 +2650,21 @@ test_expect_success 'R: ignore non-git options' '
 	git fast-import <input
 '
 
+test_expect_success 'R: corrupt lines do not mess marks file' '
+	rm -f io.marks &&
+	blob=$(echo hi | git hash-object --stdin) &&
+	cat >expect <<-EOF &&
+	:3 0000000000000000000000000000000000000000
+	:1 $blob
+	:2 $blob
+	EOF
+	cp expect io.marks &&
+	test_must_fail git fast-import --import-marks=io.marks --export-marks=io.marks <<-\EOF &&
+
+	EOF
+	test_cmp expect io.marks
+'
+
 ##
 ## R: very large blobs
 ##
-- 
2.8.2.dirty
