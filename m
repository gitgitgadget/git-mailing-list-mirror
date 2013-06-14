From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] pull: respect rebase.autostash
Date: Fri, 14 Jun 2013 11:26:11 -0700
Message-ID: <7vk3lwo8fw.fsf@alter.siamese.dyndns.org>
References: <1371200178-9927-1-git-send-email-artagnon@gmail.com>
	<1371200178-9927-2-git-send-email-artagnon@gmail.com>
	<vpqfvwlkqb5.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 14 20:26:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnYhX-0008VL-BU
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 20:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586Ab3FNS0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 14:26:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46676 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753560Ab3FNS0O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 14:26:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5816F272BB;
	Fri, 14 Jun 2013 18:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6fJCQg9bIW4bDgkOyqGHCmkK/bQ=; b=DVhy9I
	n9E6tVV7bZ018ijDZ7OKsvq6QsMMuZvE4ZM4IGCUBW51el0a06N8zVN9UcAWrrc9
	PA+TOHDpGcXaJofuXvB06DnJMhqSJG/vupckj7EV91FCAxlOHy5nRf7KtFXn0Z6j
	LIB13PRaRTTpUd8YLcB0THlJIFPQBefzY8SF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LYOUWzRHMT6ERWgTI6KwXeeXLXdE0/dg
	xNjpDCd0wJ3VwdpPOv+IHlUbzpFZyz0upEAvWmjCSK0hVcz8EEdM6sxUL+zl3yIj
	P4D4js0K9fOzbbD3md5eqIfnAzs1fWDjLRbYl7Jb7LTsPF3EHGaTDDbpgm1QBjao
	TtcMfbpHiOg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C00B272BA;
	Fri, 14 Jun 2013 18:26:14 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D8A31272B7;
	Fri, 14 Jun 2013 18:26:12 +0000 (UTC)
In-Reply-To: <vpqfvwlkqb5.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	14 Jun 2013 11:13:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E483C8D2-D51F-11E2-ABFA-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227909>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> --- a/git-pull.sh
>> +++ b/git-pull.sh
>> @@ -44,6 +44,7 @@ merge_args= edit=
>>  curr_branch=$(git symbolic-ref -q HEAD)
>>  curr_branch_short="${curr_branch#refs/heads/}"
>>  rebase=$(git config --bool branch.$curr_branch_short.rebase)
>> +autostash=$(git config --bool rebase.autostash)
>>  if test -z "$rebase"
>>  then
>>  	rebase=$(git config --bool pull.rebase)
>> @@ -203,6 +204,7 @@ test true = "$rebase" && {
>>  			die "$(gettext "updating an unborn branch with changes added to the index")"
>>  		fi
>>  	else
>> +		test true = "$autostash" ||
>>  		require_clean_work_tree "pull with rebase" "Please commit or stash them."
>
> Trivial, indeed!
>
> It would be nice to have an --autostash command-line option too, and the
> error message in "require_clean_work_tree" could suggest using it. That
> would make the feature easily discoverable.

I would actually suggest doing this the other way around.  --autostash
option, followed by configuration if needed.

I actually have this slight suspicion that rebase.autostash and
pull.autostash may want to be separate variables.  Attempting to
rebase locally when your working tree is in half-baked state is bad
enough but may be warranted in some workflows, but doing so when
integrating with other people's work is a practice in a different
league. It would be quite sensible for somebody to want to allow the
former (i.e. allows autostash with rebase.autostash=true for local
rebase) while retaining the safety of the latter (i.e. stop pulling
with pull.autostash=false).

> Perhaps this patch could mention "pull --rebase" in the doc, like (config.txt)
>
> - 	ends.  This means that you can run rebase on a dirty worktree.
> + 	ends.  This means that you can run rebase or `git pull --rebase` on a dirty worktree.
>
> (or perhaps it's obvious enough and not needed)
