From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: speeding up cg-log -u
Date: Mon, 16 May 2005 11:38:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505161115010.30848-100000@iabervon.org>
References: <7voebboafy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Zack Brown <zbrown@tumblerings.org>,
	git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon May 16 17:47:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXhmt-00066v-0h
	for gcvg-git@gmane.org; Mon, 16 May 2005 17:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVEPPoy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 May 2005 11:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVEPPlg
	(ORCPT <rfc822;git-outgoing>); Mon, 16 May 2005 11:41:36 -0400
Received: from iabervon.org ([66.92.72.58]:5383 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261723AbVEPPjm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2005 11:39:42 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DXhgJ-000726-00; Mon, 16 May 2005 11:38:59 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voebboafy.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 16 May 2005, Junio C Hamano wrote:

> >>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> DB> Existance is the primary thing, and everything else was added as
> DB> needed. (Pure connectivity is a bit special, because it's a property of
> DB> generic objects so that fsck-cache doesn't need to know about particular
> DB> types of objects unless there are particular things to check about them)
> 
> DB> If you need more fields, let me know, and I'll figure out how to include
> DB> them.
> 
> Could you take a look at the latest round of the patch and see
> what I did there makes sense?
> 
>     From: Junio C Hamano <junkio@cox.net>
>     Date: Sun, 15 May 2005 14:18:36 -0700
>     Message-ID: <7vy8agqjbn.fsf@assigned-by-dhcp.cox.net>
>     Subject: [PATCH 1/4] Add --author and --committer match
>              to git-rev-list and git-rev-tree.

It seems generally good to me.

I think it would fit stylistically a bit better if the "mark" field on the
person names were left for programs to use however they wanted, and the
"interesting" determination were done in the programs (or, since there are
two with the same characteristics, a new file they both link against).

Alternatively, put the used bit definitions in the header file and have a
mask for unused flags.

> Another thing I wanted to ask you about was lifetime rules.
> When we "lookup" these objects (and then "parse" them, which
> causes more memory to be used), who is responsible for freeing
> them?  When my program thinks it is done with a commit, is it
> allowed to free it?  Or does the lookup machinery own all of the
> objects that have ever been looked up, and the program should
> not worry about freeing them to begin with?

The lookup machinery owns all of the objects that have been looked up. The
thing is that the program can never effectively tell if it's really done
with a commit, because some other branch it's following could have
incorrect dates and suddenly turn out to be descended from a commit that
it freed, and things would likely misbehave if the object were looked up
again, since the flags would be reset.

We could have something that causes them to be reset to unparsed, if the
program thinks that, even if it references the same object again, it won't
need the contents.

	-Daniel
*This .sig left intentionally blank*

