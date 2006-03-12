From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Trivial warning fix for imap-send.c
Date: Sun, 12 Mar 2006 08:57:02 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603120847500.3618@g5.osdl.org>
References: <20060311192954.GQ16135@artsapartment.org>
 <slrne17urp.fr9.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 12 17:57:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FITsd-0003e6-EA
	for gcvg-git@gmane.org; Sun, 12 Mar 2006 17:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbWCLQ5Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 11:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbWCLQ5Q
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 11:57:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24474 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751544AbWCLQ5Q (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Mar 2006 11:57:16 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2CGv3DZ017110
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 12 Mar 2006 08:57:03 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2CGv2P5008260;
	Sun, 12 Mar 2006 08:57:03 -0800
To: Mark Wooding <mdw@distorted.org.uk>
In-Reply-To: <slrne17urp.fr9.mdw@metalzone.distorted.org.uk>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17518>



On Sun, 12 Mar 2006, Mark Wooding wrote:
> "Art Haas" <ahaas@airmail.net> wrote:
> 
> > -			execl( "/bin/sh", "sh", "-c", srvc->tunnel, 0 );
> > +			execl( "/bin/sh", "sh", "-c", srvc->tunnel, NULL );
> 
> This is not the right fix.  NULL can be simply a #define for 0 (see
> 6.3.2.3#3 and 7.17).  You need to write (char *)0 or (char *)NULL.  I
> prefer to avoid the macro NULL entirely, since its misleading behaviour
> is precisely what got us into this mess.

It's perfectly fine.

Quite frankly, if you have a 64-bit C compiler that doesn't make "NULL" be 
"((void *)0)" (or equivalent - some compilers will actually have NULL as 
an intrisic, because especially if they also support C++, NULL has some 
really magical properties there), you should switch vendors as quickly as 
humanly possible.

The "#define NULL 0" practice is still _legal_ C, but that doesn't make it 
any less broken. It's K&R traditional, but git requires ANSI prototypes 
and some fancy features from modern compilers, so K&R compilers aren't 
welcome anyway, and if their headers don't define NULL as a void pointer, 
their headers are simply _broken_.

So in modern C, using NULL at the end of a varargs array as a pointer is 
perfectly sane, and the extra cast is just ugly and bowing to bad 
programming practices and makes no sense to anybody who never saw the 
horror that is K&R.

It's akin to trying to not using prototypes, or to trying to limit your 
externally visible names to 7 characters. It was "appropriate" about two 
decades ago, these days it's just cuddling broken setups that have been 
broken for a long long time.

Btw, the reason NULL _has_ to be a pointer ("((void *)0)" or otherwise) is 
simply that if it isn't, you not only won't get reasonable varargs 
behaviour, you'll also miss real warnings. I've seen broken code like

	int i = NULL;

in my life, and if the compiler doesn't warn about that, then the compiler 
is BROKEN, and not worth supporting as a programmer.

			Linus
