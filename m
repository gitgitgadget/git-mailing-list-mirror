From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Cleanup read_cache_from error handling.
Date: Mon, 25 Dec 2006 23:40:58 -0500
Message-ID: <20061226044058.GA28359@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 26 05:41:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gz47s-0000wR-Q2
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 05:41:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWLZElH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Dec 2006 23:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWLZElH
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 23:41:07 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58354 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932235AbWLZElG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 23:41:06 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gz47O-0000vb-Jc; Mon, 25 Dec 2006 23:40:50 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CD7C920FB65; Mon, 25 Dec 2006 23:40:58 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35410>

When I converted the mmap() call to xmmap() I failed to cleanup the
way this routine handles errors and left some crufty code behind.
This is a small cleanup, suggested by Johannes.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 This is on top of my sp/mmap topic.

 read-cache.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index ca3efbb..29cf9ab 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -793,16 +793,16 @@ int read_cache_from(const char *path)
 		die("index file open failed (%s)", strerror(errno));
 	}
 
-	cache_mmap = MAP_FAILED;
 	if (!fstat(fd, &st)) {
 		cache_mmap_size = st.st_size;
 		errno = EINVAL;
 		if (cache_mmap_size >= sizeof(struct cache_header) + 20)
 			cache_mmap = xmmap(NULL, cache_mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
-	}
+		else
+			die("index file smaller than expected");
+	} else
+		die("cannot stat the open index (%s)", strerror(errno));
 	close(fd);
-	if (cache_mmap == MAP_FAILED)
-		die("index file mmap failed (%s)", strerror(errno));
 
 	hdr = cache_mmap;
 	if (verify_hdr(hdr, cache_mmap_size) < 0)
-- 
1.4.4.3.gd2e4
