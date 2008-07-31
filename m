From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Monotone workflow compared to Git workflow ( was RE: Git vs
 Monotone)
Date: Thu, 31 Jul 2008 14:40:55 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807311426090.3277@nehalem.linux-foundation.org>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com> <alpine.LFD.1.10.0807311211260.3277@nehalem.linux-foundation.org> <63BEA5E623E09F4D92233FB12A9F79430238A5EE@emailmn.mqsoftware.com>
 <alpine.LFD.1.10.0807311253140.3277@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sverre@rabbelier.nl, Git Mailinglist <git@vger.kernel.org>
To: "Craig L. Ching" <cching@mqsoftware.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 23:52:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOg4I-0003fR-G8
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 23:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756430AbYGaVvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 17:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757880AbYGaVvU
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 17:51:20 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36482 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755723AbYGaVvS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2008 17:51:18 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6VLoiCn030261
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 Jul 2008 14:50:45 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6VLhstd013788;
	Thu, 31 Jul 2008 14:43:54 -0700
In-Reply-To: <alpine.LFD.1.10.0807311253140.3277@nehalem.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.406 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91001>



On Thu, 31 Jul 2008, Linus Torvalds wrote:
> 
> Sure, if you want to keep the build tree around, you would probably not 
> use branches. 

Side note: it's often faster to recompile, if your project has a good 
build system.

For example, for the kernel, I can literally rebuild my whole kernel 
(which is just what I use on _that_ machine) in about 16 seconds. This is 
_not_ using ccache or anything else - it's rebuilding the whole tree with 
-j16.

It turns out that using multiple build trees would actually slow things 
down, because then the source code wouldn't fit in memory any more. If I 
have to actually read the source code from the disk, my nice 16-second 
compile goes up to a minute or more.

Now, the thing you should take away from this is:

 - kernel people have cool toys, and CPU's that are faster than what you 
   have. Nyaah, nyaah.

 - disk is slow. REALLY slow. If you can share most of a single source 
   tree and thus keep it in memory, you're ahead.

 - even large projects can have a fast build cycle if your build chain 
   doesn't suck. The kernel is larger than most, but a _lot_ of build 
   systems don't parallelize or use horribly inefficient tools, so they 
   take much longer to build. 

The last part is the thing that people often stumble on. For example, I 
can literally compile the kernel a hell of a lot faster than I can do 
"make doc" on the git tree! Even just trying a "make -j16" when building 
the git documentation is really really really painful. I suspect I'd need 
a ton more memory for that horror.

So if your workflow involves xml (I think the doc build for git is all 
xsltproc - along with asciidoc written in python or something), you're 
screwed. But in the kernel we've actually cared pretty deeply about build 
times, and as a result it's actually very pleasant to switch branches and 
just rebuild. Even if some core header file has changed, it's _still_ ok 
if you've got enough CPU.

(I just tested - I can do a "make doc" for git in just under a minute from 
a clean tree. Ouch. That really is three times longer than my kernel 
build - as long as I brought the kernel and compiler into memory first ;)

			Linus
