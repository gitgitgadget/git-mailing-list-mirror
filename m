X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-format-patch little gripe
Date: Fri, 03 Nov 2006 03:17:13 -0800
Message-ID: <7vwt6cbwzq.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90611030122reecee87ufac5bbaa910ee933@mail.gmail.com>
	<511753.217.qm@web31807.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 11:17:29 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <511753.217.qm@web31807.mail.mud.yahoo.com> (Luben Tuikov's
	message of "Fri, 3 Nov 2006 01:59:18 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30826>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfx30-00051e-U5 for gcvg-git@gmane.org; Fri, 03 Nov
 2006 12:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753218AbWKCLRP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 06:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753226AbWKCLRP
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 06:17:15 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:25231 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1753218AbWKCLRP
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 06:17:15 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103111714.DVVW13632.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Fri, 3
 Nov 2006 06:17:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id iBHJ1V00R1kojtg0000000 Fri, 03 Nov 2006
 06:17:19 -0500
To: Luben Tuikov <ltuikov@yahoo.com>
Sender: git-owner@vger.kernel.org

Luben Tuikov <ltuikov@yahoo.com> writes:

> But what wouldn't I give to have
>   git-format-_patch_ -o /tmp/ <commit>
> generate a _single_ patch just as its name implies...

It would have been nicer if you made that argument as a reply to
one of these messages:

http://thread.gmane.org/gmane.comp.version-control.git/4266/focus=4279
http://thread.gmane.org/gmane.comp.version-control.git/4843/focus=4843
http://thread.gmane.org/gmane.comp.version-control.git/5440/focus=5446

It is not an ideology; it is called not breaking existing UI,
which is rather unfortunate, because its UI is not the greatest
in the world.

Back when it was done, it was not clear that we would have a
rich set of revision set operations as "--since=2.weeks",
"from..to", or "this...that" as we have today.  Even though we
have them now, these set operations do not mesh very well with
the patch-id based filtering format-patch needs to do.

In order to exclude patches that you have as commits that have
not been _merged_ into your upstream, but the change they
contain have already been _applied_, you would need "the other
set" which is roughly "rev-list yours..upstream".  Some of your
patches (i.e. "rev-list upstream..yours") may have already
applied to the upstream but obviously as different commits, and
you would fiter them by comparing the patch-ids of them and
those from "the other set".  

Unfortunately, other than the recent addition "this...that",
none of the revision set operation would give us the "other set"
that is efficient to use ("all the commits that is older than 2
weeks" is an obvious "other set" for "--since=2.weeks", but that
set goes all the way down to the initial commit, which is
obviously not what we want).

One thing we talked about but nobody stepped up to code [*1*] is
to give "git-format-patch --stdin" that reads list of commits,
and runs "git-diff-tree --pretty --stat --summary -p $commit".
With that, we could do something like:

	git rev-list linus..orinoco | git format-patch --stdin

Your "git-format-patch --single $commit" is a shorthand for a
degenerated special case of that pattern.

You cannot do patch-id based filtering with this form, but I see
that "single" is often wanted on the list and #git, and people
who want it do not care about patch-id based filtering at all.
And I do not think it is that "they do not realize how much they
would be missing without patch-id filtering", in this case.  So
the above command line would probably be Ok.

With --left-right (in "pu"), you could even do something a bit
fancier like this:

	git rev-list --left-right linus...8139cp linus...airo |
	git format-patch --stdin

The --left-right output option, when used in conjunction with
the symmetric difference set operator, prefixes each commit with
'<' (left) or '>' (right) to indicate which ancestry it belongs
to (in the above example, the commits only in the branch that
tracks Linus but not in branches 8139cp or airo are prefixed
with '<', and commits on 8139cp or airo branches that have not
been merged in linus are prefixed with '>').  --stdin could use
that and take '<' as "the other set", i.e. the ones to base
filtering of '>' commits on, and output the commits that came
with '>' prefix (but subtracting the ones that have equivalent
patches in the '<' set).


[Footnote]

*1* format-patch is primarily the tool for a patch submitter,
and I did its original version back when I was one.  For a long
time (an equivalent to "eternity" in git timescale back then)
Linus did not show _any_ interest in it (you can compare the
dates on the messages I quoted above with the commit date of
0acfc972), and I suspect one of the reasons is because he was
the toplevel maintainer and did not have a need for a tool like
that.  Now I am the toplevel maintainer here and I haven't felt
the need to update it myself for quite some time ("it works for
me"), which is a bit sad.

