X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] git reflog expire
Date: Tue, 19 Dec 2006 15:29:54 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612191524180.6766@woody.osdl.org>
References: <7vodq3a136.fsf@assigned-by-dhcp.cox.net> <7vr6uxzgjb.fsf@assigned-by-dhcp.cox.net>
 <20061218140813.GA32446@spearce.org> <7vy7p4u1au.fsf@assigned-by-dhcp.cox.net>
 <7v64c8thr4.fsf@assigned-by-dhcp.cox.net> <20061219090851.GH2511@spearce.org>
 <7vhcvsry2c.fsf@assigned-by-dhcp.cox.net> <20061219102741.GA21324@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 19 Dec 2006 23:30:26 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061219102741.GA21324@spearce.org>
X-MIMEDefang-Filter: osdl$Revision: 1.163 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34863>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwoPX-0000kX-3B for gcvg-git@gmane.org; Wed, 20 Dec
 2006 00:30:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932972AbWLSXaE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 18:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932981AbWLSXaE
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 18:30:04 -0500
Received: from smtp.osdl.org ([65.172.181.25]:45141 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932972AbWLSXaB
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 18:30:01 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBJNTt2J007986
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 19
 Dec 2006 15:29:55 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBJNTs8r013980; Tue, 19 Dec
 2006 15:29:54 -0800
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org



On Tue, 19 Dec 2006, Shawn Pearce wrote:
> 
> Smaller mmap units may help on some larger projects. For example
> 'git whatchanged' shouldn't need to setup page table entries for
> the entire pack file when only the front and middle are needed to
> obtain the data for the most recent 25 commits, before the user
> kills the pager.

At least on Linux, we do NOT set up page table entries unnecessarily. The 
cost of a mmap() is largely independent of the size of the mmap, and the 
costs will be on page fault time (which is obviously O(n) in number of 
pages you need).

The same is _largely_ true of munmap() too. There's a small cost to large 
mmaps that were only sparsely accessed being unmapped (we have to look at 
the page tables closely, even if they end up being empty), but quite 
frankly, it's not going to be all that noticeable.

So mmap() costs end up largely being one (fairly small) fixed cost, plus a 
(fairly small) cost for each page beign demand-mapped in. 

Of course, Linux is just _better_ than the competition, so things that 
don't help Linux might still help other systems. Linux does both page 
faults and the mmap system call well, other systems will generally be an 
order of magnitude worse in both. And as we've seen, it can be more.

(Things that are really fast on Linux: VM manipulation, and filename path 
lookup. Those are both ops that Linux _really_ shines on. It may not sound 
like much, but when you do millions of them, it's the difference between 
seconds and hours).

