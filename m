Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5770200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 19:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756128AbcL0TN6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 14:13:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63123 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756012AbcL0TNz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 14:13:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C24759B60;
        Tue, 27 Dec 2016 14:13:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         s=sasl; bh=bHHjQSCJTpLdjjj2kOLfTQqDkzQ=; b=o97zvKhqaw+8J3omuP+J
        wceqKv/DJJSSHwmJXCf3oGWVgad4SWS5+AGMPWPZCTGlZMJL4T7CjrvUF4RFUKVT
        XDsTVP6Etj9270M8goXVsPF1FAfcwm9ai/ixb8WYe+CYdmJSBnCtU8WdSd4s/Wvx
        bllxrs6QsbV7OXQwaZcT8so=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         q=dns; s=sasl; b=KSt7f2NPP6dunWYFrkQDqmIPMzWi427mEOrs7FodFavinR
        OHMAXiHMB0ic+S7RKbGqC+PD+fkT3u3d0hH0kQO8VWjqQZLtNzdG8HlaDiHr32So
        QMIgPPTLcbHCX4feRql3lBsJfM70SXyLBJ/ulK3sWtcRb8yvEfnE29hn3iFQk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 63DEC59B5F;
        Tue, 27 Dec 2016 14:13:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D4C9659B5D;
        Tue, 27 Dec 2016 14:13:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 10/21] read-cache: regenerate shared index if necessary
Date:   Tue, 27 Dec 2016 11:08:47 -0800
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
        <20161226102222.17150-11-chriscool@tuxfamily.org>
Message-ID: <xmqqk2al9ocv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B89F928-CC68-11E6-B376-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> +	case 0:
> +		return 1; /* 0% means always write a new shared index */
> +	case 100:
> +		return 0; /* 100% means never write a new shared index */
> +	default:
> +		; /* do nothing: just use the configured value */
> +	}

Just like you did in 04/21, write "break" to avoid mistakes made in
the future, i.e.

	default:
		break; /* just use the configured value */

> +
> +	/* Count not shared entries */
> +	for (i = 0; i < istate->cache_nr; i++) {
> +		struct cache_entry *ce = istate->cache[i];
> +		if (!ce->index)
> +			not_shared++;
> +	}
> +
> +	return istate->cache_nr * max_split < not_shared * 100;

On a 32-bit arch with 2G int and more than 20 million paths in the
index, multiplying by max_split that can come close to 100 can
theoretically cause integer overflow, but in practice it probably
does not matter.  Or does it?
