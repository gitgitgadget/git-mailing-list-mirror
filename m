From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] git: fix rare memory leak in rev-tree.c
Date: Thu, 14 Apr 2005 13:58:00 +0200
Message-ID: <20050414115800.GB14065@elte.hu>
References: <20050414112638.GA12593@elte.hu> <20050414113527.GA13790@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 13:55:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM2vu-0004Nw-N9
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 13:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVDNL6M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 07:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVDNL6M
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 07:58:12 -0400
Received: from mx1.elte.hu ([157.181.1.137]:16359 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261483AbVDNL6G (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 07:58:06 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id 4A96B31E922;
	Thu, 14 Apr 2005 13:57:28 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 43AF61FC2; Thu, 14 Apr 2005 13:58:03 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050414113527.GA13790@elte.hu>
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


this patch fixes a rare memory leak in rev-tree.c.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- rev-tree.c.orig
+++ rev-tree.c
@@ -73,8 +73,11 @@ static int parse_commit(unsigned char *s
 
 		rev->flags |= SEEN;
 		buffer = bufptr = read_sha1_file(sha1, type, &size);
-		if (!buffer || strcmp(type, "commit"))
+		if (!buffer || strcmp(type, "commit")) {
+			if (buffer)
+				free(buffer);
 			return -1;
+		}
 		bufptr += 46; /* "tree " + "hex sha1" + "\n" */
 		while (!memcmp(bufptr, "parent ", 7) && !get_sha1_hex(bufptr+7, parent)) {
 			add_relationship(rev, parent);
