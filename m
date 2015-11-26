From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH 1/3] prepare_packed_git(): find more garbage
Date: Thu, 26 Nov 2015 00:15:29 -0600
Message-ID: <1448518529-2659-1-git-send-email-dougk.ff7@gmail.com>
References: <CAGZ79kaCNT06mAGQbHNgZmdBQUyxGFTFA2Y2FXvG2UG+P7s2kg@mail.gmail.com>
Cc: sbeller@google.com, peff@github.com, gitster@pobox.com,
	Doug Kelly <dougk.ff7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 26 07:15:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1pqU-0005D2-LI
	for gcvg-git-2@plane.gmane.org; Thu, 26 Nov 2015 07:15:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbbKZGPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2015 01:15:54 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:34833 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbbKZGPw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2015 01:15:52 -0500
Received: by ioc74 with SMTP id 74so75395149ioc.2
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 22:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BGzgsfNixPNhOMISShDyvxjwDtOn+MaGyZJ3yCG/vKU=;
        b=OoUkU2gd3R1KEm7lmNpvJUy7PCexmRK/Jp5U85riP08QA9Rz8e6yeL0a696icbAtUk
         qfQwfNrfji33r5NBDczwDYyNG8wlypoeaI/4Q59IfS0l6wBLumUm2OPEWvxIeMTp6JTN
         doSoYAQIS+1W/L9HAn9BvU9CyGcvL/hz+9Omx4uLdPirLmhR8J6hpZUuYKpGzD+KOqc+
         sx0bApFNUgidYyQc6w5Dh2A01MkQ1zbzLE+SF4C+pMB4qKfB58pv+xySywUNdH1yW/Ws
         5lh73JHT5n/PhjH5gASE33DeCZsEMYYXgRPoPlqBH1AYwv3O9VXT0yNW28xlQWvVESge
         oX1Q==
X-Received: by 10.107.12.28 with SMTP id w28mr36977754ioi.33.1448518551985;
        Wed, 25 Nov 2015 22:15:51 -0800 (PST)
Received: from k-na.local.net (64-151-63-23.static.everestkc.net. [64.151.63.23])
        by smtp.gmail.com with ESMTPSA id p125sm10146861ioe.13.2015.11.25.22.15.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Nov 2015 22:15:51 -0800 (PST)
X-Mailer: git-send-email 2.6.1
In-Reply-To: <CAGZ79kaCNT06mAGQbHNgZmdBQUyxGFTFA2Y2FXvG2UG+P7s2kg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281759>

.bitmap and .keep files without .idx/.pack don't make much sense, so
make sure these are reported as garbage as well.  At the same time,
refactoring report_garbage to handle extra bits.

Signed-off-by: Doug Kelly <dougk.ff7@gmail.com>
---
 builtin/count-objects.c | 16 ++++++----------
 cache.h                 |  4 +++-
 sha1_file.c             | 17 +++++++++++++++--
 t/t5304-prune.sh        |  2 ++
 4 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index ba92919..5197b57 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -17,19 +17,15 @@ static off_t loose_size;
 
 static const char *bits_to_msg(unsigned seen_bits)
 {
-	switch (seen_bits) {
-	case 0:
-		return "no corresponding .idx or .pack";
-	case PACKDIR_FILE_GARBAGE:
+	if (seen_bits ==  PACKDIR_FILE_GARBAGE)
 		return "garbage found";
-	case PACKDIR_FILE_PACK:
+	else if (seen_bits & PACKDIR_FILE_PACK && !(seen_bits & PACKDIR_FILE_IDX))
 		return "no corresponding .idx";
-	case PACKDIR_FILE_IDX:
+	else if (seen_bits & PACKDIR_FILE_IDX && !(seen_bits & PACKDIR_FILE_PACK))
 		return "no corresponding .pack";
-	case PACKDIR_FILE_PACK|PACKDIR_FILE_IDX:
-	default:
-		return NULL;
-	}
+	else if (seen_bits == 0 || !(seen_bits & (PACKDIR_FILE_IDX|PACKDIR_FILE_PACK)))
+		return "no corresponding .idx or .pack";
+	return NULL;
 }
 
 static void real_report_garbage(unsigned seen_bits, const char *path)
diff --git a/cache.h b/cache.h
index 736abc0..5b9d791 100644
--- a/cache.h
+++ b/cache.h
@@ -1292,7 +1292,9 @@ extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_
 /* A hook to report invalid files in pack directory */
 #define PACKDIR_FILE_PACK 1
 #define PACKDIR_FILE_IDX 2
-#define PACKDIR_FILE_GARBAGE 4
+#define PACKDIR_FILE_BITMAP 4
+#define PACKDIR_FILE_KEEP 8
+#define PACKDIR_FILE_GARBAGE 16
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
 extern void prepare_packed_git(void);
diff --git a/sha1_file.c b/sha1_file.c
index 3d56746..5f939e4 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1225,6 +1225,15 @@ static void report_helper(const struct string_list *list,
 	if (seen_bits == (PACKDIR_FILE_PACK|PACKDIR_FILE_IDX))
 		return;
 
+	if (seen_bits == (PACKDIR_FILE_PACK|PACKDIR_FILE_IDX|PACKDIR_FILE_BITMAP))
+		return;
+
+	if (seen_bits == (PACKDIR_FILE_PACK|PACKDIR_FILE_IDX|PACKDIR_FILE_KEEP))
+		return;
+
+	if (seen_bits == (PACKDIR_FILE_PACK|PACKDIR_FILE_IDX|PACKDIR_FILE_BITMAP|PACKDIR_FILE_KEEP))
+		return;
+
 	for (; first < last; first++)
 		report_garbage(seen_bits, list->items[first].string);
 }
@@ -1256,9 +1265,13 @@ static void report_pack_garbage(struct string_list *list)
 			first = i;
 		}
 		if (!strcmp(path + baselen, "pack"))
-			seen_bits |= 1;
+			seen_bits |= PACKDIR_FILE_PACK;
 		else if (!strcmp(path + baselen, "idx"))
-			seen_bits |= 2;
+			seen_bits |= PACKDIR_FILE_IDX;
+		else if (!strcmp(path + baselen, "bitmap"))
+			seen_bits |= PACKDIR_FILE_BITMAP;
+		else if (!strcmp(path + baselen, "keep"))
+			seen_bits |= PACKDIR_FILE_KEEP;
 	}
 	report_helper(list, seen_bits, first, list->nr);
 }
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index def203c..1ea8279 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -261,6 +261,8 @@ test_expect_success 'clean pack garbage with gc' '
 warning: no corresponding .idx or .pack: .git/objects/pack/fake3.keep
 warning: no corresponding .idx: .git/objects/pack/foo.keep
 warning: no corresponding .idx: .git/objects/pack/foo.pack
+warning: no corresponding .pack: .git/objects/pack/fake2.idx
+warning: no corresponding .pack: .git/objects/pack/fake2.keep
 EOF
 	test_cmp expected actual
 '
-- 
2.6.1
