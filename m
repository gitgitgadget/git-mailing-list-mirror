From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 3/3] builtin-pack-object: cache small deltas
Date: Mon, 28 May 2007 23:20:59 +0200
Message-ID: <11803872602056-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <11803872591522-git-send-email-mkoegler@auto.tuwien.ac.at> <11803872591103-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 28 23:21:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsmeS-00048V-7f
	for gcvg-git@gmane.org; Mon, 28 May 2007 23:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbXE1VVJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 17:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761067AbXE1VVJ
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 17:21:09 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:59447 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbXE1VVF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 17:21:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id CA7FC7C16A95;
	Mon, 28 May 2007 23:21:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PbbCBBJR9GaD; Mon, 28 May 2007 23:21:00 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 12DD67C16AAF; Mon, 28 May 2007 23:21:00 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
In-Reply-To: <11803872591103-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48647>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
Caching small deltas improves packing time even on small repostistories.
Repacking git.git with a delta size limit of 1000 brings CPU time from
66 to 49 seconds down. A limit of 500 bytes is only two secondes slower.

The implicit cache size limit is (#objects)*(delta size limit).

 Documentation/config.txt |    4 ++++
 builtin-pack-objects.c   |    8 ++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 83cc4cd..0061f7f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -572,6 +572,10 @@ pack.deltaCacheSize::
 	gitlink:git-pack-objects[1]. 	
 	A value of 0 means no limit. Defaults to 0.
 
+pack.deltaCacheLimit::
+	The maxium size of a delta, that is cached in 
+	gitlink:git-pack-objects[1]. Defaults to 1000.
+
 pull.octopus::
 	The default merge strategy to use when pulling multiple branches
 	at once.
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 85e08dc..c316fea 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -79,6 +79,7 @@ static int pack_compression_seen;
 
 static unsigned long delta_cache_size = 0;
 static unsigned long max_delta_cache_size = 0;
+static unsigned long cache_max_small_delta_size = 1000;
 
 /*
  * The object names in objects array are hashed with this hashtable,
@@ -1403,6 +1404,9 @@ static int delta_cacheable (struct unpacked *trg, struct unpacked *src,
 	if (max_delta_cache_size && delta_cache_size + delta_size > max_delta_cache_size)
 		return 0;
 
+	if (delta_size < cache_max_small_delta_size) 
+		return 1;
+
 	/* cache delta, if objects are large enough compared to delta size */
 	if ((src_size >> 20) + (trg_size >> 21) > (delta_size >> 10))
 		return 1;
@@ -1654,6 +1658,10 @@ static int git_pack_config(const char *k, const char *v)
 		max_delta_cache_size = git_config_int(k, v);
 		return 0;
 	}
+	if(!strcmp(k, "pack.deltacachelimit")) {
+		cache_max_small_delta_size = git_config_int(k, v);
+		return 0;
+	}
 	return git_default_config(k, v);
 }
 
-- 
1.5.2.846.g9a144
