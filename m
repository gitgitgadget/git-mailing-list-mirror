From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v4 08/14] name-hash.c: remove unreferenced directory entries
Date: Thu, 07 Nov 2013 15:38:42 +0100
Message-ID: <527BA5F2.3010008@gmail.com>
References: <527BA483.6040803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jens Lehmann <Jens.Lehmann@web.de>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 15:38:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeQjM-00074U-0g
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 15:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754369Ab3KGOik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 09:38:40 -0500
Received: from mail-bk0-f53.google.com ([209.85.214.53]:34068 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996Ab3KGOij (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 09:38:39 -0500
Received: by mail-bk0-f53.google.com with SMTP id w11so270485bkz.40
        for <git@vger.kernel.org>; Thu, 07 Nov 2013 06:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=CiSVrnsjHY0zmM6hbyjZvWqh2V79/98cG/0RPWPBrQ8=;
        b=NyMwhOWik2AITMlzuI78LDnKPDLOmu/BhuLoDbPV3vZiqZtT5qjrM4nWqCVqSHplRM
         6e9VdLmqxOftVkmKTl8XY3J8CfPiHqUO5qtweIZaMd1Frqi+qajI0EBAfTr7iv6nMQBO
         Qw+YYokq5RLJKCHgRbjiUyXNNeyCf5z7QTAAoIwqjcIVgNmrPN7XMfjNIuFXMkwv79bq
         rCkhUdUBfwdZoAW7sw2nG49cFZGYnufnT7U1wLOsvbDLD5amQiRbHkKx34y4RCrnp8Sq
         OSYdN8ly+QNjJugBiasMDJD/PX5/TLqZdUe4jArTvA8sY9KiLQreWgYbcMVcmKNiIYqY
         t2Fg==
X-Received: by 10.204.169.140 with SMTP id z12mr10661bky.85.1383835118453;
        Thu, 07 Nov 2013 06:38:38 -0800 (PST)
Received: from [10.1.100.55] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id qe6sm2573638bkb.5.2013.11.07.06.38.37
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Nov 2013 06:38:37 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <527BA483.6040803@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237403>

The new hashmap implementation supports remove, so remove and free
directory entries that are no longer referenced by active cache entries.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 name-hash.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/name-hash.c b/name-hash.c
index ae636f8..116f56d 100644
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
1.8.4.msysgit.0.12.g88f5ed0
