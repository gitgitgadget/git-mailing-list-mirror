Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659BFC433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 23:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237036AbiEJXVg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 19:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbiEJXVb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 19:21:31 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B881980A6
        for <git@vger.kernel.org>; Tue, 10 May 2022 16:21:30 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 87AC618E075;
        Tue, 10 May 2022 19:21:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qE94hJJRRhkMQjTVCnWokpNJOeQVxWX7rPom/D
        cgIVU=; b=g2w2wG4Yu12OWCmeUjoe7XcYMimWaPd/tW1CP2baxY1D06ASoKqW0q
        ZvTCcnNX+VxVxXYs7inQiwDY5aDyzVBf1DjXilQ36HT7z+2GwltuZMGzvNcPig2w
        b7w9yokBDkJi0nFuBnysm8ojptRDO0kQ8qUyp4R6+yuYvpoPhkiLE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6B9E018E074;
        Tue, 10 May 2022 19:21:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 02B8D18E073;
        Tue, 10 May 2022 19:21:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     "'Johannes Schindelin via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>,
        =?utf-8?Q?'Ren=C3=A9_Scharfe'?= <l.s.r@web.de>,
        "'Taylor Blau'" <me@ttaylorr.com>,
        "'Derrick Stolee'" <stolee@gmail.com>,
        "'Elijah Newren'" <newren@gmail.com>,
        "'Johannes Schindelin'" <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 1/7] archive: optionally add "virtual" files
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
        <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
        <45662cf582ab7c8b1c32f55c9a34f4d73a28b71d.1652210824.git.gitgitgadget@gmail.com>
        <xmqqtu9x6ovh.fsf@gitster.g>
        <03d701d864ba$46d15c10$d4741430$@nexbridge.com>
Date:   Tue, 10 May 2022 16:21:24 -0700
In-Reply-To: <03d701d864ba$46d15c10$d4741430$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Tue, 10 May 2022 18:06:56
        -0400")
Message-ID: <xmqq8rr955zf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9B6823E-D0B7-11EC-90D4-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

>>If we did "--add-virtual-file=<path>:0644:<contents>" instead from day one, it
>>certainly adds a few more lines of logic to this patch, and the calling "scalar
>>diagnose" may have to pass a few more bytes, but I suspect that such a change
>>would help the project in the longer run.
>
> Would not core.filemode=false somewhat simulate this? The
> consumer-client would not care/do anything with the mode
> anyway. Or am I missing something?

Or I must be missing something.  This is part of "git archive" where
its output is a tarball (or a zipfile) in which each entry knows its
permission bits (or at least, if it is executable).  Running "tar xf" 
or "unzip" on the receiving end of the output of this command should
set the executable bit (and other permission bits) correctly I would
certainly hope, so it does matter, no?

I did say "scalar diagnose" may not care.  But a patch to "git
archive" will affect other people, and among them there would be
people who say "gee, now I can add a handful of files from the
command line with their contents, without actually having them in
throw-away untracked files, when running 'git archive'.  That's
handy!", try it out and get disappointed by their inability to
create executable files that way.  And obviously I care more about
"git archive" than "scalar diagnose".  I very welcome to enhance the
former to support the need for the latter.  I do not see a good
reason to stop at a half-feature added to the former, even that
added half is enough to satisfy the latter, when the other half is
not all that hard to add, and it is reasonably expected that users
other than "scalar diagnose" would naturally want the other half,
too.


