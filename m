From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v3 07/11] name-hash.c: remove unreferenced directory entries
Date: Tue, 01 Oct 2013 11:38:26 +0200
Message-ID: <524A9812.9070101@gmail.com>
References: <524A96FF.5090604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 01 11:38:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQwPX-0005wp-Vj
	for gcvg-git-2@plane.gmane.org; Tue, 01 Oct 2013 11:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212Ab3JAJi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Oct 2013 05:38:28 -0400
Received: from mail-ea0-f175.google.com ([209.85.215.175]:59930 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928Ab3JAJi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Oct 2013 05:38:27 -0400
Received: by mail-ea0-f175.google.com with SMTP id m14so3285866eaj.34
        for <git@vger.kernel.org>; Tue, 01 Oct 2013 02:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=SePZ4r6ZjbiufECfjbfP8EfIYZwsUeaU0Wn96O/DEes=;
        b=sf0l1zHnpWOZzC8/ETI091o4eFj5X8v5lcvBcHzOyWHoqma908niZMdiLrCDKH+wa/
         iYm5aB51RMxcbJbsqRlDv1h9Ib+Zx5LEYaUuJpWtckdwshrcchcrLmzDVl8DjhXxTvnH
         pqdrFeim3NIY8HjVh+SmVwYnryjE7hbqY2IvbjbGCsV2pEmP5uiGqaAH5BvEIxv2nNLq
         ZWR/l+tJFUV13WwCIOIIeCsZHlAvNo5owOF2DIlAYIAZBXzT+J8CZuvB+3KvrFCi1zLZ
         wHbrpZ+EG15uVnHVKCcbVVY8vidx7V7ghs7p/hd3jopLCzaqnGRAyHozIdQCDuU5zWuG
         GbZA==
X-Received: by 10.14.175.73 with SMTP id y49mr3398867eel.50.1380620306778;
        Tue, 01 Oct 2013 02:38:26 -0700 (PDT)
Received: from [10.1.100.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id v8sm11072869eeo.12.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Oct 2013 02:38:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <524A96FF.5090604@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235651>

The new hashmap implementation supports remove, so remove and free
directory entries that are no longer referenced by active cache entries.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 name-hash.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/name-hash.c b/name-hash.c
index aa57666..ce54fb3 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -85,15 +85,16 @@ static void add_dir_entry(struct index_state *istate, struct cache_entry *ce)
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
1.8.4.11.g4f52745.dirty
