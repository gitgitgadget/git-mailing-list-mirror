Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B6DC38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 17:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 995D7218AC
	for <git@archiver.kernel.org>; Fri,  8 May 2020 17:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgEHRMd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 13:12:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:41812 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726750AbgEHRMd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 13:12:33 -0400
Received: (qmail 10465 invoked by uid 109); 8 May 2020 17:12:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 May 2020 17:12:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30183 invoked by uid 111); 8 May 2020 17:12:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 May 2020 13:12:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 8 May 2020 13:12:32 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christopher Warrington via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christopher Warrington <chwarr@microsoft.com>
Subject: Re: [PATCH] bisect: fix replay of CRLF logs
Message-ID: <20200508171232.GA637136@coredump.intra.peff.net>
References: <pull.629.git.1588886980377.gitgitgadget@gmail.com>
 <20200507222510.GA42822@coredump.intra.peff.net>
 <xmqq5zd72vjp.fsf@gitster.c.googlers.com>
 <20200508130831.GB631018@coredump.intra.peff.net>
 <xmqqh7wq1n52.fsf@gitster.c.googlers.com>
 <xmqq8si2z8zb.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8si2z8zb.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 08, 2020 at 09:28:56AM -0700, Junio C Hamano wrote:

> -- >8 --
> From: Christopher Warrington <chwarr@microsoft.com>
> Subject: [PATCH] bisect: allow CRLF line endings in "git bisect replay" input
> 
> We advertise that the bisect log can be corrected in your editor
> before being fed to "git bisect replay", but some editors may
> turn the line endings to CRLF.
> 
> Update the parser of the input lines so that the CR at the end of
> the line gets ignored.

I'm a little surprised that bash "read" on Windows doesn't eat CRLFs
already. But I often find myself confused by line ending decisions in
general, as well as the difference between cygwin versus msys versus
pure windows binaries, etc.

At any rate, munging IFS seems much nicer than having an extra call to
tr.

> diff --git a/git-bisect.sh b/git-bisect.sh
> index efee12b8b1..56548d4be7 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -209,6 +209,7 @@ bisect_replay () {
>  	test "$#" -eq 1 || die "$(gettext "No logfile given")"
>  	test -r "$file" || die "$(eval_gettext "cannot read \$file for replaying")"
>  	git bisect--helper --bisect-reset || exit
> +	oIFS="$IFS" IFS="$IFS:$(printf '\015')"

There's no ":" separator in IFS, so here you're treating colon as
end-of-line. I think you just want:

  IFS="$IFS$(printf '\015')"

-Peff
