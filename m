Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AEBC433E7
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 20:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F5A920714
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 20:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GEfM0hUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439725AbgJQUSp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 16:18:45 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57896 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729935AbgJQUSo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 16:18:44 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 22AB31090B9;
        Sat, 17 Oct 2020 16:18:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+pQSONcS6eZU+JziIOklNXQA+jQ=; b=GEfM0h
        Ud4pOK7nZ43A7YZtL66sQ/ZtHMKlJXgrSAIjvuqN39eFucVFEfKd3Q8KHS61x7ps
        2m7/1IsQO5e3+Nmgpj+e9h/1DvyGra4i4YpvYF7UMUEkTsVJRoquJSfxNT3RfvIn
        PJhxPO/RlTE+Rfgxuh1CnQjZoUcDhYuOvSSu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=baysl2Fd8+TiqC0DsduX5o9UoBSXVU9F
        xaHVkdaPyfLIw5E2EeS4HPPkKMYq1aOMxWSv8n61zPOpPfyeO/UDlvWUCA7BZYPx
        zJuPO2d9YTgR6h8dnJruUxic+4vLLnuVJmhBfoqZQBS++PgqqYYcw2dY4KDBJS2R
        sTZghQPbPf0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1B0B61090B8;
        Sat, 17 Oct 2020 16:18:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 551F31090B7;
        Sat, 17 Oct 2020 16:18:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Why does git diff-index show intent-to-add file as "Added"?
References: <20201017162111.gvisfz2daqvhnjmb@yadavpratyush.com>
Date:   Sat, 17 Oct 2020 13:18:38 -0700
In-Reply-To: <20201017162111.gvisfz2daqvhnjmb@yadavpratyush.com> (Pratyush
        Yadav's message of "Sat, 17 Oct 2020 21:51:11 +0530")
Message-ID: <xmqqimb88v35.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2357078-10B5-11EB-8935-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> In this case, running diff-files gives:
>
>   :000000 100644 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 A	foo

Yes, it says "when comparing the index and the working tree, working
tree side has it, and the index side does not, so it is an addition".

Of course, if it is truly a new file that the index does not even
know about, we'd stay silent, but a path that are marked with i-t-a
bit is what the user told us to keey an eye on, so that is what you
would get.

> Running diff-index gives:
>
>   :000000 100644 0000000000000000000000000000000000000000 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 A	foo

If this is "diff-index HEAD", then I think it is expected.  "when
comparing the HEAD and the working tree, working tree side has it,
and the tree side does not, so it is an addition."  Exactly the same
story as "diff-files".

What should happen in "diff-index --cached HEAD", I offhand do not
know.  "diff-index --cached HEAD" is a request to compare two trees,
i.e. the tree that _would_ be produced if you wrote the index out as
a tree (i.e. "git write-tree") right now, and the tree of HEAD.  So
I think it may be sensible for the command to behave as if the i-t-a
path does not even exist in the index when it is run with "--cached";
I may be missing some subtleties that require us to do something
different, but that is what I would think.


