From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] git: fix memory leak #3 in update-cache.c
Date: Thu, 14 Apr 2005 15:31:34 +0200
Message-ID: <20050414133134.GB21543@elte.hu>
References: <20050414112638.GA12593@elte.hu> <20050414120834.GA14290@elte.hu> <20050414121819.GA14380@elte.hu> <20050414130309.GA18703@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 15:29:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM4OT-0002qz-Nj
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 15:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVDNNbs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 09:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVDNNbs
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 09:31:48 -0400
Received: from mx2.elte.hu ([157.181.151.9]:15252 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261499AbVDNNbq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 09:31:46 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id 128A73195E2;
	Thu, 14 Apr 2005 15:30:49 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id AD3341FC2; Thu, 14 Apr 2005 15:31:37 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050414130309.GA18703@elte.hu>
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


the patch below fixes a third memory leak in update-cache.c. (the 
mmap-ed file needs to be unmapped too) Ontop of the previous 
update-cache.c patches.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- update-cache.c.orig
+++ update-cache.c
@@ -32,6 +32,8 @@ static int index_fd(const char *path, in
 	if (!out || (int)(long)in == -1) {
 		free(out);
 		free(metadata);
+		if ((int)(long)in != -1 && size)
+			munmap(in, size);
 		return -1;
 	}
 
@@ -66,6 +68,8 @@ static int index_fd(const char *path, in
 		
 	free(out);
 	free(metadata);
+	if (size)
+		munmap(in, size);
 
 	return ret;
 }
