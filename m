From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] discard_cache(): discard index, even if no file was mmap()ed
Date: Thu, 10 Aug 2006 16:47:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608101645590.10541@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Aug 10 16:48:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBBol-0003PZ-Tt
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 16:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161272AbWHJOrX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 10:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161096AbWHJOrX
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 10:47:23 -0400
Received: from mail.gmx.de ([213.165.64.20]:38549 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161272AbWHJOrX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Aug 2006 10:47:23 -0400
Received: (qmail invoked by alias); 10 Aug 2006 14:47:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 10 Aug 2006 16:47:21 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25186>


Since add_cacheinfo() can be called without a mapped index file,
discard_cache() _has_ to discard the entries, even when
cache_mmap == NULL.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

---

	This fixes 41094b8e, the only showstopper I wrote
	about in my last -recur status report. The index file is
	now the same for -recur and -recursive when trying to recreate 
	41094b8e.

	Happy.

 read-cache.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index de8f690..3559bdc 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -841,14 +841,14 @@ int discard_cache()
 {
 	int ret;
 
+	active_nr = active_cache_changed = 0;
+	index_file_timestamp = 0;
+	cache_tree_free(&active_cache_tree);
 	if (cache_mmap == NULL)
 		return 0;
 	ret = munmap(cache_mmap, cache_mmap_size);
 	cache_mmap = NULL;
 	cache_mmap_size = 0;
-	active_nr = active_cache_changed = 0;
-	index_file_timestamp = 0;
-	cache_tree_free(&active_cache_tree);
 
 	/* no need to throw away allocated active_cache */
 	return ret;
-- 
1.4.2.rc4.g0d295-dirty
