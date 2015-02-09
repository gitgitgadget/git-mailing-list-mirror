From: Sergey Organov <sorganov@gmail.com>
Subject: Re: 'git rebase' silently drops changes?
Date: Mon, 09 Feb 2015 15:53:54 +0300
Message-ID: <87oap38cv1.fsf@osv.gnss.ru>
References: <87386ispb3.fsf@osv.gnss.ru> <54D68455.5070305@gmail.com>
	<54D7696B.3060407@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Feb 09 13:54:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKnqk-0001bV-3F
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 13:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932866AbbBIMx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 07:53:58 -0500
Received: from mail.javad.com ([54.86.164.124]:56019 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932469AbbBIMx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 07:53:57 -0500
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 9FED562BF4;
	Mon,  9 Feb 2015 12:53:56 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <sorganov@gmail.com>)
	id 1YKnqc-0008Vx-RN; Mon, 09 Feb 2015 15:53:54 +0300
In-Reply-To: <54D7696B.3060407@kdbg.org> (Johannes Sixt's message of "Sun, 08
	Feb 2015 14:49:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263565>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 07.02.2015 um 22:32 schrieb Sebastian Schuberth:
>> On 06.02.2015 22:28, Sergey Organov wrote:
>> 
>>> # Now rebase my work.
>>> git rebase -f HEAD~1
>>>
>>> # What? Where is my "Precious" change in "a"???
>>> cat a
>>> </SCRIPT>
>>>
>>> I.e., the modification marked [!] was silently lost during rebase!
>> 
>> Just a wild guess: Maybe because you omitted "-p" / "--preserve-merges"
>> from "git rebase"?
>
> No, that would not help. --preserve-merges repeats the merge, but does
> not apply the amendment.

Really? Why? Here the valid concern you gave below doesn't even apply!

Check... yes, git silently drops amend even with --preserve-merges
(script to reproduce at the end[1])! How comes?

> It's just how rebase works: It omits merge commits when it linearizes
> history.
>
> Sergey, it is impossible for git rebase to decide to which rebased
> commit the amendement applies. It doesn't even try to guess. It's the
> responsibility of the user to apply the amendment to the correct
> commit.

Yeah, this sounds reasonable, /except/ git even gives no warning when it
drops amendments. Shouldn't 'git rebase' rather consider merge amendment
a kind of conflict?


[1] To reproduce amend drop by "git rebase --preserve-merges":

<SCRIPT>
git init t
cd t
git config rerere.enabled false # doesn't actually matter either way.

echo "I" > a; git add a
echo "I" > b; git add b
git commit -aqm "I"
git tag start

git checkout -b test

echo "B" >> b; git commit -m "B" -a

git checkout master

echo "A" >> a
git commit -aqm "A"

git merge --no-edit test
git branch -d test

# Clean merge, but result didn't compile, so I fixed it and
# amended the merge:
echo "Precious!" >> a # [!] This is modification that gets lost
git commit --amend --no-edit -aq
cat a

# Make a change earlier in history, to rebase my work on top of it.
git co -q start
git co -b test
echo "C" > c; git add c
git commit -aqm "C"

# Now rebase my work.
git co master
git rebase --preserve-merges --no-fork-point test

# What? Where is my "Precious" change in "a"???
cat a

</SCRIPT>

-- Sergey.
