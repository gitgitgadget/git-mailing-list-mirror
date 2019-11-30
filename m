Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBB7C432C0
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 21:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FC62075A
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 21:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W9Hy54Zo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfK3VQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 16:16:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53012 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfK3VQf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 16:16:35 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 06AFD3DDD4;
        Sat, 30 Nov 2019 16:16:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kbUSY4KRAB5b
        QOFgxpVjRYQY2vE=; b=W9Hy54ZoW0M12azunWFp6ggrHL+cQawCvWWoh9SypJUS
        nuAfsU0bsy+F2QHq2pw8VtTuaQqVXuaPuy06Iv3ml32BofpqM7gxTFCrmv0YyrnE
        dZ1xX7bYGA8ejuBhyaYIiehEINmGEvnAjDvbGytmWpuVxdJqH98JcZwNMAtEyBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KG0YuA
        GdnJ4xloIvXHyt3TCWrfnW6Xd5+123LMgANZg4GAQnSHpoEtlZY+LmnuE6TsQYjU
        b4t6dHo9XuPVkGLUIa9uMGH9189SvJNCP4fwDfo2mwLLb4l9i/j4xRwK3qz4vFH+
        Iof9UieJRUOilhLqxBkpaYMCzUQXLhahpbZeY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F2EE23DDD3;
        Sat, 30 Nov 2019 16:16:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 630B53DDD2;
        Sat, 30 Nov 2019 16:16:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t9300-fast-import: don't hang if background fast-import exits too early
References: <20191130104644.17350-1-szeder.dev@gmail.com>
Date:   Sat, 30 Nov 2019 13:16:30 -0800
In-Reply-To: <20191130104644.17350-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Sat, 30 Nov 2019 11:46:44 +0100")
Message-ID: <xmqqsgm512vl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AEB3967E-13B6-11EA-BD82-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> +	(
> +		git fast-import $options <&8 >&9 &
> +		echo $! >V.fi.pid
> +		wait $!
> +		echo >&2 "background fast-import terminated too early with exit code=
 $?"
> +		# Un-block the read loop in the main shell process.
> +		echo >&9 UNEXPECTED
> +	) &
> +	echo $! >V.sh.pid
>  	# We don't mind if fast-import has already died by the time the test
>  	# ends.
> -	test_when_finished "
> +	test_when_finished '
>  		exec 8>&-; exec 9>&-;
> -		kill $(cat V.pid) && wait $(cat V.pid)
> -		true"
> +		kill $(cat V.sh.pid) && wait $(cat V.sh.pid)
> +		kill $(cat V.fi.pid) && wait $(cat V.sh.pid)
> +		true'

The original interpolates the PID of the fast-import when
"when-finished" program is registered, so it is OK if somebody else
removed V.pid file; the new one interpolates when "when-finished"
program is run, reading from V.??.pid, so somebody needs to make
sure these pid files will stay around.  I do not think it is an
issue as I suspect we've left it to the global clean-up procedure
that removes the trash directory to remove the pid file.

By the way, does the second "kill && wait" wait for the right
process?

>  background_import_still_running () {
> -	if ! kill -0 "$(cat V.pid)"
> +	if ! kill -0 "$(cat V.fi.pid)"
>  	then
>  		echo >&2 "background fast-import terminated too early"
>  		false
>  	fi
>  }
