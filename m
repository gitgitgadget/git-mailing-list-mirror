From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-stash: add flag to skip "git reset --hard"
Date: Mon, 02 May 2016 15:44:27 -0700
Message-ID: <xmqqbn4oqdv8.fsf@gitster.mtv.corp.google.com>
References: <57267BBE.9010707@google.com>
	<xmqqeg9kti6x.fsf@gitster.mtv.corp.google.com>
	<5727A6DF.5020204@google.com>
	<xmqqh9egs04d.fsf@gitster.mtv.corp.google.com>
	<5727BE65.3040004@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Tom Anderson <thomasanderson@google.com>
X-From: git-owner@vger.kernel.org Tue May 03 00:44:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axMZw-0002JS-2Z
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 00:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224AbcEBWob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 18:44:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57122 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755199AbcEBWob (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 18:44:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6214717230;
	Mon,  2 May 2016 18:44:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=olzyo+r08oCwoWmK6Vj86wqwOX8=; b=xlhRae
	HqxFYrd5IYb/iMWJjjKWdbTfyUhF077U4bSKGkB6UZ5DsBT2OdWrxV4s5BwyvSOU
	EXs4+iUEZiyFwT8xTrdyyKfY0STbX2Ot0MN3ny/djC0O33hdUOC/WXUqY+u0NNUz
	6LOQ+Y6vADTsHAW2FKcAePloAavqnbyshCMfk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KQHG5+agtL58/+WTwPt2CGikjWlcwxao
	r4tiJ7VDCI25t046wf0Euwbk5uotzPzkPTcaMOf5iIcIIpuMSn9rnhnjt4ODaIOo
	FRpC/Q0qJsGIrISU08fNK6Lq6TRzsf9nY8ah6rYt6bHHXXx1elr0w7bjzY4AsZFU
	YTDXQjaNGe0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5ACD01722F;
	Mon,  2 May 2016 18:44:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C86071722E;
	Mon,  2 May 2016 18:44:28 -0400 (EDT)
In-Reply-To: <5727BE65.3040004@google.com> (Tom Anderson's message of "Mon, 2
	May 2016 13:53:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6DC8DD78-10B7-11E6-8346-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293299>

Tom Anderson <thomasanderson@google.com> writes:

> On 05/02/2016 12:58 PM, Junio C Hamano wrote:
>> Tom Anderson <thomasanderson@google.com> writes:
>>
>>> Yes, but I like my stashes to be saved in the ref namespace.
>> Isn't that something you can do so yourself with store_stash?
>
> What I want can be achieved using "git stash store `git stash create`"

OK.

I am not strongly opposed to either a new option to create
(i.e. "create --store" stores a new stash entry) or a new
subcommand.

It just felt that a new option to "save" that deliberately breaks
the basic premise of the command, i.e. "my working tree is a mess,
and I want to revert it to the pristine state quickly to work on
something else that is urgent, but I want to store the mess away
instead of discarding, so that I can come back to it later", was
totally out of place.  I.e.

	work work work to create a mess
	git stash save
        work on a quick and urgent stuff, knowing that you are
        building on a solidly committed state
        git commit
        git stash pop
        continue building on the mess

is what "save" is about.

As your workflow is quite different (without "reset --hard", you no
longer can rely on the resulting state to be pristine, suitable to
work on something totally unrelated), it would have needed way way
more explanation in the description section to describe this quite
different mode of operation, as it is quite incompatible to the way
traditional "stash save" users would want to use the command for if
you do not revert the working tree to the pristine state.  Instead
you would do something else (which was not described--if the answer
is "keep working, leading to the creation of the next commit", it is
unclear what the resulting stash entry would be used for, as it
obviously won't apply to that state, as the stashed change is
already contained in that next commit).

"git stash save --keep" is bad enough already; it does not give the
user pristine state wrt the current HEAD--what it does is a pristine
state wrt the next HEAD that _would_ have resulted if the stuff
you've been working on and decided are good by doing "git add" is
all committed.  In hindsight, it may have deserved a separate
command to make it easier to explain to the end users.

Let's not make it worse.

This is a tangent, but I am not sure where your aversion to "reset
--hard" comes from.  If something was changed, mtime changes, and
otherwise your build would break.  It's not like "reset --hard"
touches mtime for every path in the working tree including unchanged
ones.
