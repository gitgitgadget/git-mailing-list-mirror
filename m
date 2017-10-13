Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E02320372
	for <e@80x24.org>; Fri, 13 Oct 2017 00:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753360AbdJMACi (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 20:02:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57306 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752884AbdJMACi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 20:02:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 865D5AEABE;
        Thu, 12 Oct 2017 20:02:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3jpUvO+jfelICn9Aw8SZohD5/LI=; b=Jsvh+H
        dZiDDRB3F+fnGKzgvt0AmC/7eT09JzmWKBGF76ItRmGzq+WEyhQWNyCuYS0Jp1+1
        uF/08ziK2XTFLHWj+nNy7MQsT5/gi9OAXAzxB45tcWigyWgJR750WNhnMm0w9JCz
        S/sCroqMbwc54x98GnAeXsNbE0iHnxPHHSDHk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NHqUgA9Um8gamHyPbTVpo7/hiVCP5pl2
        lKYLwmywOmrtkqlo9fuja9tZtK0J7iwskavo+PYUSkHvl0sMd+MA3eACZ42jsOCf
        8fK4BInIhRQAjDAyYjUdjwPOoMhCKOs+KO0LfyBN0T+w3hH+UzzbuN2nA+3aHre0
        9iPjBUDYrbU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DD1AAEABD;
        Thu, 12 Oct 2017 20:02:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EE0D3AEABC;
        Thu, 12 Oct 2017 20:02:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] color: discourage use of ui.color=always
References: <xmqqr2uao2vy.fsf@gitster.mtv.corp.google.com>
        <20171012021007.7441-1-gitster@pobox.com>
        <20171012021007.7441-3-gitster@pobox.com>
        <20171012150844.jhdbnckabkbdzi4d@sigill.intra.peff.net>
Date:   Fri, 13 Oct 2017 09:02:35 +0900
In-Reply-To: <20171012150844.jhdbnckabkbdzi4d@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 12 Oct 2017 11:08:45 -0400")
Message-ID: <xmqqmv4vykx0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D2410BBC-AFA9-11E7-92E8-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Oct 12, 2017 at 11:10:07AM +0900, Junio C Hamano wrote:
>
>> Warn when we read such a configuration from a file, and nudge the
>> users to spell them 'auto' instead.
>
> Hmm. On the one hand, it is nice to make people aware that their config
> isn't doing what they might think.
>
> On the other hand, if "always" is no longer a problem for anybody, do we
> need to force users to take the step to eradicate it? I dunno. Were we
> planning to eventually remove it?
>
>> @@ -320,6 +322,11 @@ int git_config_colorbool(const char *var, const char *value)
>>  			 * Otherwise, we're looking at on-disk config;
>>  			 * downgrade to auto.
>>  			 */
>> +			if (!warn_once) {
>> +				warn_once++;
>> +				warning("setting '%s' to '%s' is no longer valid; "
>> +					"set it to 'auto' instead", var, value);
>> +			}
>
> This warn_once is sadly not enough to give non-annoying output to
> scripts that call many git commands. E.g.:
>
>   $ git config color.ui always
>   $ git add -p
>   warning: setting 'color.ui' to 'always' is no longer valid; set it to 'auto' instead
>   warning: setting 'color.ui' to 'always' is no longer valid; set it to 'auto' instead
>   warning: setting 'color.ui' to 'always' is no longer valid; set it to 'auto' instead
>   warning: setting 'color.ui' to 'always' is no longer valid; set it to 'auto' instead
>   warning: setting 'color.ui' to 'always' is no longer valid; set it to 'auto' instead
>   warning: setting 'color.ui' to 'always' is no longer valid; set it to 'auto' instead
>   warning: setting 'color.ui' to 'always' is no longer valid; set it to 'auto' instead
>   warning: setting 'color.ui' to 'always' is no longer valid; set it to 'auto' instead
>   warning: setting 'color.ui' to 'always' is no longer valid; set it to 'auto' instead
>   warning: setting 'color.ui' to 'always' is no longer valid; set it to 'auto' instead
>   diff --git a/file b/file
>   [...]

I am ambivalent.  

We (especially you) have kept saying that "always" is a mistake that
makes little sense, and wanted to force users to "fix" their
configuration.  But as you said, we made it not a mistake, so it is
OK to leave it as they are, I guess.

Let's drop the warning part of the change, at least.



