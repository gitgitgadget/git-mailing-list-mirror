From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What to expect after 0.99.8
Date: Mon, 3 Oct 2005 16:16:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510031606550.31407@g5.osdl.org>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0510031522590.23242@iabervon.org> <7vmzlqnwmw.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0510031709360.23242@iabervon.org> <7v1x32l0gz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Dan Aloni <da-x@monatomic.org>
X-From: git-owner@vger.kernel.org Tue Oct 04 01:17:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMZYT-0003IT-8I
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 01:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbVJCXQm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Oct 2005 19:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbVJCXQm
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Oct 2005 19:16:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9942 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932440AbVJCXQl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2005 19:16:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j93NGT4s009051
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 3 Oct 2005 16:16:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j93NGRMI028364;
	Mon, 3 Oct 2005 16:16:28 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x32l0gz.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9657>



On Mon, 3 Oct 2005, Junio C Hamano wrote:
> 
> This reminds me of one patch:
> 
>     From: Dan Aloni <da-x@monatomic.org>
>     Subject: [PATCH] Fix git+ssh's indefinite halts during long fetches
>     Date: Sat, 1 Oct 2005 21:39:42 +0300
>     Message-ID: <20051001183942.GA2099@localdomain>
> 
> I'd appreciate it if you had a chance to take a look at it and
> comment on it.

I personally hate it.

It adds horrible patches to fairly core stuff, all because the prefetching 
is not limited.

As far as I can tell, it should be much easier to just limit the 
prefetching to some reasonable limit (say, a few objects deep), which 
guarantees that the prefetching doesn't fill up the write queues on the 
fetching side.

It's not like prefetching improves performance once you get to the point 
where you can stream. I suspect having more than two or three objects "in 
flight" really only helps with

 - lots of small objects
 - high latency
 - high bandwidth

and the thing is, high latency together with high bandwidth is really 
quite uncommon - usually high latency goes along with _low_ bandwidth (the 
one exception is things like satellite links, which can have latencies in 
the seconds, even with good throughput).

It should be pretty easy to benchmark, but my _suspicion_ is that limiting 
the read-ahead to even just five is likely to get you 99% of the way, and 
that the performance impact of going higher is very limited.

(It might need some extra code to make the synchronous receiving side 
re-start the prefetching if the prefetching has stopped after a few 
entries - but at that point the extra code is where it is supposed to be, 
rather than having core code work around problems in the fetching. I also 
suspect that the prefetch limiting can happily be done in the generic 
"pull" code, rather than separately for each protocol, so it would need to 
be done in just one place).

		Linus
