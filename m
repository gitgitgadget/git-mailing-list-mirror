X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Mon, 11 Dec 2006 08:59:01 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612110855550.12500@woody.osdl.org>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com> 
 <e5bfff550612101151r5e77ddc0w8f61f36fc1f2920e@mail.gmail.com> 
 <Pine.LNX.4.64.0612101159530.12500@woody.osdl.org> 
 <Pine.LNX.4.64.0612101213520.12500@woody.osdl.org> 
 <e5bfff550612101405h507cc877k87491264d11b0aa8@mail.gmail.com> 
 <Pine.LNX.4.64.0612101410220.12500@woody.osdl.org> 
 <e5bfff550612101435o6bc938acmac28ad6adf0c8844@mail.gmail.com> 
 <Pine.LNX.4.64.0612101439540.12500@woody.osdl.org> 
 <e5bfff550612101615u5f588513n499e3b88ce14a6f6@mail.gmail.com> 
 <Pine.LNX.4.64.0612101647310.12500@woody.osdl.org>
 <e5bfff550612102317w331f3b0fyc3c6b095ff21191a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 11 Dec 2006 17:01:04 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <e5bfff550612102317w331f3b0fyc3c6b095ff21191a@mail.gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34014>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtoWM-0001ZH-UW for gcvg-git@gmane.org; Mon, 11 Dec
 2006 18:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762933AbWLKQ7s (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 11:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762941AbWLKQ7s
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 11:59:48 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44064 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1762933AbWLKQ7q
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006 11:59:46 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBBGx3ID021406
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 11
 Dec 2006 08:59:38 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBBGx1J1031913; Mon, 11 Dec
 2006 08:59:02 -0800
To: Marco Costalba <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org



On Mon, 11 Dec 2006, Marco Costalba wrote:
> 
> These are tipical values (warm cache):
> 
> $ time git rev-list --header --boundary --parents --topo-order HEAD | cat > /dev/null
> 3.67user 0.36system 0:04.29elapsed 93%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (0major+18033minor)pagefaults 0swaps

That's not timing what I asked. That's just timing the "git-rev-list". You 
need to time the "cat" part too. Either use a script, or do something like 

	time sh -c "git-rev-list ... | cat > /dev/null".

> $ time git rev-list --header --boundary --parents --topo-order HEAD >
> /tmp/tmp.txt; cat /tmp/tmp.txt > /dev/null
> 3.44user 0.28system 0:03.74elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (0major+18033minor)pagefaults 0swaps

Again - you're only timing the _writer_, not the "cat" at all.

> For some reason the CPU *never* goes up 93% with pipe (while it's easy
> in the other two cases)

That's because you're only timing 93% of the work (ignoring the "cat" 
part), and in the other cases you're ignoring the "cat" (that happens 
_afterwards_, not concurrently) entirely.

> OK. I just don't understand how after waiting 100ms I get only 60KB
> and stay in the loop only one cycle instead of reading,


That's because the _writer_ will block. It notices that the reader cannot
read ass fast as it can write, so it blocks when its buffers fill up.

If you want to be fast, you need to be fast at reading. It's that simple.

