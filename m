From: Stefan Beller <sbeller@google.com>
Subject: [PATCH V2 5/6] pack-bitmap: fix a memleak
Date: Fri, 27 Mar 2015 15:32:48 -0700
Message-ID: <1427495569-10863-6-git-send-email-sbeller@google.com>
References: <1427495569-10863-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, tanoku@gmail.com, blees@dcon.de
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 23:33:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ybcok-0005m7-Gj
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 23:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650AbbC0WdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 18:33:20 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34021 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbbC0WdK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 18:33:10 -0400
Received: by igcau2 with SMTP id au2so39710020igc.1
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 15:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WA+3G5sqSBk9Y85uujgLws1uUPKNaOBxmije0j0cdKQ=;
        b=SZKg4+ZrJES6Cibdpgj8TUXPONwsFC1x5fY4pii81nUglHtPpEg3ZNzSe9Y9ac8VXH
         Z/LbryX8GdyEX358LA6Hz0QR5FAJXnHbOM6djfSRwLu9P92dkQTkdoKcPhFWRAKTupc8
         G2bq82qtD4GKdLndVww53ewaDU3qzHvXh3JBXUo8rSHA/1J1FV64b8qFQ5mTadlELRhN
         oeduKNkhQ+TgHn0BJzEatDIrlk5ewXyPKNJSFJ/Db0CwsqCJP6S/EURS2XC5yO3kQQoa
         5qi0w6MuEZJZw5WsLjrnUN/ifXznkzuPMgzc9YbqMjv0MgQzhPODV9chTXLAJBnr0Og1
         nX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WA+3G5sqSBk9Y85uujgLws1uUPKNaOBxmije0j0cdKQ=;
        b=JbHqFxXQZyCe+q1K1QUCS9hUFY97PKAYlwi2U7+BOk0LpfsWWTBvokbRLW5QlseYVz
         PNevtRj5MEYwhSYc5CzCKmH6ef6nP5GE68KnFvIIG5QwcoHJRJLn8ed3TyY6P74ygG2o
         82H1Yknq06lUmwE1sT9kYwwrj7V6ZYS4sHoHTl8TX47EDF/D8G7Vx9E6ALQ5mfEeGzO5
         ooTXov8NqnojbkzIfW1Fz2YlTFPsm+sYiwqp7Z3Xycpvlq2Ii1wL+MubrufaSVhcevBz
         ZQLcRVdWec/Q0vHjyWihpRDdYwp/2hu2hRehDaUo7NyuLOtuTbc3SlbMNG9oqSLThLAj
         40Iw==
X-Gm-Message-State: ALoCoQkw7oFOAfq2zLEsgzg52pbHrUpNb5O+z0ZRxdPp6f9KGNH3W8NJjQd+NsvAVn2aCUhh871e
X-Received: by 10.107.134.219 with SMTP id q88mr31836572ioi.27.1427495589984;
        Fri, 27 Mar 2015 15:33:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:7174:4672:de72:7789])
        by mx.google.com with ESMTPSA id i1sm2552801igh.5.2015.03.27.15.33.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Mar 2015 15:33:09 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1427495569-10863-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266400>

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
