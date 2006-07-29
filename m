From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git prune pig slow
Date: Sat, 29 Jul 2006 11:14:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607291110180.4168@g5.osdl.org>
References: <20060729090250.GC26956@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 29 20:14:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6tKN-0004G2-AW
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 20:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWG2SOP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 14:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWG2SOP
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 14:14:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59274 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932203AbWG2SOO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jul 2006 14:14:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6TIE4nW024730
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 29 Jul 2006 11:14:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6TIE2rS015838;
	Sat, 29 Jul 2006 11:14:03 -0700
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20060729090250.GC26956@flint.arm.linux.org.uk>
X-Spam-Status: No, hits=-0.523 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24430>



On Sat, 29 Jul 2006, Russell King wrote:
> 
> I killed it after 10 minutes and decided to do the job manually -
> git-fsck-objects --unreachable and deleting the objects one by one is
> _much_ quicker than git-fsck-objects --full --cache --unreachable.

It's also very dangerous.

If you have partial packing (which you can get if you fetch data using 
rsync or http, for example), not havign the "--full" means that 
git-fsck-objects will report on objects being "unreachable" if they are 
only reachable from another object that is packed.

Now, in practice, if you only use the git native protocol, this should 
never happen, and you're fine. But there's a _very_ real reason why "git 
prune" passes the "--full" flag to git-fsck-cache. "git prune" is simply 
too dangerous without it.

That said, the current "git prune" in 1.4.2-rc is much faster, because it 
does the reachability analysis on its own, and doesn't do all the other 
things that git-fsck-cache does.

Btw, another alternative to "git prune" is actually to do

	git repack -a -d

and then just delete all unpacked objects.

			Linus
