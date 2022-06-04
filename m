Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA10CCA483
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 09:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbiFDJnJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 05:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiFDJnD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 05:43:03 -0400
Received: from nmsh5.e.nsc.no (nmsh5.e.nsc.no [148.123.160.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9122219F9D
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 02:43:01 -0700 (PDT)
Received: from [192.168.1.110] (unknown [194.19.73.58])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: joak-pet)
        by nmsh5.e.nsc.no (smtp.online.no) with ESMTPSA id 2D3E95202F;
        Sat,  4 Jun 2022 11:42:57 +0200 (CEST)
Message-ID: <ed7d78a5-3c70-df5a-81c3-bdb631271700@online.no>
Date:   Sat, 4 Jun 2022 11:42:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] git-prompt: make colourization consistent
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20220602145935.10512-1-joak-pet@online.no>
 <20220603142521.42863-1-joak-pet@online.no> <xmqqy1ydhfcc.fsf@gitster.g>
 <7d391d82-b15e-4a31-5207-c4037fec0bf9@online.no>
 <9fa34f22-3404-7bf8-6985-642c80634bf8@online.no>
 <CAGTqyRxkiGt7CRggV7VeXNRK2VmDMxDX3EpOr5cPcc5AdH8ZaA@mail.gmail.com>
 <xmqqwndxcuru.fsf@gitster.g>
From:   Joakim Petersen <joak-pet@online.no>
In-Reply-To: <xmqqwndxcuru.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Source-IP: 194.19.73.58
X-Scanned-By: MIMEDefang 2.84 on 10.123.160.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/06/2022 23:16, Junio C Hamano wrote:
> After thinking it again, I actually am OK with the original coloring
> code structure.  The rule is "you always counter whatever color
> settings left behind by somebody who came before you".
> 
> As long as the color effect you use is not additive (e.g. if the
> final product is $a$b, and $a is prefixed with $c_red and $b is
> prefixed with $c_blue, an additive coloring scheme may end up
> painting b in purple), we'll save number of $c_clear we would need
> to emit.  Plain colors are probably not additive, but some
> attributes are, so this is more brittle than "always reset to the
> base state" rule, but it may be more desirable in practice.
> 
> I have no strong preference either way.  But if we are to go that
> route, we definitely need to make sure that the last element added
> to gitstring is followed by $c_reset, by doing something like the
> attached patch.  Currently, $r has unconditional $c_clear in front
> of it, and $upstream is never colored, and that is the only thing
> that is saving us from leftover color bleeding into whatever comes
> after the prompt.

There might be something I'm not seeing, but having it so each element
counters whatever colour left by the preceding element seems less
intuitive when adding or moving elements in the final $gitstring. Adding
an element will then require going into __git_ps1_colorize_gitstring,
even when it is not intended to be colourized. All existing uncoloured
elements will also need to be prefixed to protect against colour bleed
from being moved around. I'm partial to the idea of each coloured
element clearing its own colour.
