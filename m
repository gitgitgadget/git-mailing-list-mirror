Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF1AC433EF
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 17:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349021AbiDKR5v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 13:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349056AbiDKR5m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 13:57:42 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99781DA75
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 10:55:27 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 20710186A18;
        Mon, 11 Apr 2022 13:55:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R3qFRnICHVXBrizLllRBHHJYHngeZ6BGT36AHP
        sdv5M=; b=tEOww+8ocZx1OtPa0VmuvpeW0t8ixkilI49+8ChoQM3XShky92LVm0
        hVjHkgxzuOCw/AkOCacNQz1WX9h/ZAtnyAipQ5AlzxVztm8Llw9aRExDOHHpveAq
        23cRtbxpE4W+VL8sQo0GDNR/QhfC1aPxdO70+/Bb1zkORlb1lKL0o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 19411186A17;
        Mon, 11 Apr 2022 13:55:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6FAA4186A15;
        Mon, 11 Apr 2022 13:55:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        joostkremers@fastmail.fm, Kyle Meyer <kyle@kyleam.com>
Subject: Re: [PATCH] stash: disable literal treatment when passing top pathspec
References: <20220408031228.782547-1-kyle@kyleam.com>
        <xmqqa6cvmmzn.fsf@gitster.g> <877d7y3nif.fsf@kyleam.com>
Date:   Mon, 11 Apr 2022 10:55:23 -0700
In-Reply-To: <877d7y3nif.fsf@kyleam.com> (Kyle Meyer's message of "Sat, 09 Apr
        2022 00:10:32 -0400")
Message-ID: <xmqq8rsbjyic.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 90234B70-B9C0-11EC-8BC4-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Meyer <kyle@kyleam.com> writes:

> However, for --include-untracked/clean case, the subprocess directory is
> set to startup_info->original_cwd since 0fce211ccc (stash: do not
> attempt to remove startup_info->original_cwd, 2021-12-09).

Interesting.  I find the logic there a bit convoluted.  IIUC, it
goes like this:

 - we do not want to lose the directory our process was originally
   in, which is recorded in startup_info->original_cmd.

 - we have gone up to the root of the working tree, and running
   "clean" from there is what we want---even if we started "git
   stash" from a subdirectory, we want to make the entire working
   tree clean, not just inside our subdirectory.

 - but we came up with a hack that allows us to skip removing the
   directory the Git process started at.  To take advantage of the
   mechanism, we'd need to start from that original_cmd.

 - but then "clean" run from that subdirectory normally cleans only
   that subdirectory, which is not what we want to do.  To work it
   around, we'd need to pass :/ pathspec to say that we are cleaning
   from the top.

It makes me suspect that "we protect current directory" is a too
specialized way that didn't really consider the possibility that we
sometimes spawn a subcommand.  Even "we protect this directory" may
not be sufficient and we may need a "we protect these directories",
I suspect.  When the user originally starts "git foo" in one
directory, which may have to run "git bar" in another directory, and
"git bar" would want to protect the directory it starts in and also
where "git foo" started from, no?  It almost makes me suspect that
we'd want some "git" wide option that allows us to pass a list of
paths not to rmdir, whose default value is ["."], or something.

Elijah, thoughts?

But as a short-term fix, I think "--no-literal-pathspecs" is fine for
this code path.

Thanks.



