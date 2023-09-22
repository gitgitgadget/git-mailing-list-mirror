Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A910CE7AB7
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 19:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjIVTsb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 15:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIVTsa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 15:48:30 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D4AB9
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 12:48:23 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A8171B0C49;
        Fri, 22 Sep 2023 15:48:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=n/v6SijmAx1SDr7txQfi6TyOGP95VkjdM9PlD7
        FPt0E=; b=q5idWlvKfd97oBG/H49ijGVlVvJuT4dhqHr+WIu5uEEU86qs9z2qUp
        JAxhCYafW7Te5ebbR7wFrWLxA8qt/Rjeb258VKkgPe/d3N5zM+zrpHSFDRtZqUCh
        44uQkt/F9qubnRZ0iH0ZaAFUdmHqIHYqHaq6B9nKl6MF/MDObFm+g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 81E531B0C48;
        Fri, 22 Sep 2023 15:48:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EBF081B0C47;
        Fri, 22 Sep 2023 15:48:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Arver <linusa@google.com>
Cc:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 5/6] trailer: rename *_DEFAULT enums to *_UNSPECIFIED
In-Reply-To: <owly8r8yt6cr.fsf@fine.c.googlers.com> (Linus Arver's message of
        "Fri, 22 Sep 2023 11:23:16 -0700")
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
        <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
        <52958c3557c34992df59e9c10f098f457526702c.1694240177.git.gitgitgadget@gmail.com>
        <xmqqr0n4v8ul.fsf@gitster.g> <owlyzg1pjx2f.fsf@fine.c.googlers.com>
        <xmqq1qf1la0q.fsf@gitster.g> <owly8r8yt6cr.fsf@fine.c.googlers.com>
Date:   Fri, 22 Sep 2023 12:48:18 -0700
Message-ID: <xmqqil820z25.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB2DBCA0-5980-11EE-AE33-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

> ... I prefer the
> WHERE_UNSPECIFIED as in this patch because the WHERE_DEFAULT is
> ambiguous on its own (i.e., WHERE_DEFAULT could mean that we either use
> the default value WHERE_END in default_conf_info, or it could mean that
> we fall back to the configuration variables (where it could be something
> else)).

Yup.  "Turning something that is left UNSPECIFIED after command line
options and configuration files are processed into the hardcoded
DEFAULT" is one mental model that is easy to explain.

I however am not sure if it is easier than "Setting something to
hardcoded DEFAULT before command line options and configuration
files are allowed to tweak it, and if nobody touches it, then it
gets the hardcoded DEFAULT value in the end", which is another valid
mental model, though.  If both can be used, I'd personally prefer
the latter, and reserve the "UNSPECIFIED to DEFAULT" pattern to
signal that we are dealing with a case where the simpler pattern
without UNSPECIFIED cannot solve.

The simpler pattern would not work, when the default is defined
depending on a larger context.  Imagine we have two Boolean
variables, A and B, where A defaults to false, and B defaults to
some value derived from the value of A (say, opposite of A).

In the most natural implementation, you'd initialize A to false and
B to unspecified, let command line options and configuration
variables to set them to true or false, and after all that, you do
not have to tweak A's value (it will be left to false that is the
default unless the user or the configuration gave an explicit
value), but you need to check if B is left unspecified and tweak it
to true or false using the final value of A.

For a variable with such a need like B, we cannot avoid having
"unspecified".  If you initialize it to false (or true), after the
command line and the configuration files are read and you find B is
set to false (or true), you cannot tell if the user or the
configuration explicitly set B to false (or true), in which case you
do not want to futz with its value based on what is in A, or it is
false (or true) only because nobody touched it, in which case you
need to compute its value based on what is in A.

And that is why I asked if we need to special case "the user did not
touch and the variable is left untouched" in the trailer subsystem.

Thanks.
