From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/3] pre-merge-hook
Date: Fri, 07 Sep 2012 12:00:03 +0200
Message-ID: <5049C5A3.1000202@drmicha.warpmail.net>
References: <cover.1346851863.git.git@drmicha.warpmail.net> <7v8vcn68o9.fsf@alter.siamese.dyndns.org> <50485BCB.20607@drmicha.warpmail.net> <7vwr072e7a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 12:00:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9vMI-0003LG-Br
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 12:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760332Ab2IGKAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 06:00:08 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44739 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760298Ab2IGKAG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2012 06:00:06 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 77CA1211B6;
	Fri,  7 Sep 2012 06:00:05 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 07 Sep 2012 06:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=PAQc5UCO/BlnsWRGeI+2Lx
	3HR/g=; b=EH4LuURTGI5k/hytNg2J7rhFiBrtUCRgo7/tt585688s6y8RbrHlqS
	N+nS7Pez5LFUNipGQc/Lh2hpCpZAvkVt1mE0/iKp+HpzlprKuP8pTwFE0byLL7No
	WLdjpMeWSOqFHf/zh6x7Z8ypHDIYfordyFRmv6dURzJEq/8GdP54I=
X-Sasl-enc: zJSCb84iULztwNyoMJtqTrof/BvzQ/mZI2Qoff4BYTdk 1347012005
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id E015848255C;
	Fri,  7 Sep 2012 06:00:04 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7vwr072e7a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204956>

Junio C Hamano venit, vidit, dixit 06.09.2012 20:34:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Junio C Hamano venit, vidit, dixit 06.09.2012 07:07:
>>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>> 
>>>> The pre-commit hook is often used to ensure certain properties
>>>> of each comitted tree like formatting or coding standards,
>>>> validity (lint/make) or code quality (make test). But merges
>>>> introduce new commits unless they are fast forwards, and
>>>> therefore they can break these properties because the
>>>> pre-commit hook is not run by "git merge".
>>>> 
>>>> Introduce a pre-merge hook which works for (non ff, automatic)
>>>> merges like pre-commit does for commits. Typically this will
>>>> just call the pre-commit hook (like in the sample hook), but it
>>>> does not need to.
>>> 
>>> When your merge asks for a help from you to resolve conflict,
>>> you conclude with "git commit", and at that point, pre-commit
>>> hook will have a chance to reject it, presumably.  That means for
>>> any project that wants to audit a merge via hook, their
>>> pre-commit hook MUST be prepared to look at and judge a merge.
>>> Given that, is a separate hook that "can just call the pre-commit
>>> but does not need to" really needed and useful?
>>> 
>>> I admit that I haven't thought things through, but adding a
>>> boolean "merge.usePreCommitHook" smells like a more appropriate
>>> approach to me.
>>> 
>>> I dunno.
>> 
>> That would be an option ;)
> 
> I said "I dunno" as others may have opinions on the best direction to
> go.

Sure. I meant to make a pun the config option approach being an option.

>> Either works for me, and if we don't change the current behaviour 
>> (pre-commit-hook resp. no hook for non-automatic merges resp.
>> automatic merges) the config option is probably less confusing.
> 
> If we were to go in the "pre-commit has to be prepared to vet a merge
> already, so let it handle the automerge case" direction, I have
> another suggestion.
> 
> Because you need to support "merge --no-verify" to override the hook 
> anyway, I think it makes sense to introduce "merge --verify" to force
> it trigger the hook (and it needs to percolate up to "pull").
> 
> People who want it always on may want a boolean merge.verify, but 
> that should come in a separate step.  The patch that implements it 
> must make sure all our internal uses of "merge" is updated to pass 
> "--no-verify", unless there is a very good reason.

Hmm. Nothing calls cmd_merge() nor the relevant parts. "git pull" calls
"git merge" and should probably obey that option. All others (am etc.)
call git-merge-${strategy} directly and are not affected by the option.
Am I overlooking something?

> Another direction to go would be to deprecate the "commit is the way 
> to conclude a merge that stopped in the middle due to a conflict 
> asking for your help" and introduce "merge --continue" [*1*].  That 
> would open a way to a separate "pre/post-merge" hook much cleanly. At
> that point it would be clear that "pre-commit" won't be involved in
> "merge" (i.e. the user never will use "git commit" when merging).
> 
> I am fairly negative on the current mess imposed on "git commit" that
> has to know who called it and behave differently (look for "whence"
> in builtin/commit.c), and would rather not to see it made worse by
> piling "call pre-merge if exists and in a merge, or call pre-commit"
> kind of hack on top of it.

That is a mess, yes. Part of it is due to the fact that both
builtin/{commit,merge}.c do a lot of "commit stuff" in parallel, often
with copy & pasted code, and "commit" needs to be aware of other states
(in-am, in-rebase) also.

My feeling is that builtin/merge.c should rather get rid of the stuff
that parallels things that builtin/commit.c does, so that all is in one
place. (I think that redundancy is to blame for the inconsistent hook
behaviour for merges even within builtin/merge.c).

> [Footnote]
> 
> *1* This has been brought up a few times during discussion on 
> sequencer and mergy operations, and I think it makes sense in the 
> longer term.  "am" and "rebase" were first to use "--continue", 
> instead of having the user to use "commit" to conclude, and later 
> "cherry-pick" and "revert" have been updated to follow suit, so 
> "merge" may be the only oddball remaining now.

"git merge --continue" to commit a resolved merge, but code-wise
builtin/commit.c taking over because it's just one more case?

I afraid that restructuring is beyond my available Git capacity and my
self-imposed constraint to avoid anything with backwards compatibility
or migration plan issues. (I took this up because I thought it's within,
to share something I've been using for a while.)

I fully agree that a big-picture-solution is preferable.

Michael
