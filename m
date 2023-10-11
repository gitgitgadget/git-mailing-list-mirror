Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBBECDB46B
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 16:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjJKQyj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 12:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjJKQyi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 12:54:38 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9858F
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 09:54:37 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D95012FDD8;
        Wed, 11 Oct 2023 12:54:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=0X+b1nWx0KHRlt0UHVp2RAecj0MoWQs48k9Th4
        ZOVPw=; b=R5P1qVqn8/hPCPKNFI9vfvhyeV9vjQHp08SwTzFQQtRf48WtKifii0
        eoSLxDRkiTI3eDq5jRVysPCfcJoRXfoUO7bqE4WoqK0K+FAUeETz2ljElQWwNRzj
        d5+DD9Ui16XyLqJfIv1P0psYJT7Ry2c9RmVUOVr2vbe4w6p2yeiiE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D1F092FDD7;
        Wed, 11 Oct 2023 12:54:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 128672FDD6;
        Wed, 11 Oct 2023 12:54:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] rev-list: add support for commits in `--missing`
In-Reply-To: <CAOLa=ZSbd_E+DAkhuGrUpfHkxaje3jrH9-fEDyctAPFExKnj9A@mail.gmail.com>
        (Karthik Nayak's message of "Wed, 11 Oct 2023 12:37:03 +0200")
References: <20231009105528.17777-1-karthik.188@gmail.com>
        <ZSTs3BUVtaI9QIoA@tanuki> <xmqqil7etndo.fsf@gitster.g>
        <CAOLa=ZSbd_E+DAkhuGrUpfHkxaje3jrH9-fEDyctAPFExKnj9A@mail.gmail.com>
Date:   Wed, 11 Oct 2023 09:54:31 -0700
Message-ID: <xmqqbkd5nlq0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA1DB9C2-6856-11EE-98B4-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

> Seems like this is because of commit-graph being enabled, I think
> the best thing to do here would be to disable the commit graph of
> these tests.

If the CI uncovered that the new code is broken and does not work
with commit-graph, wouldn't the above a totally wrong approach to
correct it?  If the updated logic cannot work correctly when
commit-graph covers the history you intentionally break, shouldn't
the code, when the feature that is incompatible with commit-graph is
triggered, disable the commit-graph?  I am assuming that the new
feature is meant to be used to recover from a corrupt repository,
and if it does not work well when commit-graph knows (now stale
after repository corruption) more about the objects that are corrupt
in the object store, we do want to disable commit-graph.  After all,
commit-graph is a secondary information that is supposed to be
recoverable from the primary data that is what is in the object
store.  Disabling commit-graph in the test means you are telling the
end-users "do not use commit-graph if you want to use this feature",
which sounds like a wrong thing to do.
