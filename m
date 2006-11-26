X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH]  Make logAllRefUpdates true by default
Date: Sun, 26 Nov 2006 12:12:59 -0800
Message-ID: <7vhcwmt19w.fsf@assigned-by-dhcp.cox.net>
References: <11645554033331-git-send-email-wildfire@progsoc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 26 Nov 2006 20:13:17 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32365>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoQNA-00075W-4z for gcvg-git@gmane.org; Sun, 26 Nov
 2006 21:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757954AbWKZUND (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 15:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757955AbWKZUND
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 15:13:03 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:9445 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S1757954AbWKZUNB
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 15:13:01 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061126201300.HCMG97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Sun, 26
 Nov 2006 15:13:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id rYD81V01L1kojtg0000000; Sun, 26 Nov 2006
 15:13:09 -0500
To: Anand Kumria <wildfire@progsoc.org>
Sender: git-owner@vger.kernel.org

I do not think I can take this patch in its current form.

Although I think majority of users would find it convenient to
have ref-log enabled by default on repositories to be developed
in, it does not make sense to enable ref-log by default for bare
repositories that is used as a distribution point.  So at least
this needs an option to disable it (if you make it the default),
or enable it.

        Side note.  A ref-log at a distribution point _could_ be
        used for somebody to say "Hey, I pushed that fix three
        days ago -- why are you complaining about the breakage
        I've already fixed before checking the public tip?", but
        that is a manifestation of lack of communication among
        people and a SCM is not about solving that problem.

But having to add an option tends to drive people nuts.  We
already have --shared and --template, so adding --with-reflog
would be "just one more option" that we may not have to worry
too much about, but we would have to revisit this as we gain
more experience using git and more best-current-practices are
learned.  I wonder if we can infer if a particular invocation of
init-db is to prepare a repository to be developed in without
being told with a command line option.  If we can do so, then we
can do the configuratio setting with --with-reflog=[yes|no|guess]
option (and lack of --with-reflog means "guess").

There are three use cases that init-db is run directly from the
command line, and I think you want different behaviours.

 (1) you have a directory, perhaps already with many files
     there, because you are doing an initial import to prepare a
     repository to work in.  You obviously want a ref-log there,
     and you want --shared=no.  You do not care about
     denyNonFastForwards because you are not likely to be
     pushing into it.

 (2) you are preparing a public distribution point for _your_
     own tree.  You do not want a ref-log, you want --shared=no,
     and you _might_ want denyNonFastForwards.

 (3) you are preparing a public shared repository for project
     members to use to synchronize, CVS-style.  You do not want
     a ref-log, you do want --shared=group, and and you want
     denyNonFastForwards.

Another case that init-db is run indirectly is via git-clone and
via foreign SCM importers.  I think enabling ref-log during
non-bare clone, for example, should behave similarly to (1)
because the resulting repository is clearly meant to be used
with a working tree in which to develop.  A bare clone is either
(2) or (3) but you do not have to decide what to do with ref-log
(i.e. "don't").  But in these "indirect" cases, the command that
drives init-db can explicitly tell init-db what it is doing, and
we would need to have both --with-reflog and --without-reflog
options so that the command can tell what it wants from init-db
explicitly without having init-db guess.

If you can come up with a reliable way to tell (1)..(3) then we
can make init-db to do the right thing without an end user to
tell what should happen --with-reflog or --without-reflog; and
they do not even have to say --shared anymore as an added bonus.

Having thought about all the above, I think the event to create
distribution/synchronization point repositories are rare enough
and the simplest and cleanest way might be to make it default
and add a --without-reflog option to the command, and forget
about the guessing.

