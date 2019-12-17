Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FDCC43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 22:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AD8205ED
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 22:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="J/vYeGGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfLQWwF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 17:52:05 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54393 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfLQWwF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 17:52:05 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 297339CB8B;
        Tue, 17 Dec 2019 17:52:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VbbMK1Z+fk81P8YE2H+dAqiy1EI=; b=J/vYeG
        GCDfqUreUMCrVRHyTEOKYM3d5H6LbCohAbJsjujgkITO1a/OmrTzH5yXnb8yXGKc
        y3mkgKseHG6rgztNwM3uYTT7Uf2H5ATfvatjTZf32D3GWrs1+XWrJvjHG54XIHk/
        Xdf1pDX8GdkdsVE7p24MMaQVuG+NKMvUvqdDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ckOkPWlixyizy+9MbwtZh8tXL9bXu/BT
        477omw4Dq3dENRY/jZTiYvlqNKY+UtGY0bw/kjD+dZ3uM5z8uqPycJ0FqNZdQe7l
        +yHBMLS7fpLChnHMsBlwGQsI1YCmquAiK9X4iSmZBIx/UdXqkmZ5jhuM/Y98A+fo
        94hhSa1ejhg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 211929CB8A;
        Tue, 17 Dec 2019 17:52:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 49CCD9CB87;
        Tue, 17 Dec 2019 17:52:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yang Zhao <yang.zhao@skyboxlabs.com>
Cc:     git@vger.kernel.org, luke@diamand.org, liu.denton@gmail.com,
        seraphire@gmail.com
Subject: Re: [PATCH v2 04/14] git-p4: encode/decode communication with p4 for python3
References: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
        <20191213235247.23660-6-yang.zhao@skyboxlabs.com>
Date:   Tue, 17 Dec 2019 14:51:58 -0800
In-Reply-To: <20191213235247.23660-6-yang.zhao@skyboxlabs.com> (Yang Zhao's
        message of "Fri, 13 Dec 2019 15:52:38 -0800")
Message-ID: <xmqq1rt2ftv5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D669C8B6-211F-11EA-8999-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yang Zhao <yang.zhao@skyboxlabs.com> writes:

> The marshalled dict in the response given on STDOUT by p4 uses `str` for
> keys and string values. When run using python3, these values are
> deserialized as `bytes`, leading to a whole host of problems as the rest
> of the code assumes `str` is used throughout.
>
> This patch changes the deserialization behaviour such that, as much as
> possible, text output from p4 is decoded to native unicode strings.
> Exceptions are made for the field `data` as it is usually arbitrary
> binary data. `depotFile[0-9]*`, `path`, and `clientFile` are also exempt
> as they contain path strings not encoded with UTF-8, and must survive
> survive round-trip back to p4.

Doubled "survive"; will drop one of them while queuing.
