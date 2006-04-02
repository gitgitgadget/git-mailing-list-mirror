From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Solaris cloning woes partly diagnosed
Date: Sun, 2 Apr 2006 11:33:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604021118210.3050@g5.osdl.org>
References: <7vy7yol0nk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 02 20:33:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQ7Oc-0005ZT-0f
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 20:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWDBSdv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 14:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWDBSdv
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 14:33:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59533 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750779AbWDBSdv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Apr 2006 14:33:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k32IXlEX013917
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 2 Apr 2006 11:33:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k32IXjTu018197;
	Sun, 2 Apr 2006 11:33:45 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7yol0nk.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18275>



On Sun, 2 Apr 2006, Junio C Hamano wrote:
>
> We do two funky things when we have progress bar.  We play games
> with timer signal (setitimer(ITIMER_REAL) and signal(SIGALRM)),
> and we spit out messages to stderr.

I'd be willing to bet that it's the fact that we take signals.

Suddenly, some system calls will either return -1/EINTR, or they'll return 
partial reads or writes. 

We should be pretty good at handling that, but maybe some place forgets.

One thing to do might be to make the itimer use a much higher frequency, 
to trigger the problem more easily.

We do, for example, expect that regular file writing not do that. At least 
"write_sha1_from_fd()" will just do a "write()" without testing the error 
return, which is bad (it would silently create a truncated object if the 
/tmp filesystem filled up). If somebody has their filesystem over NFS 
mounted interruptible, partial writes could also happen.

Ho humm.

		Linus
