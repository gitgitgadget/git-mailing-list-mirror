X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] config option core.showroot to enable showing the diff of the root commit
Date: Fri, 24 Nov 2006 00:54:38 -0800
Message-ID: <7vlkm1cjht.fsf@assigned-by-dhcp.cox.net>
References: <200611211341.48862.andyparkins@gmail.com>
	<8aa486160611210609h1c2d229ekf0b5e8aeb4f21f11@mail.gmail.com>
	<slrnem694k.4lm.Peter.B.Baumann@xp.machine.xx>
	<Pine.LNX.4.64.0611210820100.3338@woody.osdl.org>
	<20061121180643.GC7201@pasky.or.cz> <ejvfng$cj6$1@sea.gmane.org>
	<20061121182135.GD7201@pasky.or.cz>
	<7v64d8y4tu.fsf@assigned-by-dhcp.cox.net>
	<slrnemaqt1.esn.Peter.B.Baumann@xp.machine.xx>
	<7virh5khrc.fsf@assigned-by-dhcp.cox.net>
	<slrnemcc0b.ncc.Peter.B.Baumann@xp.machine.xx>
	<7vejrthf2y.fsf@assigned-by-dhcp.cox.net>
	<7vzmahfx6q.fsf@assigned-by-dhcp.cox.net>
	<slrnemd98k.a3v.Peter.B.Baumann@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 08:54:54 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32199>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnWpY-0000qq-6D for gcvg-git@gmane.org; Fri, 24 Nov
 2006 09:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934518AbWKXIyk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 03:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934519AbWKXIyk
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 03:54:40 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:8155 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S934518AbWKXIyj
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 03:54:39 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061124085439.QYUE9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Fri, 24
 Nov 2006 03:54:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qYum1V00i1kojtg0000000; Fri, 24 Nov 2006
 03:54:47 -0500
To: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Sender: git-owner@vger.kernel.org

Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
writes:

> One question, what's the difference between git-log -p and
> git-whatchanged -p?
> ...
> As you can see, the root commit isn't shown. Is this intentional?

Some historical background.

The traditional command do do log-minded things was whatchanged
and it was implemented as

	git rev-list $revision_args -- $path_limits |
        git diff-tree --stdin --pretty -r $format_args

and whatchanged did not give --root to diff-tree by default.
And 'diff-tree' does not show --pretty logs when there is no
diff to be shown (which still is true today and is a useful
behaviour), hence no mention of the root commit.

On the other hand, "git-log" traditionally looked like this:

	git rev-list --pretty $revision_args 

Back then, there was no path_limits nor even diff options to
it.

Later, Linus (with help from others) made the revision walk
machinery as callable inside programs other than "rev-list",
eliminating the need to pipe rev-list into diff-tree to perform
log-minded things.  That enriched what "git log" can do, and
mostly made "whatchanged" a redundant command.  As you may have
noticed, there isn't much difference between these two commands
in builtin-log.c; their differences are solely what default
options for diff and revision machinery are used and are meant
to match the traditional behaviour of these commands.

So there shouldn't be any differences, really, when you override
their defaults with the likes of -p.

Honestly speaking, I do not think there was _any_ consciously
designed intention to handle root commits, either to make these
commands behave identically or differently; regarding parentless
commits, they just behave the way they happen to behave, because
root commits were not something either Linus nor I were
interested in.

Given the recent discussion, however, the intention now should
be that Porcelain level commands should default to do --root
(i.e.  when asked to do "diff" to show how a commit without a
parent differs from its nonexistent parent, show diff with
emptiness).
