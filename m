Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2E9620D09
	for <e@80x24.org>; Mon, 17 Apr 2017 04:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752140AbdDQEZC (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 00:25:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63993 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750994AbdDQEZB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 00:25:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD59B8C54F;
        Mon, 17 Apr 2017 00:24:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dgVaAiRZ65LrNg1VcpasM0hLVCo=; b=GrKCcZ
        PPst25c8HVXprKlI1v5BtgjfAOz1MPV+/5fxbvOIuri+rlfoor3t1EUcSkvjIWx0
        SC7nEGzP1izV68/ylHWG0I2Vw4WfopmOmabTB8Zc61Cvzh7a0zry/Jd2gLlP04kN
        LR0yhCzkGNyfuP3NkBRHKWJqVexZXkSuMcnvE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c2PvzguKdlF5CEy1jOSNUWkvWlKV8J1M
        ChmHLD2t0gfihKwmrh4I1N0cI1g9Dyc1miRbboZnLWwA0OtqP5W7iKwgCvgWjcw3
        9PI1sW0fItY9wK8llVGC+L64e0LVI9+egB/Ckp3uQEApIg9GJtZzQx8sQ90pVz3b
        ailhTzehoDA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D31878C54E;
        Mon, 17 Apr 2017 00:24:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4BA748C54D;
        Mon, 17 Apr 2017 00:24:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tom \"Ravi\" Hale" <tom@hale.ee>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH] __git_ps1: Don't kill shell if user types `set -e`
References: <b344d0c3-c8b8-da27-79f6-ae750be6830a@hale.ee>
Date:   Sun, 16 Apr 2017 21:24:58 -0700
In-Reply-To: <b344d0c3-c8b8-da27-79f6-ae750be6830a@hale.ee> (Tom Hale's
        message of "Sun, 16 Apr 2017 15:28:33 +0700")
Message-ID: <xmqq60i3k6ed.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1793D32-2325-11E7-83EA-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tom \"Ravi\" Hale" <tom@hale.ee> writes:

> If a user types `set -e` in an interactive shell, and is using __git_ps1
> to set
> their prompt, the shell will die if the current directory isn't inside a git
> repository.
>
> This is because `set -e` instructs the shell to exit upon a command
> returning a non-zero exit status, and the following command exits with
> status 128:
>
> 	repo_info="$(git rev-parse --git-dir --is-inside-git-dir \
> 		--is-bare-repository --is-inside-work-tree \
> 		--short HEAD 2>/dev/null)"

Hmph.  So the fix would be something like this?

 	repo_info="$(git rev-parse --git-dir --is-inside-git-dir \
 		--is-bare-repository --is-inside-work-tree \
- 		--short HEAD 2>/dev/null)"
+ 		--short HEAD 2>/dev/null || :)"

I am too afraid to ask what a user would try to achieve by doing the
"set -e" thing in an interactive session.  It is understandable (I
am not saying I think it is necessarily a good idea) to do so in a
script, but for an interactive shell?
