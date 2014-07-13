From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH RFC v2 03/19] rebase -i: reword executes pre-commit hook
 on interim commit
Date: Sun, 13 Jul 2014 13:00:44 +0200
Message-ID: <53C266DC.4050408@gmail.com>
References: <53A258D2.7080806@gmail.com>	<cover.1404323078.git.bafain@gmail.com>	<12171cf0323b3d10b12b02e3b7d42ff4b7964724.1404323078.git.bafain@gmail.com> <xmqqlhs38tub.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 13:01:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6HWn-0008Up-TU
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 13:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365AbaGMLBC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2014 07:01:02 -0400
Received: from mail-qc0-f172.google.com ([209.85.216.172]:64845 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911AbaGMLAs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 07:00:48 -0400
Received: by mail-qc0-f172.google.com with SMTP id l6so2528047qcy.17
        for <git@vger.kernel.org>; Sun, 13 Jul 2014 04:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=GMMTC7b9UWkfHHxQnt/WuJNZfcNJUZep3w2q2+fZEPw=;
        b=K2C6GXQ07GL8CPb2cghhlF/vCqNG3i7UG9ypex/FvqGjvIJ2DU+xrJ+fIt67GTOt5b
         w9DiN4QPZupduF1T48VgRr3gXDn+foMPOYQ9+jmtqSIUPyh7Hg/QnRDZDRqZ6YRNwJEw
         3Utj+cFJVPvylIEARgv6TRfDO1bUSo4WcD/KNuoN+nbHlg5KO4tQ4fBXrqdlb0ef04pl
         PqWrRHHR/8iyAHPUa1EfG3p/7zPK9h0ZPO9KEhfPBim2b2tMm1nxMfyLfQFqukkTJUni
         q4ZTvVWBMc0GuXofKSCsU9l8f08SjEmZcsGUyeKaThAcO+JbF8pU/Udo6EdqED4y2Gea
         3H+w==
X-Received: by 10.224.4.73 with SMTP id 9mr13948807qaq.12.1405249247271;
        Sun, 13 Jul 2014 04:00:47 -0700 (PDT)
Received: from client.googlemail.com (HSI-KBW-078-042-067-235.hsi3.kabel-badenwuerttemberg.de. [78.42.67.235])
        by mx.google.com with ESMTPSA id f23sm3413411qge.10.2014.07.13.04.00.45
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jul 2014 04:00:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqlhs38tub.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253447>

Hi Junio,

Junio C Hamano writes:
> Fabian Ruch <bafain@gmail.com> writes:
>> The to-do list command `reword` replays a commit like `pick` but lets
>> the user also edit the commit's log message. This happens in two
>> steps. Firstly, the named commit is cherry-picked. Secondly, the
>> commit created in the first step is amended using an unchanged index
>> to edit the log message. The pre-commit hook is meant to verify the
>> changes introduced by a commit (for instance, catching inserted
>> trailing white space). Since the committed tree is not changed
>> between the two steps, do not execute the pre-commit hook in the
>> second step.
> 
> It is not like the second step is built as a child commit of the
> result from the first step, recording the same tree without any
> change.  Why is it a good thing not to run the pre-commit hook (or
> other hooks for that matter)?  After all, the result of the second
> step is what is recorded in the final history; it just feels wrong
> not to test that one, even if it were a good idea to test only once.

if I understand correctly, the tree of the (amended) commit isn't tested
at all by git-rebase--interactive because git-cherry-pick, and therefore
pick_one, commits with both the pre-commit and commit-msg hook disabled
(see the "git commit -n" command line being built in
sequencer.c#run_git_commit since revision 9fa4db5).

The "commit --amend" we are concerned with here amends using an
untouched tree so that the history ought to record exactly the same
trees as prior to "commit --amend". If git-cherry-pick was testing the
tree, then it would be unnecessary to test the tree a second time. Since
git-cherry-pick is not testing as of yet, testing and possibly rejecting
a tree in the second step would actually be wrong. I totally neglected
to look for a test case when I submitted this patch, so I'd like to
supply one late now:

> test_expect_success 'reword a commit violating pre-commit' '
> 	mkdir -p .git/hooks &&
> 	PRE_COMMIT=.git/hooks/pre-commit &&
> 	cat >"$PRE_COMMIT" <<EOF
> #!/bin/sh
> echo running pre-commit
> exit 1
> EOF
> 	chmod +x "$PRE_COMMIT" &&
> 	test_must_fail test_commit file &&
> 	test_commit --no-verify file &&
> 	set_fake_editor &&
> 	FAKE_LINES="pick 1" git rebase -i HEAD^ &&
> 	FAKE_LINES="pick 1" git rebase -i --no-ff HEAD^ &&
> 	FAKE_LINES="reword 1" git rebase -i HEAD^
> '

(This addition to t3404-rebase--interactive.sh is based on the test case
"rebase a commit violating pre-commit"; "test_commit --no-verify" will
be implemented the obvious way.)

In both cases, it's correct to disable the pre-commit hook when editing
the log message and it just makes sense to test changes where you make
them. Unfortunately, it is not obvious that "git commit --amend" merely
edits the log message rather than committing a new tree.

For what it's worth, if we were to create an empty child commit and
squash it into the parent instead of amending immediately, then
git-rebase--interactive would disable tree verification in the second
step as well. This behaviour was introduced by commit c5b09fe. Although
the change seems to have been triggered by something completely
different back then, the correctness criterion remains the same, i.e.
recording previously committed trees.

Best regards,
   Fabian

>> Specify the git-commit option `--no-verify` to disable the pre-commit
>> hook when editing the log message. Because `--no-verify` also skips
>> the commit-msg hook, execute the hook from within
>> git-rebase--interactive after the commit is created. Fortunately, the
>> commit message is still available in `$GIT_DIR/COMMIT_EDITMSG` after
>> git-commit terminates. Caveat: In case the commit-msg hook finds the
>> new log message ill-formatted, the user is only notified of the
>> failed commit-msg hook but the log message is used for the commit
>> anyway. git-commit ought to offer more fine-grained control over
>> which hooks are executed.
>>
>> Signed-off-by: Fabian Ruch <bafain@gmail.com>
>> ---
>>  git-rebase--interactive.sh | 17 +++++++++++++----
>>  1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>> index 689400e..b50770d 100644
>> --- a/git-rebase--interactive.sh
>> +++ b/git-rebase--interactive.sh
>> @@ -504,10 +504,19 @@ do_next () {
>>  
>>  		mark_action_done
>>  		do_pick $sha1 "$rest"
>> -		git commit --allow-empty --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} || {
>> -			warn "Could not amend commit after successfully picking $sha1... $rest"
>> -			exit_with_patch $sha1 1
>> -		}
>> +		# TODO: Work around the fact that git-commit lets us
>> +		# disable either both the pre-commit and the commit-msg
>> +		# hook or none. Disable the pre-commit hook because the
>> +		# tree is left unchanged but run the commit-msg hook
>> +		# from here because the log message is altered.
>> +		git commit --allow-empty --amend --no-post-rewrite -n ${gpg_sign_opt:+"$gpg_sign_opt"} &&
>> +			if test -x "$GIT_DIR"/hooks/commit-msg
>> +			then
>> +				"$GIT_DIR"/hooks/commit-msg "$GIT_DIR"/COMMIT_EDITMSG
>> +			fi || {
>> +				warn "Could not amend commit after successfully picking $sha1... $rest"
>> +				exit_with_patch $sha1 1
>> +			}
>>  		record_in_rewritten $sha1
>>  		;;
>>  	edit|e)
