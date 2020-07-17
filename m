Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B96EC433DF
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 16:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49EE7206BE
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 16:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Uw+NhNnv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgGQQeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:34:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61436 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgGQQeB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 12:34:01 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 211E16A024;
        Fri, 17 Jul 2020 12:33:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K/dyY5x0Zwd+JoQicXju/zGv0LA=; b=Uw+NhN
        nvyDMvOmjHhEN2EyFB0AizH5kLKpCrMnpYuIIf4gFFSM6qthp6wiKiRMxe12ScR5
        9Te7taSXiVaL+pXM4gNtJ63jBd58X6a7HIdJ/NTdtXRQWA4+4Td+qny3Px5RYNSx
        RJs+d44AIziqVOe+S2Lbxwy6Ed3jJzRgsGG8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pxP6nOHjb+EK8J/EPYB4+4c3ULhqCtMi
        aotnopgMMV9t7ydR7CvDsTK7U+1EE/LCYDqBCeT0e2VMeES34SB36MBrNsqkn7vx
        xMhmbVo4p96zXWXiF5YGsRj1MpCh/bVVG+PxK0Q0vhDVUQj7HCNi+eCYME6Y8hmW
        yd8tLz+az+8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 188046A023;
        Fri, 17 Jul 2020 12:33:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 992CF6A022;
        Fri, 17 Jul 2020 12:33:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 03/13] bisect--helper: introduce new `write_in_file()` function
References: <20200717105406.82226-1-mirucam@gmail.com>
        <20200717105406.82226-4-mirucam@gmail.com>
Date:   Fri, 17 Jul 2020 09:33:57 -0700
In-Reply-To: <20200717105406.82226-4-mirucam@gmail.com> (Miriam Rubio's
        message of "Fri, 17 Jul 2020 12:53:56 +0200")
Message-ID: <xmqqzh7ydrt6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 50797110-C84B-11EA-B943-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> +	fp = fopen(path, mode);
> +	if (!fp)
> +		return error_errno(_("cannot open file '%s' in mode '%s'"), path, mode);
> +	res = vfprintf(fp, format, args);
> +
> +	if (res < 0) {
> +		fclose(fp);
> +		return error_errno(_("could not write to file '%s'"), path);

If the fclose(fp) failed, the errno from that failure (i.e. why fp
cannot be closed) would be reported by the error_errno(), which may
not be ideal.  Either use just error() (which may be suboptimal),
follow an often-used pattern to use save_errno (grep for the symbol
to learn from the existing code) and keep using error_errno(), or
check errors from fclose() too (which may be overkill).

	if (res < 0) {
		int saved_errno = errno;
#if OVERKILL
		if (fclose(fp))
                	error_errno(_("..."));
#else
		fclose(fp);
#endif
		errno = saved_errno;
		return error_errno(_("..."), ...);
	}
