Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835D3C43334
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 16:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiGTQI6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 12:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGTQI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 12:08:57 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BAF4AD56
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 09:08:55 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 88FE512E85D;
        Wed, 20 Jul 2022 12:08:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=75hxNS3yrl6ug75oxVzxVHaebkqfwoclyl6wsC
        mRX8U=; b=lQ/JkqfYeHo8M6aNb/cC3IcxBZoDpZNGHUp3UEVXA/DggE0WSl8Su5
        wOIP1pGkFAYuwoYyt3ftE+lzqFO0em4c5ol4matgjiHG6+GTVB6dqM104xkwsOXC
        KSCqjuNeNR3ZlfATBgFb1pr/m5uNwN9/bwfMnwLJKKYltrkxwvV0U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F81C12E85C;
        Wed, 20 Jul 2022 12:08:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E1FD612E85B;
        Wed, 20 Jul 2022 12:08:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Moritz Baumann via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>,
        Moritz Baumann <moritz.baumann@sap.com>
Subject: Re: [PATCH] git-p4: fix crlf handling for utf16 files on Windows
References: <pull.1294.git.git.1658294873702.gitgitgadget@gmail.com>
Date:   Wed, 20 Jul 2022 09:08:52 -0700
In-Reply-To: <pull.1294.git.git.1658294873702.gitgitgadget@gmail.com> (Moritz
        Baumann via GitGitGadget's message of "Wed, 20 Jul 2022 05:27:53
        +0000")
Message-ID: <xmqqilnr4vhn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40648FCA-0846-11ED-B959-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Moritz Baumann via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Moritz Baumann <moritz.baumann@sap.com>

Can you describe briefly what problem is being solved and how the
change solves it in this place above your Sign-off?  The title says
"fix", without saying how the behaviour by the current code is
"broken", so that is one thing you can describe.  It talks about
"UTF-16 files on Windows", but does it mean git-p4 running on
Windows or git-p4 running anywhere that (over the wire) talks with
P4 running on Windows?  IOW, would the same problem trigger if you
are on macOS but the contents of the file you exchange with P4
happens to be in UTF-16?

These are the things you can describe to help those who are not you
(i.e. without access to an environment similar to what you saw the
problem on) understand the issue and help them convince themselves
that the patch they are seeing is a sensible solution.  Without any,
it is hard to evaluate.

> Signed-off-by: Moritz Baumann <moritz.baumann@sap.com>
> ---

> diff --git a/git-p4.py b/git-p4.py
> index 8fbf6eb1fe3..0a9d7e2ed7c 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -3148,7 +3148,7 @@ class P4Sync(Command, P4UserMap):
>                      raise e
>              else:
>                  if p4_version_string().find('/NT') >= 0:
> -                    text = text.replace(b'\r\n', b'\n')
> +                    text = text.replace(b'\x0d\x00\x0a\x00', b'\x0a\x00')
>                  contents = [text]
>  
>          if type_base == "apple":

OK, the part being touched is inside this context:

        if type_base == "utf16":
            # ...
            # But ascii text saved as -t utf16 is completely mangled.
            # Invoke print -o to get the real contents.
            #
            # On windows, the newlines will always be mangled by print, so put
            # them back too.  This is not needed to the cygwin windows version,
            # just the native "NT" type.
            #

            try:
                text = ...
            except Exception as e:
                ...
            else:
                if p4_version_string().find('/NT') >= 0:
                    text = text.replace(b'\r\n', b'\n')
                contents = [text]

So the intent of the existing code is "we know we are dealing with
UTF-16 text, and after successfully reading 'text' without
exception, we need to convert CRLF back to LF if we are on 'the
native NT type'".  Presumably 'text' that came from
p4_read_pipe(... raw=True) is not unicode string but just a bunch of
bytes, so each "char" is represented as two-byte sequence in UTF-16?

With that (speculative) understanding, I can guess that the patch
makes sense, but the patch should not make readers guess.

Thanks.
