X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: should git download missing objects?
Date: Mon, 13 Nov 2006 12:05:48 -0800
Message-ID: <7virhj6rj7.fsf@assigned-by-dhcp.cox.net>
References: <ej7fgp$8ca$1@sea.gmane.org>
	<7vwt60bggs.fsf@assigned-by-dhcp.cox.net>
	<20061113194532.GA4547@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 13 Nov 2006 20:06:09 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061113194532.GA4547@steel.home> (Alex Riesen's message of
	"Mon, 13 Nov 2006 20:45:32 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31317>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gji41-0003vp-Ua for gcvg-git@gmane.org; Mon, 13 Nov
 2006 21:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933058AbWKMUFu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 15:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933059AbWKMUFu
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 15:05:50 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:47047 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S933058AbWKMUFt
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 15:05:49 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061113200548.RCQN9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>; Mon, 13
 Nov 2006 15:05:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id mL5N1V00N1kojtg0000000; Mon, 13 Nov 2006
 15:05:23 -0500
To: Alex Riesen <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org

fork0@t-online.de (Alex Riesen) writes:

> Junio C Hamano, Sun, Nov 12, 2006 20:41:23 +0100:
>> Since this is not everyday anyway, a far easier way would be to
>> clone-pack from the upstream into a new repository, take the
>> pack you downloaded from that new repository and mv it into your
>> corrupt repository.  You can run fsck-objects to see if you got
>> back everything you lost earlier.
>
> I get into such a situation annoyingly often, by using
> "git clone -l -s from to" and doing some "cleanup" in the
> origin repository. For example, it happens that I remove a tag,
> or a branch, and do a repack or prune afterwards. The related
> repositories, which had "accidentally" referenced the pruned
> objects become "corrupt", as you put it.
>
> At the moment, if I run into the situation, I copy packs/objects from
> all repos I have (objects/info/alternates are useful here too), run a
> fsck-objects/repack and hope nothing is lost. It works, as I almost
> always have "accidental" backups somewhere, but is kind of annoying to
> setup. A tool to do this job more effectively will be very handy (at
> least, it wont have to copy gigabytes of data over switched windows
> network. Not often, I hope. Not _so_ many gigabytes, possibly).

I suspect it is a different issue.  Maybe you would need reverse
links from the origin directory to .git/refs/ directroy of
repositories that borrow from it to prevent pruning.  No amount
of butchering fetch-pack to look behind incomplete refs that lie
and claim they are complete would solve your problem if you do
not have any "accidental backups".

In general, 'git clone -l -s' origin directories may not be
writable by the person who is making the clone, so we should not
do this inside 'git clone'.  Also you could add alternates after
you set up your repository, so maybe something like this would
help?

	#!/bin/sh
	#
	# Usage: git-add-alternates other_repo
        #
        : ${GIT_DIR=.git}
	my_refs=`cd $GIT_DIR/refs && pwd`
	other=$1
        test -d "$other/.git" && test -d "$other/objects" || {
        	echo >&2 "I do not see a repository at $other"
                exit 1
	}
	mkdir -p "$other/.git/refs/borrowers" || {
        	echo >&2 "You cannot write in $other"
        	echo >&2 "Arrange with the owner of it to make"
        	echo >&2 "sure the objects you need are not pruned."
                exit 2
        }
	cnt=0
        while test -d "$other/.git/refs/borrowers/$cnt"
        do
		cnt=$(($cnt + 1))
	done
        ln -s "$my_refs" "$other/.git/refs/borrowers/$cnt"
