Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94493C432BE
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 01:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E4B760F6C
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 01:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbhH1BzE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 21:55:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57218 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbhH1BzD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 21:55:03 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A9D03DFE1E;
        Fri, 27 Aug 2021 21:54:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wp7TFrIeCbJo
        RVptaFO1TxvnH+1xqyBSHtiz+7lZBaA=; b=xFSRfkeYKmYUBNG1fERXDEK9cc01
        IkYoFuc2/aAgiYwIanR5wZtPocTWZen8ZBKj1TAnS6HvzFwX0OaFSlpHoGmLRWN8
        z7P+YXwtuYkTpWx+thfF/0S+Fnc7szLp0UKswV0kAx7tURH2IQa4siWU0KdR9gf7
        h8zgZrQcDlzU0TI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FD57DFE1D;
        Fri, 27 Aug 2021 21:54:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D4D8DFE1B;
        Fri, 27 Aug 2021 21:54:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 5/5] bundle: show progress on "unbundle"
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
        <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com>
        <patch-v3-5.5-cd38b0f0fed-20210826T140414Z-avarab@gmail.com>
Date:   Fri, 27 Aug 2021 18:54:12 -0700
In-Reply-To: <patch-v3-5.5-cd38b0f0fed-20210826T140414Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 26 Aug
 2021 16:05:51
        +0200")
Message-ID: <xmqqmtp28hbv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D7F1FB8E-07A2-11EC-AFCD-D601C7D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +	if (progress) {
> +		strvec_push(&extra_args, "-v");
> +		strvec_push(&extra_args, "--progress-title");
> +		strvec_push(&extra_args, _("Unbundling objects"));

Nice.  I would have expected to see pushl() though.

> +	}
> +
> +	ret =3D !!unbundle(the_repository, &header, bundle_fd, progress ?
> +			 &extra_args : NULL) ||

Again, I wouldn't make the &extra_args conditional to progress
here.  Future code change may decide to pass more args to underlying
index-pack and the criteria for doing so may be different from
progress.

If this code cares about readability, it should uncondtionally pass
&extra_args.

If this code cares about readability *and* micro-optimization, then
the condition should be on !!extra_args.nr, not on whatever set of
conditions happen to be used in today's code to throw items into
extra_args array.

Other than that, this was a pleasant read.

Thanks.
