X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: Mon, 18 Dec 2006 14:22:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org>
References: <86y7p57y05.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181251020.3479@woody.osdl.org>
 <86r6uw9azn.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181625140.18171@xanadu.home>
 <86hcvs984c.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 18 Dec 2006 22:23:28 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <86hcvs984c.fsf@blue.stonehenge.com>
X-MIMEDefang-Filter: osdl$Revision: 1.163 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34746>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwQt6-0005Lo-UM for gcvg-git@gmane.org; Mon, 18 Dec
 2006 23:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754675AbWLRWXJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 17:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754690AbWLRWXJ
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 17:23:09 -0500
Received: from smtp.osdl.org ([65.172.181.25]:51448 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1754675AbWLRWXI
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006 17:23:08 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBIMMvID023874
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 18
 Dec 2006 14:23:03 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBIMMung014202; Mon, 18 Dec
 2006 14:22:57 -0800
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Sender: git-owner@vger.kernel.org



On Mon, 18 Dec 2006, Randal L. Schwartz wrote:
> 
> I have a single pack.
> 
> "Indexing" took about 30 seconds.
> "Resolving 313037 deltas" looks like it's going to take an hour.
> 
> So that *was* a local delay.

Ok, interesting. Two questions:

 - what does "top" say (is it CPU-bound? Is it perhaps blowing out your 
   disk cache? Is it swapping?)

 - do you have "oprofile" (or even just pgprof) to see where the *hell* 
   that time is spent, if it's actually CPU?

For me, it takes 25 seconds. Not an hour:

	[torvalds@woody linux]$ time git-index-pack -v -o /dev/null .git/objects/pack/*.pack
	Indexing 393507 objects.
	 100% (393507/393507) done
	Resolving 316071 deltas.
	 100% (316071/316071) done
	fatal: unable to create /dev/null: File exists
	
	real    0m24.619s
	user    0m22.569s
	sys     0m1.316s

(I admit that 25 seconds is already "too much", but it does actually end 
up exploding a lot of objects and doing quite a bit of work, so I guess 
it's fair).

And the process grew to 33MB in RSS at it's biggest, so it wasn't even 
using all that much memory (33MB isn't _tiny_, but considering that the 
pack in question is 155MB and has hundreds of thousands of objects, 33MB 
isn't really all that bad.

You're running this under OS X, aren't you? It's a pig of an OS, but 
"almost one hour" vs "25 seconds" is still unreasonable.

