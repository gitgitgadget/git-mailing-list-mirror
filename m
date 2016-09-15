Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D9952070F
	for <e@80x24.org>; Thu, 15 Sep 2016 21:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753360AbcIOVJD (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 17:09:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54399 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752388AbcIOVJB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 17:09:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 832F53D7DC;
        Thu, 15 Sep 2016 17:09:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sXMlRV9CRpYIg2fF9zUxKEuJa4w=; b=Z4vCKa
        yLHZdcEFV8dxJ+8Xowd2MBx9ERsHR0orptmMzUVHiVZhxSgfjcOkOw8RI4UQR5O3
        qpGsi/gLszYLforc+vbEjj9mTwAqaulMkCzpKdMJ5i0a0PQvnQQf/9rAOTAbH5Nm
        yEZxoDxzKrEHcNqxlC+lb1OZEwgH7cqLBAijs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=paskigZxVqV8lzN0/Vf/Ao1Uguq+qLhO
        GaqfGC0y92C1v13VUexHHeHCoH/c3aaa5tClyJ28LHZQE0RexnYz3fRfpqIzO7KI
        AgnFnDW7kgvndU8y8eDvUKcQ8vOsmU6ERzpgAmkBpZWLVLeD4L3RFj9mMKEegNYf
        0ZHmow32/Gs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 767603D7DB;
        Thu, 15 Sep 2016 17:09:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E11163D7DA;
        Thu, 15 Sep 2016 17:08:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH 3/2] batch check whether submodule needs pushing into one call
References: <20160824173017.24782-1-sbeller@google.com>
        <20160824183112.ceekegpzavnbybxp@sigill.intra.peff.net>
        <xmqqh9aaot49.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYOBqQ0FF4J-+KbefSD8HRrUeMqpO27m_jprhm93aB+LA@mail.gmail.com>
        <20160824230115.jhmcr4r7wobj5ejb@sigill.intra.peff.net>
        <20160914173124.GA7613@sandbox>
        <xmqqwpiep10i.fsf@gitster.mtv.corp.google.com>
        <20160915121044.GA96648@book.hvoigt.net>
Date:   Thu, 15 Sep 2016 14:08:58 -0700
In-Reply-To: <20160915121044.GA96648@book.hvoigt.net> (Heiko Voigt's message
        of "Thu, 15 Sep 2016 14:10:44 +0200")
Message-ID: <xmqq1t0kna51.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F50E142-7B88-11E6-9631-096F12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

>  	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
>  		struct child_process cp = CHILD_PROCESS_INIT;
> -		const char *argv[] = {"rev-list", NULL, "--not", "--remotes", "-n", "1" , NULL};
> +
> +		argv_array_push(&cp.args, "rev-list");
> +		sha1_array_for_each_unique(hashes, append_hash_to_argv, &cp.args);
> +		argv_array_pushl(&cp.args, "--not", "--remotes", "-n", "1" , NULL);
> +
>  		struct strbuf buf = STRBUF_INIT;
>  		int needs_pushing = 0;

These two become decl-after-stmt; move your new lines a bit lower,
perhaps?

> -		argv[1] = sha1_to_hex(sha1);
> -		cp.argv = argv;
>  		prepare_submodule_repo_env(&cp.env_array);

By the way, with the two new patches, 'pu' seems to start failing
some tests, e.g. 5533 5404 5405.

