From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in git.git
Date: Tue, 17 Oct 2006 10:16:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610171005370.3962@g5.osdl.org>
References: <7vvemjmlo2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 19:17:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZsYZ-0006N1-0G
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 19:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWJQRQn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 13:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWJQRQn
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 13:16:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51126 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751323AbWJQRQm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 13:16:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9HHGMaX019025
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Oct 2006 10:16:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9HHGL60029221;
	Tue, 17 Oct 2006 10:16:21 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvemjmlo2.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.476 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29095>



On Tue, 17 Oct 2006, Junio C Hamano wrote:
>
> * The 'maint' branch has this fix and produced 1.4.2.4 release.
> 
>    Linus Torvalds (1):
>       Fix hash function in xdiff library

There's two things to note about this:

 - the libxdiff dependencies are broken, so it's likely that you need to 
   do a "make clean; make" to actually see the result of this.

   We really should fix this. I was bitten by this _again_ when I wanted 
   to do some performance testing, and was scratching my head about why it 
   didn't seem to matter.

   I haven't looked into which part of the Makefile is broken yet, so I 
   really don't know what's broken, but maybe somebody who likes makefiles 
   could take a look? Basically, doing a

	touch xdiff/xmacros.h

   should cause a recompile of a lot more than it causes.

 - while the hash function problem _can_ cause really huge slowdowns in 
   some unlucky situations, it actually causes noticeable performance 
   issues even for normal situations.

   For example, for me on a 2GHz merom machine in the current git 
   directory:

   Before:

	[torvalds@merom git]$ time ./git log -p | wc -l
	746211
	
	real    0m27.223s
	user    0m26.894s
	sys     0m0.424s

   After:

	[torvalds@merom git]$ time ./git log -p | wc -l
	746211
	
	real    0m9.638s
	user    0m9.329s
	sys     0m0.468s

   so there's a factor-of-three difference here even on a "normal" load 
   like git itself. You don't need a huge file with tons of changes to see 
   the effect of this.

So we should fix the makefile to add whatever proper header file 
dependencies, but we should also make sure that whoever builds binaries 
has done a "make clean", otherwise the fix is potentially hidden.

		Linus
