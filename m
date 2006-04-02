From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] pack-objects: be incredibly anal about stdio semantics
Date: Sun, 2 Apr 2006 15:58:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604021554480.23419@g5.osdl.org>
References: <15051.1144015974@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 00:58:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQBWr-0006vd-OZ
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 00:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbWDBW6j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 18:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbWDBW6i
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 18:58:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13773 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751515AbWDBW6i (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Apr 2006 18:58:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k32MwaEX025023
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 2 Apr 2006 15:58:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k32MwZuR025969;
	Sun, 2 Apr 2006 15:58:35 -0700
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <15051.1144015974@lotus.CS.Berkeley.EDU>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18295>



On Sun, 2 Apr 2006, Jason Riedy wrote:
> 
> If you consider stdio to be a low-level wrapper over syscalls
> that only adds buffering and simple parsing, then passing EINTR
> back to the application is a sensible choice.  I wouldn't be
> too surprised if L4, VxWorks, etc. do something similar.

No, returning EINTR is insane, because stdio has to do re-starting of 
system calls by hand _anyway_ for the "short read" case. 

EINTR really _is_ 100% equivalent to "short read of zero bytes" (that 
literally is what it means for a read/write system call - anybody who 
tells you otherwise is just crazy). 

So any library that handles short reads, but doesn't handle EINTR is by 
definition doing something totally idiotic and broken.

Now, I agree that somebody else might be broken too. I would not agree 
that it's "acceptable". It's craptastically bad library code.

> Anyone with an older HP/UX care to try these patches?  HP/UX 
> may not be sane, but I think it may lack SA_RESTART.  I don't 
> know if stdio calls need restarted, though.

I'd assume that older HPUX is so BSD-based that all signals end up 
restarting. That was the BSD signal() semantics, after all.

			Linus
