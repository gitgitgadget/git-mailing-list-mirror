From: Junio C Hamano <junkio@cox.net>
Subject: (Unsolicited hint) straightening out stray "git bisect"
Date: Wed, 09 Aug 2006 12:30:32 -0700
Message-ID: <7vodut3dwn.fsf_-_@assigned-by-dhcp.cox.net>
References: <ebcnml$btf$1@sea.gmane.org>
	<7vfyg54vjb.fsf@assigned-by-dhcp.cox.net>
	<7vbqqt4vct.fsf@assigned-by-dhcp.cox.net>
	<7vwt9h3e35.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Aug 09 21:30:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAtlF-0008Hj-43
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 21:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWHITae (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 15:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWHITae
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 15:30:34 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:20910 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751147AbWHITae (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Aug 2006 15:30:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060809193033.VKV23903.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Aug 2006 15:30:33 -0400
To: git@vger.kernel.org
In-Reply-To: <7vwt9h3e35.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 09 Aug 2006 12:26:38 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25136>

Junio C Hamano <junkio@cox.net> writes:

> Junio C Hamano <junkio@cox.net> writes:
>
>> Junio C Hamano <junkio@cox.net> writes:
>>
>>> Jakub Narebski <jnareb@gmail.com> writes:
>>>
>>>> First (noticed by matled) is that for git-diff-tree with single tree
>>>> as an argument it outputs fist commit-id of commit given at input. 
>>>> It is not mentioned in documentation and I think totally unnecessary:
>>>>
>>>> 1038:jnareb@roke:~/git> git diff-tree --abbrev origin
>>>> d5dc6a76d49367cddc015e01d2e9aa22e64d7e28
>>>> :040000 040000 44fb36d... 1c26294... M  Documentation
>>>
> Turns out that git-diff-tree from 1.0.0 behaves this way.  Since
> 7384889 (May 18, 2005), one-tree form of diff-tree showed the
> "header" line that has the commit object name at the top, and
> since 1809266 (Jun 23, 2005) we have exactly one commit object
> name there; before that we used to say "commitA (from commitB)".

BTW, I got curious and run "git bisect" to see when the " (from
commitB)" was dropped.  This turned out to be quite an
interesting one.  You would start from these:

        $ git bisect start
        $ git bisect good 7384889 ;# this said "( from commitB)"
        $ git bisect bad v1.0.0   ;# we know this did not

and keep building and testing "git-diff-tree", to mark the ones
that do not say "( from commitB)" as bad and the ones that do as
good.

At some point, it crosses the "coolest merge ever" and suggests
c2f6a02 to be checked, which is on the original "gitk" branch.
There is no way to build git-diff-tree in that revision ;-).

At this point, "visualize" helps.

	$ git bisect visualize

shows (pardon the ASCII art):

    *--bisect/bad git-rev-list: add option to list all objects
    *  git-rev-parse: re-organize and be more careful
    .
    *  Do a cross-project merge of Paul Mackerras' gitk visualizer 
    |* Try to assign colors so crossing lines have different colors
    |* Account for indentation of the checkin commments by git-rev-list
    |.
    |*-bisect Show heads as well as tags
    |.
    |* Add initial version of gitk to the CVS repository
    o--bisect/good-fae22ac [PATCH] git-apply: tests for --stat and --summary.

Now, we know that gitk did not have diff-tree, so up to the
commit "Try to assign colors..." are irrelevant to the "bug" we
are hunting.  We say:

	$ git bisect good 6c20ff3

(where 6c20ff3 is the commit "Try to assign colors...") to mark
everything leading to that commit (ones on the line on the right
hand side in the above ASCII graph) are good.  After that bisect
continues normally.
