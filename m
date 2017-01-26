Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADCDD1F794
	for <e@80x24.org>; Thu, 26 Jan 2017 23:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbdAZX07 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 18:26:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63092 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752436AbdAZX06 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 18:26:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F9FC64C7B;
        Thu, 26 Jan 2017 17:33:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZrzoKz6bbWuybLUEUAvpNY3NSKE=; b=CQSYTJ
        dJGPocvubvpMZnz6ssqf0GxjhzRGPn5W+ogWuVYZ2Y7/c823j7oeqYcQ/rGjrHAt
        9UHIDX5fhW14e+5UkpWu6wXixj+i4hXz7JZP4RfUFt5awNG26hP1B5BdOB+67x4W
        a/UTh0B1nVGi7Qbqy/7OxcKYkBk5gIA4T+xg8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hXntDdGxFqBxdLc96WBii5Gk4z0tuZDI
        FjlaBQKpwbRpep5hkUpPlfcf/6YfnlNT0i1yctsfgvO0zhXzcy6KsRn4Ltbr8H75
        aZhqN7cqDabwEE3lP7VgnEdoT4cYppOFbC8Q+hTluerV+GjVGQQAIAqQFid/lMzM
        mT5TgvnjDms=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0682064C7A;
        Thu, 26 Jan 2017 17:33:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6C83E64C79;
        Thu, 26 Jan 2017 17:33:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC 03/14] upload-pack: test negotiation with changing repo
References: <cover.1485381677.git.jonathantanmy@google.com>
        <cover.1485381677.git.jonathantanmy@google.com>
        <afe5d7d3f876893fdad318665805df1e056717c6.1485381677.git.jonathantanmy@google.com>
Date:   Thu, 26 Jan 2017 14:33:29 -0800
In-Reply-To: <afe5d7d3f876893fdad318665805df1e056717c6.1485381677.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Wed, 25 Jan 2017 14:02:56 -0800")
Message-ID: <xmqq8tpx30zq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 767BA1EC-E417-11E6-959C-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> diff --git a/t/lib-httpd/one-time-sed.sh b/t/lib-httpd/one-time-sed.sh
> new file mode 100644
> index 000000000..060ec0300
> --- /dev/null
> +++ b/t/lib-httpd/one-time-sed.sh
> @@ -0,0 +1,8 @@
> +#!/bin/sh
> +
> +if [ -e one-time-sed ]; then
> +	"$GIT_EXEC_PATH/git-http-backend" | sed "$(cat one-time-sed)"
> +	rm one-time-sed
> +else
> +	"$GIT_EXEC_PATH/git-http-backend"
> +fi

CodingGuidelines?

> +inconsistency() {
> +	# Simulate that the server initially reports $2 as the ref
> +	# corresponding to $1, and after that, $1 as the ref corresponding to
> +	# $1. This corresponds to the real-life situation where the server's
> +	# repository appears to change during negotiation, for example, when
> +	# different servers in a load-balancing arrangement serve (stateless)
> +	# RPCs during a single negotiation.
> +	printf "s/%s/%s/" \
> +	       $(git -C "$REPO" rev-parse $1 | tr -d "\n") \
> +	       $(git -C "$REPO" rev-parse $2 | tr -d "\n") \
> +	       >"$HTTPD_ROOT_PATH/one-time-sed"

I'd prefer for the printf'd result to have a final LF (i.e. not
leaving the resulting one-time-sed with a final incomplete line).
Also, do you really need the pipe to tr-d?  Doesn't the result of 
$(command substitution) omit the final LF anyway?

    $ printf '1 %s 2 %s 3\n' "$(echo foo)" "$(echo bar)"; echo OK
    1 foo 2 bar 3
    OK

> diff --git a/upload-pack.c b/upload-pack.c
> index b88ed8e26..0678c53d6 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -862,9 +862,13 @@ static void receive_needs(struct string_list *wanted_ns_refs)
>  		} else if (skip_prefix(line, "want ", &arg) &&
>  			   !get_sha1_hex(arg, sha1_buf)) {
>  			o = parse_object(sha1_buf);
> -			if (!o)
> +			if (!o) {
> +				packet_write_fmt(1,
> +						 "ERR upload-pack: not our ref %s",
> +						 sha1_to_hex(sha1_buf));
>  				die("git upload-pack: not our ref %s",
>  				    sha1_to_hex(sha1_buf));
> +			}

This somehow looks like a good thing to do even in production.  Am I
mistaken?

