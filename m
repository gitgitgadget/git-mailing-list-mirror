Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B3601F609
	for <e@80x24.org>; Thu, 29 Nov 2018 01:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeK2MzJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 07:55:09 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60549 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeK2MzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 07:55:09 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CCCB73AD3C;
        Wed, 28 Nov 2018 20:51:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4FAlkbYDpQc+5/W4B0hYxyOUPLM=; b=r9256f
        Ax0Revt5tHglGxMm1IjEhYjL+Sze4/btSeBjn/vj3Y1/6HCosrvFqMMYst2fZZ1B
        aNlmBLjkYetUI4L4rk9enSAVMGc5XtVmJ15V3AmE0ow5XwXwMVKtgnydx7M+q3bU
        O7e8JOYh58TPOAy+AcBfcTur7lCJSXjfGmehA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OCPCS7Rb9YqIndBO84CO796KmDiHMC+R
        RDpwyU47UG+BeiKBsCq/s7YD94skY20Bo81RZ0LktBhoqFo0Z1VkF0unq5a5exuL
        U1533TbYb1EJ7IMwdwRZYSfb9vwLBLUkqidAcBaaIs2BQrhYwC0e6R+Fqko0yMGI
        jI6IPDmRl4Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B0F4D3AD3A;
        Wed, 28 Nov 2018 20:51:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CD9A03AD30;
        Wed, 28 Nov 2018 20:51:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
Subject: Re: in 2.19.2 t0061-run-command FAILs if . is in $PATH
References: <20181128100517.28d44804@pc09.procura.nl>
        <nycvar.QRO.7.76.6.1811281041400.41@tvgsbejvaqbjf.bet>
Date:   Thu, 29 Nov 2018 10:51:23 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1811281041400.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 28 Nov 2018 10:42:45 +0100 (STD)")
Message-ID: <xmqqpnuor6qs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47F39B72-F379-11E8-A669-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> -test_expect_success 'run_command is restricted to PATH' '
> +test_lazy_prereq DOT_IN_PATH '
> +	case ":$PATH:" in
> +	*:.:*) true;;
> +	*) false;;
> +	esac
> +'

An empty element in the colon-separated list also serves as an
instruction to pick up executable from $cwd, so

	case ":$PATH:" in
	*:.:** | *::*) true ;;
	*) false ;;
	esac

perhaps.

> +test_expect_success !DOT_IN_PATH 'run_command is restricted to PATH' '
>  	write_script should-not-run <<-\EOF &&
>  	echo yikes
>  	EOF
> -- snap --
>
> If so, can you please provide a commit message for it (you can add my
> Signed-off-by: line and your Tested-by: line).
>
> Thanks,
> Johannes
