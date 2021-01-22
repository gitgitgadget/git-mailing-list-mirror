Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E6EC433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 20:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7C1C23B01
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 20:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbhAVUfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 15:35:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:35670 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730369AbhAVUcv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 15:32:51 -0500
Received: (qmail 13672 invoked by uid 109); 22 Jan 2021 20:32:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 22 Jan 2021 20:32:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18212 invoked by uid 111); 22 Jan 2021 20:32:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 Jan 2021 15:32:05 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 22 Jan 2021 15:32:04 -0500
From:   Jeff King <peff@peff.net>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] upload-pack.c: fix filter spec quoting bug
Message-ID: <YAs2RMT1rEH/2LSp@coredump.intra.peff.net>
References: <20210122142137.21161-1-jacob@gitlab.com>
 <20210122142137.21161-2-jacob@gitlab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210122142137.21161-2-jacob@gitlab.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 22, 2021 at 03:21:37PM +0100, Jacob Vosmaer wrote:

> This fixes a bug that occurs when you combine partial clone and
> uploadpack.packobjectshook. You can reproduce it as follows:
> 
> git clone -u 'git -c uploadpack.allowfilter '\
> '-c uploadpack.packobjectshook=" exec" '\
> 'upload-pack' --filter=blob:none --no-local \
> src.git dst.git
> 
> Be careful with the line endings because this has a long quoted string
> as the -u argument. Note that there is an intentional space before
> 'exec'. Without that space, run-command.c tries to be smart and the
> command fails for the wrong reason.

The "-u" command is run with a shell, so:

  git clone \
    -u 'git -c uploadpack.allowfilter \
            -c uploadpack.packobjectshook=env \
	    upload-pack' \
  --filter=blob:none --no-local src.git dst.git

may be a more readable version. I also found the use of " exec" clever,
but rather subtle; you need the extra space so that our "don't bother
using a shell" run-command optimization does not kick in. I replaced it
with "env" here, which is a slightly more canonical way of running a
sub-program that does not rely on shell builtins.

But all of this should be added as a new test, probably in t5544 with
the other pack-objects hook tests.

> The problem is an unnecessary and harmful layer of quoting. I tried
> digging through the history of this function and I think this quoting
> was there from the start. My best guess is that it stems from a
> misunderstanding of what use_shell=1 means. The code seems to assume
> it means "arguments get joined into one big string, then fed to
> /bin/sh". But that is not what it means: use_shell=1 means that the
> first argument in the arguments array may be a shell script and if so
> should be passed to /bin/sh. All other arguments are passed as normal
> arguments.

Yeah, that is exactly right. "use_shell" just means that the command is
(possibly) run with a shell. Quoting for any extra arguments is handled
automatically.

I think you're correct that this was broken from the start in 10ac85c785
(upload-pack: add object filtering for partial clone, 2017-12-08).
That's even before the use_shell was added, and then later it was pushed
into that conditional by 0b6069fe0a (fetch-pack: test support excluding
large blobs, 2017-12-08). Presumably because the non-hook path would not
have worked at all, and that was the first time any of it was actually
tested. ;)

(I've cc'd authors of those commits as an FYI; I think both were
relatively new to the project at the time so misunderstanding this
subtlety of run-command is not too surprising).

I'm somewhat embarrassed to say that despite being the one who added the
pack-objects hook 4 years ago, we still have not switched over to it at
GitHub from our custom patch (the reason is just mundane; there's some
other adjustments that would have to happen and nobody has ever quite
gotten around to it). Presumably you are looking to use it at GitLab.
Just beware that you are probably treading new-ish ground, so there may
be other bugs like this lurking.

> diff --git a/upload-pack.c b/upload-pack.c
> index 3b66bf92ba..eae1fdbc55 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -305,14 +305,7 @@ static void create_pack_file(struct upload_pack_data *pack_data,
>  	if (pack_data->filter_options.choice) {
>  		const char *spec =
>  			expand_list_objects_filter_spec(&pack_data->filter_options);
> -		if (pack_objects.use_shell) {
> -			struct strbuf buf = STRBUF_INIT;
> -			sq_quote_buf(&buf, spec);
> -			strvec_pushf(&pack_objects.args, "--filter=%s", buf.buf);
> -			strbuf_release(&buf);
> -		} else {
> -			strvec_pushf(&pack_objects.args, "--filter=%s", spec);
> -		}
> +		strvec_pushf(&pack_objects.args, "--filter=%s", spec);

Yep, this looks like the right fix. I think with an addition to the test
suite, this will be good to go.

-Peff
