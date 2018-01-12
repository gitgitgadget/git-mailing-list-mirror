Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 928931F406
	for <e@80x24.org>; Fri, 12 Jan 2018 19:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965088AbeALTTr (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 14:19:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61596 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964998AbeALTTq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 14:19:46 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4018B73EB;
        Fri, 12 Jan 2018 14:19:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aNHKV2um8Y9bB3G8UcZUi6VmSSk=; b=O6h9B9
        IecEfEur+sV8y+L+dLPT34XIPrF4FQVvH7vnpGcf583rXVHnnGbnpubd3qJn5ih9
        WpyAN+gaGl5ZFfV1Ctg5cLI0ERNebVGnuFz8OU/2XosBqhk4rFGKNcqzAAVmIzcz
        UILLWQT+H9+ru2Qy/OxAd0WB/BEqou+2OlKXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TxvXRxAxqpFd+jcLIEIuTGGX9BIn9UMB
        HU2otlaFGX7U7f/7AP2udRIIn7OfpD/3T8h4sKDZ6XYZ9ZlVj2z1Ey8Rwywd8F5b
        4RMmXq9xwBX1P0rIuLnXk3f9SiiBUilaAPAM773U3PHakHtUuYe4hO6145w9lzo9
        c7Kn8dX67t0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BC692B73E9;
        Fri, 12 Jan 2018 14:19:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 25DA2B73E6;
        Fri, 12 Jan 2018 14:19:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 4/4] trace.c: be smart about what env to print in trace_run_command()
References: <20180111094712.2551-1-pclouds@gmail.com>
        <20180112095607.18293-1-pclouds@gmail.com>
        <20180112095607.18293-5-pclouds@gmail.com>
        <20180112133355.GE27499@sigill.intra.peff.net>
        <xmqqpo6fvstf.fsf@gitster.mtv.corp.google.com>
        <20180112184546.GA15514@sigill.intra.peff.net>
Date:   Fri, 12 Jan 2018 11:19:44 -0800
In-Reply-To: <20180112184546.GA15514@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 12 Jan 2018 13:45:46 -0500")
Message-ID: <xmqqlgh2x4tr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C4D7CA0-F7CD-11E7-871D-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The actual prep_childenv() code looks like it would always do
> last-one-wins, so we should treat FOO as unset in that final case. But
> that only kicks in on non-Windows.
>
> On Windows we feed cmd->env straight to mingw_spawnvpe().  That ends up
> in make_environment_block(), which looks like it does something similar.
>
> It's too bad the prep code is not shared, since then we could probably
> just ask _it_ which deltas it applied.

Yeah, but that function does a lot more than computing delta.  

It's primary point, which comes from ae25394b ("run-command: prepare
child environment before forking", 2017-04-19), is to create a full
copy of the environment, not just a series of putenv/unsetenv that
describes what gets changed, and that is done to avoid any
allocation after fork before exec in the child process.

I guess prep_childenv() could take an extra and optional string-list
to report what "deltas" it applied to the tracing machinery.  I am
not sure if that is worth it, though.



