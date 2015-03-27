From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/6] pack-bitmap: fix a memleak
Date: Fri, 27 Mar 2015 15:09:01 -0700
Message-ID: <1427494150-8085-2-git-send-email-sbeller@google.com>
References: <1427494150-8085-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 27 23:10:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbcSM-00057y-Kf
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 23:10:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbbC0WKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 18:10:15 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36092 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252AbbC0WKI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 18:10:08 -0400
Received: by igbud6 with SMTP id ud6so32672260igb.1
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 15:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WA+3G5sqSBk9Y85uujgLws1uUPKNaOBxmije0j0cdKQ=;
        b=O+fjxj1HTXeELt8p2jMNpy5/RQdUa4qK/6/pDJQuIDwzK5MasO+MVISc1sN3RQHr/D
         vwCU6qUY2bQ3e4ayVbNXyuhRWWqc2duEwrqbVDEGqBncz6BXbqwz/aPHw0dJLn2bQdux
         tuYZFata/uUpXwUVhd+OCtmWR0jSLSYlTCmCPON0IFv4jQGdznEX+JG44jUEdpcgkc9I
         GOqBQHxtfLd4KXTc0KVSSUtQkFJ9AuvMRp402qVha0pSUGx5+I/XLXJ4QOnxb1ljRYn9
         5CeOczWpk+7hOKr/Kd6+KWpenFf6L2Gb604ZFdjX/cMTFqlXX/MiPCYlVqUcT4iMum38
         u4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WA+3G5sqSBk9Y85uujgLws1uUPKNaOBxmije0j0cdKQ=;
        b=CgmSzjdzy/Dmzon2WDKlQy1v0VQksZ8qR+1Zcb2WUJ/ZFi2lnqHZXWZA2s7av3sR5g
         /HmEvuLYbojEY4FKQhAOyFp4BF1EeQXDFUVpNeQFrDJ8RFXQwluXJMmGkVHXOFld8Tvi
         rVPVSLzEOl/H+GBx3vLbN301NlfKkHwbZzCzyrxzLjUpFjzlDCFbfD98UD1l9n9j97+Z
         701s1L8J0eDiV0/rVnwat7e6+AfLHwjBcq109Y1IlrvpRgMdTl50zwH5Jws/xz5N9nKx
         hyohT9XJdyhceGR7rGQPrk5/3nucT9Dimot+CH9xEwqAhtlAFCR6RDMyV1M3gbSKgx+4
         XNPQ==
X-Gm-Message-State: ALoCoQmsruJU1q/Cd/nbDPpodOjjN8hU11hu6AGadf+JeZFvismdBfsnI1GnNV+jjVu6A8+06/0+
X-Received: by 10.107.157.82 with SMTP id g79mr32776543ioe.72.1427494208267;
        Fri, 27 Mar 2015 15:10:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:7174:4672:de72:7789])
        by mx.google.com with ESMTPSA id gz4sm2500948igb.19.2015.03.27.15.10.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Mar 2015 15:10:07 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1427494150-8085-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266384>

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
