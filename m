Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3600EC4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 20:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14CF661042
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 20:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhHGU6r (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 16:58:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52762 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhHGU6q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 16:58:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8217AF6564;
        Sat,  7 Aug 2021 16:58:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2lBTNS6v6ui4ICY/aWK9QbTbEs3HyRL9jUJjNt
        lZXVw=; b=tJXAxQJ/pBnY9GSFsrRKgrvJlo6tommO/pH0Tuesgbz4Zkp2DvgjJX
        gYnV9SugPrNwseaHDq9z8mERHTFhRkZ0LHqslPA1LLK32cCi4nfsT63yRFqd50p7
        /MGMudUrnVcESHFUx6u4DpdQNL+LaZZPAr5ZszObmGnkQHLqGfTw8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7821EF6563;
        Sat,  7 Aug 2021 16:58:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0993FF6562;
        Sat,  7 Aug 2021 16:58:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Noah Pendleton <noah.pendleton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] blame: Skip missing ignore-revs file
References: <20210807202752.1278672-1-noah.pendleton@gmail.com>
Date:   Sat, 07 Aug 2021 13:58:27 -0700
In-Reply-To: <20210807202752.1278672-1-noah.pendleton@gmail.com> (Noah
        Pendleton's message of "Sat, 7 Aug 2021 16:27:51 -0400")
Message-ID: <xmqqr1f5hszw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36D4657E-F7C2-11EB-9011-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Noah Pendleton <noah.pendleton@gmail.com> writes:

> Setting a global `blame.ignoreRevsFile` can be convenient, since I
> usually use `.git-blame-ignore-revs` in repos. If the file is missing,
> though, `git blame` exits with failure. This patch changes it to skip
> over non-existent ignore-rev files instead of erroring.

That cuts both ways, though.  Failing upon missing configuration
file is a way to catch misconfiguration that is hard to diagnose.

I wonder if we can easily learn where the configuration variable
came from in the codepath that diagnoses it as a misconfiguration.

If it came from a per-repo configuration and names a non-existent
file, it clearly is a misconfiguration that we want to flag as an
error.  Even if it came from a per-user configuration, if it was
specified in a conditionally included file, it is likely to be a
misconfiguration.  If it came from a per-user configuration that
applies without any condition, it can be a good convenience feature
to silently (or with a warning) ignore missing file.
