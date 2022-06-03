Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1998C43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 16:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343991AbiFCQiw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 12:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242947AbiFCQis (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 12:38:48 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECA52CDFF
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 09:38:46 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2271712E2E4;
        Fri,  3 Jun 2022 12:38:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Zx79islprasYnx9vHbY6f0CPzHlajH9/BBCx90
        AKqTg=; b=UF6kXi126+fCUBdhrwjgEDqbug0kM1juzPHSza4gsADR40I3balSCu
        FxvijEFrc5hr+5P7H+4ArSL2BqZR2kb24lDfZwzSSHqCVFp1Sv1Zs+XdKJsdeD2R
        f7nyQQAe+2hObupzGyMGBuLPuyYL5f9x5Z0uXs2CAL0y3lTMv0b6I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A4C412E2E3;
        Fri,  3 Jun 2022 12:38:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8007712E2E2;
        Fri,  3 Jun 2022 12:38:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joakim Petersen <joak-pet@online.no>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
Subject: Re: [PATCH v3] git-prompt: make colourization consistent
References: <20220602145935.10512-1-joak-pet@online.no>
        <20220603142521.42863-1-joak-pet@online.no>
Date:   Fri, 03 Jun 2022 09:38:43 -0700
In-Reply-To: <20220603142521.42863-1-joak-pet@online.no> (Joakim Petersen's
        message of "Fri, 3 Jun 2022 16:25:21 +0200")
Message-ID: <xmqqy1ydhfcc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A242584A-E35B-11EC-AF8F-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is not a new issue, but seeing this:

 	if [ $detached = no ]; then
 		branch_color="$ok_color"
 	else
 		branch_color="$bad_color"
 	fi
 	c="$branch_color$c"
 
 	z="$c_clear$z"
 	if [ "$w" = "*" ]; then
 		w="$bad_color$w"
 	fi
 	if [ -n "$i" ]; then
 		i="$ok_color$i"
 	fi
 	if [ -n "$s" ]; then
 		s="$flags_color$s"
 	fi
 	if [ -n "$u" ]; then
 		u="$bad_color$u"
 	fi
+	if [ -n "$p" ]; then
+		p="$c_clear$p"
+	fi
+	if [ -n "$sparse" ]; then
+		sparse="$c_clear$sparse"
+	fi
 	r="$c_clear$r"
 }

it makes me wonder if the more forward looking and future-proof way
that is resistant to any future and random reshuffling like what
0ec7c23c (git-prompt: make upstream state indicator location
consistent, 2022-02-27) did would be to make it a rule to maintain
that there is no coloring by default, and when any of these tokens
like w, i, s, ... are not empty, enclose them inside "color-on" and
"color-off" sequence.

For example, 

 	if [ "$w" = "*" ]; then
 		w="$bad_color$w"
 	fi

would mean $w, when it is "*", would cause gitstring to contain an
asterisk that is painted in $bad_color, but ALSO causes whatever
that happens to come AFTER $w in gitstring to be painted in the same
color UNLESS it tries to protect itself.  Right now, $w may be
immediately followed by $i, and $i does protect itself by prefixing
with $ok_color, but if $i is empty, $w's coloring will extend to $s.

So, if we did this instead:

- 	z="$c_clear$z"
 	if [ "$w" = "*" ]; then
- 		w="$bad_color$w"
+ 		w="$bad_color$w$c_clear"
 	fi

and make similar changes to everything else we see above, we
probably can lose the ones that prefix with $c_clear, because each
token that paints itself in unusual color is now responsible for
returning the terminal state to normal with the $c_clear sequence
after it is done with it.  We do not have to special case sparse, p,
or r in this helper function at all if we go that route, no?

If the helper were written that way, then reshuffling the order of
the tokens done in 0ec7c23c (git-prompt: make upstream state
indicator location consistent, 2022-02-27) wouldn't have made the
patch under discussion necessary at all, which is what I see is
valuable from the "maintainability" point of view.

