Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBDCC001DF
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 17:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjGXRaB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 13:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjGXR37 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 13:29:59 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F213170F
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 10:29:57 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 84412280C9;
        Mon, 24 Jul 2023 13:29:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d4IGJZV8rtnvuaR8KSw4bibsExGM5aLPPpLPc7
        gM3Bs=; b=sxvei3D7qohQ63s9FSvq2dEEmxaAnuMf31VTF1Vv0DLAGdGckbFj0n
        lFYlraGmvflkZEUwZQx2RUMP8nHO2LmK5oiybpteQ5hyUTng7RjuglSGpXUMHdnW
        aTV0QCXmq/Mx06ZvugLW6mWe+h6AQXqoGqUF2uS8WipuzR7fLkQm8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7D5C5280C8;
        Mon, 24 Jul 2023 13:29:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1535F280C7;
        Mon, 24 Jul 2023 13:29:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Siddharth Singh <siddhartth@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v4 1/2] ref-filter: add multiple-option parsing functions
References: <20230719162424.70781-1-five231003@gmail.com>
        <20230723162717.68123-1-five231003@gmail.com>
        <20230723162717.68123-2-five231003@gmail.com>
Date:   Mon, 24 Jul 2023 10:29:52 -0700
In-Reply-To: <20230723162717.68123-2-five231003@gmail.com> (Kousik
        Sanagavarapu's message of "Sun, 23 Jul 2023 21:49:58 +0530")
Message-ID: <xmqqa5vlqktr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B3B4441A-2A47-11EE-8E81-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kousik Sanagavarapu <five231003@gmail.com> writes:

> The functions
>
> 	match_placeholder_arg_value()
> 	match_placeholder_bool_arg()
>
> were added in pretty 4f732e0fd7 (pretty: allow %(trailers) options
> with explicit value, 2019-01-29) to parse multiple options in an
> argument to --pretty. For example,
>
> 	git log --pretty="%(trailers:key=Signed-Off-By,separator=%x2C )"
>
> will output all the trailers matching the key and seperates them by
> a comma followed by a space per commit.
>
> Add similar functions,
>
> 	match_atom_arg_value()
> 	match_atom_bool_arg()
>
> in ref-filter.

What are their similarities, and in what way are they different?  If
they are similar enough, is it reasonable to allow these two pairs
of helpers to share code (the best case would be we can just call
the existing ones, possibly changing their names to more suitable
ones that fit their now-more-general-purpose nature better)?

> There is no atom yet that can use these functions in ref-filter, but we
> are going to add a new %(describe) atom in a subsequent commit where we
> parse options like tags=<bool-value> or match=<pattern> given to it.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Hariom Verma <hariom18599@gmail.com>
> Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
> ---
>  ref-filter.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)

Asking just out of curiousity, all patches from you seem to have
"Mentored-by" naming your mentors, but how deeply involved are they
in each patch you send out?  Is it like you first ask them to review
and only after addressing the issues their reviews raise, you are
sending the polished patches to the list?  Or are they not deeply
involved in the code but offering suggestions on the design (I am
curious what their reactions were on your design decision to
add the two helper functions)?

