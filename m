From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] git: fix 1-byte overflow in show-files.c
Date: Thu, 14 Apr 2005 14:53:54 +0200
Message-ID: <20050414125354.GB15420@elte.hu>
References: <20050414112638.GA12593@elte.hu> <20050414120834.GA14290@elte.hu> <20050414121819.GA14380@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 14:52:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM3ob-0004sW-AF
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 14:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVDNMyn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 08:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVDNMyn
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 08:54:43 -0400
Received: from mx1.elte.hu ([157.181.1.137]:3460 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261491AbVDNMyl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 08:54:41 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id 12D0531E2D0;
	Thu, 14 Apr 2005 14:53:22 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 190EF1FC2; Thu, 14 Apr 2005 14:53:57 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050414121819.GA14380@elte.hu>
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


this patch fixes a 1-byte overflow in show-files.c (looks narrow is is 
probably not exploitable). A specially crafted db object (tree) might 
trigger this overflow.

'fullname' is an array of 4096+1 bytes, and we do readdir(), which 
produces entries that have strings with a length of 0-255 bytes. With a 
long enough 'base', it's possible to construct a tree with a name in it 
that has directory whose name ends precisely at offset 4095. At that 
point this code:

                        case DT_DIR:
                                memcpy(fullname + baselen + len, "/", 2);

will attempt to append a "/" string to the directory name - resulting in 
a 1-byte overflow (a zero byte is written to offset 4097, which is 
outside the array).

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- show-files.c.orig
+++ show-files.c
@@ -49,7 +49,7 @@ static void read_directory(const char *p
 
 	if (dir) {
 		struct dirent *de;
-		char fullname[MAXPATHLEN + 1];
+		char fullname[MAXPATHLEN + 2]; // +1 byte for trailing slash
 		memcpy(fullname, base, baselen);
 
 		while ((de = readdir(dir)) != NULL) {

