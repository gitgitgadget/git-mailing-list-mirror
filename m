X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Fri, 8 Dec 2006 15:27:42 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612081453430.3516@woody.osdl.org>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>
 <45744FA3.7020908@zytor.com> <Pine.LNX.4.64.0612061847190.3615@woody.osdl.org>
 <45778AA3.7080709@zytor.com> <Pine.LNX.4.64.0612061940170.3615@woody.osdl.org>
 <4577A84C.3010601@zytor.com> <Pine.LNX.4.64.0612070953290.3615@woody.osdl.org>
 <45785697.1060001@zytor.com> <Pine.LNX.4.64.0612071052560.3615@woody.osdl.org>
 <457868AA.2030605@zytor.com> <20061207193012.GA84678@dspnet.fr.eu.org>
 <4578722E.9030402@zytor.com> <4579611F.5010303@dawes.za.net>
 <45798FE2.9040502@zytor.com> <Pine.LNX.4.64.0612080830380.3516@woody.osdl.org>
 <457998C8.3050601@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 8 Dec 2006 23:28:45 +0000 (UTC)
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <457998C8.3050601@garzik.org>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33768>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsp8u-0005a0-U3 for gcvg-git@gmane.org; Sat, 09 Dec
 2006 00:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758846AbWLHX2e (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 18:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758841AbWLHX2e
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 18:28:34 -0500
Received: from smtp.osdl.org ([65.172.181.25]:50685 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1758846AbWLHX2d
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 18:28:33 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB8NRiID009516
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Fri, 8
 Dec 2006 15:27:46 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB8NRg4G008937; Fri, 8 Dec
 2006 15:27:43 -0800
To: Jeff Garzik <jeff@garzik.org>
Sender: git-owner@vger.kernel.org



On Fri, 8 Dec 2006, Jeff Garzik wrote:
> 
> This is quite nice and easy, if memory-only caching works for the situation:
> http://www.danga.com/memcached/
> 
> There are APIs for C, Perl, and plenty of other languages.

Actually, just looking at the examples, it looks like memcached is 
fundamentally flawed, exactly the same way Apache mod_cache is 
fundamentally flawed.

Exactly like mod_perl, it appears that if something isn't cached, the 
memcached server will just return "not cached" to everybody, and all the 
clients will, like a stampeding herd, all do the uncached access. Even if 
they have the exact same query. And you're back to square one: your server 
load went through the roof.

You can't have a cache architecture where the client just does a "get", 
like memcached does. You need to have a "read-for-fill" operation, which 
says:

 - get this cache entry

 - if this cache entry does not exist, get an exclusive lock

 - if you get that exclusive lock, return NULL, and the client promises 
   that it will fill it (inside the kernel, see for example 
   "find_get_page()" vs "grab_cache_page()" - the latter will return a 
   locked page whether it exists or not, and if it didn't exist, it will 
   have inserted it into the cache datastructures so that you don't have 
   multiple concurrent readers trying to all create different pages)

 - if you block on the exclusive lock, that means that some other client 
   is busy fulfilling it. When you unblock, do a regular "read" operation 
   (not a "repeat": we only block once, and if that fails, that's it).

 - any cachefill operation will release the lock (and allow pending 
   cache queries to succeed)

 - the locking client going away will release the lock (and allow pending 
   cache queries to fail, and hopefully cause a "set cache" operation)

 - a timeout (settable by some method) will also force-release a lock in 
   the case of buggy clients that do "read-for-modify" but never do the 
   "modify".

The "timeout" thing is to handle the case of buggy clients that crash 
after trying to get - it will slow down things _enormously_ if that 
happens, but hey, it's a buggy client. And it will still continue to work.

Looking at the memcached operations, they have the "read" op (aka "get"), 
but they seem to have no "read-for-fill" op. So memcached fundamentally 
doesn't fix this problem, at least without explicit serialization by the 
client.

(The serialization could be done by the client, but that would serialize 
_everything_, and mean that a uncached lookup will hold up all the cached 
ones too - which is why you do NOT want to serialize in the caller: you 
really want to serialize in the layer that does the caching).

It's fairly easy to do the lock. You could just hash the lookup key using 
some reasonable hash. It doesn't even have to be a _big_ hash: it's ok to 
have just a few bits for lock hashing, since it's only going to be for 
misses.

So hashing to eight bits and using 256 locks is probably fine, as long as 
this is done by the cache server. That means that the cache server only 
ever needs to track that many timeouts, for example (it also indirectly 
sets a limit on the number of possible "outstanding uncached requests", 
which is _exactly_ what you want - but hash collissions will also 
potentially unlock the _wrong_ bucket, so if you have too many of them, it 
can make the "only one outstanding unhashed request per key" not be as 
effective).

So assuming you get good cache hit statistics, the locking shouldn't be a 
big issue. But you definitely want to do it, because the whole point of 
caching was to not do the same op multiple times. 

I still don't understand why apache doesn't do it. I guess it wants to be 
stateless or something.

