From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Change set based shallow clone
Date: Sun, 10 Sep 2006 13:00:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609101254590.27779@g5.osdl.org>
References: <20060910190332.17667.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: jonsmirl@gmail.com, git@vger.kernel.org, paulus@samba.org
X-From: git-owner@vger.kernel.org Sun Sep 10 22:00:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMVTw-0002Bs-7S
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 22:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWIJUAd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 16:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbWIJUAd
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 16:00:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57558 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964835AbWIJUAc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Sep 2006 16:00:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8AK0MnW021117
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 10 Sep 2006 13:00:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8AK0L4Z018411;
	Sun, 10 Sep 2006 13:00:21 -0700
To: linux@horizon.com
In-Reply-To: <20060910190332.17667.qmail@science.horizon.com>
X-Spam-Status: No, hits=-0.517 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26814>



On Sun, 10 Sep 2006, linux@horizon.com wrote:
> 
> A direct fork() (or even faster, vfork) and exec() is going to have a
> lot less overhead, although it's more work to code.  See Stevens for
> excellent examples.

Well, that said, the Linux fork/exec/exit is certainly fairly efficient, 
but nothing can hide the fact that it _is_ a very expensive operation.

So we may do a fork/exit in a millisecond, but on the other hand, we can 
generally open a file in a microsecond. So we're definitely talking about 
several orders of magnitude difference..

And a lot of the trivial git helpers are literally not doing a lot more 
than opening a file, reading it, and parsing it. That's for things like 
looking up the SHA1 of a branch head, for example. Doing it in-line might 
be a microsecond or two, while spawning a shell to execute git-rev-parse 
will take you several microseconds.

Do it a million times, and the difference is now a second vs an hour. Or a 
few minutes vs a week.

So in that sense, it is absolutely undeniable that fork/exit is slow. 
Everything is relative. The Linux fork/exit is fast when compared to most 
other systems fork/exit, but it's slow as hell when compared to just doing 
some small op directly in-line.

			Linus
