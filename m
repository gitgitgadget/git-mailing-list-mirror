Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED3151F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 07:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeKXSW0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 13:22:26 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62810 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeKXSWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Nov 2018 13:22:25 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A0C11286EE;
        Sat, 24 Nov 2018 02:34:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gqJxv6uvJrO+dCDdS5fUlzXNcd4=; b=Yw3mBq
        oqxbB6V8Blr8wAWUgoIHrj8gTfhlTTig+Xn3aYhcRp4rPQIWjVzyBK9w5dyT3NxI
        5UbPWr2Us4DbXo3cZGAc5xVR8nc/ekHbv+4wTV9OHXwK7bt7ExzFbvlIGelLq0Ud
        +lW176+/mm1ZNWzq1SJLYtcwnCobhYUuqEqKI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GfFeU2hg+n4Ndm6/6QIiiTrMOhHVI5LX
        ESE3q9YQoIVDYGQ27WoyAbq2cYd8LsI3egW1MlBNN2vdw2k+YIVWQVb/7oOV0vgg
        dUGLQ9aj+KvvT6KXEDmYialf6Y0fI4akXmT71n0DLlzhw+Dccu9ktZU8dJ59LTcj
        gT8yfuf/D9Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5306C1286ED;
        Sat, 24 Nov 2018 02:34:54 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C92CB1286EB;
        Sat, 24 Nov 2018 02:34:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Max Kirillov <max@max630.net>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH] t5562: do not reuse output files
References: <20181124070428.18571-1-max@max630.net>
Date:   Sat, 24 Nov 2018 16:34:52 +0900
In-Reply-To: <20181124070428.18571-1-max@max630.net> (Max Kirillov's message
        of "Sat, 24 Nov 2018 09:04:28 +0200")
Message-ID: <xmqqbm6f2ajn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F3365A8-EFBB-11E8-BA11-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Kirillov <max@max630.net> writes:

> diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
> index 90d890d02f..bb53f82c0c 100755
> --- a/t/t5562-http-backend-content-length.sh
> +++ b/t/t5562-http-backend-content-length.sh
> @@ -25,6 +25,8 @@ test_http_env() {
>  	handler_type="$1"
>  	request_body="$2"
>  	shift
> +	(rm -f act.out || true) &&
> +	(rm -f act.err || true) &&

Why "||true"?  If the named file doesn't exist, "rm -f" would
succeed, and if it does exist but somehow we fail to remove, then
these added lines are not preveting the next part from reusing,
i.e. they are not doing what they are supposed to be doing, so we
should detect such a failure (if happens) as an error, no?

IOW, shouldn't it just be more like

	+	rm -f act.out act.err &&

The same comment applies to the other hunk.


>  	env \
>  		CONTENT_TYPE="application/x-git-$handler_type-pack-request" \
>  		QUERY_STRING="/repo.git/git-$handler_type-pack" \
> @@ -155,6 +157,8 @@ test_expect_success 'CONTENT_LENGTH overflow ssite_t' '
>  '
>  
>  test_expect_success 'empty CONTENT_LENGTH' '
> +	(rm -f act.out || true) &&
> +	(rm -f act.err || true) &&
>  	env \
>  		QUERY_STRING="service=git-receive-pack" \
>  		PATH_TRANSLATED="$PWD"/.git/info/refs \
