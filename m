From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Remove diff machinery dependency from read-cache
Date: Thu, 21 Jan 2010 14:18:34 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001211355500.13231@localhost.localdomain>
References: <alpine.LFD.2.00.1001211119130.13231@localhost.localdomain> <7vljfrp6g2.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001211215080.13231@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 21 23:20:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY5Ny-0004iC-OQ
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 23:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494Ab0AUWUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 17:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755435Ab0AUWUN
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 17:20:13 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39845 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754631Ab0AUWUM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jan 2010 17:20:12 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0LMIYu0004484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jan 2010 14:18:35 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0LMIYdp000544;
	Thu, 21 Jan 2010 14:18:34 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.1001211215080.13231@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.449 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137697>



On Thu, 21 Jan 2010, Linus Torvalds wrote:
> 
> Sure. Except, as I mentioned, it's not just git-hash-object. It's _all_ of 
> them.
> 
> The total space savings wasn't 1.7M, it was 12M.

There are some other interesting cases. For example, look at this:

	[torvalds@nehalem git]$ size show-index.o git-show-index
	   text	   data	    bss	    dec	    hex	filename
	   1310	      0	   1024	   2334	    91e	show-index.o
	 222706	   2296	 112720	 337722	  5273a	git-show-index

ie a trivial program like 'show-index' has ballooned to 220kB. Let's look 
at why:

	[torvalds@nehalem git]$ nm show-index.o | grep ' U '
	                 U die
	                 U fread
	                 U free
	                 U printf
	                 U sha1_to_hex
	                 U stdin
	                 U usage
	                 U xmalloc

ok, if you ignore standard library things (which will be from a shared 
library anyway), it really only wants totally trivial things: die, 
xmalloc, and sha1_to_hex. Those should be a few hundred bytes, not a few 
hundred _kilo_bytes.

So what happens?

 - sha1_to_hex brings in all of sha1_file.c, even though it doesn't need 
   any of it. Ok, that's easily fixed: split up the hex helpers into a 
   file of its own ("hex.c")

 - "die()" brings in usage.c, which is actually designed correctly, so it 
   is all fine. No extra pain there. Sure, we'll get some other trivial 
   stuff from there, but we're talking maybe a kilobyte of code.

 - "xmalloc()" brings in the trivial wrappers.

   OOPS.

Those wrappers bring in zlib (through git_inflate*), which is not a huge 
issue, we coult just move the git_inflate*() wrappers to its own file. 
Trivial. But the wrappers also bring in:

 - xmalloc/xrealloc/xstrdup:
                 U release_pack_memory

which in turn brings in _all_ of the rest of the git libraries. End 
result: a trivial git helper program that _should_ be a couple of 
kilobytes in size ends up being 200+kB of text, and 900kB with debug 
information.

Absolutely _none_ of which is in the least useful.

Oh well.

We could fix it a few ways

 - ignore it. Most git programs will get the pack handling functions 
   anyway, since they want to get object reading.

 - as mentioned, just build in _everything_ so that we only ever have one 
   binary

 - get rid of release_pack_memory() entirely. We have better ways to limit 
   pack memory use these days, but they do require configuration (we do 
   have a default packed_git_limit, though, so even without any explicit 
   configuration it's not insane).

 - don't have explicit knowledge about 'release_pack_memory' in xmalloc, 
   but instead have the packing functions register a "xmalloc 
   pressure_reliever function". So then programs that have pack handling 
   will register the fixup function, and programs that don't will never 
   even know.

Hmm? We have about 20 external programs that may hide issues like this.

		Linus
