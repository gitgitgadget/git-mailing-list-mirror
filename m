From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow
 trees
Date: Mon, 16 Apr 2007 07:59:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704160745040.5473@woody.linux-foundation.org>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net>
 <fcaeb9bf0704142257x3761ef2cie3996420b3bcd24a@mail.gmail.com>
 <Pine.LNX.4.64.0704151115270.5473@woody.linux-foundation.org>
 <200704152051.35639.andyparkins@gmail.com> <Pine.LNX.4.64.0704151317180.5473@woody.linux-foundation.org>
 <20070416021729.GH2689@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Andy Parkins <andyparkins@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 16:59:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdSgF-00066E-3S
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 16:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658AbXDPO7o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 10:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752670AbXDPO7n
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 10:59:43 -0400
Received: from smtp.osdl.org ([65.172.181.24]:37873 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752658AbXDPO7m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 10:59:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3GExXIs023713
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Apr 2007 07:59:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3GExWQb004842;
	Mon, 16 Apr 2007 07:59:33 -0700
In-Reply-To: <20070416021729.GH2689@curie-int.orbis-terrarum.net>
X-Spam-Status: No, hits=-0.451 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44647>



On Sun, 15 Apr 2007, Robin H. Johnson wrote:
>
> Nobody has addressed the single problem that I have with adding it when
> it's leaving the environment, and that's still of paramount concern to
> me. Simply put, there is a conflict between being able to add revision
> information of stuff leaving the environment, and those additions
> breaking previous checksums (which may be digitally signed, and thus
> breaking the signatures).

Don't be silly. 

You can just checksum without the ID. Which you have to do with git 
anyway, since any expanded ID *itself* would be part of any ID, which 
means that under git, you *physically*cannot* make an ID string be part of 
the source control environment anyway, unless you did the SHA1 while 
ignoring the $Id$ expansion.

In other words, the problem you talk about exists *regardless*. You 
suggest pushing that problem into the SCM layer, and de-stabilizing the 
SCM and causing EVERYBODY ELSE provlems.

And I'm telling you that if you want the idiocy of keyword expansion, you 
can have it, BUT YOU CANNOT HAVE IT IN THE SCM.

Because *every* *single* problem you have with keyword expansion (whether 
it be checksums or anything else) will be MUCH MUCH worse if you do it at 
the SCM level!

Really. 

When you talk about your "single problem", why the HELL do you think that 
problem goes away just because you try to deal with it inside the SCM? 
Trust me, the problem does *not* go away, it gets *bigger*.

You're trying to push it into the SCM, because _you_ don't want to deal 
with the inevitable problems that keywords cause. But face it, the SCM 
wants to deal with them *even*less*, because they are much worse there, 
and more importantly, you'd be trying to push them into a level where most 
users have gotten over the braindamage and no longer want it!

So you're trying to make *everybody* suffer, just because you cannot do it 
right. 

And suffer people do. There's a reason people are so negative about 
keyword expansion: we've _seen_ those problems first-hand. 

So the proper solution is:
 - don't do keyword expansion on the "originals".
 - add release information when you do a release. 
 - if you want to sign releases, do so *after* the release. That's what a 
   release process is all about.
 - if you're so damn lazy that you can't be bothered to do the signing of 
   the release, don't ask others to do stupid things because *you* do 
   something stupid - just make sure that whatever release information you 
   add can be *removed*, so that you can verify an exact match.

For example, look at how "git archive" does this. It actually adds release 
information to the tar-file. It's hidden as a magic header, but that also 
means that since it's *separate* from the source code, it avoids all the 
problems with keyword expansion, and now you can (for example) diff the 
tar-ball source tree with the git tree, and you will not get spurious AND 
INCORRECT differences! And any checksums would still be valid!

And the same kind of thing can be done even if you absolutely have to 
embed the information on a file-by-file basis. Just make sure that you do 
it in some reversible manner. But preferably you generate a separate file 
(eg my hypothetical Makefile example that actually generates a "prt" file 
from a "svg" file) so that you have the original and can do any diff or 
validation efforts on *that*.

			Linus
