Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4981C433FE
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 18:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239070AbiKPSyk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 13:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239254AbiKPSxu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 13:53:50 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF1F657C5
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 10:52:57 -0800 (PST)
Received: (qmail 21773 invoked by uid 109); 16 Nov 2022 18:52:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Nov 2022 18:52:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2904 invoked by uid 111); 16 Nov 2022 18:52:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Nov 2022 13:52:56 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Nov 2022 13:52:55 -0500
From:   Jeff King <peff@peff.net>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] notes: avoid empty line in template
Message-ID: <Y3Uxh25Gh5fPQrMq@coredump.intra.peff.net>
References: <347ee7ad6fea7cf96bb1e51772802102082b58cc.1668614158.git.git@grubix.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <347ee7ad6fea7cf96bb1e51772802102082b58cc.1668614158.git.git@grubix.eu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 16, 2022 at 04:56:40PM +0100, Michael J Gruber wrote:

> When `git notes` prepares the template it adds an empty newline between
> the comment header and the content:
> 
> >
> > #
> > # Write/edit the notes for the following object:
> >
> > # commit 0f3c55d4c2b7864bffb2d92278eff08d0b2e083f
> > # etc
> 
> This is wrong structurally because that newline is part of the comment,
> too, and thus should be commented. Also, it throws off some positioning
> strategies of editors and plugins, and it differs from how we do commit
> templates.
> 
> Change this to follow the standard set by `git commit`:
> 
> >
> > #
> > # Write/edit the notes for the following object:
> > #
> > # commit 0f3c55d4c2b7864bffb2d92278eff08d0b2e083f
> >

Yeah, this makes perfect sense.

> Tests pass unchanged after this code change.

I'm mildly surprised that there wasn't some test depending on this in a
stupid way. :) But grepping for "Write/edit" shows that nobody did (and
obviously the tests pass).

We could add a new test here, but it probably is trivial enough not to
worry about.

> diff --git a/builtin/notes.c b/builtin/notes.c
> index be51f69225..80d9dfd25c 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -181,7 +181,7 @@ static void prepare_note_data(const struct object_id *object, struct note_data *
>  		strbuf_addch(&buf, '\n');
>  		strbuf_add_commented_lines(&buf, "\n", strlen("\n"));
>  		strbuf_add_commented_lines(&buf, _(note_template), strlen(_(note_template)));
> -		strbuf_addch(&buf, '\n');
> +		strbuf_add_commented_lines(&buf, "\n", strlen("\n"));

And the patch looks obviously good. The irony is the version two lines
above which does it correctly. ;)

-Peff
