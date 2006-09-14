From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: open(2) vs fopen(3)
Date: Thu, 14 Sep 2006 08:46:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609140835080.4388@g5.osdl.org>
References: <20060914091513.19826.qmail@web25812.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 14 17:46:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNtPw-0004KA-20
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 17:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWINPqQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 11:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWINPqQ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 11:46:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37077 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750793AbWINPqP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Sep 2006 11:46:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8EFkEnW017708
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 14 Sep 2006 08:46:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8EFkDpE022243;
	Thu, 14 Sep 2006 08:46:13 -0700
To: moreau francis <francis_moreau2000@yahoo.fr>
In-Reply-To: <20060914091513.19826.qmail@web25812.mail.ukl.yahoo.com>
X-Spam-Status: No, hits=-0.513 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.148 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27003>



On Thu, 14 Sep 2006, moreau francis wrote:
> 
> I'm reading git source code and falling on this stupid question:
> Why sometime open(2) is used and other time fopen(3) is
> prefered. I'm sorry for this dump question but I have no clue.

fopen() tends to result in easier usage, especially if the file in 
question is a line-based ASCII file, and you can just use "fgets()" to 
read it. So fopen is the simple alternative for simple problems.

Using a direct open() means that you have to use the low-level IO 
functions (I'm ignoring the use of "fdopen()"), but if done right, it has 
a number of advantages:

 - with the proper use, it's potentially more efficient (but stdio is a 
   lot more efficient if you do lots of small writes without buffering)

 - you can control the creation flags better (ie if you want to do an 
   exclusive open, you _have_ to use "open()" - there's no portable way to 
   say O_EXCL with "fopen()")

 - error conditions are a lot more obvious and repeatable with the 
   low-level things, at least so I find personally. Error handling with 
   stdio routines is _possible_, but probably because almost nobody ever 
   does it, it's not something that people are conditioned to do, so it 
   ends up beign "strange".

   (So this third one is more a psychological issue than a really 
   technical issue - at least for me. I'd not use stdio for things I 
   might expect to do fsync() on, for example. It's _possible_, but very 
   non-intuitive, because that's now how people generally use stdio).

So it boils down to the fact that people tend to do higher-level things 
with stdio interfaces (fopen and friends), and lower-level things with the 
raw system call ("unistd.h") interfaces.

In git, you'd expect to see code that actually works on the object 
database or the refs using "open()" (both because it's low-level, and it 
generally wants to use O_EXCL and friends), and then things that open the 
".gitignore" file to use fopen() (because it's a line-based ASCII 
interface, and it's not an "important" file in the sense that we don't 
really care about some strange situation where it could give us an IO 
error).

There might also be a difference in personality. I probably tend to use 
the core unistd interfaces more than some other people would, and some 
other people might end up using stdio for pretty much everything.

			Linus
