From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: tracking perms/ownership
Date: Fri, 24 Aug 2007 10:51:35 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708241039250.25853@woody.linux-foundation.org>
References: <1187716461.5986.71.camel@beauty> <20070821134030.b763e9d3.seanlkml@sympatico.ca>
 <1187817948.5986.159.camel@beauty> <alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
 <1187905879.5986.199.camel@beauty> <7vtzqpsy3q.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999.0708231626580.30176@woody.linux-foundation.org>
 <85ir75h2zb.fsf@lola.goethe.zz> <alpine.LFD.0.999.0708232327100.25853@woody.linux-foundation.org>
 <86mywhfk17.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Aug 24 19:51:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOdK1-0006uq-Mv
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 19:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761462AbXHXRvq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 13:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760356AbXHXRvp
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 13:51:45 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34453 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751864AbXHXRvo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Aug 2007 13:51:44 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7OHpZGP017723
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 24 Aug 2007 10:51:36 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7OHpZR7007157;
	Fri, 24 Aug 2007 10:51:35 -0700
In-Reply-To: <86mywhfk17.fsf@lola.quinscape.zz>
X-Spam-Status: No, hits=-2.451 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_21
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.28__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56584>



On Fri, 24 Aug 2007, David Kastrup wrote:
> >
> > Which means that any such environment *has* to encode the owndership
> > *separately* from the actual filesystem ownership. Because doing it
> > in the filesystem simply isn't sane.
> 
> But in this case you have a work directory and an installation
> directory.  And you have an installation procedure.  No tracking is
> involved at all.

I agree that the cases are different.

I also agree that a tool that is *specialized* to only do basically 
backups (or, equivalently, "distributed installation") would potentially 
be a different issue, and there "it will only run as root" is a reasonable 
thing to do.

But git is, if anything, specialized the other way - which means that I 
think it's perfectly fine to let it know about ownership, but it's *not* a 
valid thing to do to then say "only root can do it". 

Also, even with a distributed installer/backup thing, the fact is, 
"ownership" and "permissions" is simply not well-defined at a filesystem 
level. Are we talking just unix owner/group/mode here? That won't do for a 
lot of filesystems that have ACL's or other extended user/permission 
information. 

> In your example, neither installed files nor ownership are tracked in
> the filesystem.  Both are "tracked" in the Makefile.  Or rather than
> being tracked, they are explicitly catered for by the user.

And I seriously am saying that that is the only way to handle things 
sanely in a distributed content tracker like git.

Because full permissions and ownership (think ACL's) simply aren't 
"content" enough. The way to _reliably_ turn them into "content" that can 
be tracked, is to make it some form of file content.

Because otherwise, you will always hit situations where you simply cannot 
access it sanely. Even as an administrator you might need to do some 
emergency fixup, but you may be on vacation, and the only thing you have 
access to is some machine that you're not root on - and you'd like to send 
a "git bundle" with the fix to your less-than-stellar stand-in that is 
knee-deep in sh*t because he doesn't know the system, and you're on some 
sunny tropical island.

Or just imagine the case where you have slightly different setups for 
different people - some have ACL's, some have just basic permissions. But 
you want to maintain an image that works for both cases. What do you do?

See? If you just accept the fact that ownership and permissions are 
totally "separate content" that is tracked AS CONTENT, and not as the 
filesystem thing, you solve all these problems.

> git is a content _tracker_.  It tracks contents, also contents that
> move around.  If it can't track the permissions moving around as well,
> it's sort of pointless to integrate this into git: if you have to
> manage the stuff yourself, anyway, there is no point in creating the
> illusion that it is done by git.

Fair enough - I'll certainly agree with the notion that we don't 
necessarily need any integration of permissions/ownership into git at 
all, and you can always do it as a totally independent layer.

> > Your choice. But I know which one I'd choose.
> 
> That's fine.  But you don't actually need git at all to implement your
> choice, so this is orthogonal to whether having an option to do it
> inside of git might be worth having.

But I care about git having a *sane*design*, whether I use all the 
features or not. Because I simply care about my tools at a higher level 
than most users do. Which means that it doesn't matter whether I'll use 
permissions/ownership tracking or not - I still require that git do it 
*sanely* from my standpoint of having a good content tracker.

And that means tracking those things *separately*, and not trying to mess 
up the "tree" structure, for example.

			Linus
