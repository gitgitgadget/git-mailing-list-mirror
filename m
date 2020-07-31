Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B2BC433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 17:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E9BB22B40
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 17:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387502AbgGaRgu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 13:36:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:43828 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733055AbgGaRgu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 13:36:50 -0400
Received: (qmail 23245 invoked by uid 109); 31 Jul 2020 17:36:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 Jul 2020 17:36:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28414 invoked by uid 111); 31 Jul 2020 17:36:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jul 2020 13:36:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 31 Jul 2020 13:36:49 -0400
From:   Jeff King <peff@peff.net>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] refs: add \t to reflog in the files backend
Message-ID: <20200731173649.GA843002@coredump.intra.peff.net>
References: <pull.688.git.1596195370757.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.688.git.1596195370757.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 31, 2020 at 11:36:10AM +0000, Han-Wen Nienhuys via GitGitGadget wrote:

> diff --git a/refs.c b/refs.c
> index 89814c7be4..2dd851fe81 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -907,7 +907,6 @@ static void copy_reflog_msg(struct strbuf *sb, const char *msg)
>  	char c;
>  	int wasspace = 1;
>  
> -	strbuf_addch(sb, '\t');
>  	while ((c = *msg++)) {
>  		if (wasspace && isspace(c))
>  			continue;
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index e0aba23eb2..985631f33e 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1628,8 +1628,10 @@ static int log_ref_write_fd(int fd, const struct object_id *old_oid,
>  	int ret = 0;
>  
>  	strbuf_addf(&sb, "%s %s %s", oid_to_hex(old_oid), oid_to_hex(new_oid), committer);
> -	if (msg && *msg)
> +	if (msg && *msg) {
> +		strbuf_addch(&sb, '\t');
>  		strbuf_addstr(&sb, msg);
> +	}

I wondered here whether the existing code would always write the tab,
even for an entry with no message, since we seem to unconditionally add
the tab in the hunk above.

But it looks like we only call copy_reflog_msg() if it's non-empty:

  static char *normalize_reflog_message(const char *msg)
  {
          struct strbuf sb = STRBUF_INIT;
  
          if (msg && *msg)
                  copy_reflog_msg(&sb, msg);
          return strbuf_detach(&sb, NULL);
  }

so this is retaining that behavior (and indeed, doing a simple "git
update-ref" confirms that we currently omit the tab in this case).

So the patch looks good (and the intent seems obviously good to me, as
well).

-Peff
