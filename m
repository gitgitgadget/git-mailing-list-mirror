Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EE1CE79A9
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 16:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjISQid (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 12:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjISQic (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 12:38:32 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CE6D6
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 09:38:26 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5FEE62CFD8;
        Tue, 19 Sep 2023 12:38:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=SePhkDsrdQHbz6YNs7B3bzHbw1zOlnFrFBIUre
        CvEQg=; b=sIE3hTSgUu201lcYzayBEnAWUw8o96NQr8x52p9PZjWj11UxhykV6D
        rJjZP0cc4L0l7daat5zalfsuSmRQveOydH2McDeKh1rXJPxI7N9YUBoXXKCIGB3Q
        iVQNEYRlPaAEZF12QNOtpS40hmU6zXgKW+hnP3w39PTCYYAu/9eoU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 580732CFD7;
        Tue, 19 Sep 2023 12:38:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C31582CFD6;
        Tue, 19 Sep 2023 12:38:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] diff-merges: improve --diff-merges documentation
In-Reply-To: <87v8c7mp1j.fsf@osv.gnss.ru> (Sergey Organov's message of "Mon,
        18 Sep 2023 19:20:08 +0300")
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20230909125446.142715-2-sorganov@gmail.com>
        <xmqqfs3ktnvo.fsf@gitster.g> <87ttrzhmfu.fsf@osv.gnss.ru>
        <xmqqcyymly5m.fsf@gitster.g> <87v8c7mp1j.fsf@osv.gnss.ru>
Date:   Tue, 19 Sep 2023 09:38:19 -0700
Message-ID: <xmqqh6nqgltw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F180E718-570A-11EE-8D8E-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I was only trying to help you polish the text you added to explain
>> what you called the "legacy feature" to reflect the reason behind
>> that legacy.  As you obviously were not there back then when I made
>> "--cc" imply "-m" while keeping "-p" not to imply "-m".
>
> Your help is appreciated, yet unfortunately I still can't figure how to
> improve the text based on your advice.

If I were doing this patch, I would start from something like this:

-m::
	By default, comparisons between parent commits and the child
	commit are not shown for merge commits, but with the `-m`
	option, `git log` can be told to show comparisons for merges
	in chosen formats (e.g. `--raw`, `-p`, `--stat`).  When
	output formats (e.g. `--cc`) that are specifically designed
	to show better comparisons for merges are given, this option
	is implied; in other words, you do not have to say e.g. `git
	log -m --cc`.  `git log --cc` suffices.


The rest is a tangent that is not related to the above.  I suspect
that this also applies to newer `--remerge-diff`, as it also targets
to show merges better than the original "pairwise patches" that were
largely useless, but the right way to view what `--cc` and other
formats do for non-merge commits is *not* to think that they "imply"
`-p`.  It is more like that the output from these formats on
non-merge commits happen to be identical to what `-p` would produce.
You could say that the "magic" these options know to show merge
commits better degenerates to what `-p` gives when applied to
non-merge commits.

Another way to look at it is that `--cc` and friends, even though
they are meant as improvements for showing merges over "-m -p" that
gives human-unreadable pair-wise diffs, do not imply "--merges"
(i.e. show only merge commits)---hence they have to show something
for non-merge commits.  Because output formats for all of them were
modeled loosely [*] after "-p" output, we happened to pick it as the
format they fall back to when they are not showing comparisons for
merge commits.


[Footnote]

 * Here, `-p` roughly means "what GNU patch and `git apply` take".
   Output from `-c` and `--cc` on merge commits do not qualify, but
   they are loosely modeled after it.
