From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v5 08/14] name-hash.c: remove unreferenced directory entries
Date: Thu, 14 Nov 2013 20:21:26 +0100
Message-ID: <528522B6.2050302@gmail.com>
References: <52851FB5.4050406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jens Lehmann <Jens.Lehmann@web.de>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 14 20:21:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vh2Tq-0001jF-2D
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 20:21:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243Ab3KNTV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 14:21:27 -0500
Received: from mail-we0-f170.google.com ([74.125.82.170]:36461 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754344Ab3KNTVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 14:21:25 -0500
Received: by mail-we0-f170.google.com with SMTP id p61so2579920wes.1
        for <git@vger.kernel.org>; Thu, 14 Nov 2013 11:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=z5w0A/zU6XC/hWsNy1PBK2JLaavVR/MkLkpkkO7Ofs8=;
        b=kjrCyI3m5lADUkUOu/e1WS567PxoK/ffzXWlkSdTahogUpPDS0l0YWNoP8IC6FOaYM
         lZqYg5WOvdUlRrLf7pZ7plpl1Y6GuQ9PNRJFucwOdi6fY+EzSRqS4QOkpsG2GWDvAgV+
         75uW7hrtR+os6u4mqgR46APqNWycdjcWcwi7jY0TL/aHYVF5B6EMMAWxIdJZChNmECX1
         yJgLdQUcDGidwu8air/SX8sTlMIbzT6/OpOw/hnj7uSlX+LF8joYJ5D1vi5pmgie7IgO
         gJI+aqbSdEaqTIBbWx3Deyn4ipjq7Vg794NPfx8rPNH2kzLr/SbIPTpHVyBo/0eG1y6L
         JP4Q==
X-Received: by 10.180.208.107 with SMTP id md11mr4208178wic.47.1384456884548;
        Thu, 14 Nov 2013 11:21:24 -0800 (PST)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id gb1sm7742464wic.0.2013.11.14.11.21.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Nov 2013 11:21:23 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <52851FB5.4050406@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237869>

The new hashmap implementation supports remove, so remove and free
directory entries that are no longer referenced by active cache entries.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 name-hash.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/name-hash.c b/name-hash.c
index c75fadf..effe96d 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -86,15 +86,16 @@ static void add_dir_entry(struct index_state *istate, struct cache_entry *ce)
 static void remove_dir_entry(struct index_state *istate, struct cache_entry *ce)
 {
 	/*
-	 * Release reference to the directory entry (and parents if 0).
-	 *
-	 * Note: we do not remove / free the entry because there's no
-	 * hash.[ch]::remove_hash and dir->next may point to other entries
-	 * that are still valid, so we must not free the memory.
+	 * Release reference to the directory entry. If 0, remove and continue
+	 * with parent directory.
 	 */
 	struct dir_entry *dir = hash_dir_entry(istate, ce, ce_namelen(ce));
-	while (dir && dir->nr && !(--dir->nr))
-		dir = dir->parent;
+	while (dir && !(--dir->nr)) {
+		struct dir_entry *parent = dir->parent;
+		hashmap_remove(&istate->dir_hash, dir, NULL);
+		free(dir);
+		dir = parent;
+	}
 }
 
 static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
-- 
1.8.5.rc0.333.g5394214
