Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C133C433FE
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 10:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbiBFKVK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 05:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiBFKVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 05:21:09 -0500
X-Greylist: delayed 310 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 02:21:08 PST
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E22C06173B
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 02:21:08 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AD5E218405A;
        Sun,  6 Feb 2022 05:15:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=3e7EzDZkaj2uC/iCIGnVBSlzk
        nwN2BrZmTZGBHlwgIQ=; b=xkKThC9rcGjp5yDYMXUWlPse61cR0XXGRtIC1wytf
        IB3YMe588euodMM3mTpqR1tSvIKZYYsZ9aGApefBOp0+aeoMwmC48EpLHqy0QzI5
        7bODP/3EePF8rxFHXa5Ztw3lTGgmqkrq3uLxIQFWNsLBLxkOZzmDwlHBlbiZKIeN
        KE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A4A2C184059;
        Sun,  6 Feb 2022 05:15:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.213.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 04121184057;
        Sun,  6 Feb 2022 05:15:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     "Gamblin, Todd" <gamblin2@llnl.gov>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Commit SHA1 == SHA1 checksum?
References: <ED97E252-CABA-41BB-B18C-819A5EF305E3@llnl.gov>
        <121ce485-bea8-3168-aa35-d11eb13022da@iee.email>
Date:   Sun, 06 Feb 2022 02:15:50 -0800
Message-ID: <xmqq1r0gjo6h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C3D74286-8735-11EC-83E0-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> The tag contains the sha1 hash of the release commit, which in turn
> contains the sha1 hashes of the tree that is being released, and the=C2=
=A0
> previous commit in the git history, and onward the hashes roll...

That's how a signed tag protects the commit it points at, and
everything reachable from it.  As much or as little trust you have
in SHA-1 in validating tarball.tar with its known SHA-1 checksum,
you can trust to the same degree that the commit that is pointed by
a tag is what the person who signed (with GPG) the tag wanted the
tag to point at, and in turn the trees and blobs in that commit are
what the signer wanted to have in that tagged commit, ad infinitum,
in the space dimension.  At the same time, a commit object records
the hash of the commit objects that are its parents, the whole
history of the project going back to inception can be trusted to the
same degree in the time dimension.

> https://lore.kernel.org/git/xmqqh7n5zv2b.fsf@gitster.c.googlers.com/ is
> a recent discussion on the refreshing of the PGP key. the post
> https://lore.kernel.org/git/YA3nwFcYz4tbhrlO@camp.crustytoothpaste.net/
> in the thread notes "The signature is .. over the uncompressed
> .tar ... You therefore need to uncompress it first with gunzip."

That thread has very little to do with the way how Git objects are
cryptographically protected, which I discussed earlier in this
message.

Instead, it was a discussion about how the checksum files and
tarballs at

    https://www.kernel.org/pub/software/scm/git/

relate to each other.  A typical release tarball for Git version
$VERSION has multiple tarballs git-$VERSION.tar.{gz,bz2,xz,...} and
they all uncompresses back to the same git-$VERSION.tar tarball.

There is git-$VERSION.tar.sign file next to them in the same
directory.  The file is supposed to contain a detached signature
over the uncompressed version of the archive.

