X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Two conceptually distinct commit commands
Date: Mon, 04 Dec 2006 22:33:30 -0800
Message-ID: <7virgqj1hh.fsf@assigned-by-dhcp.cox.net>
References: <87d56z32e1.wl%cworth@cworth.org>
	<20061205035123.GA8831@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 06:33:45 +0000 (UTC)
Cc: git@vger.kernel.org, Carl Worth <cworth@cworth.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061205035123.GA8831@thunk.org> (Theodore Tso's message of
	"Mon, 4 Dec 2006 22:51:23 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33309>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrTs7-0008A8-84 for gcvg-git@gmane.org; Tue, 05 Dec
 2006 07:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937125AbWLEGdc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 01:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937187AbWLEGdc
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 01:33:32 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:52529 "EHLO
 fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S937125AbWLEGdc (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 01:33:32 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061205063331.QBCC296.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Tue, 5
 Dec 2006 01:33:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id uuZg1V00W1kojtg0000000; Tue, 05 Dec 2006
 01:33:41 -0500
To: Theodore Tso <tytso@mit.edu>
Sender: git-owner@vger.kernel.org

Theodore Tso <tytso@mit.edu> writes:

> A second issue which you left unspecified is what should
> commit-working-tree-content do if the index != HEAD.  In particular,
> in this case:
>
> edit foo.c
> git update-index
> edit foo.c
> git commit-working-tree-content foo.c
>
> What should happen to foo.c in the index?  Should it be stay the same?
> Should the contents be replaced with version of foo.c that has just
> been commited?  The latter seems to make sense, but runs the risk of
> losing the data (what was in the index).  The former has the downside
> that the index might have a version of foo.c which is older than what
> has been just commited, which could be confusing.  Or should git
> commit-working-tree abort with an error message if index != HEAD?

That is exactly the "'commit --only' jumps the index" issue.

Updating the index with what is committed makes sense because
the commit after this --only commit happens builds on top of it,
and not doing so would mean the change to foo.c would be
reverted.  As you mentioned above, updating the index with the
committed version of foo.c means information loss of what was
staged earliser, and the traditional behaviour has been to
"abort with an error if index != HEAD" at that path, which was a
safety valve.

However, In the recent discussion, everybody (Linus, Nico, and I
included) seems to think this information loss is acceptable and
in fact is even useful.  I've sent a patch to remove the
obsolete safety valve for comments today, but haven't applied it
to any of my public branches yet, but most likely I will, and it
will happen sooner with encouragement from the list.
