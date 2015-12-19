From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH 1/3] prepare_packed_git(): find more garbage
Date: Fri, 18 Dec 2015 18:06:38 -0600
Message-ID: <1450483600-64091-2-git-send-email-dougk.ff7@gmail.com>
References: <20151215232534.GA30998@sigill.intra.peff.net>
 <1450483600-64091-1-git-send-email-dougk.ff7@gmail.com>
Cc: peff@peff.net, sbeller@google.com, gitster@pobox.com,
	Doug Kelly <dougk.ff7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 19 01:07:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aA53H-0008QC-6F
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 01:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbbLSAHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2015 19:07:05 -0500
Received: from mail-yk0-f175.google.com ([209.85.160.175]:33229 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbbLSAHE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2015 19:07:04 -0500
Received: by mail-yk0-f175.google.com with SMTP id 140so76758433ykp.0
        for <git@vger.kernel.org>; Fri, 18 Dec 2015 16:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LfmGKKyGlF+6jr1ppEYl8Q++5ZAPI1Q+6BdYaI2KV3A=;
        b=VpvZfhwaLcRERPooMA/5/qJdSVizU1m+PYS2OZ/C9jyqfBM9V0MDUuApqkWSi2s8E+
         kvErlFqWJj2W6/mxXeBWaUGCSZe1IlmBE0oD75Nytx4eyCwryPh6K18GuwZ4PQGGcE73
         i71IR5BNBcde6jCfPUKCTVnIXkyMxAfnEEBcy5KcarLbCdRaYyYvCtx962TC4c6vNMvM
         b3dECT5LhGMICveBV52aUujTLA4z6HLQVCoGxbal/dt1vcCBGbSZLxpEPx1kmJY4+URS
         EVwfRltItk+xdpgfTN4nxqErvsDIcYuKFAOqcdgW0ha1kuncJmMLcLxP94x0mxVOsC0A
         fxeQ==
X-Received: by 10.129.106.214 with SMTP id f205mr5370286ywc.298.1450483623118;
        Fri, 18 Dec 2015 16:07:03 -0800 (PST)
Received: from localhost.localdomain ([204.77.163.41])
        by smtp.gmail.com with ESMTPSA id w184sm18490831ywc.41.2015.12.18.16.07.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Dec 2015 16:07:02 -0800 (PST)
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1450483600-64091-1-git-send-email-dougk.ff7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282721>

.bitmap and .keep files without .idx/.pack don't make much sense, so
make sure these are reported as garbage as well.  At the same time,
refactoring report_garbage to handle extra bits.

Signed-off-by: Doug Kelly <dougk.ff7@gmail.com>
---
 builtin/count-objects.c | 16 ++++++----------
 cache.h                 |  4 +++-
 sha1_file.c             | 12 +++++++++---
 t/t5304-prune.sh        |  2 ++
 4 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index ba92919..ed103ae 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -17,19 +17,15 @@ static off_t loose_size;
 
 static const char *bits_to_msg(unsigned seen_bits)
 {
-	switch (seen_bits) {
-	case 0:
-		return "no corresponding .idx or .pack";
-	case PACKDIR_FILE_GARBAGE:
+	if (seen_bits & PACKDIR_FILE_GARBAGE)
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
+	else if (!(seen_bits & (PACKDIR_FILE_IDX|PACKDIR_FILE_PACK)))
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
index 3d56746..3524274 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1222,7 +1222,9 @@ void (*report_garbage)(unsigned seen_bits, const char *path);
 static void report_helper(const struct string_list *list,
 			  int seen_bits, int first, int last)
 {
-	if (seen_bits == (PACKDIR_FILE_PACK|PACKDIR_FILE_IDX))
+	static const int pack_and_index = PACKDIR_FILE_PACK|PACKDIR_FILE_IDX;
+
+	if ((seen_bits & pack_and_index) == pack_and_index)
 		return;
 
 	for (; first < last; first++)
@@ -1256,9 +1258,13 @@ static void report_pack_garbage(struct string_list *list)
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
