Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6052F203E1
	for <e@80x24.org>; Sun, 24 Jul 2016 15:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbcGXPvm (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 11:51:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58398 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751584AbcGXPvl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2016 11:51:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 17976286ED;
	Sun, 24 Jul 2016 11:51:40 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fwq9d2/7u4clLohUNYEbcpnZwPE=; b=UI8MN0
	lsmMM97kqNqddv3XHGurxrMquBqF9hmp23wG/JGiDmojKJQ404d11r18Gj8sZYdl
	pxBIM+byoa5RB8irmMzr6Np42Kfwy088meMST6JPHIrzDLCU+f5BOXwINsujFZuN
	4pY+V6wHb/23BDqnMkUeGhceBAR2m37v1dBWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NxItUZQgF9/Y4URYUBtutlEslXSXLDJO
	ehBGQYnn/W3voSqvLuY8RA38UUpRJpW8kd8e/6vJpFFuJMCdvrYXf5sP++5vg5e4
	XqVsyqvD+bVjQWBdoxw3ozZXGd7uZ2oBjpthSmlnaOS5sh1AZ7Ytu12dQvyN10yX
	CpEqtzCnugA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F2202286EB;
	Sun, 24 Jul 2016 11:51:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5D230286EA;
	Sun, 24 Jul 2016 11:51:39 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Eric Wong <e@80x24.org>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] format-patch: escape "From " lines recognized by mailsplit
References: <20160722224739.GA22961@whir>
	<xmqqk2gb8q81.fsf@gitster.mtv.corp.google.com>
Date:	Sun, 24 Jul 2016 08:51:37 -0700
In-Reply-To: <xmqqk2gb8q81.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sun, 24 Jul 2016 00:11:58 -0700")
Message-ID: <xmqqd1m3825y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8255BDFC-51B6-11E6-BADB-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Eric Wong <e@80x24.org> writes:
>
>> Users have mistakenly copied "From " lines into commit messages
>> in the past, and will certainly make the same mistakes in the
>> future.  Since not everyone uses mboxrd, yet, we should at least
>> prevent miss-split mails by always escaping "From " lines based
>> on the check used by mailsplit.
>>
>> mailsplit will not perform unescaping by default, yet, as it
>> could cause further invocations of format-patch from old
>> versions of git to generate bad output.  Propagating the mboxo
>> escaping is preferable to miss-split patches.  Unescaping may
>> still be performed via "--mboxrd".
>
> As a tool to produce mbox file, quoting like this in format-patch
> output may make sense, I would think, but shouldn't send-email undo
> this when sending individual patches?

Also, doesn't it break "git rebase" (non-interactive), or anything
that internally runs format-patch to individual files and then runs
am on each of them, anything that knows that each output file from
format-patch corresponds to a single change and there is no need to
split, badly if we do this unconditionally?

IOW, shouldn't this be an optional feature to format-patch that is
triggered by passing a new command line option that currently nobody
is passing?
