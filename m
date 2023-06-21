Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D54EEB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 06:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjFUGzG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 02:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjFUGys (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 02:54:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B58DE7E
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 23:54:47 -0700 (PDT)
Received: (qmail 12196 invoked by uid 109); 21 Jun 2023 06:54:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jun 2023 06:54:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13426 invoked by uid 111); 21 Jun 2023 06:54:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jun 2023 02:54:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Jun 2023 02:54:46 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>
Subject: Re: Determining whether you have a commit locally, in a partial
 clone?
Message-ID: <20230621065446.GB607974@coredump.intra.peff.net>
References: <CAPMMpohiTzANyhzL-mS-gg2kzbOEOiDktNbdwEXBKy9uL0-JgA@mail.gmail.com>
 <CAPMMpog8Hv_KcjNxbh_wzjwrFYt7TuTvrVy1XEtJMm6RWSKzRg@mail.gmail.com>
 <xmqqo7lam1ei.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo7lam1ei.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2023 at 11:31:01AM -0700, Junio C Hamano wrote:

> In hindsight, I think (1) the first one should probably fail the
> "git log" process (not just the lazy fetch subprocess), and (2)
> there should be an explicit way, e.g. giving an empty string, to
> "clear" the list of .url accumulated so far.

Agreed. I think in general that any "list" config that is not doing
last-one-wins should have let a blank entry reset the list.

> (2) may look something silly like this:

I know you said "silly", but in case anybody wants to follow up on
this...

> diff --git c/remote.c w/remote.c
> index 0764fca0db..ecc146856a 100644
> --- c/remote.c
> +++ w/remote.c
> @@ -64,12 +64,22 @@ static const char *alias_url(const char *url, struct rewrites *r)
>  
>  static void add_url(struct remote *remote, const char *url)
>  {
> +	if (!*url) {
> +		remote->url_nr = 0;
> +		return;
> +	}

...it probably needs to free() the entries from 0..url_nr, and then also
free the unused empty-string "url".

But I think there's some questionable memory-ownership stuff going on
here. The main config caller passes in a newly allocated string, handing
over ownership to this list (despite the "const" parameter!). But in
add_url_alias(), we take a single allocated "url" string and put it in
both the "url" and "pushurl" lists. The former goes through alias_url()
which sometimes allocates a new string and sometimes does not.

Probably both of these would be better off as strvecs or string_lists.

-Peff
