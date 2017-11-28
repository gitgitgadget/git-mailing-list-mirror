Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72EA420C11
	for <e@80x24.org>; Tue, 28 Nov 2017 01:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753319AbdK1Biy (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 20:38:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60240 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753170AbdK1Biu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 20:38:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 65DCAC0681;
        Mon, 27 Nov 2017 20:38:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RAGJj3NfEjC0AyQBODNwYG2VCgw=; b=WUS714
        hYEO/ydfZNYJsygzbM9fSMhGLHc9D4oux/3Y+H8PkLxgKqCqenyRB7VRMNuuTEUz
        d2A9trdzwFiuYaFaVBHNgaYk+nObn4/QnXsH3v2TavB8069ol4C07fp//27ftn+r
        Tqvws4SQjx3vqtIMg1pLeqyFcsYxSyuumXOp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yDQXi2pDVaZYJNezymLmw32di2xqMiQM
        sfOa7nVZEYNujSUx2V+Hae6K4OwZNwfPytHTb0o7APqkIIsKcfXQ2DQ9TmIuyodq
        5OgXIH0FjuEXlbBF+uDfcOhY2Re1pP0v8d7atIFuf1cNik8rZh2KxSrN9qVsfDGC
        tCMnVaxSPoE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E286C0680;
        Mon, 27 Nov 2017 20:38:50 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C827CC067F;
        Mon, 27 Nov 2017 20:38:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v2] diff: support anchoring line(s)
References: <20171122234152.72901-1-jonathantanmy@google.com>
        <20171127194747.118254-1-jonathantanmy@google.com>
Date:   Tue, 28 Nov 2017 10:38:48 +0900
In-Reply-To: <20171127194747.118254-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 27 Nov 2017 11:47:47 -0800")
Message-ID: <xmqq1skj9o7r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E22376F8-D3DC-11E7-8B6F-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> -	else if (!strcmp(arg, "--patience"))
> +	else if (!strcmp(arg, "--patience")) {
> +		int i;
>  		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
> -	else if (!strcmp(arg, "--histogram"))
> +		/*
> +		 * Both --patience and --anchored use PATIENCE_DIFF
> +		 * internally, so remove any anchors previously
> +		 * specified.
> +		 */
> +		for (i = 0; i < options->anchors_nr; i++)
> +			free(options->anchors[i]);
> +		options->anchors_nr = 0;

This makes sense, but "--diff-algorithm=patience" would want to do
the same, I suspect, so the loop would want to become a little
helper function "clear_patience_anchors(options)" or something like
that.

> diff --git a/t/t4064-diff-anchored.sh b/t/t4064-diff-anchored.sh
> new file mode 100755
> index 000000000..b3f510f04
> --- /dev/null
> +++ b/t/t4064-diff-anchored.sh
> @@ -0,0 +1,94 @@
> +#!/bin/sh
> +
> +test_description='anchored diff algorithm'
> +
> +. ./test-lib.sh
> +
> +test_expect_success '--anchored' '
> +	printf "a\nb\nc\n" >pre &&
> +	printf "c\na\nb\n" >post &&

This may be too little to matter, but I'd find

	printf "%s\n" a b c >pre

vastly easier to read.  Or perhaps just use

	test_write_lines a b c >pre

