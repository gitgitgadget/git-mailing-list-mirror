Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BF1320281
	for <e@80x24.org>; Mon,  6 Nov 2017 01:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750971AbdKFBDv (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 20:03:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62995 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750750AbdKFBDu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 20:03:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8AF1B4DCB;
        Sun,  5 Nov 2017 20:03:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Py8/Dbj4Az5l
        SlMnV/J9INX/CLQ=; b=XTEknG142Xc0kdxX4N+hfRQVy5SLj9Brn69ZK30IoKFY
        bjFD0R+qzP04+j1YlCeeYxMBsXGTxSNW/yWgmfvLmtBMno+DTEmjECYAkRXkDwqK
        9x/I7I1HUAmpIt92+E2Zz9RUwsHUf+VLwfcNHRAofuTFrzKkpLYWtlKBhXkK4WU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=CoywEt
        uXTfWr8SoFjhpA30mD+pg62uHOW120kg2Dh5usBLJ7DIqVpvv0cIg7qIDkV+wb46
        4GrJHAAnMTi5lcl7GpUEq5XaE2nJnpI0xRgAxYVc70af0Ny/VYJZuF806Lm0CpbB
        2ui/5Uddo2mG72lUjezNOln4OkbS1oD3vTzyk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BFAF4B4DCA;
        Sun,  5 Nov 2017 20:03:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1471AB4DC5;
        Sun,  5 Nov 2017 20:03:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] builtin/merge-base: UNLEAK commit lists
References: <CAN0heSpgUBy4a6iok4MoDqJ__hZtrXvfApcxjHuS0vOBKSuShg@mail.gmail.com>
        <cover.1509908607.git.martin.agren@gmail.com>
        <b06f593d3f8b0ad53754eeb394f77e7c3ee916bd.1509908607.git.martin.agren@gmail.com>
Date:   Mon, 06 Nov 2017 10:03:47 +0900
In-Reply-To: <b06f593d3f8b0ad53754eeb394f77e7c3ee916bd.1509908607.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Sun, 5 Nov 2017 21:26:30
 +0100")
Message-ID: <xmqqa800kyks.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 58EAC580-C28E-11E7-B4BE-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> In several functions, we iterate through a commit list by assigning
> `result =3D result->next`. As a consequence, we lose the original point=
er
> and eventually leak the list.
>
> These are immediate helpers to `cmd_merge_base()` which is just about t=
o
> return, so we can use UNLEAK. For example, we could `UNLEAK(result)`
> before we start iterating. That would be a one-liner change per
> function. Instead, leave the lists alone and iterate using a dedicated
> pointer. Then UNLEAK immediately before returning.

Hmm, I cannot shake this feeling that this goes somewhat opposite to
the spirit of UNLEAK(), which I view as "It is too cumbersome and
makes the resulting code ugly if we try to make everything properly
freed, so mark what we know we will leak upfront".  The result of
this patch feels more like "Even though we took pains to restructure
the code so that we could call free_commit_list() to properly free
things, we use UNLEAK() and do not actually bother to free."

Havin said that, I do not think the resulting code has become uglier
or the conversion process (both writing and reviewing) were too
cumbersome for this particular case, and marking where we could call
free_commit_list() with UNLEAK() like this patch does may make
sense.  If somebody someday wants to call some of these helpers in
other contexts repeatedly, they may have an easier time.
