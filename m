Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E57C64E90
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 04:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4E80206E9
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 04:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgLAEyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 23:54:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:46754 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbgLAEyD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 23:54:03 -0500
Received: (qmail 22903 invoked by uid 109); 1 Dec 2020 04:53:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Dec 2020 04:53:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23106 invoked by uid 111); 1 Dec 2020 04:53:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Nov 2020 23:53:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 30 Nov 2020 23:53:22 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] fetch-pack: disregard invalid pack lockfiles
Message-ID: <X8XMQiAmDqJXy0d3@coredump.intra.peff.net>
References: <c54233ce-ff72-ca29-68c2-1416169b8e42@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c54233ce-ff72-ca29-68c2-1416169b8e42@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 30, 2020 at 08:27:15PM +0100, René Scharfe wrote:

> 9da69a6539 (fetch-pack: support more than one pack lockfile, 2020-06-10)
> started to use a string_list for pack lockfile names instead of a single
> string pointer.  It removed a NULL check from transport_unlock_pack() as
> well, which is the function that eventually deletes these lockfiles and
> releases their name strings.
> 
> index_pack_lockfile() can return NULL if it doesn't like the contents it
> reads from the file descriptor passed to it.  unlink(2) is declared to
> not accept NULL pointers (at least with glibc).  Undefined Behavior
> Sanitizer together with Address Sanitizer detects a case where a NULL
> lockfile name is passed to unlink(2) by transport_unlock_pack() in t1060
> (make SANITIZE=address,undefined; cd t; ./t1060-object-corruption.sh).
> 
> Reinstate the NULL check to avoid undefined behavior, but put it right
> at the source, so that the number of items in the string_list reflects
> the number of valid lockfiles.

It took me a minute to understand how 9da69a6539 made this worse, since
in the hunk you're touching here, the original "if NULL, do nothing"
check was checking the pointer-to-pointer to see if the caller was
interested in the lockfile name. But your "but put it right at the
source" pointed me in the right direction. The hunk from 9da69a6539 that
matters is this one:

  -       if (pack_lockfile) {
  -               printf("lock %s\n", pack_lockfile);
  +       if (pack_lockfiles.nr) {
  +               int i;
  +
  +               printf("lock %s\n", pack_lockfiles.items[0].string);
                  fflush(stdout);
  +               for (i = 1; i < pack_lockfiles.nr; i++)
  +                       warning(_("Lockfile created but not reported: %s"),
  +                               pack_lockfiles.items

(not complaining about anything, just verbosely reviewing).

> diff --git a/fetch-pack.c b/fetch-pack.c
> index b10c432315..4625926cf0 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -915,8 +915,9 @@ static int get_pack(struct fetch_pack_args *args,
>  	if (start_command(&cmd))
>  		die(_("fetch-pack: unable to fork off %s"), cmd_name);
>  	if (do_keep && pack_lockfiles) {
> -		string_list_append_nodup(pack_lockfiles,
> -					 index_pack_lockfile(cmd.out));
> +		char *pack_lockfile = index_pack_lockfile(cmd.out);
> +		if (pack_lockfile)
> +			string_list_append_nodup(pack_lockfiles, pack_lockfile);
>  		close(cmd.out);
>  	}

So this is an obviously correct fix, but I have to wonder whether we
ought to be (even before 9da69a6539) complaining about pack-objects not
correctly reporting the pack name to us. I think in practice this
happens when it dies early without reporting anything to us, in which
case we'd notice its non-zero exit anyway. So it's probably not a big
deal, but would amount to an assertion (and if we did want to do it, it
should come on top of your fix, and not hold it up).

-Peff
