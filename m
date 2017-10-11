Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,PI_IMPORTANCE_HIGH,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0135920437
	for <e@80x24.org>; Wed, 11 Oct 2017 02:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754212AbdJKCHb (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 22:07:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62988 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751156AbdJKCHb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 22:07:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F0F29E23C;
        Tue, 10 Oct 2017 22:07:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=gi739Zpec7eTBQ6tIR5qY5ps9Rs=; b=hexMH/MC2aeWkgG1IHsS
        OleWThriF4RfkJBxLWSKIQ5S5HslfLIUGzaOXdC62Hnb0NOhUGsVcCF8Gcc8LPsH
        vhbaJ8a4qMPTxhyyV0TXtpQ5FzLfA7sDVpyi/HCCsWUIEplq2nJ2tKJjiPy/5I7c
        mxlPRUgy6oSnF9apS0uEOwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=aCnrY9ikCn8jpa3D4OgbuZEHrBBKHt3jyVxFF/11iIISDq
        mInnKmKN6rAl6GQ60UyHH6DNXMe72CCcS63LmC/qx5kJYdsywvFmd9hFePeHTeT/
        nh/ocTEmN3EdlQQ3Qko9nPvGM0RO+SiXY/QiqWmkkVP26yPO/mXUlgPIBfs/s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 77C879E23B;
        Tue, 10 Oct 2017 22:07:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AFBB09E23A;
        Tue, 10 Oct 2017 22:07:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] for-each-ref: let upstream/push optionally report the remote name
References: <cover.1506952571.git.johannes.schindelin@gmx.de>
        <cover.1507205895.git.johannes.schindelin@gmx.de>
        <964525df50e6d35847bcf57b0fe0949c99f0dbca.1507205895.git.johannes.schindelin@gmx.de>
Importance: high
Date:   Wed, 11 Oct 2017 11:07:28 +0900
Message-ID: <xmqqinfmo2sf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF73DDFE-AE28-11E7-975C-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The implementation chooses *not* to DWIM the push remote if no explicit
> push remote was configured; The reason is that it is possible to DWIM this
> by using
>
> 	%(if)%(push:remotename)%(then)
> 		%(push:remotename)
> 	%(else)
> 		%(upstream:remotename)
> 	%(end)
>
> while it would be impossible to "un-DWIM" the information in case the
> caller is really only interested in explicit push remotes.

Good.

> Note: the dashless, non-CamelCased form `:remotename` follows the
> example of the `:trackshort` example.

Good.  Come to think of it, aside from modifiers, the use of
squashedwords like committerdate and objecttype has long been the
norm in the for-each-ref atom names, so "remotename" is much more in
line with other formats.

> @@ -1354,16 +1371,20 @@ static void populate_value(struct ref_array_item *ref)
>  			if (refname)
>  				fill_remote_ref_details(atom, refname, branch, &v->s);
>  			continue;
> -		} else if (starts_with(name, "push")) {
> +		} else if (atom->u.remote_ref.push) {
>  			const char *branch_name;
>  			if (!skip_prefix(ref->refname, "refs/heads/",
>  					 &branch_name))
>  				continue;
>  			branch = branch_get(branch_name);
>  
> -			refname = branch_get_push(branch, NULL);
> -			if (!refname)
> -				continue;
> +			if (atom->u.remote_ref.push_remote)
> +				refname = NULL;
> +			else {
> +				refname = branch_get_push(branch, NULL);
> +				if (!refname)
> +					continue;
> +			}
>  			fill_remote_ref_details(atom, refname, branch, &v->s);

It still feels a bit strange to pass NULL refname to
fill_remote_ref_details() function, but fixing it would require
overhaul of this if/else if cascade, I think, so let's not worry too
much about it at least for now.

Looks much better than the previous one.  Thanks.  Queued.

