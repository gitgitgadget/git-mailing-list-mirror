From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH 1/4] prepare_packed_git(): find more garbage
Date: Wed, 13 Jan 2016 11:07:09 -0600
Message-ID: <bb5104d63e7095ae96fad8461bb6f904b800e168.1452704305.git.dougk.ff7@gmail.com>
References: <1450483600-64091-1-git-send-email-dougk.ff7@gmail.com>
 <cover.1452704305.git.dougk.ff7@gmail.com>
Cc: peff@peff.net, sbeller@google.com, Doug Kelly <dougk.ff7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 18:07:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJOtc-0005Eb-W0
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 18:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231AbcAMRHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 12:07:41 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33433 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314AbcAMRH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 12:07:28 -0500
Received: by mail-oi0-f67.google.com with SMTP id j3so5854237oig.0
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 09:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=EbKd1yua4Eeg8P69OZMnX1UfJr8Be+hYtnPzumVfiSI=;
        b=gZ0qtOmgcbQV5P9gU16HKiMvwALR8zRc0mB2Xcms8iQEB/lpT92hUTdR18JQgnlbqt
         IZC3tRgtJyXo+JwC/+CHQ/H6wLKco/qC8sTrc07pHRjU6t4F05qA/Ulucpl+wOQt0pF9
         15CVCBphNIMut2xvPQlsOIcZvX5EH4QhPPPkZMi2QkSjat5Y1gzvj8Qdgk6P5ZRjpDsO
         FXjF9CKYGlmlZlR06LEBbs2Rz6qEUNbsWoawt8kD1yvQJYJwamE6gDwV7QsEdsln0unE
         PlD6KRUIYIdBT7yhr6d+KXA87ew2CXw9m9slngG5xLxiDwSug9oFiSTGTg/NcSfR5RMr
         iv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=EbKd1yua4Eeg8P69OZMnX1UfJr8Be+hYtnPzumVfiSI=;
        b=cLm5In782FlTbAmxP7tacH7hXf3rAFEus0iV6/RXivf0iTBo4cFq9b4W20w1H9N9X2
         PCZggADbH+/J0xXcCLCBC1jEq4I6R7lhVWHecrHu4kwzKe3W2y65qLra+DCZwjmXsv4P
         fkSkcMdKT/MYM2LUgGMBXjkucoDnkx9GS+8zvDdEN9zuL+ONUxpKdcJ8TZFWsF+fFPhk
         LZwPpt/ua8chgyvMkSyWjpTE6VeZocJboRvkKMuCcvX4NH2CnWFoqs/gbj9+oA8f0h4Z
         L5dyBhk5l00VupLZfRWM3Fo48E/q4iXVHJ7sxOj0hV9u8FyeP8CbpN8qRZ/B5MTWXmqs
         wxog==
X-Gm-Message-State: ALoCoQkUZujI5Fh7ZltpR2LkhEY6rUblYlnMlgr8iVSZyhGKzHP5b+KsY2DDT5JlThqWfnuwYHDSsBrsapCkvGY1DX2ZdJdfCA==
X-Received: by 10.202.219.10 with SMTP id s10mr23060351oig.27.1452704847973;
        Wed, 13 Jan 2016 09:07:27 -0800 (PST)
Received: from localhost.localdomain ([204.77.163.41])
        by smtp.gmail.com with ESMTPSA id dh8sm996371obb.2.2016.01.13.09.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jan 2016 09:07:27 -0800 (PST)
X-Mailer: git-send-email 2.6.1
In-Reply-To: <cover.1452704305.git.dougk.ff7@gmail.com>
In-Reply-To: <cover.1452704305.git.dougk.ff7@gmail.com>
References: <cover.1452704305.git.dougk.ff7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283940>

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
index dfc459c..aee1d51 100644
--- a/cache.h
+++ b/cache.h
@@ -1317,7 +1317,9 @@ extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_
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
index 73ccd49..b21b2ba 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1223,7 +1223,9 @@ void (*report_garbage)(unsigned seen_bits, const char *path);
 static void report_helper(const struct string_list *list,
 			  int seen_bits, int first, int last)
 {
-	if (seen_bits == (PACKDIR_FILE_PACK|PACKDIR_FILE_IDX))
+	static const int pack_and_index = PACKDIR_FILE_PACK|PACKDIR_FILE_IDX;
+
+	if ((seen_bits & pack_and_index) == pack_and_index)
 		return;
 
 	for (; first < last; first++)
@@ -1257,9 +1259,13 @@ static void report_pack_garbage(struct string_list *list)
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
