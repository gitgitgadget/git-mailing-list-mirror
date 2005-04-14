From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] git: fix memory leaks in read-cache.c
Date: Thu, 14 Apr 2005 14:32:58 +0200
Message-ID: <20050414123258.GA15148@elte.hu>
References: <20050414112638.GA12593@elte.hu> <20050414120834.GA14290@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 14:30:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM3U7-0001aG-Rq
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 14:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVDNMd2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 08:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVDNMd2
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 08:33:28 -0400
Received: from mx2.elte.hu ([157.181.151.9]:3721 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261484AbVDNMdY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 08:33:24 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id 6BF6D31985A;
	Thu, 14 Apr 2005 14:32:12 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 158BC1FC2; Thu, 14 Apr 2005 14:33:01 +0200 (CEST)
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


this patch fixes a common and a rare memory leak in read-cache.c.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- read-cache.c.orig
+++ read-cache.c
@@ -226,8 +226,11 @@ int write_sha1_file(char *buf, unsigned 
 	SHA1_Update(&c, compressed, size);
 	SHA1_Final(sha1, &c);
 
-	if (write_sha1_buffer(sha1, compressed, size) < 0)
+	if (write_sha1_buffer(sha1, compressed, size) < 0) {
+		free(compressed);
 		return -1;
+	}
+	free(compressed);
 	if (returnsha1)
 		memcpy(returnsha1, sha1, 20);
 	return 0;
