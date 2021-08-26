Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EA8C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 20:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74A2661002
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 20:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242313AbhHZUJD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 16:09:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52850 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240039AbhHZUI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 16:08:56 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7911BE6FCD;
        Thu, 26 Aug 2021 16:08:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/AfML5dZfi4M1Y+W0n2IjP2lGWbaAILRRkDdPm
        taph4=; b=GK+vylyLfqLmLdH6qf9vrEg31gB3i8iSOPF4anYA1wxSPIH9koolmo
        Vl9vggc6lO6STBqGCIYBG1R6/vcTEPjLITr35y64N4Kh0YhExLLv9nZOxLoOAkbE
        koyf6AmCyuUF1PjKNHwzH/319BldhlPe4iosnddeDK6h7BEuiWObo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 70780E6FCC;
        Thu, 26 Aug 2021 16:08:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D29F5E6FCB;
        Thu, 26 Aug 2021 16:08:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, felipe.contreras@gmail.com,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <emilyshaffer@google.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] make: add install-stripped target
References: <20210826113824.50078-1-bagasdotme@gmail.com>
        <20210826113824.50078-2-bagasdotme@gmail.com>
Date:   Thu, 26 Aug 2021 13:08:06 -0700
In-Reply-To: <20210826113824.50078-2-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Thu, 26 Aug 2021 18:38:23 +0700")
Message-ID: <xmqq8s0odl5l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54844F9E-06A9-11EC-8907-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> +install-stripped: install
> +	for f in $(PROGRAMS) git$X; do \
> +		find $$prefix -type f -name $$f -exec $(STRIP) $(STRIP_OPTS) {} \; ; \
> +	done
> +

This sounds awfully wasteful.

The recipe for the install target knows exactly each of these
programs are installed, but yet the above is running around inside
$prefix to find them after the fact.

It also looks incorrect, too.

It is not guaranteed that $prefix does not contain any $IFS
whitespace in it, and worse yet, $prefix may not contain $bindir or
$libexecdir in it, so find may never reach these binaries.

It also depends on "strip" not to break handlinks to the same
binary.  "git" is linked to many built-in command binary like
"git-cat-file" and "git-remote-$curl" for various protocols are
installed by creating links to "git-remote-http".  It seems that the
"strip" command from GNU binutils package strips such a binary
in-place, but I do not think there is no fundamental reason to
believe that everybody else's "strip" would behave that way.

I would have expected that 'install-stripped' and 'install' targets
would run the same recipe, and when $(install_bindir_programs) are
installed in $(bindir) using $(INSTALL), we would optionally pass
the '--strip' option to the $(INSTALL) program when the recipe is
run for the install-stripped target.  All the tricky symlinking,
hardlinking and copying happens only on the result of that step, and
the strip step should happen before that, I would think.

> +.PHONY: install-gitweb install-doc install-man install-man-perl install-html install-info install-pdf install-stripped

Split the overly long line like this into two or more.

>  .PHONY: quick-install-doc quick-install-man quick-install-html
>  install-gitweb:
>  	$(MAKE) -C gitweb install
