From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] git: fix memory leak #2 in read-cache.c
Date: Thu, 14 Apr 2005 14:39:34 +0200
Message-ID: <20050414123934.GA15420@elte.hu>
References: <20050414112638.GA12593@elte.hu> <20050414120834.GA14290@elte.hu> <20050414123258.GA15148@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 14:37:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM3a6-0002UI-GD
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 14:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVDNMjn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 08:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVDNMjn
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 08:39:43 -0400
Received: from mx2.elte.hu ([157.181.151.9]:27274 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261489AbVDNMjm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 08:39:42 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id 8E70031822A;
	Thu, 14 Apr 2005 14:38:48 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 1E97F1FC2; Thu, 14 Apr 2005 14:39:37 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050414123258.GA15148@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


this patch fixes a memory leak in read-cache.c: when there's cache entry 
collision we should free the previous one.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- read-cache.c.orig
+++ read-cache.c
@@ -369,6 +369,7 @@ int add_cache_entry(struct cache_entry *
 
 	/* existing match? Just replace it */
 	if (pos >= 0) {
+		free(active_cache[pos]);
 		active_cache[pos] = ce;
 		return 0;
 	}
