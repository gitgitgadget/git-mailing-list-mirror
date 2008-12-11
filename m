From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: epic fsck SIGSEGV! (was Recovering from epic fail (deleted
 .git/objects/pack))
Date: Wed, 10 Dec 2008 16:45:13 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812101636351.3340@localhost.localdomain>
References: <1228867861.14165.19.camel@starfruit.local>  <7vd4g051ax.fsf@gitster.siamese.dyndns.org>  <1228903606.4445.53.camel@starfruit.local> <493FAA5A.8070801@viscovery.net>  <1228949523.27061.20.camel@starfruit.local>  <alpine.LFD.2.00.0812101523570.3340@localhost.localdomain>
 <1228955062.27061.36.camel@starfruit.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 01:47:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAZhz-0007qR-0H
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 01:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386AbYLKAp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 19:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752961AbYLKAp5
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 19:45:57 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35434 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752571AbYLKAp4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2008 19:45:56 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBB0jPmF025491
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Dec 2008 16:45:26 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBB0jEfq000557;
	Wed, 10 Dec 2008 16:45:18 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <1228955062.27061.36.camel@starfruit.local>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.426 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102757>



On Wed, 10 Dec 2008, R. Tyler Ballance wrote:
>
> The stack size is 8M as you assumed, I'm curious as to how the kernel
> handles a process that exceeds the ulimit(2) stacksize. I know from our
> experience with this repository that when Git runs up against the
> address space (ulimit -v) that an ENOMEM or something similar is
> returned. Is there an E_NOSTACK? :) (figured I'd ask, given your
> apparent knowledge on the subject ;))

Since stack expansion doesn't involve any system calls, and since there is 
no way to recover from it anyway, the kernel has no choice: it just sends 
a SIGSEGV.

An application that wants to _can_ handle this case by installing a signal 
handler, but since signal handling needs some stack-space too, a regular 
"sigaction(SIGSEGV..)" isn't sufficient. You also need to set up a 
separate signal stack ..

Nobody really ever does that, except for some _really_ special programs. 
But it's a way to handle errors in stack allocation if you really need to. 
Git certainly does not do it.

> > (You can do something like
> > 
> > 	git rev-list --first-parent HEAD | wc -l
> 
> tyler@ccnet:~/source/slide/brian_main>  git rev-list --first-parent HEAD | wc -l
> 46751 

Ahh. yes. The 80k number is because the callchain was that deep, but since 
each recursion involves _two_ functions, it really only needed a 40k 
commit depth to the root to get there.

> > But we should definitely fix this braindamage in fsck. Rather than 
> > recursively walk the commits, we should add them to a commit list and just 
> > walk the list iteratively.
> 
> Given that this issue affects our internal (proprietary) repository, I
> can't very well give access to it or publish a clone, but I'm willing to
> help in any way I can. We maintain an internal fork of the Git tree, so
> I can apply any changes you'd like to an internal 1.6.0.4 or 1.6.0.5
> build. For obvious reasons I ran the fsck against an upstream maintained
> (stable) build of Git.

Can you try with a bigger stack? Just do

	ulimit -s 16384

and then re-try the fsck. Just to verify that this is it. If nothing else, 
it will at least give you a working fsck, even if it's obviously not the 
"correct" solution.

		Linus
