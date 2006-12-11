X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Mon, 11 Dec 2006 11:25:46 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612111120190.12500@woody.osdl.org>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com> 
 <e5bfff550612101435o6bc938acmac28ad6adf0c8844@mail.gmail.com> 
 <Pine.LNX.4.64.0612101439540.12500@woody.osdl.org> 
 <e5bfff550612101615u5f588513n499e3b88ce14a6f6@mail.gmail.com> 
 <Pine.LNX.4.64.0612101647310.12500@woody.osdl.org> 
 <e5bfff550612102317w331f3b0fyc3c6b095ff21191a@mail.gmail.com> 
 <Pine.LNX.4.64.0612110855550.12500@woody.osdl.org> 
 <Pine.LNX.4.64.0612110905180.12500@woody.osdl.org> 
 <e5bfff550612110939r58df1a73ud28983633c12e487@mail.gmail.com> 
 <Pine.LNX.4.64.0612111003140.12500@woody.osdl.org>
 <e5bfff550612111059g35f1aa2dmdead17a60f5dfca8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 11 Dec 2006 19:26:07 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <e5bfff550612111059g35f1aa2dmdead17a60f5dfca8@mail.gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34029>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gtqmn-0008VW-5V for gcvg-git@gmane.org; Mon, 11 Dec
 2006 20:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937614AbWLKTZ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 14:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937609AbWLKTZ5
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 14:25:57 -0500
Received: from smtp.osdl.org ([65.172.181.25]:56584 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S937597AbWLKTZ4
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006 14:25:56 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBBJPlID029599
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 11
 Dec 2006 11:25:48 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBBJPklS004256; Mon, 11 Dec
 2006 11:25:46 -0800
To: Marco Costalba <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org



On Mon, 11 Dec 2006, Marco Costalba wrote:
> 
> $ time sh -c "git rev-list --header --boundary --parents --topo-order HEAD | cat > /dev/null"
> $ time sh -c "git rev-list --header --boundary --parents --topo-order HEAD > /tmp/tmp.txt; cat /tmp/tmp.txt > /dev/null"

Btw, for me the numbers aren't stable enough to be al lthat final, but 
doing it multiple times on the kernel archive I get:

	real    0m0.947s
	real    0m1.046s
	real    0m0.943s
	real    0m0.868s

for the pipe case, and

	real    0m0.953s
	real    0m1.056s
	real    0m1.060s
	real    0m0.968s

for the temp-file. IOW, no real difference. Just doing the "> /dev/null" 
directly is more consistent (no task-switching, SMP effects, or cache 
conflicts) at

	real    0m0.806s
	real    0m0.806s
	real    0m0.805s
	real    0m0.808s

but one recurrent theme is definitely true: the "cat" part is a noticeable 
overhead. But that in itself means that git-rev-list is just so efficient 
that even just basically copying its output is going to be measurable. 

Which is obviously a good thing, but it means that it's not very 
interesting in the big picture (ie I bet the real overheads are going to 
be elsewhere if you actually expect to draw anything on the screen).

