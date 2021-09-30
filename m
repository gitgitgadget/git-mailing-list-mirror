Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CDAC433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 22:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D36F6611C0
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 22:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344332AbhI3WHy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 18:07:54 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62093 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245172AbhI3WHx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 18:07:53 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 497E314AAFD;
        Thu, 30 Sep 2021 18:06:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Hn9FwAylS+zMpPCZLKBG6I15j3FZctaEqkTytd
        43x7U=; b=HzHRjy45P042+3dNOgQjAWcDf5SPyluTlF1jedjp3yvw48//Av2BxA
        QsIcf08s7+e5kBIuo8x8le/zRPGIifozeq503rQzUG4JiwHyYeF12Zw0osMAUylQ
        umClPmYkr26Jp7Gn+JNQFXiCUhgODPQkWogRuQ1Il2U1mt7KomMr4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 42C3714AAFC;
        Thu, 30 Sep 2021 18:06:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9C44014AAF9;
        Thu, 30 Sep 2021 18:06:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 3/5] difftool: avoid returning -1 to cmd_main() from
 run_dir_diff()
References: <20210930170146.61489-1-davvid@gmail.com>
        <20210930170146.61489-3-davvid@gmail.com>
Date:   Thu, 30 Sep 2021 15:06:06 -0700
In-Reply-To: <20210930170146.61489-3-davvid@gmail.com> (David Aguilar's
        message of "Thu, 30 Sep 2021 10:01:44 -0700")
Message-ID: <xmqq7dexafch.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9CD85978-223A-11EC-B9EF-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> difftool was forwarding the -1 result from error() to cmd_main(), which
> is implementation-defined since it is outside of the 0-255 range
> specified by POSIX for program exit codes.
>
> Stop assigning the result of error() to `ret`. Assign a value of 1
> whenever internal errors are detected instead.

Many existing codepaths take advantage of error() returning -1 and I
do not see anything is wrong to keep that "negative is error"
convention for the value of "ret" variable.  Most lines in this
patch however split that "ret = error(...)" pattern into two
statements and I do not see a very good reason for it.

Worse yet, after applying this patch, there still are at least three
assignments to "ret" that can give it a negative value:

	if (!mkdtemp(tmpdir.buf)) {
		ret = error("could not create '%s'", tmpdir.buf);
		goto finish;
	}

	ret = run_command_v_opt(helper_argv, flags);

	strbuf_addf(&buf, "%s/wtindex", tmpdir.buf);
	if (hold_lock_file_for_update(&lock, buf.buf, 0) < 0 ||
	    write_locked_index(&wtindex, &lock, COMMIT_LOCK)) {
		ret = error("could not write %s", buf.buf);
		goto finish;
	}

Among them, the return value from run_command_v_opt() eventually
come from wait_or_whine(), I think, so it may be generic -1 or
it may be WEXITSTATUS() of the child process.

But I am not sure if this partcular caller cares.  It is not
prepared to handle -1 and positive return from run_command_v_opt()
any differently.  So I think a single

-	return ret;
+	return !!ret;

at the end would be much easier to reason about and maintain.
