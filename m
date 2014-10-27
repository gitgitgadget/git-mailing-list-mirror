From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge & sequencer: turn "Conflicts:" hint into a comment
Date: Mon, 27 Oct 2014 10:32:15 -0700
Message-ID: <xmqqegttfmg0.fsf@gitster.dls.corp.google.com>
References: <xmqq1tpxgw6t.fsf@gitster.dls.corp.google.com>
	<xmqqvbn9f9ig.fsf@gitster.dls.corp.google.com>
	<xmqqr3xxf9ey.fsf_-_@gitster.dls.corp.google.com>
	<20141026185909.GC18144@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 27 18:32:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xio9c-00040t-Ir
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 18:32:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbaJ0RcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2014 13:32:24 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54822 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751081AbaJ0RcX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 13:32:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CBC4E18B36;
	Mon, 27 Oct 2014 13:32:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gpklmXpqRWHN8caYR1iFOsDMNT4=; b=gD26IK
	bINpUSyWjDrTbpc/BF4VexQiUOy3JbE/2R/dxZUIfjJ7xvc48mKaLWb+s7qwamhC
	mKa8r9v9Y+Hdx+ryC+3hW+3ijfOdJE0KgEJvU/okvg/IG6wPQgi9Ux8egQ0VUWkJ
	0dgjXpDEMNh8ckDBZXyHB77wUc0qRRHWcKwaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QBdvvDYzlCpJHl7vdHzt4yq8GRP/UTPb
	CeNmXrEBSPQfOy5dnicN4wp+J5KbyZljcdBFdY5cD+z7ayK6xAODVg9Ml+rs1dnp
	wYG0E4xc/gNVO1vHLBmXjGnh2V4wfiCHj8oDkirezQ3+NFzIGKePIVGYMGTzLnpr
	PXlSd4ThL4M=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C31B518B35;
	Mon, 27 Oct 2014 13:32:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 43BDB18B2F;
	Mon, 27 Oct 2014 13:32:17 -0400 (EDT)
In-Reply-To: <20141026185909.GC18144@peff.net> (Jeff King's message of "Sun,
	26 Oct 2014 11:59:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 327A3F12-5DFF-11E4-905F-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Just to play devil's advocate for a moment, though, are we hurting
> people who find it useful to record that information in the commit
> message?

I thought about it, but ultimately, they are using it wrong if they
did depend on them.  As you said, the paths themselves are not that
interesting, unless they are accompanied by description in the log
message explaining what caused conflicts and how they were resolved
at the semantic level.  The hints are to remind them what conflicts
in which paths to describe.

I do not mind "merge.commentConflictsHint = no" as a backward
compatibility toggle, if somebody cares deeply about it, though.

> If that is the only casualty, I think it is probably a net-win. We may
> want better tooling around viewing the merge later, but that can wait
> until somebody steps up with a real use case (because even that conflict
> list may not be completely what they want; they may also want the list
> of files that were auto-merged successfully, for example).

Yup.

Also Christian's "trailer" series may want to learn the same trick
we did to builtin/commit.c in this series, if it does not already
know about possible trailing comment and blank lines.

>> diff --git a/sequencer.c b/sequencer.c
>> index 0f84bbe..1d97da3 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -291,13 +291,12 @@ void append_conflicts_hint(struct strbuf *msgbuf)
>>  {
>>  	int i;
>>  
>> -	strbuf_addstr(msgbuf, "\nConflicts:\n");
>> +	strbuf_addch(msgbuf, '\n');
>> +	strbuf_commented_addf(msgbuf, "Conflicts:\n");
>>  	for (i = 0; i < active_nr;) {
>>  		const struct cache_entry *ce = active_cache[i++];
>>  		if (ce_stage(ce)) {
>> -			strbuf_addch(msgbuf, '\t');
>> -			strbuf_addstr(msgbuf, ce->name);
>> -			strbuf_addch(msgbuf, '\n');
>> +			strbuf_commented_addf(msgbuf, "\t%s\n", ce->name);
>
> This ends up adding a space followed by a tab. Besides being redundant,
> it makes my editor highlight it as a whitespace error. I realize this is
> a pretty minor nit, though.

Interesting ;-)

I do not think it is too hard to teach strbuf_commented_addf() about
the leading HT, but that would be a separate topic; if squashing the
SP-HT to HT is worth doing for this codepath, doing it at that helper
would benefit all callers.
