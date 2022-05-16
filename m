Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE87C433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 15:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244950AbiEPPTG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 11:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245139AbiEPPTE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 11:19:04 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEF33BBDD
        for <git@vger.kernel.org>; Mon, 16 May 2022 08:19:00 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 52A2918E161;
        Mon, 16 May 2022 11:18:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Dsi1c3+JVLkwXUDxzKom5+iLbqrobctXQj3CnK
        7jLZQ=; b=ifIlLxByZ5jIW0pmYip12v48kU6hpzuvVqFvX5ZYltKpnwsphlmujl
        sJsD6lTfqnZ8RgzvM+GlfiNADPAUcXXSAp4VbCKzmedHODpd2GovuHf6nWE7ZoNK
        FrMXSElk1pRGfuf6fbFbol+0ZfV5XxVpbr0D/tIuEb5+GKiPeEc9g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4A98118E160;
        Mon, 16 May 2022 11:18:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E4DBF18E15C;
        Mon, 16 May 2022 11:18:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Eggert <eggert@cs.ucla.edu>
Cc:     "Carlos L. via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "Carlos L." <00xc@protonmail.com>,
        GNU grep developers <grep-devel@gnu.org>
Subject: Re: [PATCH] grep: add --max-count command line option
References: <pull.1264.git.git.1652361610103.gitgitgadget@gmail.com>
        <xmqqilq658b3.fsf@gitster.g>
        <e89577f8-8f52-bf09-15f3-c534bf1a6c64@cs.ucla.edu>
Date:   Mon, 16 May 2022 08:18:54 -0700
In-Reply-To: <e89577f8-8f52-bf09-15f3-c534bf1a6c64@cs.ucla.edu> (Paul Eggert's
        message of "Mon, 16 May 2022 00:28:16 -0700")
Message-ID: <xmqqee0t5wv5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 809A3A98-D52B-11EC-B7B9-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Eggert <eggert@cs.ucla.edu> writes:

> On 5/15/22 22:57, Junio C Hamano wrote:
>
>> It indeed is curious why GNU grep chose to immediately exit with 1
>> when "-m 0" was given,
>
> As I vaguely recall, if "-m 1" stops before "-m 2" does, then the idea
> was that it's reasonable for "-m 0" to stop before "-m 1" does, and
> the logical place to stop is right at the start, before any matches
> are found (i.e., exit with status 1).
>
> What would be more useful for 'grep -m 0' to do? (Sorry, I came into
> this conversation just now.) Perhaps GNU 'grep -m 0' should change, if 
> there's something better for it to do.

"grep -m 0" that declares a failure upfront because it is asked to
stop before finding any match, combined with the fact that the
command is expected to signal a failure after finding no matches, is
an optimization that is mathmatically correct ;-)

It was asked as a part of discussion on a proposed patch to teach
the same "-m <max-number-of-hits>" option to "git grep" what it
ought to mean to give "-m 0".  As we are too accustomed to the "last
command line option wins" behaviour, I initially did not find the
behaviour of the proposed patch, where 0 (or negative) stood for
"unlimited", quite natural and useful (e.g. it allows overriding a
hardcoded default option in aliases, "[alias] gg = grep -m 4"), and
then was surprised by the "'-m 0' is an immediate failure" in GNU
grep.  I would call it mathematically pure and correct but of
dubious utility.

Sorry for not providing enough context.  Full discussion is seen at 
https://lore.kernel.org/git/pull.1264.git.git.1652361610103.gitgitgadget@gmail.com/

>> What "git grep -m -1" should do?  IIRC, OPT_INTEGER is for signed
>> integer but the new .max_count member, as well as the existing
>> "count" that is compared with it, are of "unsigned" type.  Either
>> erroring out or treating it as unlimited is probably fine, but
>> whatever we do, we should document and have a test for it.
>
> 'grep -m -1' treats the count as being unlimited, but this isn't
> documented and (from the code) appears to be accidental. It'd make
> sense for it to be documented.

Thanks.  The question was asked for the proposed addition to "git
grep", but it is funny to see it apply equally well to GNU grep ;-).

