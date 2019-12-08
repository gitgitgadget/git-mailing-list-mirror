Return-Path: <SRS0=+MKA=Z6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27FFC43603
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 05:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3CA20692
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 05:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="w3dRIi9b";
	dkim=pass (1024-bit key) header.d=kyleam.com header.i=@kyleam.com header.b="WnsdY0Bm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfLHFb0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Dec 2019 00:31:26 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63208 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbfLHFbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Dec 2019 00:31:25 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3615798A95;
        Sun,  8 Dec 2019 00:31:25 -0500 (EST)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=1ASZ90zct6nhfn8godS9FHpKuKk=; b=w3dRIi
        9bdG/jOya+dug6KInKPrvMzmhf94d4y+JvyiGi01YgOxOx66+wSPt5G7Ejwq5gck
        ZvXRdYiG8tPm5LByaIXNoJYnlvtBfcmwN2kMz8BissHRtYo3bluzXAgTfsPsBOmX
        mlhvBxN2ZhRZ5gttinlEGyRGPeHG7ENx1b4ys=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1C55898A94;
        Sun,  8 Dec 2019 00:31:25 -0500 (EST)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=rRNGObrAWuOb8eJR7PAN+UTobm6ROUbKGbLvoQsCyBo=; b=WnsdY0BmaZd6NMzbP4hB37Xp4lqxANNBhASOZ/62Tmryr9rbmnkgONvie/BLOtlDVObmg2kpbqLiDxpEVOkb6iO/Z/L7Hq/UE5NuDWLz2jkofqMRkSIAtQydlrQDa72yO1xhDJoPO1Rgc3Uq1anwq4VtyfcZ0mSXVw9hodGlYWw=
Received: from localhost (unknown [45.33.91.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7EF8D98A93;
        Sun,  8 Dec 2019 00:31:22 -0500 (EST)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG?] ls-files -o now traverses nested repo when given multiple pathspecs
In-Reply-To: <874kyf6en3.fsf@kyleam.com>
References: <874kyf6en3.fsf@kyleam.com>
Date:   Sun, 08 Dec 2019 00:31:20 -0500
Message-ID: <871rtfv0wn.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F847CBF0-197B-11EA-888F-B0405B776F7B-24757444!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Meyer <kyle@kyleam.com> writes:

> Elijah Newren <newren@gmail.com> writes:
>> [...]
>> At least my changes in git-2.24.0 made the behavior consistent; it'll
>> always traverse into a directory that matches a given pathspec.
>
> I might be getting mixed up, but the changes in 2.24.0 did introduce
> some inconsistent behavior (in the no trailing slash case) with respect
> to giving a single pathspec and giving multiple pathspecs, no?  Using
> your example:
>
>     $ git --version
>     git version 2.24.0
>     $ git ls-files -o untracked_repo
>     untracked_repo/
>     $ git ls-files -o untracked_repo empty
>     empty
>     untracked_repo/
>     untracked_repo/empty

It looks like the "multiple pathspecs trigger traversal" change isn't
limited to nested repositories.  It can also be observed with
--directory and plain untracked directories.  Assume the tree layout
from your example again.  With a single pathspec (and no slash),
'ls-files -o --directory' will not expand the untracked directory's
contents:

    $ git ls-files -o --directory untracked_dir
    untracked_dir/

But, as of 89a1f4aaf7, tacking on an additional pathspec will cause
ls-files to traverse into the untracked directory:

    $ git ls-files -o --directory untracked_dir empty
    empty
    untracked_dir/
    untracked_dir/empty

In contrast, on 89a1f4aaf7^ the same command shows

    $ git ls-files -o --directory untracked_dir empty
    empty
    untracked_dir/
