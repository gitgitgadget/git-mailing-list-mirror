From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] git: fix memory leak in write-tree.c
Date: Thu, 14 Apr 2005 15:12:32 +0200
Message-ID: <20050414131232.GA21543@elte.hu>
References: <20050414112638.GA12593@elte.hu> <20050414120834.GA14290@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 15:10:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM469-00080I-8U
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 15:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVDNNMx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 09:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVDNNMx
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 09:12:53 -0400
Received: from mx2.elte.hu ([157.181.151.9]:16016 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261484AbVDNNMt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 09:12:49 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id 21F573197C5;
	Thu, 14 Apr 2005 15:11:47 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 7F6D51FC2; Thu, 14 Apr 2005 15:12:35 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050414120834.GA14290@elte.hu>
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


this patch fixes a memory leak in write-tree.c's write_tree() function - 
we didnt free the temporary output buffer. Depending on the size of the 
tree written out this could leak a significant amount of RAM.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- write-tree.c.orig
+++ write-tree.c
@@ -33,12 +33,12 @@ static int write_tree(struct cache_entry
 {
 	unsigned char subdir_sha1[20];
 	unsigned long size, offset;
-	char *buffer;
+	char *buffer0, *buffer;
 	int i, nr;
 
 	/* Guess at some random initial size */
 	size = 8192;
-	buffer = malloc(size);
+	buffer0 = buffer = malloc(size);
 	offset = ORIG_OFFSET;
 
 	nr = 0;
@@ -97,6 +97,8 @@ static int write_tree(struct cache_entry
 	offset -= i;
 
 	write_sha1_file(buffer, offset, returnsha1);
+	free(buffer0);
+
 	return nr;
 }
 
