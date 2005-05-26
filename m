From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH Cogito] Fix cg-log -f behavior
Date: Thu, 26 May 2005 14:11:32 -0700
Message-ID: <7voeaxae0r.fsf@assigned-by-dhcp.cox.net>
References: <1117137826.12036.57.camel@pegasus>
	<7vk6llbv1j.fsf@assigned-by-dhcp.cox.net>
	<1117139740.12036.59.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu May 26 23:13:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbPeu-0008FC-CS
	for gcvg-git@gmane.org; Thu, 26 May 2005 23:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVEZVOA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 17:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbVEZVMm
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 17:12:42 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:35768 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261802AbVEZVLi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 17:11:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050526211131.NBRW12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 26 May 2005 17:11:31 -0400
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Petr Baudis <pasky@ucw.cz>, GIT Mailing List <git@vger.kernel.org>
In-Reply-To: <1117139740.12036.59.camel@pegasus> (Marcel Holtmann's message
 of "Thu, 26 May 2005 22:35:40 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "MH" == Marcel Holtmann <marcel@holtmann.org> writes:

MH> Hi Junio,

>> Doesn't that still break one-tree case (i.e. [ -z $tree2 ])?

MH> I am not sure, because I never tried it. Does it use a different format?

I am not a Cogito user, but I am a bit wondering if you have
read what is around what you are modifying.

	# List all files for for the initial commit
	if [ -z $tree2 ]; then
		list_cmd="git-ls-tree $tree1"
	else
		list_cmd="git-diff-tree -r $tree1 $tree2"
	fi
	echo
	$list_cmd | while read modes type sha1s file; do

The code you changed is fed by either git-ls-tree or
git-diff-tree, depending on whether you are talking about
initial commit.  git-ls-tree gives "mode type sha1 file".

This is why I asked Linus about a slight format change for
git-ls-tree (and git-ls-files) this morning.

Currently, there are three incompatible format floating around.

  - diff-* brothers show the metadata (separated internally with
    SP), TAB, and path.  If it is a rename diff, another TAB and
    path follow them.

  - ls-tree gives everything with TAB separated.

  - ls-files gives everything with SP separated.

The suggestion I made this morning is to make ls-tree and
ls-files use SP inside metadata and TAB before path.  If we
can agree on that is the way to go, then the output from these
commands would become:

  - diff-* brothers:

    mode SP mode SP sha1 SP sha1 SP status TAB path [ TAB path ]

  - ls-tree:

    mode SP kind SP sha1 TAB path

  - ls-files --stage :

    mode SP sha1 SP stage TAB path

What this means is the above piece of code can now be rewritten
to parse with something like this, and it does not matter what
command you have upstream:

	echo
	# List all files for for the initial commit
	if [ -z $tree2 ]; then
        	git-ls-tree "$tree1"
	else
		git-diff-tree -r "$tree1" "$tree2"
	fi |
        cut -f2 |
	while read file; do
            ...

Note that the above code is totally untested.  I do not use
"cut" myself and I am writing this in my e-mail buffer.




