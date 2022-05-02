Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99348C433F5
	for <git@archiver.kernel.org>; Mon,  2 May 2022 20:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbiEBU1i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 16:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235720AbiEBU1g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 16:27:36 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB83B12D
        for <git@vger.kernel.org>; Mon,  2 May 2022 13:24:06 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0A1191856E6;
        Mon,  2 May 2022 16:24:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t04CcEw6F0lcIdenKWuXgQc7YX4ePKeOTxz7or
        /o0To=; b=D4Jwoj+d4fSK/gjeHug/5lsvBU0XvhGh9Q8Jize46kNy61pncFExXU
        P9eN2Niy3v1zngcRqXbsqIhmlRNpJurMpA6apwIiX4wCzB+PSVlCRUgaPltaYHcp
        CCPQogjliSczSQLSTWkrZc54IqwmI4PpuRsNg9n2Tkai6C/7jBKXk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 025E61856E5;
        Mon,  2 May 2022 16:24:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 827CE1856E3;
        Mon,  2 May 2022 16:24:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brad Beam <brad.beam@b-rad.info>
Cc:     git@vger.kernel.org
Subject: Re: Bug report - ssh signing causes git tag -l malloc failed
References: <16668F1B-7670-4136-8AAF-ABAAA802C7D4@b-rad.info>
Date:   Mon, 02 May 2022 13:24:01 -0700
In-Reply-To: <16668F1B-7670-4136-8AAF-ABAAA802C7D4@b-rad.info> (Brad Beam's
        message of "Mon, 2 May 2022 14:51:33 -0500")
Message-ID: <xmqq7d73y97i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE664BA8-CA55-11EC-9AEA-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brad Beam <brad.beam@b-rad.info> writes:

Thanks for a report.


> What did you do before the bug happened? (Steps to reproduce your issue)
>
> When using ssh signing `git tag -l --format='%(contents:body)' <tag>` returns `fatal: Out of memory, malloc failed (tried to allocate 18446744073709551323 bytes)`

An obvious first follow-up question is if there is any difference in
behaviour if another kind of signing (like PGP) is used.

> What did you expect to happen? (Expected behavior)
>
> The tag to be returned without crashing
>
> What happened instead? (Actual behavior)
>
> git crashed with the above error (`fatal: Out of memory, malloc failed (tried to allocate 18446744073709551323 bytes)`)
>
> What's different between what you expected and what actually happened?
>
> Anything else you want to add:
>
>
> ```
> [14:23:54] (0):~/src/github.com/my/repo
> % git tag -sam v0.0.9 v0.0.9

Here, or before this step, there would probably have been something
to say "No, I do not use the default PGP sign, but I want SSH sign"?

For those who are reading this bug report and mistakenly thought it
is a bug to show a self-recursive tag (like I did during my first
reading of the report), the first v0.0.9 is merely an argument to
the "-m" option, and the second v0.0.9 is the name of the newly
created tag.  We are creating a signed tag with v0.0.9 in the
message that points at HEAD and has "tag v0.0.9" in the header, and
storing the resulting tag at refs/tags/v0.0.9

