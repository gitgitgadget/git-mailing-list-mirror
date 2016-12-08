Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29F2D1FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 18:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbcLHSWK (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 13:22:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55593 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751143AbcLHSWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 13:22:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD58653B64;
        Thu,  8 Dec 2016 13:22:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yLZObivrnIjJu3vl2Xvln9Jf75c=; b=uIcV1R
        6dmfNwL60A3NdpvDOWJIxX/dH3KGsnq1c3wVRJlNGBJCLv/ovEw5nIWJUw4JgjlU
        FWfbM5hI5dBBQnPqJyHskI8HM5imt6bUmj0dyBsZ3Fbb5FZmCRx5PVmBIgsTJbDo
        9qqU1CDgQ0aRxteHgDhV2q3TlE7YDhHfDkE9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fHLVmGFMumdiQxIWXBnXfK7Pd1NLxECK
        Cj8oJJk0r/Enl/cNvjBdOtcsQ2q87u5FsLz3qcaDaqH77lyUNa+qR1KNw7tbt6HI
        iPP+0vaCRfcRTcdEeumRYIzX8DPfxQg2zGcER+FNCyYI4VTIol5eaY4GyknvdgOH
        9N+T2L48iKg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D4D4153B62;
        Thu,  8 Dec 2016 13:22:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4061953B61;
        Thu,  8 Dec 2016 13:22:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Robbie Iannucci <iannucci@google.com>
Subject: Re: [PATCH 3/3] lockfile: LOCK_REPORT_ON_ERROR
References: <xmqqd1h3y506.fsf@gitster.mtv.corp.google.com>
        <20161207194105.25780-1-gitster@pobox.com>
        <20161207194105.25780-4-gitster@pobox.com>
        <alpine.DEB.2.20.1612081252490.23160@virtualbox>
Date:   Thu, 08 Dec 2016 10:22:06 -0800
In-Reply-To: <alpine.DEB.2.20.1612081252490.23160@virtualbox> (Johannes
        Schindelin's message of "Thu, 8 Dec 2016 12:53:39 +0100 (CET)")
Message-ID: <xmqqinquth69.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A90F5C6-BD73-11E6-BC83-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Sorry for the breakage.

Apologies from me, too.  Once a topic is merged, the credit still
remains with the contributor, but the blame is shared by the project
as a whole, with those who missed breakages during their reviews,
and those who didn't review or test and let breakages pass.

> When libifying the code, I tried to be careful to retain the error
> messages when not dying,...

Quite honestly, I do not think either of us cared about preserving
the exact error message the end-user was getting from each failure
sites that the series changed a call with die-on-error=1 to a call
with die-on-error=0 that is followed by a negative return while
reviewing this series.  As I wrote in the proposed log message for
3/3, this one was noticed as a end-user breaking change because it
was the only one that has become totally silent.  For example, this
bit from sequencer.c::write_message() we can see in the output from
"git show --first-parent 2a4062a4a8" does not preserve the message
at all:

    diff --git a/sequencer.c b/sequencer.c
    index 3804fa931d..eec8a60d6b 100644
    --- a/sequencer.c
    +++ b/sequencer.c
    @@ -180,17 +180,20 @@
    ...
    -static void write_message(struct strbuf *msgbuf, const char *filename)
    +static int write_message(struct strbuf *msgbuf, const char *filename)
     {
            static struct lock_file msg_file;

    -	int msg_fd = hold_lock_file_for_update(&msg_file, filename,
    -					       LOCK_DIE_ON_ERROR);
    +	int msg_fd = hold_lock_file_for_update(&msg_file, filename, 0);
    +	if (msg_fd < 0)
    +		return error_errno(_("Could not lock '%s'"), filename);

And I do not think it is necessarily bad that the error message
changed with this conversion.  In other words, I do not think it
should have been the goal to preserve the exact error message.
hold_lock*() can afford to give a detailed message that strongly
sounds as being the final decision when called with die-on-error=1
because it knows it is dying.  However, the message from the updated
write_message(), "could not lock", cannot be final---the caller may
want to add something else after it to describe what failed in a
larger picture.
