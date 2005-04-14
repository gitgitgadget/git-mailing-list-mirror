From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] git: fix memory leak #2 in read-cache.c
Date: Thu, 14 Apr 2005 15:25:50 +0200
Message-ID: <20050414132550.GA25496@elte.hu>
References: <20050414112638.GA12593@elte.hu> <20050414120834.GA14290@elte.hu> <20050414123258.GA15148@elte.hu> <20050414123934.GA15420@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Martin Schlemmer <azarah@nosferatu.za.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 15:24:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM4JF-0001oD-Mn
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 15:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVDNN0R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 09:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVDNN0R
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 09:26:17 -0400
Received: from mx2.elte.hu ([157.181.151.9]:54930 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261498AbVDNN0L (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 09:26:11 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id BB59A318ECE;
	Thu, 14 Apr 2005 15:25:04 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 4BF6D1FC2; Thu, 14 Apr 2005 15:25:53 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050414123934.GA15420@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> this patch fixes a memory leak in read-cache.c: when there's cache 
> entry collision we should free the previous one.

> +		free(active_cache[pos]);
>  		active_cache[pos] = ce;

i'm having second thoughs about this one: active_cache entries are not 
always malloc()-ed - e.g. read_cache() will construct them from the 
mmap() of the index file. Which must not be free()d!

one safe solution would be to malloc() all these entries and copy them 
over from the index file? Slightly slower but safer and free()-able when 
update-cache.c notices a collision. The (tested) patch below does this.

this would also make Martin Schlemmer's update-cache.c fix safe.

(without this second patch, free(active_cache[pos]) might crash, and 
that crash is would possibly be remote exploitable via a special 
repository that tricks the index file to look in a certain way.)

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- read-cache.c.orig
+++ read-cache.c
@@ -453,10 +453,17 @@ int read_cache(void)
 
 	offset = sizeof(*hdr);
 	for (i = 0; i < hdr->entries; i++) {
-		struct cache_entry *ce = map + offset;
+		struct cache_entry *ce = map + offset, *tmp;
 		offset = offset + ce_size(ce);
-		active_cache[i] = ce;
+
+		tmp = malloc(ce_size(ce));
+		if (!tmp)
+			return error("malloc failed");
+		memcpy(tmp, ce, ce_size(ce));
+		active_cache[i] = tmp;
 	}
+	munmap(map, size);
+
 	return active_nr;
 
 unmap:

