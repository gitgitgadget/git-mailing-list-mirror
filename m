From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/6] pack-bitmap: fix a memleak
Date: Fri, 27 Mar 2015 15:09:08 -0700
Message-ID: <1427494150-8085-9-git-send-email-sbeller@google.com>
References: <1427494150-8085-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 27 23:10:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbcSW-0005EL-1M
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 23:10:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968AbbC0WK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 18:10:27 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34423 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252AbbC0WKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 18:10:16 -0400
Received: by igcau2 with SMTP id au2so39464751igc.1
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 15:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WA+3G5sqSBk9Y85uujgLws1uUPKNaOBxmije0j0cdKQ=;
        b=o9FzpadXfZnhOCkqHgdq7bU9b3cTLc9kSF3jp5YpzI511enI2emTVN7QU/0UemJDHJ
         DfrAVYR8vVsitIlJl/QnOQcs0+HLLApg6FRmkyuGd0sPHISnglZscC5W43a8dBGiYyT1
         Vh9mEo5UXZQlIGNEPzVitsQDlpkbZl/MzIQVarylnEx3+yY3kjl2v3qOc5GlDFgTFCt/
         M+5c0RYwr27FysCvvnQI+0Ksdm5ukHbUemXlP6+5gK9Y+tdJoJ7ofO+c3H1srk2x3Qqq
         lRbkCrvhMhuyj38x2rv1XrPvSN6fxpSeBXzMuLHCx9NUvrG9qPf6JS9yKaoVAJ/9Uy5I
         klYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WA+3G5sqSBk9Y85uujgLws1uUPKNaOBxmije0j0cdKQ=;
        b=MJWHJfrUgcsHiFPbxVFdIZFkgkZyjtF9wybDUyBRdpI2p/Ng0Jf+AwwLfMF2lUU6Pq
         /oTghQgcQeOIyedok0kYuKQ1HJonjbH+BONjjgHAwR5Y6FBemPJKJQxOMBB8qho5ORcx
         TwwUZPqxUaPEV97bU0xwQ9dXTUmT7eTDejrCmEXVEj0hsWjE8nkBEx/J+z2W07/uDsRO
         xYDNThR7T3c5OT4b/pswrWbF7IRO+ith+dj3NRVFlDfWqhM45YcBdJYB9aFRT3Q21Uwk
         q631Pajdkzd1goGkxmmDso0K91ySpTcSXa0WU8p4AUjKppKdrjuW3hqCTGtqNbW7B1eU
         AERA==
X-Gm-Message-State: ALoCoQlnK6ss6D7YMlv/eMrs7FmDui6si8xGayP1g6KCCmw+MUz2MSZa6BScLOE05Z3ZJbxXKmRb
X-Received: by 10.107.25.68 with SMTP id 65mr33692667ioz.44.1427494216303;
        Fri, 27 Mar 2015 15:10:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:7174:4672:de72:7789])
        by mx.google.com with ESMTPSA id x2sm2509136igg.9.2015.03.27.15.10.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Mar 2015 15:10:15 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1427494150-8085-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266386>

`recent_bitmaps` is allocated in the function load_bitmap_entries_v1
and it is not passed into any function, so it's safe to free it before
leaving that function.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    I wonder however if we need to free the actual bitmaps
    stored in the recent_bitmaps as well.

 pack-bitmap.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 365f9d9..34823e9 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -213,7 +213,7 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 {
 	static const size_t MAX_XOR_OFFSET = 160;
 
-	uint32_t i;
+	uint32_t i, ret = 0;
 	struct stored_bitmap **recent_bitmaps;
 
 	recent_bitmaps = xcalloc(MAX_XOR_OFFSET, sizeof(struct stored_bitmap));
@@ -232,24 +232,31 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 		sha1 = nth_packed_object_sha1(index->pack, commit_idx_pos);
 
 		bitmap = read_bitmap_1(index);
-		if (!bitmap)
-			return -1;
+		if (!bitmap) {
+			ret = -1;
+			goto out;
+		}
 
-		if (xor_offset > MAX_XOR_OFFSET || xor_offset > i)
-			return error("Corrupted bitmap pack index");
+		if (xor_offset > MAX_XOR_OFFSET || xor_offset > i) {
+			ret = error("Corrupted bitmap pack index");
+			goto out;
+		}
 
 		if (xor_offset > 0) {
 			xor_bitmap = recent_bitmaps[(i - xor_offset) % MAX_XOR_OFFSET];
 
-			if (xor_bitmap == NULL)
-				return error("Invalid XOR offset in bitmap pack index");
+			if (xor_bitmap == NULL) {
+				ret = error("Invalid XOR offset in bitmap pack index");
+				goto out;
+			}
 		}
 
 		recent_bitmaps[i % MAX_XOR_OFFSET] = store_bitmap(
 			index, bitmap, sha1, xor_bitmap, flags);
 	}
-
-	return 0;
+out:
+	free(recent_bitmaps);
+	return ret;
 }
 
 static char *pack_bitmap_filename(struct packed_git *p)
@@ -986,6 +993,8 @@ void test_bitmap_walk(struct rev_info *revs)
 		fprintf(stderr, "OK!\n");
 	else
 		fprintf(stderr, "Mismatch!\n");
+
+	free(result);
 }
 
 static int rebuild_bitmap(uint32_t *reposition,
-- 
2.3.0.81.gc37f363
