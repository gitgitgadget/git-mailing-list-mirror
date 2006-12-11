X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] CGit v0.1-pre
Date: Mon, 11 Dec 2006 09:01:58 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612110859200.12500@woody.osdl.org>
References: <8c5c35580612101542n72d300c7o106e53e219670510@mail.gmail.com> 
 <Pine.LNX.4.64.0612101653420.12500@woody.osdl.org>
 <8c5c35580612110033y4f6260c9xffeaf4457f4ead21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 11 Dec 2006 17:02:10 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <8c5c35580612110033y4f6260c9xffeaf4457f4ead21@mail.gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34015>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtoXY-0001lX-6o for gcvg-git@gmane.org; Mon, 11 Dec
 2006 18:02:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762938AbWLKRCF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 12:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760367AbWLKRCE
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 12:02:04 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44236 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1762938AbWLKRCC
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006 12:02:02 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBBH1xID021587
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 11
 Dec 2006 09:02:00 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBBH1wRq032039; Mon, 11 Dec
 2006 09:01:59 -0800
To: Lars Hjemli <hjemli@gmail.com>
Sender: git-owner@vger.kernel.org



On Mon, 11 Dec 2006, Lars Hjemli wrote:
>
> But this also applies to the case where the cachefile has expired,
> right? In that case, after getting the lock, I have to recheck that
> the cachefile is _still_ expired.

Yes.

> Anyway, I must say I find it rather unlikely for these cases to occur
> (frequently) in real life. That would seem to imply that the caching
> isn't really needed at all.

The point is, if you have races, you will hit them _occasionally_. It may 
not be a performance problem in real life, BUT:

 - quite often, you can take advantage of the serialization guarantees 
   that a front-side cache offers you, and do the uncached accesses (or 
   writing the final cache-file) knowing that there's only one thing that 
   does that.

 - If so, then a race condition in the cache goes from a "unlikely 
   performance problem" to a BUG.

> > As a side note: how do you release your caches?
> 
> Simple timeouts (time()-stat.st_mtime), depending on what kind of page
> was requested. If anyone cares about invalid cache content (branch
> head moving), relevant cachefiles can be deleted with an update-hook.

I was more thinking about the locking part. Again, to be safe, you should 
probably take the lock before releasing any cache.

