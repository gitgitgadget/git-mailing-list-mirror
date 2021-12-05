Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB86C433F5
	for <git@archiver.kernel.org>; Sun,  5 Dec 2021 05:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhLEFyL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 00:54:11 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50118 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhLEFyL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 00:54:11 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4FCAE16FCDE;
        Sun,  5 Dec 2021 00:50:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wo6yGymiqAMv/SbIPlXXXkONd6ES2tmjZNqF5y
        ovc8I=; b=QZ4fWGFXRzq7+lycHJuxBaaX0xdKftVLrGDUKCnk8K3Zec1QJVyboH
        Clf5wIfmfyeWi2IikSUN/eT8GD4dQAf+SWNAyZ/fDs/8hqNTWy9oZC+QkszpOojl
        b/OHb1eMwSLRNzhdH8Glucj0W1f0kacHqJpVWiOtcSSUVuVOhAxMc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3B03416FCDD;
        Sun,  5 Dec 2021 00:50:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 37E2216FCDC;
        Sun,  5 Dec 2021 00:50:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        pedro martelletto <pedro@yubico.com>,
        Damien Miller <djm@mindrot.org>
Subject: Re: [PATCH] gpg-interface: trim CR from ssh-keygen -Y find-principals
References: <pull.1090.git.1638538276608.gitgitgadget@gmail.com>
        <Yao+l0ckDWZNf4AE@coredump.intra.peff.net>
        <20211204131149.cvyu7dvf6p66dotq@fs>
Date:   Sat, 04 Dec 2021 21:50:38 -0800
In-Reply-To: <20211204131149.cvyu7dvf6p66dotq@fs> (Fabian Stelzer's message of
        "Sat, 4 Dec 2021 14:11:49 +0100")
Message-ID: <xmqqk0gjob0x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 470E67A2-558F-11EC-AECE-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> On 03.12.2021 10:58, Jeff King wrote:
>>On Fri, Dec 03, 2021 at 01:31:16PM +0000, Johannes Schindelin via GitGitGadget wrote:
>>
>>> We need to trim \r from the output of 'ssh-keygen -Y find-principals' on
>>> Windows, or we end up calling 'ssh-keygen -Y verify' with a bogus signer
>>> identity. ssh-keygen.c:2841 contains a call to puts(3), which confirms this
>>> hypothesis. Signature verification passes with the fix.
>>> [...]
>>> @@ -497,7 +497,7 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
>>>  			if (!*line)
>>>  				break;
>>>
>>> -			trust_size = strcspn(line, "\n");
>>> +			trust_size = strcspn(line, "\r\n");
>>>  			principal = xmemdupz(line, trust_size);
>>
>>Just playing devil's advocate for a moment: this parsing is kind of
>>loose. Is there any chance that I could smuggle a CR into my principal
>>name, and make "a principal\rthat is fake" now get parsed as "a
>>principal"? Our strcspn() here would cut off at the first CR.
>>
>>I'm guessing probably not, but when it comes to something with security
>>implications like this, it pays to be extra careful. I'm hoping somebody
>>familiar with the ssh-keygen side and how the rest of the parsing works
>>(like Fabian) can verify that this is OK.
>>
>
> A good point. I just tested this and CR is a valid character to use in
> a principal name in the allowed signers file and as of now the
> principal will be passed to the verify call `as is` and everything
> works just fine. When we introduce the patch above a principal with a
> CR in it will fail to verify.
>
> I've added Damien Miller to this thread. He knows more about what the
> expected behaviour for the principal would/should be. I think at the
> moment almost everything except \n or \0 goes. Maybe restricting \r as
> well would make life easier for other uses too?
>
> From a security perspective I don't think this is problem. The
> principal does not come from any user input but is actually looked up
> in the allowed signers file using the signatures public key (with
> ssh-keygen -Y find-principals).  If I could manipulate this file I
> could change the key as well.
>
> If we add `trust on first use` in a future series I would assume we
> use the email address from the commit/tag author ident when adding a
> new principal to the file. Can the ident contain a CR?
> Even if it did, I would only allow a list of allowed alphanumeric
> chars to be added anyway since a principal can contain wildcards which
> we obviously don't want to trust on first use ;).

So instead of the posted patch, we should do something along this
line instead?

	trust_size = strcspn(line, "\n"); /* truncate at LF */
	if (trust_size && line[trust_size - 1] == '\r')
		trust_size--; /* the LF was part of CRLF at the end */


