From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 'dotest' fails, patch(1) succeeds
Date: Thu, 23 Jun 2005 09:22:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506230915330.11175@ppc970.osdl.org>
References: <42BA66C1.30400@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 18:15:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlUM5-0006U1-FM
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 18:15:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbVFWQVX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 12:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbVFWQVX
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 12:21:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12161 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262602AbVFWQUn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2005 12:20:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5NGKdjA008146
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 23 Jun 2005 09:20:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5NGKc7j027702;
	Thu, 23 Jun 2005 09:20:39 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42BA66C1.30400@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 23 Jun 2005, Jeff Garzik wrote:
> 
> Trying to use git-tools' "dotest" script to merge an mbox into a kernel 
> git repo failed, but patch(1) was OK with it:
> 
> 	[jgarzik@pretzel netdev-2.6]$ dotest /g/tmp/mbox
> 
> 	Applying 'e1000: fix spinlock bug'
> 
> 	fatal: corrupt patch at line 10

You have a corrupt patch, and "git-apply" not only tells you so, it tells 
you _exactly_ where it is:

In particular, it has whitespace damage at line 10:

 1 --- linux-2.6.12-clean/drivers/net/e1000/e1000_main.c	2005-06-17 12:48:29.000000000 -0700
 2 +++ linux-2.6.12/drivers/net/e1000/e1000_main.c	2005-06-21 10:42:29.000000000 -0700
 3 @@ -2307,6 +2307,7 @@ e1000_xmit_frame(struct sk_buff *skb, st
 4  	tso = e1000_tso(adapter, skb);
 5  	if (tso < 0) {
 6  		dev_kfree_skb_any(skb);
 7 +		spin_unlock_irqrestore(&adapter->tx_lock, flags);
 8  		return NETDEV_TX_OK;
 9  	}
10 

And take a close look. That line should have _one_ space on it (the space 
that says "neither new nor old"), and it's totally empty (well, now in my 
email it has "10 " on it, of course ;)

Btw, you have another problem: you should add a "---" marker to before the 
patch header, otherwise your commit message will have the "diff -urpN" 
thing in it. To the "dotest" scripts, "---" is the thing that says "here 
ends the message and the patch begins".

(The line numbers from "git-apply" will also start at that --- point, so 
if you add a "---" just above the "diff" line, you'd get "line 12" being 
the corrupt one)

		Linus
