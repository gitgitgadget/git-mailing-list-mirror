Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDEF91FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 22:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752379AbcLIWgl (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 17:36:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59912 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751729AbcLIWgk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 17:36:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E19252509;
        Fri,  9 Dec 2016 17:36:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AHL2lKtTMLy8/xm18YDzJ2dDZq8=; b=yeKzYO
        n7YczBaYYVYxJk1VSyseJTeyQ6iX1LIHYwxInTo16PCDAtXZU8RVSO2fO9LMqO2t
        3nvde3HCJVmyhrMXUYTq8aL/SOkqKDFrgk4UaV/XTttzk1K6Am5KLhXdDb46nMwL
        IjO3aFh1j2ujgYW5OkZw2WzGQ1kPve91CFg+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h9izk2KfQQLP3iYun9+crsEgb3OpT/Qi
        mjCUClSMge+XJlH0CqUSS82t+jFIVxWrV+4VgHbTkXSgiXaMdQbs253YI9vndq43
        z6CTM+1rvtLJUNZhxx8d8aMRc+hAIJ/AndS4/Hjep9hHOxCogRSdzadmKIlFlHaG
        3zFVQfYWZ84=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 25CF452508;
        Fri,  9 Dec 2016 17:36:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C2AA52504;
        Fri,  9 Dec 2016 17:36:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, peff@peff.net, git@vger.kernel.org
Subject: Re: [RFC PATCH] send-email: allow a custom hook to prevent sending email
References: <20161209203449.17940-1-sbeller@google.com>
Date:   Fri, 09 Dec 2016 14:36:37 -0800
In-Reply-To: <20161209203449.17940-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 9 Dec 2016 12:34:49 -0800")
Message-ID: <xmqqfulwraq2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2D4A546-BE5F-11E6-B298-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This custom hook could be used to prevent sending out e.g. patches
> with change ids or other information that upstream doesn't like to see
> or is not supposed to see.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> My first perl contribution to Git. :)
>
> Marked as RFC to gauge general interest before writing tests and documentation.
>
> Thanks,
> Stefan
>
>  git-send-email.perl | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index da81be40cb..d3ebf666c3 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -815,6 +815,15 @@ if (!$force) {
>  				. "Pass --force if you really want to send.\n";
>  		}
>  	}
> +	my @hook = ( $ENV{GIT_DIR}.'hooks/send-email', $f )
> +	if( -x $hook[0] ) {
> +		unless( system( @hook ) == 0 )
> +		{
> +			die "Refusing to send because the patch\n\t$f\n"
> +				. "was refused by the send-email hook."
> +				. "Pass --force if you really want to send.\n";
> +		}
> +	}
>  }

I doubt that this is the best place to call this hook, because the
called hook does not have access to information that may help it
make a better decision.  

For example, because the hook gets one patchfile at a time, it does
not have the entire picture (e.g. "are you sure you want 01/05,
02/05, 04/05 and 05/05 without 03/05?").  For another example, the
hook does not have access to the decision git-send-email makes on
various "parameters", which are computed based on the contents of
the patchfiles and command line arguments at this point in the code.
(e.g. @to, @cc, etc. are computed much later, so you cannot say "do
not send anythnng outside corp by mistake" with this mechanism).




