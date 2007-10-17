From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 16:53:24 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710171632200.26902@woody.linux-foundation.org>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
 <47148F72.1090602@users.sourceforge.net> <1192548367.3821.4.camel@lt21223.campus.dmacc.edu>
 <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu> <3awb7zw6.fsf@blue.sea.net>
 <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
 <1192565900.6430.16.camel@athena> <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org>
 <20071017015109.303760cc@localhost.localdomain>
 <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org>
 <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com>
 <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org>
 <1192645509.6640.21.camel@athena> <alpine.LFD.0.999.0710171147190.26902@woody.linux-foundation.org>
 <1192649598.6640.44.camel@athena> <alpine.LFD.0.999.0710171246500.26902@woody.linux-foundation.org>
 <20071017232146.4b9e4097@localhost.localdomain> <Pine.LNX.4.64.0710172310270.25221@racer.site>
 <20071018011734.7b636141@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tom Tobin <korpios@korpios.com>, git@vger.kernel.org
To: Christer Weinigel <christer@weinigel.se>
X-From: git-owner@vger.kernel.org Thu Oct 18 01:53:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiIhr-0000xg-34
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 01:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756182AbXJQXxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 19:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756124AbXJQXxc
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 19:53:32 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55078 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755833AbXJQXxb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Oct 2007 19:53:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9HNrPAa003865
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Oct 2007 16:53:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9HNrPXw014543;
	Wed, 17 Oct 2007 16:53:25 -0700
In-Reply-To: <20071018011734.7b636141@localhost.localdomain>
X-Spam-Status: No, hits=-2.717 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61444>



On Thu, 18 Oct 2007, Christer Weinigel wrote:
> 
> BTW, how serious is the problem with deltifying when there are a lot of
> spaces that David Kastrup mentioned?

I suspect it works quite well in practice.

But we've had to tweak the xdiff code before, and the hash calculations 
for bucket size limits. If somebody actually points out a problem case, we 
can probably tweak it again.

> Wouldn't it be a problem when people put ASCII graphics in comments or 
> just have comments like /*********************************/ in their 
> code?

In general, *any* situation where you have tons of character sequences 
that are the same (and here it's not the characters *themselves* that have 
to be the same - it's the *sequence* that has to be the same, so it's not 
about repeating the same character over and over per se: it's about 
repeating a certain block of characters many many times in the source 
code) will be problematic for pretty much any similarity analysis.

Why? Because you just have a lot of the same sequence, and to get a good 
delta you want to find common "sequences of these sequences" (call them 
supersequences) in order to find the biggest common chunk.

So the badly performing cases for any delta algorithm (and I do want to 
point out that this has nothing what-so-ever to do with the particular one 
that git uses) tends to be exactly the ones where you have lots and lots 
of smaller chunks that match in two files, and that then makes it costlier 
to find the *bigger* chunks that are build up of those smaller chunks.

And generally you tend to have two situations: you either (a) take *much* 
longer to find the common areas (they are often quadratic or worse 
algorithms) or (b) you decide to ignore chunks that are so common that 
they don't really add any real information when it comes to finding truly 
common chunks. Where that second choice generally means that you can miss 
some cases where you *could* have found a good match for deltification.

In fact, usually you have a combination of the above two effects: certain 
deltas may be more expensive to find but there is also a limit that kicks 
in and means that you never spend *too* much time on finding them if the 
pattern space is not amenable to it.

Would lots of spaces be such a pattern? I personally doubt it would really 
matter. In general, source code is easy to delta: the bulk of any common 
sequences in most files will be found by the trivial "look for common 
sequences in the beginning and the end". The really *bad* cases tend to be 
rather odd, and often generated files.

So no, I don't think deltification is a huge deal for spaces. But it does 
boil down to the same kind of issues: if you blow up the source base by 
20%, you often slow down things by 20% or more, simply because there is 
more data to process at all stages. It simply just slows down everything - 
totally unnecessarily.

			Linus
