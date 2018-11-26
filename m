Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C9741F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 02:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbeKZM7T (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 07:59:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63266 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeKZM7T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 07:59:19 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C110B1C303;
        Sun, 25 Nov 2018 21:06:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g5b/u18nONpLZ/k/r2F1KQxDLYw=; b=SUsOil
        2GnZFD93iporWDIsZmIib7po/xvdhFPob6P7lO0Ss/TmHkJ6BwHjQ/gVc2Ak2e9n
        PLgoDC2i8HszJ0ngsD1whI5UO80ssFaDrCwnSZxi+y84di6/kRg1mZ60vDCyOxT9
        OHh+NtSKFakSCVhodVxfGzZ4pWTMitToFRBqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KS4ebW2xWUgkG8hZx18NGZKzLEKjlLwG
        rl/G1M5DtqwtNaud6NqM/ygOcDge58AAxCkKMtC6jexD91hoAIF+3VWX8oaS+8nC
        jEILnsTsdLGHTBAdW1DNOc3/64seREarj9GFguHhGIegpgPREQL79a7Kb9aEQlGj
        i1n6sDaqlFo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B9DF71C302;
        Sun, 25 Nov 2018 21:06:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CC7B11C301;
        Sun, 25 Nov 2018 21:06:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Max Kirillov <max@max630.net>, peff@peff.net
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] t5562: do not reuse output files
References: <20181124070428.18571-1-max@max630.net>
        <xmqqbm6f2ajn.fsf@gitster-ct.c.googlers.com>
        <xmqq7eh23ojc.fsf@gitster-ct.c.googlers.com>
        <20181124130337.GH5348@jessie.local>
Date:   Mon, 26 Nov 2018 11:06:40 +0900
In-Reply-To: <20181124130337.GH5348@jessie.local> (Max Kirillov's message of
        "Sat, 24 Nov 2018 15:03:37 +0200")
Message-ID: <xmqqlg5g1tjj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EB48CD44-F11F-11E8-8F88-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Kirillov <max@max630.net> writes:

> On Sat, Nov 24, 2018 at 04:47:19PM +0900, Junio C Hamano wrote:
>> I do agree that forcing the parent to wait, like you described in
>> the comment, would be far more preferrable,
>
> It looks like it can be done as simple as:
>
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -486,6 +486,8 @@ static void run_service(const char **argv, int buffer_input)
>         if (buffer_input || gzipped_request || req_len >= 0)
>                 cld.in = -1;
>         cld.git_cmd = 1;
> +       cld.clean_on_exit = 1;
> +       cld.wait_after_clean = 1;
>         if (start_command(&cld))
>                 exit(1);
>
> at least according to strate it does what it should.

Sounds sane.

I am offhand not sure what the right value of wait_after_clean for
this codepath be, though.  46df6906 ("execv_dashed_external: wait
for child on signal death", 2017-01-06) made this non-default but
turned it on for dashed externals (especially to help the case where
they spawn a pager), as the parent has nothing other than to wait
for the child to exit in that codepath.  Does the same reasoning
apply here, too?

This is a meta point, but I wonder if there is an easy way to "grep"
for uses of run-command interface that do *not* set clean_on_exit.
The pager that can outlive us long after we exit, kept alive while
the user views our output, is an example cited by afe19ff7
("run-command: optionally kill children on exit", 2012-01-07), and
while I am wondering if the default should hae been to kill the
children instead, such a "grep" would have been very useful to know
what codepaths would be affected if we flipped the default.
