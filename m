Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 487EA1F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 18:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbdCBSeL (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 13:34:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56308 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752011AbdCBSeK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 13:34:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C4CF83DAC;
        Thu,  2 Mar 2017 13:34:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tAxzQkcHv1XGu9BQaO8wPZaphrw=; b=wL5HRc
        LhdfxaTqnkgY3QdvErY5WnzQRGULxByTRRhPeL38UqaQ5XU9DuGpa1qMT+GseeIE
        1v9qbI9iNAAj+y9h0pFkZp4Svwq96cVYBBZMPULvweL0KgMlh6edBuQaNWLZYEJg
        D+4KAdEEzdASysI+rG9zqlDf5SqVrZk+Ae/Vw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hGjYoqOT02eL5ykLqeLI5smOcx9pRqpj
        A1tmoc/1mHi0g5PdsK13chDWnA2adizF1vml438NSilRhu1XB+55DeRbOJigI1cY
        PtQzMBw+cTrSeUNW8xlN1uNTLnq8JumPTwSQ+qCUthU/80C4OsO4fPPnceao1+YB
        5y+YhC/oLXo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6FCC783DAB;
        Thu,  2 Mar 2017 13:34:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3C6DF83DA8;
        Thu,  2 Mar 2017 13:34:01 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Crowe <mac@mcrowe.com>
Cc:     tboegi@web.de, git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 1/1] git diff --quiet exits with 1 on clean tree with CRLF conversions
References: <xmqqshmyhtnu.fsf@gitster.mtv.corp.google.com>
        <20170301170444.14274-1-tboegi@web.de>
        <xmqqr32gg0o6.fsf@gitster.mtv.corp.google.com>
        <xmqqa894fyst.fsf@gitster.mtv.corp.google.com>
        <20170302142056.GB7821@mcrowe.com>
Date:   Thu, 02 Mar 2017 10:33:59 -0800
In-Reply-To: <20170302142056.GB7821@mcrowe.com> (Mike Crowe's message of "Thu,
        2 Mar 2017 14:20:56 +0000")
Message-ID: <xmqqbmtjcyug.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE49D414-FF76-11E6-9FAF-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Crowe <mac@mcrowe.com> writes:

> All the solutions presented so far do cause a small change in behaviour
> when using git diff --quiet: they may now cause warning messages like:
>
>  warning: CRLF will be replaced by LF in crlf.txt.
>  The file will have its original line endings in your working directory.

That is actually a good thing, I think.  As the test modifies a file
that originally has "Hello\r\nWorld\r\n" in it to this:

>> +test_expect_success 'quiet diff works on file with line-ending change that has no effect on repository' '
>> +	printf "Hello\r\nWorld\n" >crlf.txt &&

If you did "git add" at this point, you would get the same warning,
because the lack of CR on the second line could well be a mistake
you may want to notice and fix before going forward.  Otherwise
you'd be losing information that _might_ matter to you (i.e. the
fact that the first line had CRLF while the second had LF) and it is
the whole point of safe_crlf setting.

I also think it is a good thing if "git status" reported this path
as modified for the same reason (I didn't actually check if that is
the case).
