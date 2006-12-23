From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 11/17] Fully activate the sliding window pack access.
Date: Sat, 23 Dec 2006 10:44:51 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612231038410.3671@woody.osdl.org>
References: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
 <20061223073428.GL9837@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 19:45:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyBrt-0006Zs-QU
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 19:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753675AbWLWSpD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 13:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753683AbWLWSpD
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 13:45:03 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52374 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753675AbWLWSpA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 13:45:00 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBNIiq2J013950
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 23 Dec 2006 10:44:53 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBNIipkR019836;
	Sat, 23 Dec 2006 10:44:52 -0800
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20061223073428.GL9837@spearce.org>
X-Spam-Status: No, hits=-1.152 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.165 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35326>



On Sat, 23 Dec 2006, Shawn O. Pearce wrote:
>
> This finally turns on the sliding window behavior for packfile data
> access by mapping limited size windows and chaining them under the
> packed_git->windows list.

Hmm. You seem to default the window size to 32MB.

Maybe I'm reading that code wrong, but I think that's a bit sad.

In particular, in any setup that doesn't like mmap() at all (eg Cygwin), 
and uses the "malloc+read" emulation, 32MB is actually likely much too 
big. It's probably better to use something like a 1MB slice instead, since 
otherwise you'll often be reading much too much.

So I'd argue that if you fall back to read() (or pread) instead of mmap, 
the 32MB thing is way too big.

So maybe you should make the default depend on NO_MMAP (although it would 
seem that the default Makefile makes Cygwin actually default to using mmap 
these days, so maybe it's not a big deal).

		Linus
