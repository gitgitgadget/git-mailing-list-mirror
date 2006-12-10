X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Sun, 10 Dec 2006 12:19:55 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612101213520.12500@woody.osdl.org>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com> 
 <Pine.LNX.4.64.0612101009040.12500@woody.osdl.org>
 <e5bfff550612101151r5e77ddc0w8f61f36fc1f2920e@mail.gmail.com>
 <Pine.LNX.4.64.0612101159530.12500@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 10 Dec 2006 20:20:24 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612101159530.12500@woody.osdl.org>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33922>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtV9g-0006hC-Ua for gcvg-git@gmane.org; Sun, 10 Dec
 2006 21:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762485AbWLJUUF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 15:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762490AbWLJUUF
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 15:20:05 -0500
Received: from smtp.osdl.org ([65.172.181.25]:58451 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1762485AbWLJUUE
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 15:20:04 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBAKJuID019202
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 10
 Dec 2006 12:19:56 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBAKJtF5002090; Sun, 10 Dec
 2006 12:19:55 -0800
To: Marco Costalba <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org



On Sun, 10 Dec 2006, Linus Torvalds wrote:
> 
> So don't worry too much about low-memory situations.

Btw, I should obviously clarify that. You should _always_ worry about 
low-memory situations, but the only real issue is really "working set 
size", not "data in files or in memory".

If the file representation is very dense (like the git pack-files are, for 
example), then it may well make sense to keep the data in a file, just 
because it's smaller there than if you keep it in expanded form in memory.

Also, it's nice to keep stuff in the filesystem rather than in process VM 
memory, because filesystem data that is cached in memory is useful for 
_other_ processes, ie it has a lifetime that is longer than the process 
itself. However, that's obviously only true for long-lived files that are 
shared among processes, it's _not_ true for temporary files.

For temporary files, the memory footprint of a temp-file is usually 
_larger_ than the memory footprint of the same data kept in memory. You 
have things like page-cache alignment, and often the issue of marshalling 
data into ASCII etc. So temp-files are almost never a better solution than 
keeping things in memory (unless you use those temp-files to truly 
_share_ data between processes, ie you do a shared mmap and they can 
re-use the same pages actively in a way they couldn't otherwise).

