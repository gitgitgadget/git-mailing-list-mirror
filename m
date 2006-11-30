X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Wed, 29 Nov 2006 17:03:51 -0800
Message-ID: <7vodqpn3t4.fsf@assigned-by-dhcp.cox.net>
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
	<7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>
	<87ejrlvn7r.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 30 Nov 2006 01:04:12 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32692>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpaLE-0000NG-AV for gcvg-git@gmane.org; Thu, 30 Nov
 2006 02:03:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967769AbWK3BDx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 20:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967772AbWK3BDx
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 20:03:53 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:30647 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S967769AbWK3BDw
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 20:03:52 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061130010352.ODE18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>; Wed, 29
 Nov 2006 20:03:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id sp3J1V00V1kojtg0000000; Wed, 29 Nov 2006
 20:03:19 -0500
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth <cworth@cworth.org> writes:

> I think what I'm asking for is a much more mild change. The "keep the
> index clean" behavior exists almost everywhere already, (the few
> exceptions are things like "git cherry-pick -n", and the notable
> exception of a conflicted merge). So I don't think supporting "commit
> -a by default" means we have to introduce a large conceptual change.

We seem to be agreeing (and Linus seems to, too, in a thread
next door) that it is a good thing that git keeps index clean
unless you explicitly ask it to.

We also seem to be agreeing that people with more involved needs
can deliberately make index different from HEAD, way before
issuing "git commit", and that they can commit even when "git
diff" gives nonempty differences, and these are good things.

Are we on the same page?

Now what does it mean to make "commit" silently update the index
with all the changes in the working tree without being told?

Unless you are introducing "working tree is the king" mode to
git to make everything ignore the index's "contents" part (in
other words, the index is used as the CVS/Entries file, nothing
more, under that mode of operation), I think you just introduced
an inconsistency at the place where the difference matters most.

I do not agree what you are asking is a "mild change" at all,
and I said it already that it goes against the mental model of
how git tools work.

Earlier, the world model was "you build it in the index and you
make a commit of what is in the index; there is a last-minute
index operation you can do by passing paths to commit and as a
short-hand there is -a as well [*1*]".  Now you made the world
model "it does not matter what you have in the index before
issuing git-commit; if you want to preserve what you built in
the index, you have to do something non-default".  That WOULD
solicit more newbie confusion.  "If it does not matter at the
end unless you do something special, why bother doing it at
all?" would be the question you would face.

Earlier on the "UI warts" thread, people said that the users do
not form the mental model of how the toolset works by reading
the tool's documentation but by trying things out, and I think
that is a valid observation.  We should not be sending a wrong
message by introducing inconsistencies like that.

The tool's UI should naturally reflect what world model it is
based on, and like it or not, the world model of git includes
the index.  The way to explain "-a" to new users should not be
"you can _ignore_ index as long as you use -a".  I do not think
denying the index buys the new users anything.  Rather,
"building your next commit incrementally in the index is the
workflow git is designed to support, but you are not required to
do that _incrementally_.  Until you encounter a complex
situation such as resolving a large conflicting merge, doing
that incrementally does not buy you anything as long as you work
in a clean working tree.  Instead, you can tell git what you
want to commit when you run 'git-commit' by giving paths or
directory names, or if you want to commit everything in the
working tree, then you can also say '-a'".

I am all for rewording the cryptic "use update-index to update"
message with "use 'commit -a' to commit all of them" or
somesuch.  That does NOT break the mental model.

Another thing that we need to be aware of is that new users
won't be "newbies" forever, and the tool should not be optimized
for the first few pages of the tutorial.  You and Nico say
"experienced people can always alias UI warts away", but I think
that is a wrong attitude.  Users with experience, long after
this discussion is forgotten, would complain "other tools help
us build the next commit in the index, but git-commit by default
discards the distinction between what were marked for commit and
what were not, unless explicitly told not to.  Why does it do -a
by default, and why should I forced to alias that stupid default
away?"


[Footnote]

*1* In retrospect, making "commit -o" the default was a very bad
change; I got tired of repeating myself in that discussion and
applied that change, but it was probably a mistake.

