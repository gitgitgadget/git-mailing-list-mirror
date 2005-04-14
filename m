From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] git: fix overflow in update-cache.c
Date: Thu, 14 Apr 2005 14:18:19 +0200
Message-ID: <20050414121819.GA14380@elte.hu>
References: <20050414112638.GA12593@elte.hu> <20050414120834.GA14290@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 14:16:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM3GC-0007kP-PU
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 14:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVDNMTK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 08:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVDNMTK
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 08:19:10 -0400
Received: from mx1.elte.hu ([157.181.1.137]:8939 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261486AbVDNMTC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 08:19:02 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id 70C5531E321;
	Thu, 14 Apr 2005 14:17:47 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 900281FC2; Thu, 14 Apr 2005 14:18:22 +0200 (CEST)
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


this patch fixes a 1-byte overflow in update-cache.c (probably not 
exploitable). A specially crafted db object might trigger this overflow.

the bug is that normally the 'type' field is parsed by read_sha1_file(), 
via:

        if (sscanf(buffer, "%10s %lu", type, size) != 2)

i.e. 0-10 long strings, which take 1-11 bytes of space. Normally the 
type strings are stored in char [20] arrays, but in update-cache.c that 
is char [10], so a 1 byte overflow might occur.

This should not happen with a 'friendly' DB, as the longest type string 
("commit") is 7 bytes long. The fix is to use the customary char [20].

(someone might want to clean those open-coded constants up with a 
TYPE_LEN define, they do tend to cause problems like this. I'm not 
against open-coded constants (they make code much more readable), but 
for fields that get filled in from possibly hostile objects this is 
playing with fire.)

hey, this might be the first true security fix for GIT? ;-)

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- update-cache.c.orig
+++ update-cache.c
@@ -139,7 +139,7 @@ static int compare_data(struct cache_ent
 	if (fd >= 0) {
 		void *buffer;
 		unsigned long size;
-		char type[10];
+		char type[20];
 
 		buffer = read_sha1_file(ce->sha1, type, &size);
 		if (buffer) {
