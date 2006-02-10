From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Thu, 09 Feb 2006 16:35:44 -0800
Message-ID: <7v3bis59un.fsf@assigned-by-dhcp.cox.net>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05AA1FB3@scsmsx401.amr.corp.intel.com>
	<7v8xsk5a6k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 01:35:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7MGQ-00022C-0r
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 01:35:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWBJAfv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 19:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWBJAfv
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 19:35:51 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:5851 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750830AbWBJAfv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 19:35:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060210003416.HHBE6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 19:34:16 -0500
To: "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <7v8xsk5a6k.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 09 Feb 2006 16:28:35 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15847>

Junio C Hamano <junkio@cox.net> writes:

> "Luck, Tony" <tony.luck@intel.com> writes:
>
>> Looks very close to what I want.
>>
>>> git checkout topic
>>> git format-patch --stdout origin > topic-diff
>>
>>  topic-diff contains each commit as a separate message
>>
>>> $VISUAL topic-diff
>>> # Fix comments
>>
>>  so this needs some skill & care to rearrange the pieces
>>  and end up with legal input to git-am
>>
>> Perhaps I'd like to have:
>>
>>  git diff SHA-where-I-branched..HEAD
>>
>> but I don't see the way to compute the SHA-where-I-branched
>>
>> -Tony
>
> If what you want to end up with is a single commit, that is
> easy.
>
> If your topic branch is only "fork from master and never
> re-merge with master but just pile new commits on top of the
> tip, single strand of pearls" kind,
>
>         git-merge-base master topic
>
> would find the 'x' commit, where you forked from:
>
>                            "master"
>         ---x---o---o---o---o
>             \
>              o---o---o---o
>                           "topic"
>
> If you have "my topic will conflict with a change recently done
> in master so let's merge up from master to resolve conflict
> before going further" kind of merge commit on your topic branch,
> then you cannot have a single two-tree diff easily anyway, but
> in such a case, the following steps would work.
>
>                            "master"
>         ---o---o---o---o---o
>             \       \
>              o---o---*---o
>                           "topic"
>
>   (1) First merge "master" into "topic":
>
>         $ git checkout topic
>         $ git pull . master
>
>                            "master"
>         ---o---o---o---o---o
>             \       \       \ 
>              o---o---*---o---*
>                              "topic"
>
>       which would give you the rightmost '*' merge.
>
>   (2) Extract diff from "master" to '*':
>
>         $ git diff HEAD^2 HEAD >P.diff
>
>       HEAD^1 is previous "topic" head and HEAD^2 is what you
>       merged ("master").
>
>   (3) Pick commits only on "topic" branch but not on "master"
>
>         $ git rev-list --pretty --no-merges master..topic >P.log
>
>       This will pick up the three 'o' commits on the lower
>       development track and show their commit log message.
>
>
>   (4) Reset the "topic" branch to "master", and do the squashed
>       commit:
>
> 	$ git reset --hard master
>         $ git apply --index P.diff
>         $ git commit -F P.log -e
>
> This obviously would work equally well for single strand of
> pearls case.  Maybe you can package the above up, and send in a
> patch to add "git-squash" command?

I am stupid.  (4) can be done a lot more easily.  Do not do step
(2) -- you do not need a diff at all.  But do do step (3) to get
the logs.  Then:

	$ git reset --soft master
        $ git commit -F P.log -e

What --soft reset does is to keep the index and the working tree
as is, but just change the current branch head to point at the
named commit.  So, immediately after the above soft reset, your
commit ancestry graph looks like this:

                            "master"
         ---o---o---o---o---o
                            "topic"

and the last commit finally would give you:


                            "master"
         ---o---o---o---o---o
                             \
                              o
                              "topic"
