Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19121C4332F
	for <git@archiver.kernel.org>; Sat, 15 Oct 2022 22:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJOWkY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Oct 2022 18:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJOWkW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2022 18:40:22 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B11233A38
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 15:40:21 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EA2C51C5D09;
        Sat, 15 Oct 2022 18:40:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yAgUTz6pn8a8qPGSXXc2kohYNK6JFpmijvWCf9
        Y5rt0=; b=PJ3d5HWXTXMBP3bm5urh6t1rn30E++9cnt6JtpLNjO2G1YTxJuDJEL
        jIuzCxghWTCpJMsKjtFT145T7RO7xhCMjWxBmD1HYs9vAJNiKLp9OB4iPle8HMFT
        YxPjlaaY7OHab9vCS694HAO6b/ifoDlpoBOzx3iMXxB5D6rZYw70k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E30A81C5D08;
        Sat, 15 Oct 2022 18:40:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 281FA1C5D07;
        Sat, 15 Oct 2022 18:40:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonas Bernoulli <jonas@bernoul.li>, git@vger.kernel.org
Subject: Re: "submodule foreach" much slower than removed "submodule--helper
 --list"
References: <Y0r4US7AKxT/BLiY@coredump.intra.peff.net>
Date:   Sat, 15 Oct 2022 15:40:16 -0700
In-Reply-To: <Y0r4US7AKxT/BLiY@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 15 Oct 2022 14:13:37 -0400")
Message-ID: <xmqqwn904sof.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 576E3D50-4CDA-11ED-9AE0-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   - the output of the old "submodule--helper list" looks a lot like
>     "ls-files" dumping the index and filtering on submodule entries.
>     Running:
>
>        git ls-files -s | grep ^160000
>
>     produces the same output.

Indeed that was what we wrote in the scripted Porcelain.  This is
one of the times I wish we didn't turn things to C in piecemeal.

> I'm not sure if those are exactly equivalent, either. It looks like the
> old code was probably respecting submodule active markers (though in my
> test repo without the submodule actually checked out, it's still
> reported).

"submodule--helper list" being the "give me the gitlinks", to be
filtered with things like pathspec and presence of .git (i.e. being
activated), you are right that those who liked the output from it
would not be happy with "foreach" anyway.  The comparison in the
original was apples and oranges because "foreach" should show only
the ones that are active in the current checkout.

If one likes the output from "submodule--helper list" so much, I
think your "ls-files" above should be the closest.  There seems to
have existed some logic to squash unmerged entries down to a single
one, too (git-submodule.sh in Git 2.0.0 era has a module_list shell
function that shows what "helper list" should be doing), though.

Thanks.

