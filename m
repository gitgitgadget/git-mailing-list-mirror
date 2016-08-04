Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62D2620193
	for <e@80x24.org>; Thu,  4 Aug 2016 15:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933888AbcHDPqp (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 11:46:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54045 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756017AbcHDPqo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 11:46:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4047A30BC2;
	Thu,  4 Aug 2016 11:45:23 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ujxpU/K3Zdex2KsDdsiADkOmktc=; b=PRuI0F
	AKiRpCOKq21vwXcmodUECil4JXXvY6SeMgB2Nar8x4m+G0TnFmyaxZaEjHJAJVCj
	Qa4qUiRwyej4pWS5PK0OSR8W/nTNJ2c+pn80+xRnXJSKH/kccX+Ur3+ygIRBatt9
	eVkiaDo3ZXHr4ZYpwEEW3inUc56OcZHpmYghM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TpaaadeimZPBN8S+kA3477crywrXByDn
	z0tAmwWHe5ic8GpcEtEBFdOYOz0ZhlvLITwqitBNafrujQP/7mQStMpYucPnZwgw
	vMAE+knZwVv+bXBaHyVTeI8nHe9Kw3SQpCtMN3qalTJk9js1IEIvFgY3MbaSgxbp
	NVJIfPtl1b0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3777D30BBF;
	Thu,  4 Aug 2016 11:45:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9BE3A30BBE;
	Thu,  4 Aug 2016 11:45:22 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Pranit Bauva <pranit.bauva@gmail.com>
Cc:	Git List <git@vger.kernel.org>
Subject: Re: [RFC/PATCH v11 04/13] bisect--helper: `bisect_clean_state` shell function in C
References: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
	<0102015640423ce6-5b11201e-736d-413f-be12-7fed613ae484-000000@eu-west-1.amazonses.com>
	<xmqqy44fdpxd.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPNFohRLCS4piB1t0LO-=keucwzRKZ2Jyhhf234tnWnVGg@mail.gmail.com>
Date:	Thu, 04 Aug 2016 08:45:20 -0700
In-Reply-To: <CAFZEwPNFohRLCS4piB1t0LO-=keucwzRKZ2Jyhhf234tnWnVGg@mail.gmail.com>
	(Pranit Bauva's message of "Thu, 4 Aug 2016 01:57:54 +0530")
Message-ID: <xmqqr3a45yi7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7452C324-5A5A-11E6-A9AD-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

>> Also you do not seem to check the error from the function to smudge
>> the "result" you are returning from this function.
>
> Yes I should combine the results from every removal.
>
>> Isn't unlink_or_warn() more correct helper to use here?
>
> The shell code uses rm -f which is silent and it removes only if
> present.

Isn't that what unlink_or_warn() do?  Call unlink() and happily
return if unlink() succeeds or errors with ENOENT (i.e. path didn't
exist in the first place), but otherwise reports an error (imagine:
EPERM).

> So it makes me wonder which would be more appropriate
> unlink_or_warn() or remove_or_warn() or remove_path(). Is
> remove_path() different from its shell equivalent "rm -f"?

Read it again.

>>> +     remove_path(git_path_bisect_start());
>>
>> I can see that refs/files-backend.c misuses it already, but
>> remove_path() helper is about removing a path in the working tree,
>> together with any parent directory that becomes empty due to the
>> removal.  You do not expect $GIT_DIR/ to become an empty directory
>> after removing $GIT_DIR/BISECT_LOG nor want to rmdir $GIT_DIR even
>> if it becomes empty.  It is a wrong helper function to use here.
