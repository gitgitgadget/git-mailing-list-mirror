X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Feature request: git-pull -e/--edit
Date: Sun, 19 Nov 2006 19:21:05 -0800
Message-ID: <7v8xi67qhq.fsf@assigned-by-dhcp.cox.net>
References: <7vy7q67tf2.fsf@assigned-by-dhcp.cox.net>
	<20061120024308.18620.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 20 Nov 2006 03:21:47 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061120024308.18620.qmail@science.horizon.com>
	(linux@horizon.com's message of "19 Nov 2006 21:43:08 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31880>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Glzj2-0001xm-3t for gcvg-git@gmane.org; Mon, 20 Nov
 2006 04:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933903AbWKTDVJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 22:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933901AbWKTDVJ
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 22:21:09 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:31741 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S933903AbWKTDVH
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 22:21:07 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061120032106.RMQP18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Sun, 19
 Nov 2006 22:21:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id orMD1V0061kojtg0000000; Sun, 19 Nov 2006
 22:21:13 -0500
To: linux@horizon.com
Sender: git-owner@vger.kernel.org

linux@horizon.com writes:

>> How often is this desired, when the merge is clean?  
>
> Well, if I could quote your own words:
>
>>> I use "git pull . topicA topicB" for a tetrapus, so that is not
>>> a reason for me, but when a topicA's older parts are worthy to
>>> be in 'next' while later parts are not yet, I often do (on 'next'):
>>> 
>>>	git merge "Merge early part of branch 'topicA'" HEAD topicA~3
>
> I can't speak from personal experience, but a merge can bring in a lot
> of changes, and sometimes the auto-generated message doesn't say quite
> as much as you'd like.

That is more or less irrelevant example.  I was only saying that
it is a workaround to emulate "git pull . topicA~3"; if that
form worked, I would keep the automated fmt-merge-msg output
that is currently recorded in the merge and I do not see any
need to edit it further.

> (Indeed, it might be nice to come up with a way of including a piece of
> the "please pull" e-mail, similar to the way that git-applypatch works.)

That is a lot more relevant example.  For example, I could
imagine that Linus coming up with a wrapper that is fed a series
of e-mails and:

 * if it is a patch, run git-applymbox on it as before,

 * if it is a pull request, then extract the URL and branch, run
   "git pull" on that, match the "diff ORIG_HEAD" output against
   what is in the pull request and,

   - warn if there are huge discrepancies;

   - otherwise annotate the commit message with the explanation
     of the series taken from the pull request message.

But even in that workflow, "annotate the commit" comes after
pull happens and the merge result is verified, so I do not quite
see "commit --amend" as a "workaround" as you said.

Having said that, I think the real reason that the whole "merge"
message generation feels awkward comes from the historical
division of labor between pull and merge.

"git merge" started its life as the first level command (with a
funny syntax that does not even take command line option -m,
because you are supposed to give the whole merge message and
"git merge" itself does not do anything to affect the merge
message on its own).  When it was pushed further back to the
"worker behind the scene" status, the task of coming up with a
fancier automated merge message were still left to the "git
pull" command which (1) is the UI level command that the users
are expected to use, and (2) knows much more about the context
where the merge is generated than "git merge" itself.  As a
result, "git merge" still takes the whole message prepared and
it does not do anything on its own.

So if we rename the current "git merge" to "git-merge--record"
(or any name "git pull" uses internally to record the merge
commit), and make "git merge" a synonym to "git pull .", and
give a command line option -m to "git pull" to _affect_ the
resulting merge message, I would think everybody would become
quite happy.  It means:

 - People can say "git merge this-branch" (which is internally
   translated to "git pull . this-branch");

 - People can say "git pull -m 'I am doing this merge for such
   and such reason' $URL $branch" to _include_ that message in
   the resulting merge commit;

 - The same can be said about "git merge -m 'comment' $branch".

I said _affect_ and _include_ in the above because I suspect
that most of the time you do not want to _replace_ the
autogenerated part ("Merge branch of repo", and if you are
pulling from your subordinate trees the merge summary message as
well).
