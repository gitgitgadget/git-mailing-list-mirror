Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C58571F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 03:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbfJHDLd (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 23:11:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55684 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbfJHDLd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 23:11:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8209F9913C;
        Mon,  7 Oct 2019 23:11:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9DZJ8Nrciltt0HtgGuQ5nuJRlRY=; b=nlOCoy
        8f5ktR/iVt00UWRFRYgvP/V95c8luwatiBKMrueYdH3VJiQmvFfSNMRnGlu2oCGS
        5aE0enjkPukRowYzCok0p87UicLGpw9YqYL/5JJikSI3AEhK1c+fBptG647acOY0
        esQ1cf2FlVndgFqN2gs6IRgQBtakcLktil0VI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=urdyMN3z7BGXcTzaeWI+nnKFvHnPx8pZ
        ZJmEvzV0JIQSj4R8iQkJjmqnm3kwAvJ52MtvVKe0xFA4ZP9qqA6enKvza1ukDJpH
        102UUNeuTWRylV5rS8muieC1BkYM2UYwJL1yqxsZF2LcoFALmJxkzSe6CS5+USN0
        DqzmFVaEWvU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 79C799913B;
        Mon,  7 Oct 2019 23:11:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A96C39913A;
        Mon,  7 Oct 2019 23:11:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        entwicklung@pengutronix.de
Subject: Re: Regression in v2.23
References: <20191007110645.7eljju2h6g7ts7lf@pengutronix.de>
        <20191007134831.GA74671@cat>
Date:   Tue, 08 Oct 2019 12:11:26 +0900
In-Reply-To: <20191007134831.GA74671@cat> (Thomas Gummerer's message of "Mon,
        7 Oct 2019 14:48:31 +0100")
Message-ID: <xmqqh84knd7l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51F8FE5E-E979-11E9-9571-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> We can however rely on 'patch.def_name' in that case, which is
> extracted from the 'diff --git' line and should be equal to
> 'patch.new_name'.  Use that instead to avoid the segfault.

This patch makes the way this function calls parse_git_diff_header()
more in line with the way how it is used by its original caller in
apply.c::find_header(), but not quite.

I have to wonder if we want to move a bit of code around so that
callers of parse_git_diff_header() do not have to worry about
def_name and can rely on new_name and old_name fields correctly
filled.

There was only one caller of the parse_git_diff_header() function
before range-diff.  The division of labour between find_header() and
parse_git_diff_header() did not make any difference to the consumers
of the new/old_name fields.  They only cared that they do not have
to worry about def_name.  But by calling parse_git_diff_header()
that forces the caller to worry about def_name (which is done by
find_header() to free its callers from doing so), range-diff took
responsibility of caring, which was suboptimal.  The interface could
have been a bit more cleaned up before we started to reuse it in the
new caller, and as this bug shows, it may be time to do so now, no?

Perhaps before returing, parse_git_diff_header() should fill the two
names with xstrdup() of def_name if (!old_name && !new_name &&
!!def_name); all other cases the existing caller and this new caller
would work unchanged correctly, no?
