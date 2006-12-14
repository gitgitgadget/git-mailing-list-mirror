X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 15:46:17 -0800
Message-ID: <7vk60uyrau.fsf@assigned-by-dhcp.cox.net>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
	<200612140959.19209.andyparkins@gmail.com>
	<7vmz5q18cn.fsf@assigned-by-dhcp.cox.net>
	<200612142255.33564.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 23:46:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612142255.33564.andyparkins@gmail.com> (Andy Parkins's
	message of "Thu, 14 Dec 2006 22:55:32 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34442>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv0HO-0003Zl-Cd for gcvg-git@gmane.org; Fri, 15 Dec
 2006 00:46:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751996AbWLNXqT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 18:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbWLNXqT
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 18:46:19 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:51067 "EHLO
 fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751996AbWLNXqS (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 18:46:18 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061214234617.WZWD15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Thu, 14
 Dec 2006 18:46:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id ynmV1V0051kojtg0000000; Thu, 14 Dec 2006
 18:46:29 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> On Thursday 2006, December 14 21:22, Junio C Hamano wrote:
>
>> This is interesting.  You said "commit -b", were pointed out
>> that you were talking about "checkout -b", and just after saying
>> "yup, that is right, I was", you again say "commit -b".
>
> There truly is something wrong with me.

I did not mean it that way.  I only took it as a sign that maybe
"first create and switch to a branch and then work and commit
there, in separate steps", which is how git encourages things to
be done, does not match people's mental model so well.

> I'm not sure about your "commit -b"; is it wise to have /another/ way of 
> making a branch?  I mean - I'm clearly confused enough, have a heart :-)

I said "commit -b <newbranch>" and deliberately avoided saying
"commit -b <anybranch>", because I did not want to open another
can of worms while we are discussing so many good things
already, and my head can hold only a handful topics at once.

But people on the list (and #git channel) sometimes wished an
easy way to help the following workflow.

 * I am in the middle of working on a new feature.  As a good
   git user, I am on a topic branch dedicated for that purpose.

 * While working on it, I find an obvious bug that I would not
   want to fix on the branch (the topic branch I am currently on
   is not about fixing that bug).

 * But I fix it in the working tree anyway, because otherwise I
   would forget.  It happens to be in an isolated file that my
   current topic does not need to modify (say, I was looking at
   a function in that file that my new feature needs to call and
   I wanted to study its calling convention. And I found a typo in
   the comment near the function).

 * The fix does not belong to the current topic, but can go to
   the 'master' branch straight.  It's a fix in the comment that
   cannot possibly break things, and I can/will test it later
   anyway.

 * So with the existing set of tools, I would go there, commit
   and then come back:

	$ git checkout [-m] master
        $ git commit -m 'fix typo in that-file' that-file
        $ git checkout [-m] topic

   But it might be faster to say:

   	$ git commit -b master -m 'fix typo in that-file' that-file

   to make a commit on the other branch and come back
   immediately afterwards.

 * In the same situation, when the 'master' is closed for some
   administrative reason (e.g. "deep freeze before a release and
   strict bugfixes and nothing else are allowed"), I would create
   a new 'typofix' branch and do the same.  I can rebase it
   later on 'master' when it reopens.

	$ git commit -b typofix -m 'fix typo in that-file' that-file

	... much later when master reopens ...
        $ git rebase --onto master topic typofix

It's just a possible typesaver, but I am likely not using it
myself (my fingers are already trained to do the three command
sequence dance).

I do agree that it adds one more way to do the same thing and
would make the documentation noisier, potentially adding more to
the confusion.  So let's not go there.

