Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C24981FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 19:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751662AbdCMTFr (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 15:05:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60597 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750858AbdCMTFp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 15:05:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 436AA81705;
        Mon, 13 Mar 2017 15:05:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R8lQxdzpVkadCcf6XUAFifm7vk0=; b=c8hF5c
        kauFoxH02GknbP4xIOZSWHEgVEyUwAlOeZpH5SG/AYuTCo1p0wVfI8ZDewSpgQe5
        qhHeafOZvrbH8+uflfNXblsb0pT8grfOKj9YkGcnHVMR6EfrPNC/YV2Artn2l809
        JnzL+TmWmmMTzgNbtjTuDk6TodRDPdd7ub+NI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dFfDk218NKSLCzY85NbAnmHUq1I438mp
        m7QKdpVpOGFCsP9fKD91i2BZpflzOdKoikR8DbijMYC77VMpXNCK/w5iNObhSqrW
        iDBZtowTGgVg0ft9nseFoNQ7Ab+G3BBk+ifKlmyiu/nO79lmjViFoBdpF8CcsXi3
        P0S/9ea+pvU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D0F581704;
        Mon, 13 Mar 2017 15:05:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C65C81703;
        Mon, 13 Mar 2017 15:05:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Devin Lehmacher <lehmacdj@gmail.com>, git@vger.kernel.org
Subject: Re: [GSoC][PATCH 2/3] credential-cache.c: Make git use XDG_CACHE_HOME for credentials
References: <20170313172232.96678-1-lehmacdj@gmail.com>
        <20170313172232.96678-3-lehmacdj@gmail.com>
        <xmqqtw6xrquw.fsf@gitster.mtv.corp.google.com>
        <20170313190349.wbg7nfmrxvvzc5zv@sigill.intra.peff.net>
Date:   Mon, 13 Mar 2017 12:05:42 -0700
In-Reply-To: <20170313190349.wbg7nfmrxvvzc5zv@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 13 Mar 2017 15:03:49 -0400")
Message-ID: <xmqqd1dlro8p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0EB0E9B4-0820-11E7-8AA3-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Mar 13, 2017 at 11:09:11AM -0700, Junio C Hamano wrote:
>
>> > +	if (home_socket)
>> > +		if (file_exists(home_socket))
>> > +			return home_socket;
>> > +		else
>> > +			free(home_socket);
>> > +
>> > +	return xdg_cache_home("credential/socket");
>> > +}
>> 
>> I somehow feel that the order of precedence should be the other way
>> around, though.  
>> 
>> If somebody really wants to use the xdg location and has a socket
>> already there, using that existing socket would be the right thing
>> to do.  However, when neither ~/.git-credential-cache/socket nor
>> ~/.cache/git/socket exists, why should we prefer the latter over the
>> former?
>
> How would they get a socket in the xdg location if we never create one?

They wouldn't.  It was my oblique way to say "it is unclear from the
patch description and the code why this is a good idea---it needs to
be explained better" ;-).
