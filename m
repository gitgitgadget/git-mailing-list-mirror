Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E882FC433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C6A20691
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgLWBhg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 20:37:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65467 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgLWBhf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 20:37:35 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4184C925E9;
        Tue, 22 Dec 2020 20:36:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zFf1SAuZax9GONh4AicaG1/BPB0=; b=A4k9uj
        9Us6Q6IbceIOzbsUNVgNvwveAzinkPfCXdi0P6UqQ6bjvm6+9ao1Emp0qIohyf5Y
        4XP5vWopsqV65+HC6yQNUDBmYlL9NZ1GQIYn+Dh5plHhK6ccHn2Y2MxDwf8PXitT
        0DNHPOVQNLWE9Qo9TamvPOmHqBaIk9Z5DZhs0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m4bfeDy2d88x++oNDBxlpk907XKE7VpS
        628RzS6lHl3Y5ehHgXtfN1lPLjPVItLP1+OokSBl5FzKDClVU7wQJVzKCWs7gUG/
        ee1I4OGiCkE1nHAkcQfxjU/cnwg5r076ocORGSdpqcM4PmaMs58ewFnn31r+md2N
        nzzDa22pxaM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 361CB925E8;
        Tue, 22 Dec 2020 20:36:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B1857925E7;
        Tue, 22 Dec 2020 20:36:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Miriam Rubio <mirucam@gmail.com>, git@vger.kernel.org,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v2 2/7] bisect--helper: reimplement `bisect_replay`
 shell function in C
References: <20201221162743.96056-1-mirucam@gmail.com>
        <20201221162743.96056-3-mirucam@gmail.com>
        <gohp6klfdpbca4.fsf@cpm12071.fritz.box>
Date:   Tue, 22 Dec 2020 17:36:52 -0800
In-Reply-To: <gohp6klfdpbca4.fsf@cpm12071.fritz.box> (Rafael Silva's message
        of "Wed, 23 Dec 2020 01:23:49 +0100")
Message-ID: <xmqq4kkdfgln.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 556B7A24-44BF-11EB-A81D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rafael Silva <rafaeloliveira.cs@gmail.com> writes:

> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index b887413d8d..fb15587af8 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -988,11 +988,8 @@ static int process_replay_file(FILE *fp, struct bisect_terms *terms)
>         struct strbuf word = STRBUF_INIT;
>         int res = 0;
>
> -       while (strbuf_getline(&line, fp) != EOF) {
> +       while (!res && strbuf_getline(&line, fp) != EOF)
>                 res = process_line(terms, &line, &word);
> -               if (res)
> -                       break;
> -       }

I do not mind shorter and crisper code, but I somehow find that the
original more cleanly expresses the intent.

"We'll grab input lines one by one until the input runs out" and "we
stop when we see a line that process_line() likes" are conditions
that the loop may stop at two logically distinct levels.  You can
conflate them into a single boolean, making it "unless we found a
line the process_line() liked in the previous round, grab the next
line but stop when we ran out the input", and it may make the result
shorter, but it may be easier to follow by normal readers if we kept
them separate, like the original does.
