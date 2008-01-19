From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Avoid running lstat(2) on the same cache entry.
Date: Sat, 19 Jan 2008 11:58:47 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801191152310.2957@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801181911560.2957@woody.linux-foundation.org> <7vfxwu9s2z.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801191133330.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 20:59:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGJqv-00006x-Hq
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 20:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbYAST7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 14:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbYAST7F
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 14:59:05 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58275 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751623AbYAST7E (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jan 2008 14:59:04 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0JJwmrI032159
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 19 Jan 2008 11:58:49 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0JJwl7a019141;
	Sat, 19 Jan 2008 11:58:47 -0800
In-Reply-To: <alpine.LFD.1.00.0801191133330.2957@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.717 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71130>



On Sat, 19 Jan 2008, Linus Torvalds wrote:
> 
> The call trace for the first one is

Btw, the easiest way to do this on Linux isn't totally obvious, because 
you cannot do a simple breakpoint on "lstat()", since GNU libc internally 
uses other names.

So if anybody wants to work on this and runs Linux, the way to do this 
trivially (once you know how) is to do

	gdb git
	..
	.. run the startup to wait for the libraries to be loaded 
	..	
	(gdb) b main
	(gdb) run commit
	..
	.. modern glibc low-level lstat() call is __lxstat64
	.. at least on x86-64
	..
	(gdb) b __lxstat64
	..
	.. Ignore the first few ones (we have 23000+ files in the index, 
	.. so don't worry about getting the *first* one)
	..
	(gdb) ignore 2 1000
	(gdb) c
	..
	.. Ok, look at that backtrace, then go to the next one by
	.. just knowing that we'll be doing 23,000+ for each iteration
	.. over the index.
	..
	.. Rinse and repeat this as required:
	..
	(gdb) where
	(gdb) ignore 2 24000
	(gdb) c

which gets you the backtraces I showed you, without having to think too 
much about all the odd lstat() calls we do for resolving refs etc.

			Linus
