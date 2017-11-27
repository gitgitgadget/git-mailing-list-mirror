Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA19120A40
	for <e@80x24.org>; Mon, 27 Nov 2017 00:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbdK0A3Y (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 19:29:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50863 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752114AbdK0A3X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 19:29:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9BAF4B9AC2;
        Sun, 26 Nov 2017 19:29:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wdjLoj9kjondctNnbLca9Z3wr6E=; b=ih0TH/
        pQ4aLXesZphj9v3dlqaoHO9x/JnyAySrJT6tUGD8H37PUfIqnUSHiydUy4vlFcAB
        gtrJoWxnjGnxJDhC9B8GcxazokBVzpmc7vnlPkgAo3d9jz4SC/YbGV84IUkj09Pk
        YBwHkzh0tb7HRJC058Z1c5PUmfhHyhw6JoIvk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NYBUSScOaZAgWybU2yv0WnleuW0msv8N
        HwoWh/HMqaPHvQmv4wjWPdI+SbeBn9+DcogPva3j8Ofuo15O2ioMc3WT5yXJ+9Sz
        F3d897n0YkU44W6uEPUAAzntvjkxgy4PBAheT8DDMKe7T6RQo4QxkbqZoQcnn/5e
        5z8uhYCkRUw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 91684B9AC1;
        Sun, 26 Nov 2017 19:29:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E4D0DB9AC0;
        Sun, 26 Nov 2017 19:29:21 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Max Kirillov <max@max630.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] t5560-http-backend-noserver.sh: add CONTENT_LENGTH cases
References: <20171126193813.12531-1-max@max630.net>
        <20171126193813.12531-3-max@max630.net>
Date:   Mon, 27 Nov 2017 09:29:20 +0900
In-Reply-To: <20171126193813.12531-3-max@max630.net> (Max Kirillov's message
        of "Sun, 26 Nov 2017 21:38:13 +0200")
Message-ID: <xmqqbmjoh8db.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03846FF6-D30A-11E7-AAC7-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Kirillov <max@max630.net> writes:

> Add tests for cases:
>
> * CONTENT_LENGTH is set, script's stdin has more data.
>   (Failure would make it read GIT_HTTP_MAX_REQUEST_BUFFER bytes from /dev/zero
>   and fail. It does not seem to cause any performance issues with the default
>   value of GIT_HTTP_MAX_REQUEST_BUFFER.)
> * CONTENT_LENGTH is specified to a value which does not fix into ssize_t.

s/fix/fit/ you meant?

> diff --git a/t/helper/test-print-values.c b/t/helper/test-print-values.c
> new file mode 100644
> index 0000000000..8f7e5af319
> --- /dev/null
> +++ b/t/helper/test-print-values.c
> @@ -0,0 +1,10 @@
> +#include <stdio.h>
> +#include <string.h>
> +
> +int cmd_main(int argc, const char **argv)
> +{
> +	if (argc == 2 && strcmp(argv[1], "(size_t)(-20)") == 0)
> +		printf("%zu", (ssize_t)(-20));
> +
> +	return 0;
> +}

As far as I know, we avoid %zu (C99), as it may not be safe yet to
do so on all platforms.

e.g. c.f. https://public-inbox.org/git/64C7D52F-9030-460C-8F61-4076F5C1DDF6@gmail.com/

You may want to double check the 1/2 of this topic, too.

Forcing a test command line to spell out "(size_t)(-20)" feels a bit
atrocious, especially given that this program is capable of ever
showing that string and nothing else, and it does not even diagnose
typos as errors.

I wonder if we would want to have "test-print-larger-than-ssize" and
do something like

    #include "cache.h"

    int cmd_main(int ac, const char **av)
    {
            uintmax_t large = ((uintmax_t) SSIZE_MAX) + 1;

            printf("%" PRIuMAX "\n", large);
            return 0;
    }

perhaps?

Note that wrapper.c seems to assume that not everybody has
SSIZE_MAX, so we might have to do something silly like

	size_t large = ~0;
	large = ~(large & ~(large >> 1)) + 1;

        printf("%" PRIuMAX "\n", (uintmax_t) large);

just to be careful (even though we now assume 2's complement),
though.
