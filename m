From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH 1/3] prepare_packed_git(): find more garbage
Date: Fri, 13 Nov 2015 16:46:25 -0800
Message-ID: <1447461987-35450-1-git-send-email-dougk.ff7@gmail.com>
References: <CAGZ79kYPv2OLzMX6t9=mejes9F8CzxAJiERs8GGxDnaAG8Q64g@mail.gmail.com>
Cc: peff@github.com, gitster@pobox.com,
	Doug Kelly <dougk.ff7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 14 01:46:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxOzN-0001pE-9O
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 01:46:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbbKNAqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 19:46:42 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36751 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbbKNAql (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 19:46:41 -0500
Received: by pacdm15 with SMTP id dm15so115088738pac.3
        for <git@vger.kernel.org>; Fri, 13 Nov 2015 16:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rQkh3W0CArp2gcG4ni7SbUEMynDDk9YAxSglknQ/hFM=;
        b=I9ufXc/dHhFJMYEytG7JZzhcIZyYMYfPXTyTlXr3ldxDIHLVTa5oOkgrxPB+ivIZJn
         YvFxVDp9DaYjHkFukMobnRqgqyfl/Lil9bh7ddNxz9KU4uYXa8IuEh7MkbUdV3TPU9WB
         QaMfuUEtv9l2x1y19tRuJXNsYI+I43wyQWICv8Ppwi8Tk2Kof+8Bxp4UvAG8xDV5akhr
         dRgF6ZGUjFw8DlgdB6d6U1IcuSQUxF/rBC82amTyxb4VjfhLFpYK+xT1e9a2GsA3S0p+
         oksnuf5dgTZdmqHjma9uoW88WD+KqWu9K8sehJHoyTCgEBuFfyPjkj6dkWz8+mc05vlt
         Dr7g==
X-Received: by 10.68.163.97 with SMTP id yh1mr36090040pbb.36.1447462001159;
        Fri, 13 Nov 2015 16:46:41 -0800 (PST)
Received: from k-na.local.com ([104.135.13.127])
        by smtp.gmail.com with ESMTPSA id c1sm11548168pap.36.2015.11.13.16.46.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Nov 2015 16:46:40 -0800 (PST)
X-Mailer: git-send-email 2.6.1
In-Reply-To: <CAGZ79kYPv2OLzMX6t9=mejes9F8CzxAJiERs8GGxDnaAG8Q64g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281286>

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
index ba92919..1637037 100644
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
+	else if (seen_bits & PACKDIR_FILE_PACK && seen_bits ^ ~PACKDIR_FILE_IDX)
 		return "no corresponding .idx";
-	case PACKDIR_FILE_IDX:
+	else if (seen_bits & PACKDIR_FILE_IDX && seen_bits ^ ~PACKDIR_FILE_PACK)
 		return "no corresponding .pack";
-	case PACKDIR_FILE_PACK|PACKDIR_FILE_IDX:
-	default:
-		return NULL;
-	}
+	else if (seen_bits == 0 || seen_bits ^ ~(PACKDIR_FILE_IDX|PACKDIR_FILE_PACK))
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
