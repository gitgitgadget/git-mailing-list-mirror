X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Mon, 11 Dec 2006 12:40:37 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612111238560.3515@woody.osdl.org>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com>
 <Pine.LNX.4.64.0612111003140.12500@woody.osdl.org>
 <e5bfff550612111059g35f1aa2dmdead17a60f5dfca8@mail.gmail.com>
 <200612112128.06485.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 11 Dec 2006 20:41:12 +0000 (UTC)
Cc: Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612112128.06485.Josef.Weidendorfer@gmx.de>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34032>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtrxJ-0003EA-Hz for gcvg-git@gmane.org; Mon, 11 Dec
 2006 21:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937020AbWLKUky (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 15:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763090AbWLKUky
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 15:40:54 -0500
Received: from smtp.osdl.org ([65.172.181.25]:34799 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1762949AbWLKUkx
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006 15:40:53 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBBKecID001404
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 11
 Dec 2006 12:40:43 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBBKebYQ006674; Mon, 11 Dec
 2006 12:40:37 -0800
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org



On Mon, 11 Dec 2006, Josef Weidendorfer wrote:
> 
> A general question: How many context switches are involved in such
> a producer/consumer scenario, given that the consumer writes one
> line at a time, and the consumer uses poll/select to wait for the
> data?
> Is there some possibility to make the kernel write-combine single
> small producer writes into bigger chunks, which will be delivered
> at once (or smaller data only after a small timeout)?

The data will be write-combined.

The kernel doesn't context-switch after a write() to a pipe if there is 
space left (and usually the pipe buffer is 64kB with current kernels, so 
there obviously will be), unless the reader has a higher priority for some 
reason (ie the reader has been waiting a long time).

So _normally_ you'll see many many writes in one go, and only see context 
switching when the kernel pipe buffer fills up.

