From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Use sigaction and SA_RESTART in read-tree.c; add option
 in Makefile.
Date: Sun, 2 Apr 2006 18:02:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604021752500.23419@g5.osdl.org>
References: <17063.1144016974@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 03:03:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQDTO-0000Co-7J
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 03:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWDCBCi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 21:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWDCBCi
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 21:02:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10212 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964797AbWDCBCi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Apr 2006 21:02:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3312TEX029752
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 2 Apr 2006 18:02:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3312Sqh029179;
	Sun, 2 Apr 2006 18:02:29 -0700
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <17063.1144016974@lotus.CS.Berkeley.EDU>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18300>



On Sun, 2 Apr 2006, Jason Riedy wrote:
>
> Might as well ape the sigaction change in read-tree.c to avoid
> the same potential problems.

Looks good. I didn't realize we had the exact same code duplicated. I 
guess it's small enough that there isn't a huge win in moving it to some 
common file..

Does somebody have access to Solaris to verify that this all actually does 
fix it? I obviously believe it will, since this just explains the symptoms 
to a tee, but it would still be good to have an actual confirmation by 
somebody who has access to a Solaris environment.

> Also add a NO_SA_RESTART option in the Makefile in case someone
> doesn't have SA_RESTART but does restart (maybe older HP/UX?).
> We want the builder to chose this specifically in case the
> system both lacks SA_RESTART and does not restart stdio calls;
> a compat #define in git-compat-utils.h would silently allow
> broken systems.

I do believe that we already require POSIX.2 functionality (regex, 
fnmatch, C90 compiler), which implies that git probably wouldn't compile 
anyway on things that are _really_ ancient. 

I think SA_RESTART was part of the original POSIX.1 specs, so anybody that 
doesn't have it is likely to not have a lot of other things we rely on 
too. There are other SA_* flags that aren't as standard, but I'd expect 
SA_RESTART to be everywhere (or it likely doesn't have sigaction() at 
all..).

But hey, I certainly don't have really old HP-UX to test either.

		Linus
