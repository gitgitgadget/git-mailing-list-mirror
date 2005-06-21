From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Patch (apply) vs. Pull
Date: Tue, 21 Jun 2005 15:09:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506211452110.2353@ppc970.osdl.org>
References: <1119284365.3926.15.camel@localhost.localdomain>
 <7vbr61j631.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Darrin Thompson <darrint@progeny.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 22 00:09:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dkqw5-0003Nh-Go
	for gcvg-git@gmane.org; Wed, 22 Jun 2005 00:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbVFUWOO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Jun 2005 18:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbVFUWLt
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jun 2005 18:11:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2487 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262380AbVFUWH3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jun 2005 18:07:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5LM7AjA019164
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 21 Jun 2005 15:07:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5LM77MZ031996;
	Tue, 21 Jun 2005 15:07:08 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr61j631.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 20 Jun 2005, Junio C Hamano wrote:
>
> FYI, here is what I have been doing:
> 
>  (1) Start from Linus HEAD.
> 
>  (2) Repeat develop-and-commit cycle.
> 
>  (3) Run "git format-patch" (not in Linus tree) to generate
>      patches.
> 
>  (4) Send them out and wait to see which one sticks.
> 
>  (5) Pull from Linus.
> 
>  (6) Throw away my HEAD, making Linus HEAD my HEAD, while
>      preserving changes I have made since I forked from him.  I
>      use "jit-rewind" for this.
> 
>  (7) Examine patches that Linus rejected, and apply ones that I
>      still consider good, making one commit per patch.  I use
>      "jit-patch" and "jit-commit -m" for this.
> 
>  (8) Go back to step 2.

Btw, I'd like to help automate the 6-7 stage with a different kind of 
merge logic.

The current "real merge" is the global history merge, and that's the kind
that I personally want to use, since that's what makes sense from a
"project lead" standpoint and for the people around me in the kernel space
that are project leaders of their own.

However, as you point out, it's not necessarily the best kind of merge for
the "individual developer" standpoint. Most individual developers don't
necessarily want to merge their work, rather they want to "bring it
forward" to the current tip. And I think git could help with that too.

It would be somewhat akin to the current git-merge-script, but instead of 
merging it based on the common parent, it would instead try to re-base all 
the local commits from the common parent onwards on top of the new remote 
head. That often makes more sense from the standpoint of a individual 
developer who wants to update his work to the remote head.

Something like this (this assumes FETCH_HEAD is the remote head that we 
just fetched with "git fetch xxx" and that we want to re-base to):

 - get the different HEAD info set up, and save the original head in 
   ORIG_HEAD, the way "git resolve" does for real merges:

	: ${GIT_DIR=.git}

	orig=$(git-rev-parse HEAD)
	new=$(git-rev-parse FETCH_HEAD)
	common=$(git-merge-base $orig $new)

	echo $orig > $GIT_DIR/ORIG_HEAD

 - fast-forward to the new HEAD. We'll want to re-base everything off 
   that. If that fails, exit out - we've got dirty state

	git-read-tree -m -u $orig $new && exit 1

 - for each commit that we had in our old tree but not in the common part, 
   try to re-base it:

	> FAILED_TO_CHERRYPICK
	for i in $(git-rev-list $orig ^$common)
	do
		git-cherry-pick $i ||
			(echo $i >> FAILED_TO_CHERRYPICK)
	done
	if [ -s FAILED_TO_CHERRYPICK ]; then
		echo Some commits could not be cherry-picked, check by hand:
		cat FAILED_TO_CHERRYPICK
	fi

and here the "git-cherry-pick" thing is just a script that basically takes
an old commit ID, and tries to re-apply it as a patch (with author data
and commit messages, of course) on top of the current head. It would 
basically be nothing more than a "git-diff-tree $1" followed by tryign to 
figure out whether it had already been applied or whether it can be 
applied now.

What do you think?

		Linus
