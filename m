Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 706861FF76
	for <e@80x24.org>; Tue, 27 Dec 2016 00:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932708AbcL0Axy (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 19:53:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51991 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932561AbcL0Axw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 19:53:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 13D1C5AE4A;
        Mon, 26 Dec 2016 19:53:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jM+uR/LyeaQkxk8NkRyEBgxbY3s=; b=x5DCPL
        vwUCghU9Gd6zhK3UOS65q99n+q6e2N4Hq6w0sIk7hZRQAAZgsJP51DOfTcUGyKYh
        suBnn7uUTehorA6ryJ2TjwFlmNb4acXY6Lk/0QgDSTuhrjz8QGZE+CfCtqtZDb+5
        Qb9FrpcGx+RIqZ8xvF9DYNgvfNP8IX0kH19Qk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SjOU8+xxszO+qdMkh1XtQQX7tTzzWBQN
        SzCLjnulBPcQIMh1yGkhqbumgwIrYReXfe0TtDyfbOIceECS+ZxLEuNaN3lKDyUi
        fdvrFaHKeLpshe7JUawNtUeGLVepZvPda3mWP5BkUstlC+5QE1INjT3qQrCFkJVw
        YblgT3T5ZRs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B5EF5AE49;
        Mon, 26 Dec 2016 19:53:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5061F5AE48;
        Mon, 26 Dec 2016 19:53:50 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, David.Turner@twosigma.com,
        sandals@crustytoothpaste.net, j6t@kdbg.org
Subject: Re: [PATCHv5 3/4] submodule: rename and add flags to ok_to_remove_submodule
References: <20161220232012.15997-1-sbeller@google.com>
        <20161220232012.15997-4-sbeller@google.com>
Date:   Mon, 26 Dec 2016 16:53:49 -0800
In-Reply-To: <20161220232012.15997-4-sbeller@google.com> (Stefan Beller's
        message of "Tue, 20 Dec 2016 15:20:11 -0800")
Message-ID: <xmqqr34uchuq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE52CB02-CBCE-11E6-973A-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> As only 0 is understood as false, rename the function to invert the
> meaning, i.e. the return code of 0 signals the removal of the submodule
> is fine, and other values can be used to return a more precise answer
> what went wrong.

Makes sense to rename it as that will catch all the callers that
depend on the old semantics and name.

> -	if (start_command(&cp))
> -		die(_("could not run 'git status --porcelain -u --ignore-submodules=none' in submodule %s"), path);
> +	if (start_command(&cp)) {
> +		if (flags & SUBMODULE_REMOVAL_DIE_ON_ERROR)
> +			die(_("could not start 'git status in submodule '%s'"),
> +				path);
> +		ret = -1;
> +		goto out;
> +	}

This new codepath that does not die will not leak anything, as
a failed start_command() should release its argv[] and env[].

>  	len = strbuf_read(&buf, cp.out, 1024);
>  	if (len > 2)
> -		ok_to_remove = 0;
> +		ret = 1;

Not a new problem but is it obvious why the comparison of "len" is
against "2"?  This may deserve a one-liner comment.

Otherwise looks good to me.
