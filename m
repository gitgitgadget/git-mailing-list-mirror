From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH] Documentation/git-rebase.txt: fix -f description to match actual git behavior.
Date: Sat, 16 Aug 2014 00:14:43 +0400
Message-ID: <87ioltik7g.fsf@osv.gnss.ru>
References: <87bnrq22uf.fsf@osv.gnss.ru>
	<xmqq4mxh5w34.fsf@gitster.dls.corp.google.com>
	<xmqqzjf94f5n.fsf@gitster.dls.corp.google.com>
	<87d2c22cnx.fsf@osv.gnss.ru>
	<xmqq38cx1w0e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 22:15:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XINu6-0005gq-UM
	for gcvg-git-2@plane.gmane.org; Fri, 15 Aug 2014 22:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbaHOUOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2014 16:14:55 -0400
Received: from mail.javad.com ([54.86.164.124]:49119 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751138AbaHOUOq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2014 16:14:46 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 36A6D61865;
	Fri, 15 Aug 2014 20:14:45 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <sorganov@gmail.com>)
	id 1XINtb-0006ja-IV; Sat, 16 Aug 2014 00:14:43 +0400
In-Reply-To: <xmqq38cx1w0e.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 15 Aug 2014 10:51:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255303>

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>> ...
>>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>>> index 2a93c64..f14100a 100644
>>> --- a/Documentation/git-rebase.txt
>>> +++ b/Documentation/git-rebase.txt
>>> @@ -316,11 +316,8 @@ which makes little sense.
>>>  
>>>  -f::
>>>  --force-rebase::
>>> -	Force the rebase even if the current branch is a descendant
>>> -	of the commit you are rebasing onto.  Normally non-interactive rebase will
>>> -	exit with the message "Current branch is up to date" in such a
>>> -	situation.
>>> -	Incompatible with the --interactive option.
>>> +	Force a rebase even if the current branch is up-to-date and
>>> +	the command without `--force` would return without doing anything.
>>>  +
>>>  You may find this (or --no-ff with an interactive rebase) helpful after
>>>  reverting a topic branch merge, as this option recreates the topic branch with
>>
>> I dig more into it, and that's what I came up with, using some of your
>> suggestions as well.
>>
>> Please notice new text on essential interaction with --preserve-merges.
>>
>> I also thought about "Force the rebase that would otherwise be a no-op",
>> and while it is future-changes-agnostic indeed, it doesn't actually
>> explain anything, so I put some explanation back.
>
> A sentence "--force has no effect under --preserve-merges mode" does
> not tell the readers very much, either and leaves them wondering if
> it means "--preserve-merges mode always rebases every time it is
> asked, never noticing 'ah, the history is already in a good shape
> and there is no need to do anything further'" or "--preserve-merges
> mode ignores --force and refuses to recreate the history if the
> history is in the shape the mode deems is already desirable."

In fact there is no way to force rebase when --preserve-merges is given.
Neither --force nor --no-ff has any effect.

Maybe some clarification could be given in --preserve-merges
description, provided it's not clear that "has no effect" for --force
means that one can't force the rebase in this case.

> I think the root cause of the issue we share in this thread, when
> trying to come up with an improvement of this part, is that we are
> trying to put more explanation to the description of --force, but if
> we step back a bit, it may be that the explanation does not belong
> there.  As far as the readers are concerned, --force is about
> forcing a rebase that would not otherwise be a no-op, but the real
> issue is that the condition under which a requested rebase becomes a
> no-op, iow, "the history is already in the desired shape, nothing to
> do", is different from mode to mode, because "the desired shape" is
> what distinguishes the modes.  Preserve-merge rebase may think that
> a history that is descendant of the "onto" commit is already in the
> desired shape while plain-vanilla rebase does not if it has a merge
> in between, for example.

I think the root cause is even deeper, in the current design of the
rebase interface, but those my opinion you already know and I'll leave
discussion for another post that I currently try to formulate.

> The sentence that follows "Otherwise" in this version encourages the
> readers to be in a wrong mind-set that rebase is only about "making
> the branch a descendant of the 'onto' commit", which isn't the case.

I'm not happy with the wording myself either.

> The desired outcome depends on the mode (and that is why there are
> modes), and not saying that explicitly will only help spread the
> confusion, I am afraid.  Isn't it a better solution to explain what
> that no-op condition is for the mode at the place in the document
> where we describe each mode?
>
> E.g. under "--preserve-merges" heading, we may say "make sure the
> history is a descendant of the 'onto' commit; if it already is,
> nothing is done because there is no need to do anything" or
> something along that line.  The description for the plain-vanilla
> rebase may say "flatten the history on top of the 'onto' commit by
> replaying the changes in each non-merge commit; if the history is
> already a descendant of the 'onto' commit without any merge in
> between, nothing is done because there is no need to".
>
> That would make description of the modes more understandable, too.
> The users can read what kind of resulting history they can get out
> of by using each mode in one place.

I think you've lost me here, though I think that all the suggested
variants are still better than what is there right now.

-- 
Sergey.
