Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B123EB64D7
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 16:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjF3QpP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 12:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjF3QpI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 12:45:08 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9822E3AAF
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 09:45:07 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F0959284FC;
        Fri, 30 Jun 2023 12:45:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7+iE5IabyZpM/DpMX6IIGifRazBmgVIakB8xha
        68FNk=; b=hZmc8ZoEcH0FpTY2C97H6NF9w16q7qPd6QlIfDDJPjyXUA7QHZeSDx
        seAwVlhRb0y57JgStfvU0rOU6unoz52mE3nRFugkIp0UgnYnWEygAOMcjEitSn/9
        WFzI7+STttdUbRzNMHvyepuhJJV2l18IYT7QN+Nnjj9USMlV5J5k0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D49BB284FB;
        Fri, 30 Jun 2023 12:45:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BB038284F3;
        Fri, 30 Jun 2023 12:45:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Son Luong Ngoc <sluongng@gmail.com>
Cc:     Adam Majer <adamm@zombino.com>, Patrick Steinhardt <ps@pks.im>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: SHA256 support not experimental, or?
References: <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>
        <xmqqmt0iajww.fsf@gitster.g>
        <ZJ303bm+VAvp5nyV@tapette.crustytoothpaste.net>
        <xmqqa5wh9adg.fsf@gitster.g>
        <ZJ4uKYIZMxi3DHo3@tapette.crustytoothpaste.net>
        <vt3cizczmwbcpgktwrkr3jbiwhee37rt7m243hnkzxik7gt4m2@d2upsqoxtlgc>
        <5880fe56-aa98-64ce-4d91-ca078d3a7354@zombino.com>
        <CAL3xRKfQLj7Zufy5fMMs=ykeexBn7duqFH1jZ84+WRKKOaEpFA@mail.gmail.com>
Date:   Fri, 30 Jun 2023 09:45:01 -0700
In-Reply-To: <CAL3xRKfQLj7Zufy5fMMs=ykeexBn7duqFH1jZ84+WRKKOaEpFA@mail.gmail.com>
        (Son Luong Ngoc's message of "Fri, 30 Jun 2023 14:20:14 +0200")
Message-ID: <xmqqilb47vci.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75A33C20-1765-11EE-9DBD-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Son Luong Ngoc <sluongng@gmail.com> writes:

> Build tools such as Bazel would often need to hash the content of the
> source files to build a dependency graph.  And in a FUSE setup, it would
> be ideal if the FUSE server could supply the hash via an xattr, so that
> FUSE client does not need to fetch the whole file content and only the
> metadata.

This is unrelated tangent, but the implementation of virtual
filesystem on top of Git's object store will be able to give such
SHA-256 hash only by computing the hash itself, if the "hash the
content of the source files" has to be exactly SHA-256.  Using Git
repository that uses SHA-256 would *not* help.

    $ git init --object-format sha256
    $ echo hello | git hash-object --stdin
    2cf8d83d9ee29543b34a87727421fdecb7e3f3a183d337639025de576db9ebb4
    $ echo hello | sha256sum
    5891b5b522d5df086d0ff0b110fbd9d21bb4fc7163af34d08286a2e846f6be03  -

This is because the object name used by Git is not the hash of the
content.  It is a hash of an object header (object type and byte
count) followed by its contents.

    $ printf "blob 6\0hello\n" | sha256sum
    2cf8d83d9ee29543b34a87727421fdecb7e3f3a183d337639025de576db9ebb4  -

The build systems can choose to tell FUSE server to expose the Git
object names via xattr, but if it needs to see if some contents (not
in FUSE) it has on hand is the same as what is stored in the FUSE
server, it needs to use the "slightly modified SHA-256" that matches
what Git uses.  It would still be using some hash that has the same
strength as underlying SHA-256, but it is *not* SHA-256.

