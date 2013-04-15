From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Mon, 15 Apr 2013 18:13:16 +0200
Message-ID: <vpqwqs3lqlf.fsf@grenoble-inp.fr>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
	<1365887729-9630-4-git-send-email-artagnon@gmail.com>
	<vpq38us2oov.fsf@grenoble-inp.fr>
	<CALkWK0mdC_tK2CGqAa67fr189PQCjSjzAOPujipOHFfoiYW0qA@mail.gmail.com>
	<vpqppxvoqsc.fsf@grenoble-inp.fr>
	<CALkWK0nqrw7DFQSnMvULYjJtBHRnadKWqCLQOAjzJH0o7USo+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 18:14:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URm3U-0000vB-AW
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 18:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755855Ab3DOQOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 12:14:52 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50844 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755853Ab3DOQOv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 12:14:51 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r3FGDE2e008485
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Apr 2013 18:13:15 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1URm1s-0003A3-Nh; Mon, 15 Apr 2013 18:13:16 +0200
In-Reply-To: <CALkWK0nqrw7DFQSnMvULYjJtBHRnadKWqCLQOAjzJH0o7USo+A@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 15 Apr 2013 19:26:41 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 15 Apr 2013 18:13:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r3FGDE2e008485
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1366647197.0558@K7K/1jm72iOADOV3YDP4LA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221243>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Matthieu Moy wrote:
>> AFAICT, "git merge --abort" is an alias for "git reset --merge"
>
> Yes, that is correct.
>
>> which
>> was precisely designed to reset only modifications comming from a merge,
>> and not the local changes that were present before the merge was
>> started. The man pages are relatively obscure on the subject, but I'd
>> call that a documentation bug.
>
> I see.  Either way, we need a clean worktree for it to work, no?

No, you don't. Just try if you're not convinced:

$ git checkout -b branch
Switched to a new branch 'branch'
$ date > test.txt && git commit -m 'on branch' test.txt
[branch 2482623] on branch
 1 file changed, 1 insertion(+), 1 deletion(-)
$ git checkout -
Switched to branch 'master'
$ date > test.txt && git commit -m 'on master' test.txt
[master c322d35] on master
 1 file changed, 1 insertion(+), 1 deletion(-)
$ date > other.txt 
$ git status
# On branch master
# Changes not staged for commit:
#
#       modified:   other.txt
#
no changes added to commit (use "git add" and/or "git commit -a")
$ git merge branch
Auto-merging test.txt
CONFLICT (content): Merge conflict in test.txt
Automatic merge failed; fix conflicts and then commit the result.
$ git status
# On branch master
# You have unmerged paths.
#
# Unmerged paths:
#
#       both modified:      test.txt
#
# Changes not staged for commit:
#
#       modified:   other.txt
#
no changes added to commit (use "git add" and/or "git commit -a")
$ git merge --abort
$ git status
# On branch master
# Changes not staged for commit:
#
#       modified:   other.txt
#
no changes added to commit (use "git add" and/or "git commit -a")
$ 

There may be corner-cases where it doesn't work, but I never encountered
such case.

>> It does. stashing means the user will have to "stash pop" later. One
>> extra step, one extra opportunity to forget something important.
>
> That's only if there are conflicts.  If there are conflicts, you'll
> have to stash anyway if:
> - You're doing a pull-merge and want merge --abort to work.

Again, no.

>> A minor annoyance is that it will touch files that have no reason to be
>> touched, hence may trigger extra rebuilds with "make", disturbing text
>> editors that have the file open, etc.
>
> Okay, I need to ask you something at this point: do you ever run merge
> on a dirty worktree unless you're absolutely sure that your local
> changes won't conflict with the changes introduced by the merge? 

Most of the time, I just run "git pull" or "git merge". I know it's
conservative enough, to it will stop if there's anything dangerous.

> That's only a pull-merge.  Unfortunately, making git-pull.sh uniform
> means that we have to fall back to the least-common-denominator of
> functionality (which is currently pull-rebase).

You may want to, but you don't have to. pull-merge and pull-rebase
already have different behavior in case of non-overlapping changes:

$ git pull --rebase . branch
Cannot pull with rebase: You have unstaged changes.
Please commit or stash them.
$ git pull --no-rebase . branch
From .
 * branch            branch     -> FETCH_HEAD
[...]

I don't see any reason to restrict to the common denominator in the same
situation for another feature.

I can accept the "it's too hard to implement" argument, but not "it
doesn't bring anything".

>> As a user, when I run "git rebase --continue" and it tells me it's done,
>> I expect the work to actually be done. This is the case today. This
>> won't be the case after autostash is introduced if the user has to
>> remember to run "stash pop" afterwards.
>
> And how will you implement that for merge, since there is no merge
> --continue to execute stash pop from?  Do you propose to make commit
> do the stash pop'ing?

No, I'm not proposing to do anything for merge. There's no reason to try
being uniform in conflict resolution for pull-merge and pull-rebase as
it is already different now. We already have "git rebase --continue", we
don't have "git merge --continue". So what? The fact that merge doesn't
have the equivalent doesn't mean we should not do something for "rebase
--continue".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
