From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sat, 21 Jul 2007 06:29:41 +0200
Organization: Organization?!?
Message-ID: <851wf2bcqy.fsf@lola.goethe.zz>
References: <85lkdezi08.fsf@lola.goethe.zz> <Pine.LNX.4.64.0707180135200.14781@racer.site> <858x9ez1li.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org> <vpq4pk1vf7q.fsf@bauges.imag.fr>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?alpine.LFD.0.999?= =?ISO-8859-1?Q?.0707181004330.=04?=
	=?ISO-8859-1?Q?27353@woody.linu?= =?ISO-8859-1?Q?x-foundation.org?=
	=?ISO-8859-1?Q?>?= <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 21 06:30:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC6c1-0004Ny-AC
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 06:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbXGUEaF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 00:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752670AbXGUEaB
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 00:30:01 -0400
Received: from main.gmane.org ([80.91.229.2]:53324 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751914AbXGUEaA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 00:30:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IC6bO-0003AA-0L
	for git@vger.kernel.org; Sat, 21 Jul 2007 06:29:58 +0200
Received: from dslb-084-061-013-246.pools.arcor-ip.net ([84.61.13.246])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Jul 2007 06:29:57 +0200
Received: from dak by dslb-084-061-013-246.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Jul 2007 06:29:57 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-013-246.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:RJpil6euZmqmXt0/LJaQaGafNK4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53134>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> This really updates three different areas, which are nicely
> separated into three different files, so while it's one single
> patch, you can actually follow along the changes by just looking at
> the differences in each file, which directly translate to separate
> conceptual changes:

Ok, I have now acquired enough passing familiarity with the code that
I find part of my way around it.  Most of your patch looks like it
caters for the S_ISDIR type not previously in use in the index (how
about the repository?).  So that makes for quite a bit of nicer looks.
The disadvantage is that it introduces a new data type and thus one
has to check all the code paths to see how older versions of git will
cater with newer data.

My idea of a fake zero-length file would have had predictable side
effects:

For checking out, git would have created the directory it needed to
place the "file", then try to write an empty file called "." and
failing.  Apart from an error message (if we aren't root on Solaris),
this would have worked exactly as intended.

For deletion on checking out, git would have tried deleting "." and
failed.  I have not checked the code to see whether git takes this as
a clue not to attempt deleting the containing directory.  If not,
again stuff would have worked as intended.  If yes, well, the user
needs to clean up manually.

I am not sure what code paths are executed when using S_ISDIR now in
unmodified git.  As a theoretical question for now: do git
repositories carry some versioning inside them?  Something like "don't
touch me if you are not at least version x"?

Anyway, the code becomes quite less of a dirty hack by using that data
type, so I am pretty much taking your code (which has no overlap to
the work I have done already) as is.  Seems like it should play
together quite nicely with my own stuff.

So thanks for doing the heavy lifting in a difficult area.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
