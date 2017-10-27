Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70CCF1FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 16:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbdJ0Qf6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 12:35:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56986 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751145AbdJ0Qf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 12:35:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92C8AB8D69;
        Fri, 27 Oct 2017 12:35:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wUdRfJRHrlCv+kMCqK1H+L9Ma2E=; b=xG9axD
        d4nNJxpXYeIntNR7U7d2FuKOJr4ZXrllhAtzAZUrRT30UMj0P3Dor14pj5XgRLS6
        lustnlxdIzsVGEcFyVnhwqrLbPjRMmhhbUyrdwSzpkjMdhlwKtwxvaNykq+Vbr1a
        2Y8/fu3WtVCoW5hCmhSuKcSCKrLFRot+kFrx0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o/VZwMgL5O8aTQ7YcJYHZAQ57FxIMywI
        El+R+BFJy/rSwpnWgkG1aNM+wMlnrFelR3M0nPrZdXA5jFfsMTp5p2k22lvf4CRW
        oi8YH5i2fb49GvlgUUt/sssidFZklD86XgJgSJY7bmroIsswoM0yvShWy+9kGu03
        JN7tfT2KMlc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B77CB8D68;
        Fri, 27 Oct 2017 12:35:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 01AABB8D67;
        Fri, 27 Oct 2017 12:35:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrey Okoshkin <a.okoshkin@samsung.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>, pclouds@gmail.com,
        Ivan Arishchenko <i.arishchenk@samsung.com>
Subject: Re: [PATCH] diff: fix lstat() error handling in diff_populate_filespec()
References: <CGME20171027093331epcas2p1a945263c12b8ba608492693da4e3eff2@epcas2p1.samsung.com>
        <72e8146b-d4ab-ad7e-6afd-9168806eeca2@samsung.com>
Date:   Sat, 28 Oct 2017 01:35:54 +0900
In-Reply-To: <72e8146b-d4ab-ad7e-6afd-9168806eeca2@samsung.com> (Andrey
        Okoshkin's message of "Fri, 27 Oct 2017 12:33:25 +0300")
Message-ID: <xmqq3764czv9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7DDBABA-BB34-11E7-A1EC-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrey Okoshkin <a.okoshkin@samsung.com> writes:

> I'm not sure why only ENOENT error of lstat() is considered as an
> error but passing by other errno values leads to reading of
> uninitialized 'struct stat st' variable.  It means that the
> populated 'diff_filespec' structure may be incorrectly filled.

Entirely correct.  There is no fundamental reason to try special
casing ENOENT, unless we are clearing the "this is an error" bit
when the errno is ENOENT---but this code does not even do so.  All
errors are errors---we wanted to know the result of lstat() to carry
on, and we couldn't figure out the status.  We do not want to die
immediately (instead we want to show diffs for other paths), so
substituting the result with an empty string is the least bad thing
we can do at this point in the code.

