Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA599C001DF
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 21:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjHCVxX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Aug 2023 17:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjHCVxW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2023 17:53:22 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92B41BF9
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 14:53:20 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F11D19CBF7;
        Thu,  3 Aug 2023 17:53:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jCl0d0sWW8fGfSiryMUx+/40WjSTZTU/3Zf73o
        A7aD0=; b=R4Zk/wtL0Ti+als8XvWtuYja8xg4q1uAlO/ew82ExrftDrQTLt46L3
        xnN5m7kVPwDDjjo7kl79Q4IPWekIg9Exq8a76hBZI67kcwi8QLawZ52CRy1HQlMd
        HrCcN6BZ17ZIo7dVIHhsQ18W99jFPk+GrK7fC74mM81EHB07fx4xc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26B8B19CBF6;
        Thu,  3 Aug 2023 17:53:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8281D19CBF5;
        Thu,  3 Aug 2023 17:53:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Hilco Wijbenga <hilco.wijbenga@gmail.com>, git@vger.kernel.org,
        Aleem Zaki <aleemzaki@gmail.com>
Subject: Re: .gitignore is not enough
References: <CA+sf2-+499Nfu00ciJeLwjRmBE7Bb-WZcZuCXY2-JXs88Pwz-w@mail.gmail.com>
        <CAE1pOi1Zt8i_rVi6dCGVsshhPxa_kV7qQ7SMu6R4nsSiadq7xw@mail.gmail.com>
        <c2fea20d-af37-8721-5bd8-14bbc3daf937@kdbg.org>
        <CAE1pOi1xtaEo6LtF4VnXetmLYK5VbYU5uq7gGC=PpnVB3MWdag@mail.gmail.com>
        <e453bee1-942f-ea9a-9c50-3cf5d0f9e936@kdbg.org>
Date:   Thu, 03 Aug 2023 14:53:18 -0700
In-Reply-To: <e453bee1-942f-ea9a-9c50-3cf5d0f9e936@kdbg.org> (Johannes Sixt's
        message of "Thu, 3 Aug 2023 22:27:39 +0200")
Message-ID: <xmqqsf8z3i9d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 289DD1E4-3248-11EE-B68D-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 03.08.23 um 19:49 schrieb Hilco Wijbenga:
>> The promise part, I was aware of. In that sense, my wording was too
>> strong. It's more like "just trust me".
>> 
>> So the "you will get what you deserve" makes sense. If the
>> original/default/skeleton changes for some reason, your local changes
>> will just get overwritten. Nothing surprising there.
>> 
>> But in what scenario would Git "commit them nevertheless"? That one is
>> a surprise to me and is a bit worrisome.
>
> I don't know. In my book it is called "undefined behavior". Anything can
> happen, including things that I did not enumerate.

Exactly.

"Is commit affected?" and "Can we guarantee that operation X is not
affected?" are meaningless questions, as our implementation is not
frozen and we reserve the right to take any valid optimization
oppoertunities as long as correctness is not violated.

The assume unchanged bit allows Git to take advantage of the promise
the user has made and choose whichever is more efficient and/or
convenient to use between the file in the working tree and the blob
object for a given path when that bit is set.  When you expect an
existing blob object to be used (e.g. the one registered in the
index), in _any_ operation (which is defined now or will be invented
in the future), Git is allowed to instead use the contents of the
corresponding working tree file.  Or vice versa.

Perhaps you may be creating an archive of some format out of the
tree of HEAD, and may expect that local changes in the working tree
would not have any effect in the result.  But instead of having to
reconstruct the contents of a blob object known to be at path
"README" in the tree by uncompressing the base object and then
repeatedly applying delta data read from different parts of a
packfile, it may be easier/faster to open/read the file in the
working tree.  And if there is such a promise from the user that the
contents of the file will be kept the same as what was in the index
and the HEAD, Git is allowed to do so.  If the contents of the file
was different from the blob, the resulting archive will not be an
archive of the tree of HEAD, but that is "what you deserve".

