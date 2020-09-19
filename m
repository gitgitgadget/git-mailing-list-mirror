Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FD3C43463
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 23:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CB52207C3
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 23:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bD2/exs2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgISXCM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 19:02:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53645 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgISXCM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 19:02:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 918FC7DE45;
        Sat, 19 Sep 2020 19:02:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B4hCXiAylwxPA6n7NDJtqDbyxfo=; b=bD2/ex
        s22SLOnxFWU/phW7A4NMdxwodx8Bd6Wa+AvjvU2FLKeqNkyJ5JgFRu/qQTMDsmFc
        tOjhPMgZ9mi2mLHb/wLCOFPuXAev80zuRo80PMacV6LmIT9gLZNO01w/d43XR7vV
        ebt6nknfHaKBifhIk4128Ow1w22iw5XUq2fhA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vsUbt22uvHT+QcbjCwq9kJ2+mQD1A5Op
        Z//bhcdZJvw7HzvdTs5HATdxHjLjT4wqny5QDlvf51LYPRBsAiTwdf7ctGmwJwVF
        5LY8kQLwOOiMwF5OGljyrXXWXfne/XAkZTBLR1gBWhfhW9i0CxMDM0Ej7/o5HHCa
        XzlZ8TcCw/o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7500D7DE44;
        Sat, 19 Sep 2020 19:02:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E01F77DE43;
        Sat, 19 Sep 2020 19:02:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han Xin" <hanxin.hx@alibaba-inc.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?6JKL6ZGrKOefpeW/pyk=?= <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v3] send-pack: run GPG after atomic push checking
References: <xmqqft7eljkz.fsf@gitster.c.googlers.com>
        <20200919144750.95812-1-hanxin.hx@alibaba-inc.com>
Date:   Sat, 19 Sep 2020 16:02:07 -0700
In-Reply-To: <20200919144750.95812-1-hanxin.hx@alibaba-inc.com> (Han Xin's
        message of "Sat, 19 Sep 2020 22:47:50 +0800")
Message-ID: <xmqqpn6hid5c.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 246948F8-FACC-11EA-B90E-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han Xin" <hanxin.hx@alibaba-inc.com> writes:

> The refs update commands can be sent to the server side in two different
> ways: GPG-signed or unsigned.  We should run these two operations in the
> same "Finally, tell the other end!" code block, but they are seperated
> by the "Clear the status for each ref" code block.  This will result in
> a slight performance loss, because the failed atomic push will still
> perform unnecessary preparations for shallow advertise and GPG-signed
> commands buffers, and user may have to be bothered by the (possible) GPG
> passphrase input when there is nothing to sign.

The above sounds as if we care about the performace loss and that is
the main motivation behind this change.  Intended?  I have an
impression that it is a hard-sell as a "performance improvement"
patch, as the saved cycles are negligible compared to everything
else that is done in the flow, and more importantly, it optimizes
for the wrong case (i.e. it fails more efficiently).

> Add a new test case to t5534 to ensure GPG will not be called when the
> GPG-signed atomic push fails.
>
> Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> ---
...
> +	test_must_fail env PATH="$TRASH_DIRECTORY:$PATH" git push \
> +			--signed --atomic --porcelain \
> +			dst noop ff noff >out 2>&1 &&
> +
> +	test_i18ngrep ! "gpg failed to sign" out &&

OK, that is much less brittle than the "output must match these
lines exactly" test we saw earlier.

> +	sed -n -e "/^To dst/,$ p" out >actual &&
> +	cat >expect <<-EOF &&
> +	To dst
> +	=	refs/heads/noop:refs/heads/noop	[up to date]
> +	!	refs/heads/ff:refs/heads/ff	[rejected] (atomic push failed)
> +	!	refs/heads/noff:refs/heads/noff	[rejected] (non-fast-forward)
> +	Done
> +	EOF
> +	test_i18ncmp expect actual

Didn't you mean to remove this part, which makes the whole test more
brittle than necessary?

Thanks.
