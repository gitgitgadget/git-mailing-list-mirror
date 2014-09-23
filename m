From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH] Documentation/git-rebase.txt: discuss --fork-point assumption of vanilla "git rebase" in DESCRIPTION.
Date: Tue, 23 Sep 2014 13:04:23 +0400
Message-ID: <87k34u9088.fsf@osv.gnss.ru>
References: <87r3z72wiu.fsf@osv.gnss.ru>
	<xmqqzjdrjvnd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 11:04:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWM1S-0002XF-4B
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 11:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221AbaIWJE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 05:04:29 -0400
Received: from mail.javad.com ([54.86.164.124]:51383 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754070AbaIWJE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 05:04:26 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 515B56186E;
	Tue, 23 Sep 2014 09:04:25 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <sorganov@gmail.com>)
	id 1XWM1H-0007sH-Ll; Tue, 23 Sep 2014 13:04:23 +0400
In-Reply-To: <xmqqzjdrjvnd.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 22 Sep 2014 12:35:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257406>

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Vanilla "git rebase" defaults to --fork-point that in some cases
>> makes behavior very different from "git rebase <upstream>",
>> where --no-fork-point is assumed. This fact was not mentioned in
>> the DESCRIPTION section of the manual page, even though the case of
>> omitted <upstream> was otherwise discussed. That in turn made actual
>> behavior of vanilla "git rebase" hardly discoverable.
>>
>> While we are at it, clarify the --fork-point description itself as well.
>>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  Documentation/git-rebase.txt | 18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>> index 4138554..73e1e1c 100644
>> --- a/Documentation/git-rebase.txt
>> +++ b/Documentation/git-rebase.txt
>> @@ -21,15 +21,16 @@ If <branch> is specified, 'git rebase' will perform an automatic
>>  it remains on the current branch.
>>  
>>  If <upstream> is not specified, the upstream configured in
>> -branch.<name>.remote and branch.<name>.merge options will be used; see
>> -linkgit:git-config[1] for details.  If you are currently not on any
>> -branch or if the current branch does not have a configured upstream,
>> -the rebase will abort.
>> +branch.<name>.remote and branch.<name>.merge options will be used (see
>> +linkgit:git-config[1] for details) and the `--fork-point` option is
>> +assumed.  If you are currently not on any branch or if the current
>> +branch does not have a configured upstream, the rebase will abort.
>
> OK.  When you do not tell rebase with respect to what exact _commit_
> the operation is to be done, then we will enable --fork-point, which
> makes perfect sense because it is clear that the user is rebasing
> with respect to a _branch_, for which we may find a place better
> than its current tip to rebase onto if we look at its reflog.

I think you meant to say that we may find a better source to calculate
the exact set of commits to rebase, as we still rebase onto the current
tip. I.e., with this we select what to rebase, not where (the latter
being handled by the --onto switch.)

> It is debatable if we should do the same when the user tells us to
> rebase with respect to a specific _branch_ by giving the 'upstream'
> argument, but that is an entirely separate issue.  We might want to
> do a similar command line heuristics to tell between the branch
> switching "git checkout master" (which is an operation about a
> branch) and head detaching "git checkout refs/heads/master^0" (which
> is an operation about a commit) if we want to help the users by
> auto-enabling fork-point mode.

Well, IMHO "git rebase" and "git rebase @{u}" must do exactly the same
thing. In its current state, when they have different default for
fork-point, it's too surprising. From this POV I do like suggested
heuristics to activate --fork-point when <upstream> (either specified or
figured from configuration) is a branch. However, it seems that this
would be functionally equivalent to just making the --fork-point the
default, unconditionally, as trying to find better fork-point in a
reflog for a non-reference will bring nothing anyway. The heuristics
could be considered an optimization, but it would optimize very rare
case.

On the other hand, I'm afraid different defaults were chosen for
backward compatibility?

>>  All changes made by commits in the current branch but that are not
>>  in <upstream> are saved to a temporary area.  This is the same set
>> -of commits that would be shown by `git log <upstream>..HEAD` (or
>> -`git log HEAD`, if --root is specified).
>> +of commits that would be shown by `git log <upstream>..HEAD`; or by
>> +`git log <fork_point>..HEAD`, if --fork-point is either specified or
>> +assumed; or by `git log HEAD`, if --root is specified.
>
> OK.  <fork_point> is a new term this patch introduces to this
> document.  Do we define what it is anywhere in this document, or
> would it help the readers to add something like "... where <fork_point>
> is computed in such and such way (see ... for details)"?

Yes, it's new and is not defined, but first I didn't want to overload
the DESCRIPTION with details, and second I don't know how it's actually
done, as it seems that "fork_point=$(git merge-base <upstream>
<branch>)" sometimes returns nothing, in which case fork_point is set
back to <upstream>? If we are going to describe it, I think it should go
to --fork-point option description.

Could you please suggest the wording?

>
>> @@ -331,9 +332,8 @@ link:howto/revert-a-faulty-merge.html[revert-a-faulty-merge How-To] for details)
>>  	between `upstream` and `branch` when calculating which commits have
>>  	have been introduced by `branch` (see linkgit:git-merge-base[1]).
>>  +
>> -If no non-option arguments are given on the command line, then the default is
>> -`--fork-point @{u}` otherwise the `upstream` argument is interpreted literally
>> -unless the `--fork-point` option is specified.
>> +If either <upstream> or --root is given on the command line, then the
>> +default is `--no-fork-point`, otherwise the default is `--fork-point`.
>
> Good.  The original, especially the mention of "@{u}", does not make
> any sense and updated text reads more clearly.
>
> Thanks.

BR,
-- Sergey.
