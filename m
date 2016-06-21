Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FB5F1FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 19:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbcFUTTv (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 15:19:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51470 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750948AbcFUTTv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 15:19:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BDEFD2616E;
	Tue, 21 Jun 2016 15:06:02 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jA7Bkpd+85uzkuJW2ZFpRAQru00=; b=HKvOex
	fjrBvDKJaIRdxh7OaQdZxyp2uMHNcLgBgSIMoXqHHPZx89N1rOcdkrtV04/rAL0D
	aZWgbzfPCGb1BiBww9Lypz8rZSywUHPTf4/1d5uD/V7+eMU9rVsAJvla1f+GpqXH
	XXA0uTFhf1tsyX7LOCv02I57y0ewJvINKp5XM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lTnOH+rJVoJGafI0nxxpA/1Am85Hspxt
	/t1gl1a/c43NumJm5VYPh0k3VrGsohQuClfmGfQZRSw+KypULWamwhjlSnROF8EI
	il1GlVSk/TaRjt+tPLSoDFRe9ULuJOUmi3yNH5Q++0OrSj1jb2Binv3n1Hvot78t
	LYbqqlBhdHk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B2FC92616C;
	Tue, 21 Jun 2016 15:06:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2FD402616A;
	Tue, 21 Jun 2016 15:06:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v3 2/9] Disallow diffopt.close_file when using the log_tree machinery
References: <cover.1466420060.git.johannes.schindelin@gmx.de>
	<cover.1466505222.git.johannes.schindelin@gmx.de>
	<973f9f676225aa98377f607ced1ff474f39b863f.1466505222.git.johannes.schindelin@gmx.de>
	<xmqqfus6quii.fsf@gitster.mtv.corp.google.com>
Date:	Tue, 21 Jun 2016 12:05:59 -0700
In-Reply-To: <xmqqfus6quii.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 21 Jun 2016 11:14:29 -0700")
Message-ID: <xmqqlh1ypdk8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 32488188-37E3-11E6-93DD-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>> We are about to teach the log_tree machinery to reuse the diffopt.file
>> setting to output to a file stream different from stdout.
>>
>> This means that builtin am can no longer ask the diff machinery to
>> close the file when actually calling the log_tree machinery (which
>> wants to flush the very same file stream that would then already be
>> closed).
>
> Sorry for being slow, but I am not sure why the first paragraph has
> to mean the second paragraph.  This existing caller opens a new
> stream, sets .fp to it, and expects that the log_tree_commit() to
> close it if told by setting .close_file to true, all of which sounds
> sensible.
>
> If a codepath wants to use the same stream for two or more calls to
> log_tree by pointing the stream with .fp, it would be of course a
> problem for the caller to set .close_file to true in its first call,
> as .fp will be closed and no longer usable for second and subsequent
> call, and that would be a bug, but for a single-shot call it feels
> entirely a sensible request to make, no?
>
> Obviously you have looked at the codepaths involved a lot longer
> than I did, and I do not doubt your conclusion, but I cannot quite
> convince myself with the above explanation.
>
> The option parser of "git diff" family sets ->close_file to true
> when the --output option is given.
>
> Wouldn't this patch break "git log --output=foo -3"?

I wonder if the right approach is to stop using .close_file
everywhere.

With this "do not set .close_file if you use log_tree_commit()",
"git log --output=/dev/stdout -3" gets broken, but removing that
check is not sufficient to correct the same command with "-p", as
letting .close_file to close the output file after finishing a
single diff would mean that subsequent write to the same file
descriptor will trigger a failure.
