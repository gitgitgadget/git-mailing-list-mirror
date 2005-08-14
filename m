From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC][PATCH] Rewriting revs in place in push target repository
Date: Sat, 13 Aug 2005 19:10:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508131859190.3553@g5.osdl.org>
References: <20050813214725.GM5608@pasky.ji.cz> <7vwtmpjq17.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 14 04:10:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E47x8-0001r9-IJ
	for gcvg-git@gmane.org; Sun, 14 Aug 2005 04:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbVHNCKS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 22:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbVHNCKS
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 22:10:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42924 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932416AbVHNCKQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 22:10:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7E2A1jA016250
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 13 Aug 2005 19:10:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7E2A0T6005724;
	Sat, 13 Aug 2005 19:10:01 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtmpjq17.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.44__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 13 Aug 2005, Junio C Hamano wrote:
>
> Petr Baudis <pasky@suse.cz> writes: 
> > Rewrite refs in place in receive-pack & friends
> >
> > When updating a ref, it would write a new file with the new ref and
> > then rename it, overwriting the original file. The problem is that
> > this destroys permissions and ownership of the original file, which is
> > troublesome especially in multiuser environment, like the one I live in.
> 
> Hmph.  If a repo is _really_ used multiuser then you should not
> have to care about ownership.

I think Pasky's usage is that different heads are owned by different
groups and/or users, and he wants to use the filesystem permissions to
determine who gets to update which branch. Which is reasonable in a way.

On the other hand, I don't think filesystem permissions are really very 
useful. I think it's more appropriate to use triggers to say something 
like "only allow people in the 'xyz' group to write to this head".

Obviously, triggers aren't about _security_ - somebody who has write 
permissions to the tree can always screw up others. But triggers are fine 
for things like branch ownership, where you trust your users, but you just 
want to avoid mistakes.

So a trigger might be something like

	#!/bin/sh
	. git-sh-setup-script
	branch="$1"
	old="$2"
	new="$3"
	if [ -e $GIT_DIR/permissions/$branch ]; then
		id=$(id -un)
		grep -q "^$id$" $GIT_DIR/permissions/$branch ||
			die "You're not allowed to write to $branch"
	fi
	true

and that would allow you to list all users that are allowed to write to 
the branch in $GIT_DIR/permissions/<branchname>.

Totally untested, of course. But the concept should work.

		Linus
