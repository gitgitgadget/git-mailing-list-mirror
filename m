Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ECFD202A0
	for <e@80x24.org>; Tue, 24 Oct 2017 02:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751294AbdJXCQh (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 22:16:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60818 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751259AbdJXCQg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 22:16:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 97D2596AC2;
        Mon, 23 Oct 2017 22:16:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xb7IMFLsjw041B7/fL29I/SBfuk=; b=L9c/8w
        OSHgvwms4yxa+IQrGZs7GHOwoyJoWJZKga29sR2PwDsb7Kpm5XTwkr/C4350+5dI
        11NaMMEkXFu+//twC7p1V6IklAmqn7YvZXHRnP3JQH8vT78F5nxu7oL8jk77RMh1
        tbsTjrOkI+OmcPwz0x9/j0xCX1/JHsXxD6ycY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qOVnmSGwRJZSGOGjjfQxi1NN6pMM1I3P
        fHQVqAmPz2Zn+3CyBpZkL3YsokoFMFVRlY9Wmy8c9l4hBa0pS1JwFxBHgKR+ythe
        s8o50vLRpASFOR2bU0pkegZY5lGMpHLFmLnmOGUZ4xYYXoyvuGGM+Q6CNPOpJ++7
        91gmhnFuuoE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DAD996AC1;
        Mon, 23 Oct 2017 22:16:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F072C96ABF;
        Mon, 23 Oct 2017 22:16:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, peff@peff.net, sbeller@google.com,
        William Yan <wyan@google.com>
Subject: Re: [PATCH 3/5] ssh: 'auto' variant to select between 'ssh' and 'simple'
References: <20170926235627.79606-1-bmwill@google.com>
        <20171003201507.3589-1-bmwill@google.com>
        <20171003201507.3589-11-bmwill@google.com>
        <20171003214206.GY19555@aiede.mtv.corp.google.com>
        <20171016171812.GA4487@google.com>
        <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
        <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com>
Date:   Tue, 24 Oct 2017 11:16:33 +0900
In-Reply-To: <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com>
        (Jonathan Nieder's message of "Mon, 23 Oct 2017 14:31:59 -0700")
Message-ID: <xmqq60b59toe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5BDCEE76-B861-11E7-8A1D-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>  1. First, check whether $GIT_SSH supports OpenSSH options by running
>
> 	$GIT_SSH -G <options> <host>
>
>     This returns status 0 and prints configuration in OpenSSH if it
>     recognizes all <options> and returns status 255 if it encounters
>     an unrecognized option.  A wrapper script like
>
> 	exec ssh -- "$@"
>
>     would fail with
>
> 	ssh: Could not resolve hostname -g: Name or service not known
>
>     , correctly reflecting that it does not support OpenSSH options.

Two comments.

 * It would have been really nicer if the push_ssh_options() got
   split from its caller in a separate preparatory [PATCH 2.5/5].

 * Use of -G for auto-detection is clever and cute, but do we know
   how safe it would be in the real world?  What worries me the most
   is "myssh -G localhost" (no extra options) that does not fit our
   expectation on "-G" to either exit immediately with an error when
   it is not understood, or to exit like OpenSSH does, and instead
   successfully makes a connection and gets stuck.
