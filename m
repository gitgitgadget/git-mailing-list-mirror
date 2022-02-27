Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0209C433EF
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 19:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiB0TIj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 14:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiB0TIi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 14:08:38 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7865A25C4E
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 11:08:00 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 57AE3115795;
        Sun, 27 Feb 2022 14:07:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g4J71iCsNWcDYdTLAVXWnzHsON8AVz2TndEPSZ
        k6iSA=; b=IKRXvoD3TeimbOLkhwUTvU59Ck7UXfBSMr1XLzDBRqdTWs5jUOEhQP
        UxNPXcJx2G/+NeQi/sO5mgRfLIkodFLjWDRTVMyVr/c4TKWiQ2SCJtWN+odscY90
        G6/eqAnKvraClyh9dlPjdHJxG7ih3kKNOZRC5cp6snbHYICRNE3l8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DF42115794;
        Sun, 27 Feb 2022 14:07:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AE478115793;
        Sun, 27 Feb 2022 14:07:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re* [PATCH] rerere-train: modernise a bit
References: <xmqqsfsjuw8m.fsf@gitster.g>
        <20220227180203.pakrqimsxbjx47tu@gmail.com>
Date:   Sun, 27 Feb 2022 11:07:55 -0800
In-Reply-To: <20220227180203.pakrqimsxbjx47tu@gmail.com> (Johannes
        Altmanninger's message of "Sun, 27 Feb 2022 19:02:03 +0100")
Message-ID: <xmqqy21w3z78.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9285A066-9800-11EC-B088-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Altmanninger <aclopte@gmail.com> writes:

> Yep, tformat is more correct semantically, but it's worth noting that there
> is no behavior change here. These commands behave the same
>
> 	git show -s --pretty=tformat:"Learning" HEAD
> 	git show -s --pretty=format:"Learning" HEAD

Your observation is not quite right.

The difference between tformat and format does matter in practice,
unless your pager is hiding the difference.

    $ export GIT_PAGER=cat; # disable the pager
    $ git show -s --pretty=format:"%s" HEAD; echo Q
    The eighth batchQ
    $ exit

This episode also exposes another bug in the rerere-train script,
caused by the fact that it lets GIT_PAGER to interfere.

--- >8 ---
Subject: rerere-train: prevent GIT_PAGER from pausing 'git show -s'

The script uses "git show -s --format" to display the title of the
merge commit being studied, without explicitly disabling the pager,
which is not a safe thing to do in a script.

For example, when the pager is set to "less" with "-SF" options (-S
tells the pager not to fold lines but allow horizontal scrolling to
show the overly long lines, -F tells the pager not to wait if the
output in its entirety is shown on a single page), and the title of
the merge commit is longer than the width of the terminal, the pager
will wait until the end-user tells it to quit after showing the
single line.

Explicitly disable the pager for this "git show" invocation to avoid
this.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/rerere-train.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/contrib/rerere-train.sh w/contrib/rerere-train.sh
index 499b07e4a6..2b9df7b6f2 100755
--- c/contrib/rerere-train.sh
+++ w/contrib/rerere-train.sh
@@ -81,7 +81,7 @@ do
 	fi
 	if test -s "$GIT_DIR/MERGE_RR"
 	then
-		git show -s --format="Learning from %h %s" "$commit"
+		git --no-pager show -s --format="Learning from %h %s" "$commit"
 		git rerere
 		git checkout -q $commit -- .
 		git rerere
