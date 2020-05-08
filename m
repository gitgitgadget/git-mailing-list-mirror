Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4990AC35280
	for <git@archiver.kernel.org>; Fri,  8 May 2020 01:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7AC22082E
	for <git@archiver.kernel.org>; Fri,  8 May 2020 01:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XbHwDUWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgEHBU5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 21:20:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55406 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgEHBU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 21:20:56 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EA0F55D0F;
        Thu,  7 May 2020 21:20:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0qlXXbugdpFM9sB0KlezhPRfuNM=; b=XbHwDU
        WCWbBEcURk4WDxLYo+wq38AJgW52gVri2UX11/VeUB2Kgb9o1FFcM/dsksI9mFyV
        YnDS5g4OwNdkibF6ckxaMrDAHJaDAQJG/u1c8iZekT3XCxYLol3cgbbC8147xTVn
        dji8stlYAoseqfxEaVodeJ9Qk6juBzd+xLcn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FR8QIuDB6cAjdigVvlFQjls9FaC1Josw
        krYJtMC+siKAIh+qbvIMRHbIVzyWx6c9UgDeXyrL98bxsV+bZClGrZdoJfzpRF8W
        RqNOGGRImRk0ydhjzGIbpSWhmbWIVV82kZjRGHzvkYh6+DVgnbAFovX28tI17He2
        4ChvLrG6prg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9719255D0E;
        Thu,  7 May 2020 21:20:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 14EEF55D0D;
        Thu,  7 May 2020 21:20:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4] bugreport: collect list of populated hooks
References: <20200508005357.223058-1-emilyshaffer@google.com>
Date:   Thu, 07 May 2020 18:20:53 -0700
In-Reply-To: <20200508005357.223058-1-emilyshaffer@google.com> (Emily
        Shaffer's message of "Thu, 7 May 2020 17:53:57 -0700")
Message-ID: <xmqqlfm31atm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 296D8CFE-90CA-11EA-8205-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
> index 2e73658a5c..ff317cce68 100755
> --- a/t/t0091-bugreport.sh
> +++ b/t/t0091-bugreport.sh
> @@ -57,5 +57,20 @@ test_expect_success 'can create leading directories outside of a git dir' '
>  	nongit git bugreport -o foo/bar/baz
>  '
>  
> +test_expect_success 'indicates populated hooks' '
> +	test_when_finished rm git-bugreport-hooks.txt &&
> +	test_when_finished rm -fr .git/hooks &&
> +	rm -fr .git/hooks &&
> +	mkdir .git/hooks &&
> +	for hook in applypatch-msg prepare-commit-msg.sample
> +	do
> +		write_script ".git/hooks/$hook" <<-\EOF || return 1
> +		echo "hook $hook exists"
> +		EOF

Probably our mails crossed, but as I said in my response, this will
make the hook say "hook  exists" because $hook will be literally in
the script file.  EOF needs to be left unquoted, i.e.

		write_script ".git/hooks/$hook" <<-EOF || return 1
		...

> +	done &&
> +	...

Thanks.


