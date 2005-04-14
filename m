From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] git: fix memory leak #2 in read-cache.c
Date: Thu, 14 Apr 2005 08:11:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504140804480.7211@ppc970.osdl.org>
References: <20050414112638.GA12593@elte.hu> <20050414120834.GA14290@elte.hu>
 <20050414123258.GA15148@elte.hu> <20050414123934.GA15420@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 17:07:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM5vP-0004pr-8J
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 17:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVDNPJ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 11:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVDNPJ4
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 11:09:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:18051 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261517AbVDNPJx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 11:09:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3EF9ns4010976
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 14 Apr 2005 08:09:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3EF9nqP031706;
	Thu, 14 Apr 2005 08:09:49 -0700
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050414123934.GA15420@elte.hu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 14 Apr 2005, Ingo Molnar wrote:
> 
> this patch fixes a memory leak in read-cache.c: when there's cache entry 
> collision we should free the previous one.

As you already noticed "read_cache()" normally just populates the
active-cache with pointers to the mmap'ed "active" file.

Whether that is a good idea or not, I do not know. But I do know that the 
active file is the single biggest file we work with (ie 1.6MB in size), so 
since _most_ tools just read it and modify a very small number of entries, 
it seemed like a good idea.

In other words, if the common case is that we update a couple of entries
in the active cache, we actually saved 1.6MB (+ malloc overhead for the 17
_thousand_ allocations) by my approach.

And the leak? There's none. We never actually update an existing entry 
that was allocated with malloc(), unless the user does something stupid. 
In other words, the only case where there is a "leak" is when the user 
does something like

	update-cache file file file file file file .. 

with the same file listed several times.

And dammit, the whole point of doing stuff in user space is that the 
kernel takes care of business. Unlike kernel work, leaking is ok. You just 
have to make sure that it is limited enough to to not be a problem. I'm 
saying that in this case we're _better_ off leaking, because the mmap() 
trick saves us more memory than the leak can ever leak.

(The command line is limited to 128kB or so, which means that the most 
files you _can_ add with a single update-cache is _less_ than the mmap 
win).

It was _such_ a relief to program in user mode for a change. Not having to 
care about the small stuff is wonderful.

		Linus
