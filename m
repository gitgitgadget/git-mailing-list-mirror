Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F4181FAFB
	for <e@80x24.org>; Mon, 10 Apr 2017 00:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752794AbdDJAVy (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Apr 2017 20:21:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60090 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752696AbdDJAVx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2017 20:21:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FBFF74AA8;
        Sun,  9 Apr 2017 20:21:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LSumqmkbt7btpwyhjYwx4G/JLi4=; b=V2oodQ
        ZoY00LBUixHcvuZRXU435OzOfvJeQ/s7MTCzU4fDr/QUJWvq9hQ8czBDHHRpBh4F
        +FJ9dl6NZPWIYFR4TxxK1AVl8DD+qH4F1cQzsp3mW/iXHzQ7gdplKtoWTPal2CYj
        oybKQVh0rk+t+yINTQazyFQWrmI96bP00KRPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P3+5I4ManDJWE9hfFSsy5uLEr3bRR03o
        5ynZ7As8RceUw9sX3dO9YwYoTqes8G5nc4P/TbCPxV5F0MzmQXN0juaiD/ZC8GtP
        YwJCzhl+xPbr2nQq84T8+rc8JTT2w4whyc18X7h1vCyMh6btJXi89YC0Yw3gBdfZ
        fAj8Ni7yieY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 83B0174AA7;
        Sun,  9 Apr 2017 20:21:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DE01A74AA6;
        Sun,  9 Apr 2017 20:21:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danny Sauer <danny@dannysauer.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make git log work for git CWD outside of work tree
References: <20170409022128.21337-1-danny@dannysauer.com>
        <alpine.DEB.2.20.1704091238560.4268@virtualbox>
        <413a1456-cac6-56c8-ea45-38f14cf958ae@dannysauer.com>
Date:   Sun, 09 Apr 2017 17:21:49 -0700
In-Reply-To: <413a1456-cac6-56c8-ea45-38f14cf958ae@dannysauer.com> (Danny
        Sauer's message of "Sun, 9 Apr 2017 09:15:36 -0500")
Message-ID: <xmqqvaqdqfhe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1380B22-1D83-11E7-A4EF-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Danny Sauer <danny@dannysauer.com> writes:

> That's feedback I was looking for - what's the "right" way to get the
> path to the file.

My knee-jerk reaction is that you SHOULDN'T have to do anything
special to "get the path".

I do not have the code in front of me (this is my "down" week after
all), so let me give the general outline of how to reason about
this, with the knowledge of code evolution of the system.

In the beginning, Git worked only from the top level of the working
tree.  If you have your project in ~/myproject with a file "f" in a
directory "d", that file is ~/myproject/d/f", and you would do

    $ cd ~/myproject
    $ git add d/f

to add it.  If Git wanted to access the index, it just accessed
".git/index" as a relative path.  If Git wanted to access a file at
the top of the working tree, say ".gitignore", it just accessed
".gitignore" as a relatlvei path.  Because it only worked from the
top.

Then we added a support for running Git from a subdirectory, so that
you can say "cd ~/myproject/d && git add f".  In order to keep the
existing code that wants to access the index as ".git/index" and
wants to access the top-level ".gitignore" as ".gitignore" working,
the support to run Git from a subdirectory is designed this way:

    - Each main program of subcommand (e.g. cmd_log()) receives a
      parameter "prefix", which tells what subdirectory you were in
      when you started Git.

    - Before running the main program of subcommand, Git chdir(2)s
      up to the top level of the working tree.

    - The main program of subcommand receives the command line from
      the user intact.  It is responsible for prepending the prefix
      to the path the user gave it from the command line.

So if you did "cd ~/myproject/d && git add f", Git goes up to
"~/myproject", passes argv=("f", NULL) and prefix="d/" to cmd_add().

Adding to the index wants to read and update the index, which is
still done by opening ".git/index" (relative to the toplevel as
before), and inspecting the top-level .gitigore file is done by
opening ".gitignore" (relative to the toplevel as before).  And
the cmd_add() forms the path "d/f" by using the prefix "d/" and the
user-supplied pathname "f".

When we first added a support for having the (equivalent of) ".git/"
directory outside the working tree by setting GIT_DIR environment
variable, again, you can only use Git from the top-level of the
working tree.  Instead of "~/myproject/.git", you can keep your
repository metainformation in say "~/mypro.git/" and point at it
with GIT_DIR environment variable, and said

    $ export GIT_DIR=~/mypro.git
    $ cd ~/myproject
    $ git add d/f

Later we also added GIT_WORK_TREE environment variable to be used
together with GIT_DIR so that you can start from ~/myproject/d, very
similarly to how you worked from a subdirectory without these
environment variables, i.e.

    $ export GIT_DIR=~/mypro.git GIT_WORK_TREE=~/myproject
    $ cd ~/myproject/d
    $ git add f

The way this support was added was to go to the top-level of the
working tree (i.e. "~/myproject" in this example) and passing the
prefix (i.e. "d" in this example).

Notice that in all of the above configurations, if a Git command
knows a path to something that is relative to the top of the working
tree (e.g. ".git/index" in the ancient Git, ".gitignore" at the
top-level that governs the entire working tree, or ".mailmap"), it
should just be able to open that path without asking "where is the
top of the working tree?".

So if your directory arrangement is a variation of these basic
configurations supported, e.g. if your git directory is
~/myproject/.git and your working tree is ~/myproject, and you use
the GIT_DIR and GIT_WORK_TREE to point at them, regardless of which
subdirectory of $GIT_WORK_TREE you started with, Git should already
have done chdir(2) to ~/myproject/ before it starts cmd_log(), and
it should be able to just open and read ".mailmap" (of course, it
needs to limit itself to do so only when it is working with a
repository with a working tree).

If your arrangement is even more exotic, e.g. you have these two
variables set, and then are running from OUTSIDE the working tree,
my knee-jerk reaction is that you should get your head examined, as
it is totally unclear what "git add foo" would mean if you did this:

    $ export GIT_DIR=~/myproject/.git GIT_WORK_TREE=~/myproject
    $ cd ~/myproject/../somewhere/else
    $ git add foo

But it should still "work" in the sense that the above command
should notice that you are trying to add "../somewhere/else/foo" to
the index, which is obviously nonsense, and die with a message.

Similarly, if you replace "git add foo" with "git log", it still
should work in the above, i.e.

    $ export GIT_DIR=~/myproject/.git GIT_WORK_TREE=~/myproject
    $ cd ~/myproject/../somewhere/else
    $ git log

If Git is not chdir(2)ing to ~/myproject before calling cmd_log()
in the above (again, this is my down week so I didn't and will not
check with the code myself), we may want to call that a bug and fix
it, so that you do not have to do anything special to get to the
path of ".mailmap" that is at the top-level.

