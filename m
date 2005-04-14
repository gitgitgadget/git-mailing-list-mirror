From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] git: clean up add_file_to_cache() in update-cache.c
Date: Thu, 14 Apr 2005 15:08:29 +0200
Message-ID: <20050414130829.GB18703@elte.hu>
References: <20050414112638.GA12593@elte.hu> <20050414120834.GA14290@elte.hu> <20050414121819.GA14380@elte.hu> <20050414130309.GA18703@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 15:07:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM431-0007Pi-Bp
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 15:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVDNNJU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 09:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVDNNJU
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 09:09:20 -0400
Received: from mx1.elte.hu ([157.181.1.137]:42630 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261495AbVDNNJP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 09:09:15 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id 7D8F132013A;
	Thu, 14 Apr 2005 15:07:57 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 84B2F1FC2; Thu, 14 Apr 2005 15:08:32 +0200 (CEST)
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


this patch cleans up add_file_to_cache() to free up all memory it 
allocates. This has no significance right now as the only user of 
add_file_to_cache() die()s immediately in the 'leak' paths - but if the 
function is ever used without dying then this uncleanliness could lead 
to a memory leak.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- update-cache.c.orig
+++ update-cache.c
@@ -120,10 +120,17 @@ static int add_file_to_cache(char *path)
 	ce->st_size = st.st_size;
 	ce->namelen = namelen;
 
-	if (index_fd(path, namelen, ce, fd, &st) < 0)
+	if (index_fd(path, namelen, ce, fd, &st) < 0) {
+		free(ce);
 		return -1;
+	}
 
-	return add_cache_entry(ce, allow_add);
+	if (add_cache_entry(ce, allow_add)) {
+		free(ce);
+		return -1;
+	}
+
+	return 0;
 }
 
 static int match_data(int fd, void *buffer, unsigned long size)

