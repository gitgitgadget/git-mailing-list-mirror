Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E03DE201C8
	for <e@80x24.org>; Mon, 13 Nov 2017 05:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751214AbdKMFYY (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 00:24:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54357 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750949AbdKMFYY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 00:24:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A71FB6916;
        Mon, 13 Nov 2017 00:24:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MffIYbAEvCQBEZIXUO5RUeZS9uI=; b=rt1H9A
        DAMMc1XLjGps5GOEwTXrdzdovaLf8KtFB+ltgOH+7f09hD5yW/iCx2udqUCjNatJ
        cXblvooLVRNd6BmQX6Ahpq96XKizwu4J2FKILCv0ZfITARBEYhvq+Vx1Hj4DEwq8
        QBAnzHVCbBJ1vqeIJQAMs7t8c7QIKbKcTcozw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TfXdjguOAFNPpb6wSJyVhoHLhvM/v5H6
        Xiw0+UtfFOZqDZ6jSpbMydEf5L55TPinZJg1YwRyCLQDDc8e7NvGeP0rnwdyIJvw
        aqO41XFSNuyLmofuNxnbaA3Eg//DyG3mnhNnWJ+pn4WBx2GjYOsuzQpr3xKVxnsY
        OFris+KU/Yo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 91C0BB6915;
        Mon, 13 Nov 2017 00:24:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 15E26B6914;
        Mon, 13 Nov 2017 00:24:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4] progress: Fix progress meters when dealing with lots of work
References: <20171110173956.25105-1-newren@gmail.com>
        <20171110173956.25105-4-newren@gmail.com>
Date:   Mon, 13 Nov 2017 14:24:21 +0900
In-Reply-To: <20171110173956.25105-4-newren@gmail.com> (Elijah Newren's
        message of "Fri, 10 Nov 2017 09:39:55 -0800")
Message-ID: <xmqqtvxy92ey.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E866E35C-C832-11E7-B7ED-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Subject: Re: [PATCH 3/4] progress: Fix progress meters when dealing with lots of work

Style: s/Fix/fix/;

> The possibility of setting merge.renameLimit beyond 2^16 raises the
> possibility that the values passed to progress can exceed 2^32.  For my
> usecase of interest, I only needed to pass a value a little over 2^31.  If
> I were only interested in fixing my usecase, I could have simply changed
> last_value from int to unsigned, and casted each of rename_dst_nr and
> rename_src_nr (in merge-recursive.c) from int to unsigned just before
> multiplying them.  However, as long as we're making changes to allow
> larger progress meters, we may as well make a little more room in general.
> Use uint64_t, because it "ought to be enough for anybody".  :-)

The middle part of the log message may waste more mental bandwidth
of readers than it is worth.  It might have gave you satisfaction to
be able to vent, but don't (the place to do so is after the three
dash lines).

I am not sure if we want all codepaths to do 64-bit math for
progress meter, but let's see what others would think.

> -static int display(struct progress *progress, unsigned n, const char *done)
> +static int display(struct progress *progress, uint64_t n, const char *done)
>  {
>  	const char *eol, *tp;
>  
> @@ -106,7 +106,7 @@ static int display(struct progress *progress, unsigned n, const char *done)
>  		if (percent != progress->last_percent || progress_update) {
>  			progress->last_percent = percent;
>  			if (is_foreground_fd(fileno(stderr)) || done) {
> -				fprintf(stderr, "%s: %3u%% (%u/%u)%s%s",
> +				fprintf(stderr, "%s: %3u%% (%lu/%lu)%s%s",

Are these (and there are probably other instances in this patch) %lu
correct?
