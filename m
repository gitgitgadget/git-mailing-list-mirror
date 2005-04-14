From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] git: fix memory leak #2 in checkout-cache.c
Date: Thu, 14 Apr 2005 13:35:27 +0200
Message-ID: <20050414113527.GA13790@elte.hu>
References: <20050414112638.GA12593@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 13:33:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM2aO-0000z4-HK
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 13:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVDNLfs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 07:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVDNLfs
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 07:35:48 -0400
Received: from mx1.elte.hu ([157.181.1.137]:7396 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261481AbVDNLfn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 07:35:43 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id 38E3131F8B7;
	Thu, 14 Apr 2005 13:34:55 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 2DA741FC2; Thu, 14 Apr 2005 13:35:30 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050414112638.GA12593@elte.hu>
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


this patch fixes another (very rare) memory leak in checkout-cache.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- checkout-cache.c.orig
+++ checkout-cache.c
@@ -74,6 +74,8 @@ static int write_entry(struct cache_entr
 
 	new = read_sha1_file(ce->sha1, type, &size);
 	if (!new || strcmp(type, "blob")) {
+		if (new)
+			free(new);
 		return error("checkout-cache: unable to read sha1 file of %s (%s)",
 			ce->name, sha1_to_hex(ce->sha1));
 	}
