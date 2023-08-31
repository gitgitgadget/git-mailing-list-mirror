Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D9AEE49B0
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 21:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbjHaVwT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 17:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjHaVwS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 17:52:18 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E296AB8
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 14:52:15 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 812F821D18;
        Thu, 31 Aug 2023 17:52:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=iO0LqepUmR1fr9XWwsprmO+oIqCwreSuqY3i8v
        2MxMA=; b=u3NiL2Kl2P/71pnTAufjpHGabQ/j+AtmxQpyHBOVpS26kV4prniDKZ
        2Qk+wuEF6zhdRtnELkMR8spzH2spV1KEV8a+Dp4ppGj0K8cRFOuGFXZlOpubz6iS
        v+J+yeo/kTIubTOFNZOyuUHzcK73WVLf6Ec+AIvizDqMbzRjRQbsc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7945F21D17;
        Thu, 31 Aug 2023 17:52:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A40EC21D16;
        Thu, 31 Aug 2023 17:52:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wesley Schwengle <wesleys@opperschaap.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] builtin/rebase.c: Emit warning when rebasing
 without a forkpoint
In-Reply-To: <xmqqbkenszfa.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        31 Aug 2023 13:57:13 -0700")
References: <20230819203528.562156-1-wesleys@opperschaap.net>
        <20230819203528.562156-2-wesleys@opperschaap.net>
        <xmqqbkenszfa.fsf@gitster.g>
Date:   Thu, 31 Aug 2023 14:52:10 -0700
Message-ID: <xmqq1qfiubg5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3BB5DB8-4848-11EE-9120-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I am not commenting on the tests, as the above code probably needs
> to be corrected first so that folks who want to squelch the message
> and want the "forkpoint behaviour by default when rebuilding on the
> usual upstream" behaviour can do so by setting the variable to true.
>
> And that obviously need to be tested, too.

Another worrysome thing about rebase.forkpoint is that it will be
inevitable for folks to start complaining that it does not work the
way other configuration variables do.  Setting the variable to
'true' is not the same as passing '--fork-point=true' from the
command line.

I actually think it would be a lot larger behaviour change with a
huge potential to be received as a regression if we start making the
variable to mean the same thing as passing '--fork-point=true'.
People may like the current "if you are rebuilding your branch on
its usual upstream, pay attention to the rebase and rewind of the
upstream itself, but if you are giving an explicit upstream from the
command line, the tool does not second guess you with the fork-point
heuristics" behaviour and prefer to set it to true.  We would be
breaking them big time if suddenly the rebase.forkpoint=true they
set previously starts triggering the fork-point heuristics when they
run "git rebase upstream".  So that needs to be kept in mind when/if
we fix the "setting the variable, even to 'true', will squelch the
warning".

