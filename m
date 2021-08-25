Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78CEC432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 17:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CF866103B
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 17:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242350AbhHYRwq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 13:52:46 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52268 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhHYRwp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 13:52:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 87C8D14118F;
        Wed, 25 Aug 2021 13:51:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ac207D96jGQQ7hzcmWwCSuPJaBUHAPje7nQAwL
        LuUgE=; b=p4t8YZhZ+8EFdbEa79eewo6oH8btVzd1lzbmMka4/oQNOAqalqRCks
        QodH00YiOv0eBvTV/OCOzcDWPkOlpNQSsjmvFVDtAVD6k87o/yJMd/v+vyaIe17j
        RhiN8Sf6XlvIs78crKfVuTQtnxyV5ad1e+mCYIQhhrwjgvbi5vvPw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 800F114118E;
        Wed, 25 Aug 2021 13:51:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CAF6D14118C;
        Wed, 25 Aug 2021 13:51:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch: skip formatting updated refs with `--quiet`
References: <40c385048a023dbd447c5f0b4c95ff32485e1e23.1629906005.git.ps@pks.im>
Date:   Wed, 25 Aug 2021 10:51:55 -0700
In-Reply-To: <40c385048a023dbd447c5f0b4c95ff32485e1e23.1629906005.git.ps@pks.im>
        (Patrick Steinhardt's message of "Wed, 25 Aug 2021 17:45:09 +0200")
Message-ID: <xmqqv93tif9g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23C91F2E-05CD-11EC-A1D9-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> When fetching, Git will by default print a list of all updated refs in a
> nicely formatted table. In order to come up with this table, Git needs
> to iterate refs twice: first to determine the maximum column width, and
> a second time to actually format these changed refs.
>
> While this table will not be printed in case the user passes `--quiet`,
> we still go out of our way and do all these steps. In fact, we even do
> more work compared to not passing `--quiet`: without the flag, we will
> skip all references in the column width computation which have not been
> updated, but if it is set we will now compute widths for all refs.

Interesting.  This line

	/* uptodate lines are only shown on high verbosity level */
	if (!verbosity && oideq(&ref->peer_ref->old_oid, &ref->old_oid))
		return;

at the beginning of the adjust_refcol_width() function indeed does
not skip if verbosity is negative, so the comment is wrong---it is
not only computed on high verbosity level.  Why doesn't this patch
include a change like this then?

	if (verbosity <= 0 || oideq(&ref->peer_ref->old_oid, &ref->old_oid))
		return;

Another thing I notice is this part from store_updated_refs():

			if (note.len) {
				if (verbosity >= 0 && !shown_url) {
					fprintf(stderr, _("From %.*s\n"),
							url_len, url);
					shown_url = 1;
				}
				if (verbosity >= 0)
					fprintf(stderr, " %s\n", note.buf);
			}

We no longer need to check for verbosity, right?

Other than these two, I like the approach a lot.

