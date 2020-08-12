Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDEFC433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 20:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CD7320781
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 20:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SI0rqFnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHLU20 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 16:28:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59270 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgHLU20 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 16:28:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8551E70507;
        Wed, 12 Aug 2020 16:28:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cDwDEo9R1ZXR
        CPQWKAmUDW2iX58=; b=SI0rqFnVjNnz95ROLGsJcY/wVSmgSuROX3CpA9CIO5vE
        rgINBH+TapdfyjXMCFm5E9hc1+cSQ8DO7HzWyqAkugdfetuvpaWu3GmMSnmGjiCt
        TkOmMJYiDP3k/qdqbb+zzYvXeFyKrYUYixbBgV2rrrrA5PH2BN8CWVZxFcUvq0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=lUDfp4
        tUXWHnd2Brfql/aQHOhG8qsY+ScsnGAnpOZWZH1aBNGgPPH2bxkJrC/JT2F8cAx0
        gly8pvNAOijXyyQ+eHmQ5t0v56+W+VL1hvw1DXSLFVCc+3ZZkqRnNynBUlYLHJBK
        iMGllZuBdv6mJeUoQM+6u2Ff57lHExBacnh10=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D83C70506;
        Wed, 12 Aug 2020 16:28:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 03DE270505;
        Wed, 12 Aug 2020 16:28:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Chris Torek <chris.torek@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] midx: use buffered I/O to talk to pack-objects
References: <c5920e08-b7dd-e870-f99e-225d0aafc663@web.de>
        <9162c1cb-36fd-3203-ec58-4bd1501938d0@web.de>
Date:   Wed, 12 Aug 2020 13:28:22 -0700
In-Reply-To: <9162c1cb-36fd-3203-ec58-4bd1501938d0@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 12 Aug 2020 18:52:54 +0200")
Message-ID: <xmqqh7t7623d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5E3E2E46-DCDA-11EA-B3D3-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>  		nth_midxed_object_oid(&oid, m, i);
> -		xwrite(cmd.in, oid_to_hex(&oid), the_hash_algo->hexsz);
> -		xwrite(cmd.in, "\n", 1);
> +		fprintf(cmd_in, "%s\n", oid_to_hex(&oid));

I do think it is silly to send an object name and terminating LF in
two different system calls per object.

The original uses xwrite() so that it does not have to worry about
having to restart interrupted system calls and such.  Do we need to
do that ourselves now or does the stdio layer take care of it for
us?

>  	}
> -	close(cmd.in);
> +	fclose(cmd_in);
>
>  	if (finish_command(&cmd)) {
>  		error(_("could not finish pack-objects"));
> --
> 2.28.0
