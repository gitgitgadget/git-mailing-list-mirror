From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [test failure] Re: t4114 binary file becomes symlink
Date: Mon, 20 Jul 2009 14:56:32 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907201451150.19335@localhost.localdomain>
References: <20090718134551.GC16708@vidovic> <200907191301.15533.j6t@kdbg.org> <20090720090937.GA20412@sigill.intra.peff.net> <200907202251.22490.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 23:57:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MT0qz-0008Qt-47
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 23:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753556AbZGTV4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 17:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299AbZGTV4x
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 17:56:53 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47876 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751063AbZGTV4x (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jul 2009 17:56:53 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6KLuYpC006388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 20 Jul 2009 14:56:35 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6KLuWVT027366;
	Mon, 20 Jul 2009 14:56:33 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <200907202251.22490.j6t@kdbg.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.963 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123639>



On Mon, 20 Jul 2009, Johannes Sixt wrote:

> On Montag, 20. Juli 2009, Jeff King wrote:
> >
> > OK, I guess I can buy the "don't use this unless you need it" rationale.
> > But two questions:
> >
> >   1. _Are_ we sure it works under Windows?  That is, do we know for a
> >      fact that using a va_list twice is OK there, or are we just going
> >      on the fact that nobody has reported the bug?
> 
> We are sure (well, I am sure ;) that it worked on Windows with gcc 3.

Not only that, but it's literally how people used to historically do 
things.

Sure, some places do require 'va_copy()', and there's a reason why it got 
added in C99. But there's also a reason why it wasn't added earlier - 
because it didn't exist!

So I agree with Johannes: we should _not_ make our compat version of 
'snprintf()' use va_copy, for the simple reason that

 - modern C library versions will have a working snprintf already

 - old setups that don't have a working snprintf quite likely don't have a 
   va_copy either.

So the set of systems that need both the va_copy _and_ our compat version 
of snprintf is likely much smaller than the set of systems that would 
actively break compilation if they don't have va_copy.

Of course, we could also add a new "NEEDS_VA_COPY" thing, and do

	#ifdef NEEDS_VA_COPY
	  #define va_copy(dst,src) (dst) = (src)
	#endif

or something like that.

		Linus
