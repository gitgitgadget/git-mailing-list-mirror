Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 746C520189
	for <e@80x24.org>; Wed, 22 Jun 2016 18:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbcFVSBE (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 14:01:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59516 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751927AbcFVSBD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 14:01:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D24A2256B2;
	Wed, 22 Jun 2016 14:01:01 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XaiHNOQCSbcgTwP8OLm6PhCROe4=; b=jJD2nH
	eHRcYoXe59ZvnYwHskH6JutQFAetodNeN9krxvHelI8ClJ5djkLpaVVGJtWVZSzU
	8JSnzxqWDGmg+elMsX51PSrmCfty/vRM/7u5mJoqSXP2ik/EnQY8MutosRQOyYr5
	d80HZT3ORd6sHEGTRw4CeRF7COwJsWTQdab3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XsVsbTsZv29KbYGXt7zqtUN7hAnHE7Tn
	N+WwdcCayDOph4H5nXl0/cbyTdEQCc2sSxxNeVP3HPY6SZUBPXta7FjJiIsI3MKD
	VEz4EX0BsBPwdS6zOYHoWqRVGac9HSnFlfaZCsNq2BcWTPr88eEMcrGkoFvgmHAG
	cODZzf3/SSc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CAB81256B1;
	Wed, 22 Jun 2016 14:01:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AF83C256AF;
	Wed, 22 Jun 2016 14:01:00 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Charles Bailey <charles@hashpling.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] grep: fix grepping for "intent to add" files
References: <20160621211412.28752-1-charles@hashpling.org>
	<20160621211412.28752-2-charles@hashpling.org>
	<xmqqinx2nonl.fsf@gitster.mtv.corp.google.com>
	<CACsJy8C9Dh_Owr3UFJnCtvXserG4V-e1ws8ZY52ME1yr+fefOw@mail.gmail.com>
Date:	Wed, 22 Jun 2016 11:00:58 -0700
In-Reply-To: <CACsJy8C9Dh_Owr3UFJnCtvXserG4V-e1ws8ZY52ME1yr+fefOw@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 22 Jun 2016 18:11:35 +0200")
Message-ID: <xmqqlh1xm7c5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47422204-38A3-11E6-8368-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> So I wonder if a better change would be more like
>>
>>         for (...) {
>>                 if (!S_ISREG(ce->ce_mode))
>>                         continue; /* not a regular file */
>>                 if (!ce_path_match(ce, pathspec, NULL)
>>                         continue; /* uninteresting */
>> +               if (cached && ce_intent_to_add(ce))
>> +                       continue; /* path not yet in the index */
>>
>>                 if (cached || ...)
>>                         UNCHANGED FROM THE ORIGINAL
>>
>> perhaps?
>
> I did wonder a bit about these cases. But, can i-t-a really be
> combined with CE_VALID or CE_SKIP_WORKTREE? CE_SKIP_... is
> automatically set and should not cover i-t-a entries imo (I didn't
> check the implementation). CE_VALID is about real entries, yes you
> could do "git update-index --assume-unchanged <ita-path>" but it does
> not feel right to me.

Yeah but we know people are stupid^W^Wdo unexpected things ;-)

> If cached is false and ce_ita() is true and either CE_VALID or
> CE_SKIP_WORKTREE is set, we would continue to grep an _empty_ SHA-1.
> But I think we should grep_file() instead, at least for CE_VALID.

Yes, that is the breakage I noticed in the patch under discussion
and that I wanted to fix in the "I wonder if a better change would
be..." version.
