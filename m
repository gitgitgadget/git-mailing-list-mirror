From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Submodule object store
Date: Tue, 27 Mar 2007 11:41:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703271124590.6730@woody.linux-foundation.org>
References: <20070326183523.GG22773@admingilde.org> <200703262133.44520.Josef.Weidendorfer@gmx.de>
 <20070326220302.GH22773@admingilde.org> <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net>
 <20070326231637.GJ22773@admingilde.org> <7vy7ljtwir.fsf@assigned-by-dhcp.cox.net>
 <20070326233603.GL22773@admingilde.org> <20070327112549.GA12178@informatik.uni-freiburg.de>
 <20070327115029.GC12178@informatik.uni-freiburg.de> <20070327155306.GQ22773@admingilde.org>
 <20070327172216.GA24200@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463790079-1168663986-1175020871=:6730"
Cc: Martin Waitz <tali@admingilde.org>,
	Junio C Hamano <junkio@cox.net>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Tue Mar 27 20:42:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWGcR-000832-D3
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 20:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934169AbXC0SmB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 14:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934168AbXC0SmB
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 14:42:01 -0400
Received: from smtp.osdl.org ([65.172.181.24]:37428 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934169AbXC0Sl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 14:41:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2RIfDU2009579
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Mar 2007 11:41:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2RIfBr4024769;
	Tue, 27 Mar 2007 11:41:12 -0700
In-Reply-To: <20070327172216.GA24200@informatik.uni-freiburg.de>
X-Spam-Status: No, hits=-0.469 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43295>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463790079-1168663986-1175020871=:6730
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Tue, 27 Mar 2007, Uwe Kleine-König wrote:
> 
> 	embeddedproject$ git ls-tree HEAD | grep linux
> 	040000 commit 0123456789abcde0... linux-2.6
> 
> (or how ever you save submodules).  Then you might have to duplicate the
> objects of linux-2.6, because they are part of both histories.

No they are not. Unless you do it wrong.

The *only* object that is part of the superproject would be the tree that 
*contains* that entry itself.

We should *never* automatically follow such an entry down, *exactly* 
because that doesn't scale. So to actually follow that entry for something 
like a recursive, you'd literally "cd into linux, and start 'git diff' 
from commit 0123456.."

In other words, the subproject would be its own project, and the 
superproject never sees it as "part of itself". I really think, for 
example, that the "git diff" family of programs (diff-index, diff-tree, 
diff-files) and things like "git ls-tree" should literally:

 - have a mode where they don't even recurse into subprojects, and I 
   personally think that it could/should be the default!

 - when they recurse, they should literally (at least to begin with) do 
   that kind of "fork() ; if (child) { chdir(subproject); execve(myself) }" 

The latter is really to make sure that *even*by*mistake* we don't screw 
things up and tie the sub/superproject together too tightly. 

I'm serious. I really think that the first version (which ends up being 
the one that sets semantics) should be very careful here, so that 
subprojects never get mixed up with the superproject.

And I'm also serious about the "don't recurse into subproject by default 
at all". If I'm at the superproject, and I maintain the superproject, I 
think the state of the subprojects themselves are a totally separate 
issue. It's quite a valid thing to do to maintain the build 
infrastructure, and if I'm the maintainer of that, and I do "git diff", I 
sure as hell don't want to wait for git to do "git diff" on the 
subprojects when there are 5000 of them!

Sure, "git diff" is fast (on the kernel, it takes me 0.069s on a clean 
tree), but 

 - multiply that 0.069s by 5000 and it's not so fast any more

 - when you have a thousand subprojects, it's quite possible (even likely) 
   that all your directories won't fit in the cache any more, and suddenly 
   even a single "git diff" takes several seconds.

Really! Try this on the Linux tree (that "drop_caches" thing needs root 
privileges):

	echo 3 > /proc/sys/vm/drop_caches
	git diff

and see it take something like 5 seconds. Now, imagine that you have a 
hundred subprojects, and they're big enough that the caches are *never* 
warm.

People sometimes don't seem to understand what "scalability" really means. 
Scalability means that something that is so fast that you don't even 
*think* about it will become a major bottleneck when you do it a thousand 
times, and the working set has grown so big that it totally blows out 
several levels of caches (both CPU caches and disk caches)

		Linus
---1463790079-1168663986-1175020871=:6730--
