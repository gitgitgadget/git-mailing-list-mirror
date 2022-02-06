Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C4DC433EF
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 20:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242621AbiBFUEl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 15:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiBFUEk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 15:04:40 -0500
X-Greylist: delayed 120 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 12:04:39 PST
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510A0C06173B
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 12:04:39 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D2736105AE6;
        Sun,  6 Feb 2022 15:02:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EUan4xEYLDp8JRl8V5xjGXc9yEPouzKI4lLBXk
        t+/0Q=; b=fVGmsAzog0pZapB2016/QX0QssRHABxcn38KPFZTf9IeFCviJ+1dBa
        0tXinEiZcLxx0jlZETOPzQfT14OVuhYuwVCf0G/+VSZZCRM6H37KYSv9bfytJTFN
        9kBY9xxgoVZtcjC2dVmYwqQK2tGg3iTHmLp6UuhWYEnVhMNTXdr5o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C9D3D105AE4;
        Sun,  6 Feb 2022 15:02:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.213.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4CDC2105AE1;
        Sun,  6 Feb 2022 15:02:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     "Gamblin, Todd" <gamblin2@llnl.gov>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Commit SHA1 == SHA1 checksum?
References: <ED97E252-CABA-41BB-B18C-819A5EF305E3@llnl.gov>
        <121ce485-bea8-3168-aa35-d11eb13022da@iee.email>
        <xmqq1r0gjo6h.fsf@gitster.g>
        <eca83634-ee91-89bd-567e-6b0807b5ff79@iee.email>
Date:   Sun, 06 Feb 2022 12:02:34 -0800
In-Reply-To: <eca83634-ee91-89bd-567e-6b0807b5ff79@iee.email> (Philip Oakley's
        message of "Sun, 6 Feb 2022 19:25:27 +0000")
Message-ID: <xmqqee4fix0l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BA0BF5E2-8787-11EC-9F09-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> I think part of Todd's question was how the tag and uncompressed archive
> 'checksums' (e.g. hashes) relate to each other and where those
> guarantees come from.

There is no such linkage, and there are no guarantees.  The trust
you may or may not have on the PGP key that signs the tag and the
checksums of the tarball is the only source of such assurance.

More importantly, I do not think there can be any such linkage
between the Git tree and release tarball for a few fundamental
reasons:

 * We add generated files to "git archive" output when creating the
   release tarball for builder's convenience, so if you did

       rm -fr temp && git init temp
       tar Cxf temp git-$VERSION.tar
       git -C temp add . && git -C temp write-tree

   the tree object name that you get out of the last step will not
   match the tree object of the version from my archive (interested
   parties can study "make dist" for more details).

 * Even if we did not add any files to "git archive" output when
   creating a release tarball, a tarball that contains all the
   directories and files from a given git revision is *NOT* unique.
   We do not add randomness to the "git archive" output, just to
   make them unstable, but we have made fixes and improvements to
   the archive generation logic in the past, and we do reserve the
   rights to do so in the future.  And it is not just limited to
   "git archive" binary, but how it is driven, e.g. "tar.umask"
   settings can affect the mode bits.
