Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF01C433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 01:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C35D820737
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 01:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="E4LKIUxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgHZBT1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 21:19:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57365 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgHZBT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 21:19:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B528577A99;
        Tue, 25 Aug 2020 21:19:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IWxn0MMVDrVxy9csqdDopLWDAMs=; b=E4LKIU
        xXuqnWZaHtREkstTVQzJdqSeK8PDInISHDmCkziJeR2puF069HX3+FlcxpJaeqZu
        kT6Ek778Z4TY97ll9POs4bMVax5hUCX46V7eZwi0R1lYyO/+0+oqtTZpqjkbeSyA
        ENeD705CS1ZFUf//Lo4RPKKk+bqVlxn6jqbEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bvnemWPSe5IVBS4zVjtd0Ypy3gxNm9oI
        abGzCU5Bb64lhxTk9ZIETFnWa5e57iXQj0cOa7BfTkIT803N5K6eqBNw4++srnuS
        9Hfnr53I5jG/DtPVzIosnDLI9DZWy4BsDEXsWfodINnPPcd3FmmkPdYEEwG6Et8a
        qWdA0j8Xi0w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ADAA277A98;
        Tue, 25 Aug 2020 21:19:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B81A77A97;
        Tue, 25 Aug 2020 21:19:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 3/3] git: catch an attempt to run "git-foo"
References: <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com>
        <20200826011718.3186597-1-gitster@pobox.com>
        <20200826011718.3186597-4-gitster@pobox.com>
Date:   Tue, 25 Aug 2020 18:19:22 -0700
In-Reply-To: <20200826011718.3186597-4-gitster@pobox.com> (Junio C. Hamano's
        message of "Tue, 25 Aug 2020 18:17:18 -0700")
Message-ID: <xmqqimd6xkyt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2CB8614C-E73A-11EA-BAA2-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> If we were to propose removing "git-foo" binaries from the
> filesystem for built-in commands, we should first see if there are
> users who will be affected by such a move.  When cmd_main() detects
> we were called not as "git", but as "git-foo", give an error message
> to ask the user to let us know and stop our removal plan, unless we
> are running a selected few programs that MUST be callable in the
> dashed form (e.g. "git-upload-pack").
>
> Those who are always using "git foo" form will not be affected, but
> those who trusted the promise we made to them 12 years ago that by
> prepending the output of $(git --exec-path) to the list of
> directories on their $PATH, they can safely keep writing
> "git-cat-file" will be negatively affected as all their scripts
> assuming the promise will be kept are now broken.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

The same idea as the one for pack-redundant.  I do not use the
technique to inspect $PATH and see if $GIT_EXEC_PATH is on it, as
that would mean we will *not* bug users with legitimate need to keep
the feature working, hence will not get "don't do that" objections.

We may want to ensure command_list[] is sorted by name and run
binary search on it if running find_cmdname_help() for each and
every dashed "git-foo" invocations turns out to be costly.  Our
conjecture behind this patch is that the form is rarely if ever
used, so it may not matter at all, though.
