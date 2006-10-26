X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: StGIT and rerere
Date: Thu, 26 Oct 2006 10:21:55 -0700
Message-ID: <7vfydbkn64.fsf@assigned-by-dhcp.cox.net>
References: <200610210039.10215.robin.rosenberg.lists@dewire.com>
	<tnxu01r2fzv.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 17:22:26 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30244>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd8vY-00030M-PK for gcvg-git@gmane.org; Thu, 26 Oct
 2006 19:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423627AbWJZRV5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 13:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423629AbWJZRV5
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 13:21:57 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:54220 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S1423627AbWJZRV4
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 13:21:56 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061026172155.JBQI6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>; Thu, 26
 Oct 2006 13:21:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id f5Me1V0051kojtg0000000 Thu, 26 Oct 2006
 13:21:38 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

Catalin Marinas <catalin.marinas@arm.com> writes:

> I didn't know it exists. I've been thinking at a way to avoid
> duplicating the conflict fixing but haven't got to any results. This
> looks like a good idea.
> ...
> My problem was with maintaining a public branch where re-basing
> patches is not welcomed but I would still like to use StGIT in my
> development branch. When pulling from upstream in my devel branch, I
> get conflicts in some patches. The problem is that I get the same
> conflicts in the patches already merged in the public branch where the
> patches were previously checked in.
>
> Another case is several branches with common patches that generate
> conflicts.
> ...
> Note, however, that I haven't looked at how git-rerere works and I
> might have misunderstood its functionality.

I think Documentation/git-rerere.txt describes its operation in
enough details for the end user, but if there is anything
unclear please ask away.

There are two details that are not mentoined in the end-user
documentation.

* Identifying "same" conflicts.

This is done by hashing the text inside the conflict markers:

	<<<<<<<
        a
        =======
	b
        >>>>>>>

Each conflicted section like the above are first canonicalized
so that section "a" sorts alphabetically earlier than section
"b" (in other words, if the conflict were <<< b === a >>> then
they are swapped to read <<< a === b >>>), concatenated and fed
into SHA-1 digest.  The final digest after conflicted file is
read as a whole becomes the name of the conflict, and naming is
done per file.

The reason for this canonicalization is because the order in the
conflicted section depends on the direction of the merge (if
you pull test into master you get the conflict marked the other
way from the case you pulled master into test).

* rerere's resolution can affect outside conflict markers.

If an earlier conflict read like this:

	...
	z
	<<<<<<<
        a
        =======
        b
        >>>>>>>
        c
	d
	e
        f
        g
	...
        
and your earlier resolution was like this:

	...
	w
        b
        dd
        e
        f
        g
	...

That is what rerere records (i.e. including removal of c and
change from z to w).

Then, when you see the same conflict like this (notice that g is
now h):

	...
	z
	<<<<<<<
        a
        =======
        b
        >>>>>>>
        c
	d
	e
        f
        h
	...

it is resolved like this:

	...
	w
        b
        d
        e
        f
        h
	...

This is often useful when e.g. a <<< === >>> section changes
function signature of a (static) function; parts outside the
conflicted section needs matching changes to adjust to it and
that is recorded and replayed by rerere.
