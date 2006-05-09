From: sean <seanlkml@sympatico.ca>
Subject: Re: Implementing branch attributes in git config
Date: Mon, 8 May 2006 22:47:21 -0400
Message-ID: <BAYC1-PASMTP04C9C4BF5B89E55B9D877AAEA90@CEZ.ICE>
References: <1147037659.25090.25.camel@dv>
	<Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
	<1147048587.17371.13.camel@dv>
	<Pine.LNX.4.64.0605071740550.3718@g5.osdl.org>
	<7vfyjli9vf.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP0334B471C6908E4E40BFD2AEA80@CEZ.ICE>
	<7vbqu9i6zl.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP110777A694DAF1D7623895AEA80@CEZ.ICE>
	<Pine.LNX.4.64.0605081905240.6713@iabervon.org>
	<BAYC1-PASMTP0453E2D70B10C6D116167EAEA80@CEZ.ICE>
	<Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de>
	<BAYC1-PASMTP03ADC2F3E75E482ADC5CD3AEA90@CEZ.ICE>
	<Pine.LNX.4.64.0605081731440.3718@g5.osdl.org>
	<7virogc90u.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605081801360.3718@g5.osdl.org>
	<7v1wv4c7wk.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605081854190.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 04:52:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdIL2-0001qJ-Jh
	for gcvg-git@gmane.org; Tue, 09 May 2006 04:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWEICwa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 22:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWEICwa
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 22:52:30 -0400
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:56821 "EHLO
	BAYC1-PASMTP04.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751348AbWEICw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 May 2006 22:52:29 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP04.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 8 May 2006 19:52:28 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id D107B644C28;
	Mon,  8 May 2006 22:52:27 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Message-Id: <20060508224721.045a48fb.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.64.0605081854190.3718@g5.osdl.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 09 May 2006 02:52:29.0274 (UTC) FILETIME=[9C6F23A0:01C67313]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 8 May 2006 18:57:08 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> Btw, I keep coming back to the same
> 
> 	["jc/show-branch-dense"]
> 		remote = git://...
> 
> branch specifier syntax. It just seems very intuitive and is easy to 
> parse. 

We already need such section headers for remotes, and for branches.. 
both which may well need to be quoted as above.. how to distinguish
between them?   How to handle the next case that comes along where we
want these special header semantics?

We really need:

   [branch.Whatever]

and:

   [remote.Whatever]

As in the case of "origin" where we have a remote and a branch
named that.


> The only real downside ends up being the non-forwards-compatibility thing. 
> But trying to be forwards-compatible for old git versions with this thing 
> would seem to be a major pain for rather slim gain.

What's the advantage of section quotation marks over just allowing these
characters in regular section names?  To be specific, what is wrong with:

   [jc/show-branch-dense]
       remote = git://...

If we just relax the legal characters in identifiers to include slash and dash?
It doesn't seem to be any different in amount of code needed to achieve, and it
is just as intuitive (perhaps more so) and no worse on the forward-compatibility
thing.

If we continue with case insensitive section names, it's quite possible for 
the user to mess up while hand editing or forgetting proper "git" quoting
rules on the command line and end up with silent breakage:

$ git repo-config "Branch".url = git://...  
        (updates section ["Branch"])

And then the next time forget the quotes and use:

$ git repo-config Branch.url = git://...    
         (updates section [branch])

And all of a sudden the user is updating _different_ sections with 
unpredictable results.  This is just awkward; why not just admit that 
section names should always be case sensitive if we're going to put
filenames inside them?

Sean
