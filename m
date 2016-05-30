From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 0/1] t6038-merge-text-auto.sh
Date: Mon, 30 May 2016 11:00:25 -0700
Message-ID: <xmqqzir7o286.fsf@gitster.mtv.corp.google.com>
References: <xmqq7fev55qk.fsf@gitster.mtv.corp.google.com>
	<1464627642-23994-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Mon May 30 20:00:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7RUQ-0004dK-Ir
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 20:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161717AbcE3SAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 14:00:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60116 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161249AbcE3SAa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 14:00:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 474B01EDAD;
	Mon, 30 May 2016 14:00:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hrGSpnrLO0QxijojPPz/zMJeHsU=; b=YkynoO
	rieq5jGSHoRzAaZx0Vl8Jf/LvhDcAykQI94Qg4hkYitdWQA9Rb9sFKLgWNjuMFmN
	ATiTjFAZxnA/6Yhhjja78lztq9Kv/cG3JEmkBOjZBM83a6g+SpDcnFjYKMyBwArx
	RyIBbBns2SbjaP3OndjZEV+AhFnQmr6DXQBgE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c5OeD8Qmb+OwQPtFrIFqvTxHJakVVDqV
	54/+qSRg2agauoAv9uz4xzCMnFPYtnsEgNWvurztLp144PRAlS0rrrUO3hFquBpS
	6rbm/eZhVSyjSpZMbaQRkXh4So4sch5L5CikCs9KghddPEl+4ROnXkI1k8bv2mby
	704q7+eJ4RA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3FD301EDA7;
	Mon, 30 May 2016 14:00:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B543A1EDA3;
	Mon, 30 May 2016 14:00:27 -0400 (EDT)
In-Reply-To: <1464627642-23994-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Mon, 30 May 2016 19:00:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 641397CA-2690-11E6-9099-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295914>

tboegi@web.de writes:

> This is a little bit of a hen-and-egg problem:
> The problem comes up after the "unified auto handling".
> In theory, it should have been since before:
> get_sha1_from_index() says:
>
>  * We might be in the middle of a merge, in which
>  * case we would read stage #2 (ours).
>
> This seams wrong, as in the merge we sometimes need to
> look at "theirs".

The two comment you quoted is absolutely the right thing to do.
"In a merge, we sometimes need to look at 'theirs'" is like saying
"When we are dong 'git add', we need to look at what is in the
working tree".  It is total red herring.

Step back and think why we even look at what in the index in the
first place; it is to decide if we want or do not want to disable
the automatic CRLF -> LF conversion.  And think again the reason why
do we look at the index.

There may be a line with CRLF line endings in the new contents,
whether it came from a merge, cherry-pick, patch application, or
plain-simple "git add" from the working tree.  Auto-CRLF usually
says "We want CRLF turned into LF".  But the user misconfigured and
for this path the user might not want the conversion take place, in
which case you would disable the conversion.  Where do you take that
hint "the user might have misconfigured?" from?  By looking at what
the user _started_ her update from.  If the state before this "we
need to replace the blob in the index with a new contents, so we
need to hash the new contents to come up with the updated blob"
started contains CRLF already, that may be a hint--if we apply the
CRLF->LF conversion on the original, even if the "new contents" were
identical to what she already had, we would end up changing the blob
with her current configuration.  Hence we disable.

Isn't that the reasoning behind that "safe auto-crlf" thing?

The new contents getting integrated into her current state may have
CRLF, and if a merge or a cherry-pick leaves conflicts, they may be
stored in stage #3.  But paying attention to that to decide if we
want to disable Auto-CRLF conversion is simply wrong; you should
look at the CRLF in stage #3 as purely something that might need to
be converted, not something that affects the decision if it needs to
be converted, just like you view CRLF in a working tree file when
you do "git add"..

Imagine that you started from a history where somebody recorded a
text file with CRLF in the blob, unconverted.  Later the project
decided to express their text with LF to support cross-platform
development better, and sets up the Auto-CRLF.  Your user is working
near the tip of that history after the eol correction happened.  Now
she gets a pull-request of a branch that forked from an old point in
the history, before the eol correction and full of CRLF.  Yes, to
integrate the change being proposed, she needs to look at "theirs";
that's the whole point of a "merge".  Why should she revert the eol
correction her history has by getting fooled by the fact that the
update was based on a part of the history before the eol correction?
