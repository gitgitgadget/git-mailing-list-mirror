Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E19C43616
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9F6C613F6
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239120AbhELX0E (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 19:26:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:52912 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376538AbhELXKK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 19:10:10 -0400
Received: (qmail 30065 invoked by uid 109); 12 May 2021 23:09:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 May 2021 23:09:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10613 invoked by uid 111); 12 May 2021 23:09:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 May 2021 19:09:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 May 2021 19:08:59 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH 9/9] send-email: move trivial config handling to Perl
Message-ID: <YJxgC/PJ/JIcIOfq@coredump.intra.peff.net>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
 <patch-9.9-0d87c9a5a3-20210512T132955Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-9.9-0d87c9a5a3-20210512T132955Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 12, 2021 at 03:48:25PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Optimize the startup time of git-send-email by using an amended
> config_regexp() function to retrieve the list of config keys and
> values we're interested in.
> 
> For boolean keys we can handle the [true|false] case ourselves, and
> the "--get" case didn't need any parsing. Let's leave "--path" and
> other "--bool" cases to "git config". As noted in a preceding commit
> we're free to change the config_regexp() function, it's only used by
> "git send-email".

I think both of these cases should be safe.

It is a bit unfortunate to have to go through these contortions, but
this is definitely the best we can do for now. I think in the long run
it would be nice to have a "--stdin" mode for git-config, where we could
do something like:

  git config --stdin <<\EOF
  key=foo.bar
  type=bool
  default=false

  key=another.key
  type=color
  default=red
  EOF

But that doesn't exist yet, and using it would probably involve
rearranging send-email a bit (we would need an up-front list of all of
the keys we care about and their types). So I'm perfectly content with
this strategy in the meantime.

> diff --git a/perl/Git.pm b/perl/Git.pm
> index f18852fb09..a9020d0d01 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -739,18 +739,18 @@ sub config_int {
>  =item config_regexp ( RE )
>  
>  Retrieve the list of configuration key names matching the regular
> -expression C<RE>. The return value is a list of strings matching
> -this regex.
> +expression C<RE>. The return value is an ARRAY of key-value pairs.

The Git.pm interface is public-facing, isn't it? Are we breaking
third-party callers of config_regexp here?

-Peff
