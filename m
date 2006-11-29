X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Tue, 28 Nov 2006 23:44:57 -0800
Message-ID: <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>
	<7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net>
	<87bqmswm1e.wl%cworth@cworth.org>
	<7vodqse90q.fsf@assigned-by-dhcp.cox.net>
	<87ac2cwha4.wl%cworth@cworth.org>
	<7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net>
	<878xhwwdyj.wl%cworth@cworth.org>
	<7vk61gcnzl.fsf@assigned-by-dhcp.cox.net>
	<7vd5786opj.fsf@assigned-by-dhcp.cox.net>
	<871wnnwi3k.wl%cworth@cworth.org>
	<7virgzuf38.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611282322320.9647@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 29 Nov 2006 07:45:15 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611282322320.9647@xanadu.home> (Nicolas Pitre's
	message of "Tue, 28 Nov 2006 23:33:59 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32621>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpK7v-0003He-H4 for gcvg-git@gmane.org; Wed, 29 Nov
 2006 08:45:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965919AbWK2Ho7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 02:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966031AbWK2Ho7
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 02:44:59 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:25239 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S965919AbWK2Ho6
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 02:44:58 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061129074458.BOUK7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>; Wed, 29
 Nov 2006 02:44:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id sXkR1V01J1kojtg0000000; Wed, 29 Nov 2006
 02:44:26 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> This argument has its converse.  What you should _not_ have to worry 
> about all the time is whether your index really includes all the changes 
> you want included in your next commit.

That's what we have "git diff" with various output options for;
I often do "git diff --stat" or "git diff --name-status" when I
know I am about to commit in a dirty working tree.  I suspect
that I am not getting your point.

> And whether wanting to leave local changes in the working directory 
> without commiting them actually happen more often than wanting to commit 
> every changes is arguable.

I do not think anybody is talking about which happens more
often.  "screw the index" people do not have to worry about the
index during the course of their changes in the working tree
toward the next commit, and the only time they need to tell git
(which _IS_ a system based on the index, dammit) about what they
want to do with the index is at the commit time, and they tell
git to "screw the index" by passing "-a" to "git commit".  In
other words, "-a" at commit time is a magic incantation to allow
them to be casual about index manipulation before reaching the
point to commit.  They do not have to worry about differences
between "git rm --force" vs "/bin/rm" nor "git apply" vs "git
apply --index").

It might make sense to have a configuration in .git/config that
says "user.workingtreeistheking = true".  This should obviously
affect what "git commit" does by default, but it also should
change the behaviour of other commands to suit the "screw the
index" workflow better.

For example, the configuration should probably make "git diff"
(without an explicit --cached nor HEAD) pretend it was asked to
show diff between HEAD and the working tree, because the user
chose not to care about the index.  Not caring about the index
is different from consciously keeping the index clean; for
example, running "git apply --index" by mistake when he meant to
say "git apply" should be tolerated, and Porcelain-ish that is
working under workingtreeistheking mode should behave as if the
index does not exist.  In other words, the index is _not_ a
staging area towards the next commit for him; the working tree
is.

I thought Cogito largely follows that model, so it certainly is
possible to do things that way.  And I would not mind if the
changes are cleanly done and maintainable.  I am NOT going to
say that I will refuse to maintain the code that implements the
workingtreeistheking half of the system, although it is very
unlikely that I would ever enable that configuration in my
repositories.

Would that make people happy?  I do not think so.  I think it
will lead to more confusion to have two majorly different
semantics in the same set of tools.

