Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C704F20196
	for <e@80x24.org>; Thu, 14 Jul 2016 18:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbcGNS1w (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 14:27:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55359 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751150AbcGNS1u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2016 14:27:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B101B2B86F;
	Thu, 14 Jul 2016 14:27:39 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6O+BDKDnerLM
	x9xGQal55NCdSMI=; b=LCvgTZJmzz9i2f1MlnnR0W9XB97DgnLMTJDOVg3lS6h0
	kfktQ24ZD6gb3e8g9O6jq3BVDZGGwnkHycIFi23JvacQTqiQVLdwx9wUNNL4KdTd
	BjJF8/7rWqIDU0HoDGgmZVCmluTXlUUta03A++hfSbn7LDFTTno0MlD0e6xd+qE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Dczo7d
	NgN1RH9wVQsFZ7WJR4kzJszWzHEcSAhmtULd99nZluF/gjIYIMJ4Rpd4yn/9Knxn
	9Pz6seFqZ121Cchi0cOZMEeU/Af2Az4c2IWPPjvbuWDkw8x9c8guj1nmod3dkqqM
	IAhsPz01hAuhaIRIXi6PwJT8bObPrhy9GbItc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A42D22B86E;
	Thu, 14 Jul 2016 14:27:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 267F32B86D;
	Thu, 14 Jul 2016 14:27:39 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Thorsten Glaser <t.glaser@tarent.de>
Cc:	Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Server-side preventing some files from being overwritten
References: <alpine.DEB.2.20.1607141725390.25238@tglase.lan.tarent.de>
	<CAGZ79kb=2rpYucjhavNB_XHLk9rjKSoHzL9bwM5buDO0GyW3vw@mail.gmail.com>
	<alpine.DEB.2.20.1607141948530.25238@tglase.lan.tarent.de>
Date:	Thu, 14 Jul 2016 11:27:36 -0700
In-Reply-To: <alpine.DEB.2.20.1607141948530.25238@tglase.lan.tarent.de>
	(Thorsten Glaser's message of "Thu, 14 Jul 2016 19:51:09 +0200
	(CEST)")
Message-ID: <xmqqpoqgqdlz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A510BFB8-49F0-11E6-AB8D-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Thorsten Glaser <t.glaser@tarent.de> writes:

> Although I’m ordinarily loath to write GNU bash scripts, this
> helps avoiding temporary files. This works:
>
> -----cutting here may damage your screen surface-----
> #!/bin/bash
> export LC_ALL=C
> subdir=x/y
> while IFS=' ' read -r old new name; do
> 	test x"$name" = x"refs/heads/master" || continue
> 	if test x"0" != x"$(comm -23z \
> 	    <(git ls-tree -r -z "$old" "$subdir" | sort -z) \
> 	    <(git ls-tree -r -z "$new" "$subdir" | sort -z) | wc -c)"; then
> 		echo >&2 'Untouchable files touched, commit rejected!'
> 		exit 1
> 	fi

Can't this become simpler, e.g.

	if ! git diff-tree --quiet "$old" "$new" -- "$subdir"
	then
		echo >&2 "Ooh, $subdir is touched"
		exit 1
	fi

> done
> exit 0
> -----cutting here may damage your screen surface-----
>
> Of course, set “subdir” in line 3 correctly, and GNU coreutils
> are required for the NUL line termination, which is not an issue
> here. (BSD has “-R ''” for sort(1), for example.)
>
> bye,
> //mirabilos
