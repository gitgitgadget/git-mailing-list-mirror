Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD33E82CAF
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 16:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjI0Q1G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 12:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjI0Q05 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 12:26:57 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A191BE6
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 09:26:53 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3344D1EEB1;
        Wed, 27 Sep 2023 12:26:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=RUpdxuGDLYG/iTRNDv3c5B51d3o3obOF/a3Rdm
        s8dpI=; b=ihAIDOefNTyHB7mTf45wh8O4Hi3yOlJy2RjNRsq5GPlHMaHZDABYrr
        +nTq1oed9g6aHkYphXGxlJ9CPtDIDlQ7mIHfYqGtUOSMP7RK2iPn78zpUGsMj6ib
        1yG3C8UZol7GgCYVbtClufBGoNFFy+eQufPn85CA+gPytkdFuLQJs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B9251EEB0;
        Wed, 27 Sep 2023 12:26:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9DE761EEAF;
        Wed, 27 Sep 2023 12:26:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     "Eric W. Biederman" <ebiederm@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] bulk-checkin: only support blobs in index_bulk_checkin
In-Reply-To: <ZRQ9aSeu/wpJERuV@nand.local> (Taylor Blau's message of "Wed, 27
        Sep 2023 10:34:17 -0400")
References: <878r918ps3.fsf@gmail.froward.int.ebiederm.org>
        <xmqqr0mtcosy.fsf@gitster.g>
        <87zg1h58xa.fsf@gmail.froward.int.ebiederm.org>
        <87msx99b9o.fsf_-_@gmail.froward.int.ebiederm.org>
        <xmqqmsx8mwr4.fsf@gitster.g> <ZROHrSmmZOIE6bl9@nand.local>
        <xmqqil7wmf50.fsf@gitster.g> <ZRQ9aSeu/wpJERuV@nand.local>
Date:   Wed, 27 Sep 2023 09:26:46 -0700
Message-ID: <xmqq7cobmvjt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A7A8DF26-5D52-11EE-B851-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I am not sure that I follow. If we have an address in memory from which
> we want to stream raw bytes directly to the packfile, that should work
> for all objects regardless of type, no?

For a single hash world, yes.  For keeping track of "the other hash"
and correspondence, you need to (1) interpret the contents of the
object (e.g., if you received a tree contents for SHA-1 repository,
you'd need to split them into tree entries and know which parts of
the bytestream are SHA-1 hashes of the tree contebnts), (2) come
up with the corresponding tree contents in the SHA-256 world (you
should be able to do that now you know SHA-1 names of the objects
directly referred to by the tree) and hash that using SHA-256, and
(3) remember the SHA-1 and the SHA-256 name correspondence of the
tree object you just hashed, in addition to the usual (4) hashing
the contents using SHA-1 hash algorithm without caring what the byte
stream represents.
