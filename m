From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: [PATCH 3/5] read_cache_from(): small simplification
Date: Wed, 25 Apr 2007 11:18:17 -0300
Organization: Mandriva
Message-ID: <20070425111817.4d4e4af5@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Apr 25 16:19:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgiL5-0004NV-VF
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 16:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbXDYOTU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 10:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbXDYOTU
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 10:19:20 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:46468 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932224AbXDYOTT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 10:19:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 581FF17AE2;
	Wed, 25 Apr 2007 11:19:17 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id lKMDvJjHU4Wy; Wed, 25 Apr 2007 11:19:17 -0300 (BRT)
Received: from localhost (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 6088D17AD3;
	Wed, 25 Apr 2007 11:18:18 -0300 (BRT)
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.3; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45530>

This change 'opens' the code block which maps the index file into
memory, making the code clearer and easier to read.

Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>
---
 read-cache.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index d2f332a..24e5581 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -856,15 +856,15 @@ int read_cache_from(const char *path)
 		die("index file open failed (%s)", strerror(errno));
 	}
 
-	if (!fstat(fd, &st)) {
-		cache_mmap_size = xsize_t(st.st_size);
-		errno = EINVAL;
-		if (cache_mmap_size >= sizeof(struct cache_header) + 20)
-			cache_mmap = xmmap(NULL, cache_mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
-		else
-			die("index file smaller than expected");
-	} else
+	if (fstat(fd, &st))
 		die("cannot stat the open index (%s)", strerror(errno));
+
+	errno = EINVAL;
+	cache_mmap_size = xsize_t(st.st_size);
+	if (cache_mmap_size < sizeof(struct cache_header) + 20)
+		die("index file smaller than expected");
+
+	cache_mmap = xmmap(NULL, cache_mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	close(fd);
 
 	hdr = cache_mmap;
-- 
1.5.1.1.320.g1cf2
