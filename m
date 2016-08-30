Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F2B41F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 17:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933444AbcH3RhW (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 13:37:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62444 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932789AbcH3RhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 13:37:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B0693905D;
        Tue, 30 Aug 2016 13:37:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GHDwXpug0oaJum89PRRViRlpW1Y=; b=O6mr3v
        tkUitC39YxAp5S+OVz3Bu5Uolw3H8khNv+COkwtI4YgJ9dP+0cs3MyuKJItvTVUp
        tupwkwVPZa8Y3+ssk6CHlKSd4Bgd7TKmiCK77NH3vHqmP56PLzfUH/JNfy1dkOAj
        RkxUeh3Ax7dBgCwDY9G2wStQRa1+RleuhUwcI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aX7aLl+rICB6T34Ig5BiTaIRoVGsmgRJ
        xaOeH6lZqpJf2EifYGmDrjwMmpSmqB7bxm432Q4NfU/MGJxOI+ExmfpeMBU7hlzS
        wELiy2NESGX7a2X8Qzvtb3WVkJRLm9OGppJlrPPw6R9iY/7P8sIdAM12VItfhMta
        wIbD2E3hwc8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 428BC3905C;
        Tue, 30 Aug 2016 13:37:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 99D693905A;
        Tue, 30 Aug 2016 13:37:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joe Perches <joe@perches.com>
Cc:     git <git@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: git am and duplicate signatures
References: <1472573556.5512.93.camel@perches.com>
        <xmqqwpiy5haf.fsf@gitster.mtv.corp.google.com>
        <1472576869.5512.98.camel@perches.com>
Date:   Tue, 30 Aug 2016 10:37:10 -0700
In-Reply-To: <1472576869.5512.98.camel@perches.com> (Joe Perches's message of
        "Tue, 30 Aug 2016 10:07:49 -0700")
Message-ID: <xmqq4m625fax.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6287D368-6ED8-11E6-AF60-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joe Perches <joe@perches.com> writes:

> (adding lkml)
>
> On Tue, 2016-08-30 at 09:54 -0700, Junio C Hamano wrote:
>> Joe Perches <joe@perches.com> writes:
>> > git-am -s will avoid duplicating the last signature
>> > in a patch.
>> > 
>> > But given a developer creates a patch, send it around for
>> > acks/other signoffs, collects signatures and then does
>> > a git am -s on a different branch, this sort of sign-off
>> > chain is possible:
>> > 
>> > 	Signed-off-by: Original Developer <od@domain.com>
>> > 	Acked-by: Random Developer <rd@domain.com>
>> > 	Signed-off-by: Original Developer <od@domain.com>
>> Both correct and allowing the earlier one duplicated as long as
>> there is somebody/something else in between is deliberate.
>
> linux-kernel has a script (scripts/checkpatch.pl) that
> looks for duplicate signatures (<foo>-by: [name] <address>)
>
> Should the last Signed-off-by: in the commit log be
> excluded from this check?

That is left for the kernel folks to decide, but excluding only "the
last" does not make much sense to me.  If you look for only "two
consecutive same signatures" and barf, that would be in line with
what we have been shooting for to support the above "original then
random then back to original" example you gave us above.


