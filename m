Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4461C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 11:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AF906103C
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 11:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241577AbhJ0LFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 07:05:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:47884 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239782AbhJ0LFb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 07:05:31 -0400
Received: (qmail 13083 invoked by uid 109); 27 Oct 2021 11:03:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Oct 2021 11:03:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21502 invoked by uid 111); 27 Oct 2021 11:03:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Oct 2021 07:03:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Oct 2021 07:03:05 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Krzysztof =?utf-8?Q?=C5=BBelechowski?= <giecrilj@stegny.2a.pl>,
        git@vger.kernel.org, Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: *Really* noisy encoding warnings post-v2.33.0
Message-ID: <YXkx6WzoF+B1id5T@coredump.intra.peff.net>
References: <9896630.2IqcCWsCYL@localhost.localdomain>
 <YSWVi8uLHZCTtG0l@coredump.intra.peff.net>
 <xmqqeeahjxj4.fsf@gitster.g>
 <YSkvNyR4uT52de13@coredump.intra.peff.net>
 <87ily7m1mv.fsf@evledraar.gmail.com>
 <YWEAEjIN0HVHbIpg@coredump.intra.peff.net>
 <YWEBmJk0aENR5Yeo@coredump.intra.peff.net>
 <871r4umfnm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871r4umfnm.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 09, 2021 at 03:47:16PM +0200, Ævar Arnfjörð Bjarmason wrote:

> But in this case this seems to have been because someone tried to feed
> "HTML" to it, which is not an encoding, and something iconv_open() has
> (I daresay) always and will always error on. It returns -1 and sets
> errno=EINVAL.
> 
> So having a warning or other detection in the revision loop seems
> backwards to me, surely we want something like the below instead?
> I.e. die as close to bad option parsing as possible?

Sorry for the slow response; this got thrown on my "to think about and
look at later" pile.

Yeah, I agree that if we sanity-checked the encoding up front, that
would cover the case we saw in practice, and goes a long way towards
catching any practical errors.

But I think this patch is tricky:

> diff --git a/environment.c b/environment.c
> index 43bb1b35ffe..c26b18f8e5c 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -357,8 +357,18 @@ void set_git_dir(const char *path, int make_realpath)
>  
>  const char *get_log_output_encoding(void)
>  {
> -	return git_log_output_encoding ? git_log_output_encoding
> +	const char *encoding = git_log_output_encoding ? git_log_output_encoding
>  		: get_commit_output_encoding();
> +#ifndef NO_ICONV
> +	iconv_t conv;
> +	conv = iconv_open(encoding, "UTF-8");
> +	if (conv == (iconv_t) -1 && errno == EINVAL)
> +		die_errno("the '%s' encoding is not known to iconv", encoding);
> +#else
> +	if (strcmp(encoding, "UTF-8"))
> +		die("compiled with NO_ICONV=Y, can't re-encode to '%s'", encoding);
> +#endif
> +	return encoding;
>  }

So one obvious problem here is that we call this function once per
commit, so it's a lot of extra iconv_open() calls. But obviously we
could use a static flag to do it once per process.

The other issue is that it is assuming UTF-8 on one end of the
conversion. But we aren't necessarily doing such a conversion; it
depends on the commit's on-disk encoding, and the requested output
encoding. In particular:

  - if both of those match, we do not need to call iconv at all (see the
    same_encoding() check in repo_logmsg_reencode()). With the patch
    above, the NO_ICONV case would start to die() when both are say
    iso8859-1, even though it currently works.

  - likewise, even if you have iconv support, it's possible that your
    preferred encoding is not compatible with utf8. In which case
    iconv_open() may complain, even though the actual conversion we'd
    ask it to do would succeed.

I.e., I don't think there's a way to just ask iconv "does this encoding
name by itself make any sense". You can only ask it about to/from
combos.

So I think a much better version of this is to catch the _actual_
iconv_open() call we make. And if it fails, say "woah, this combo of
encodings isn't supported". The reason I didn't do that in the earlier
patch is that all of this is obscured inside reencode_string_len(),
which does both the iconv_open() and the iconv() call. We could surface
that error information.

But I'm not sure it would make sense to die() in that case. While for
something like "git log --encoding=nonsense" every commit is going to
fail to re-encode, it's still possible that iconv_open() failures are
commit-specific. I.e., you could have some garbage commit in your
history with an unsupported encoding, and you wouldn't want to die() for
it (it's the same case you are complaining about having a warning for,
but much worse).

I suspect the best we could do along these lines is to wait until a real
iconv_open(to, from) fails, and then as a fallback try:

  iconv_open("UTF-8", from);
  iconv_open(to, "UTF-8");

to sanity-check them individually, and guess that one of them is broken
if it can't go to/from UTF-8. But even that feels like it's making
assumptions about both the system iconv, and the charsets people use.

To be clear, I'd expect that most people just use utf-8 in the first
place, and even if they don't that their system has some basic utf-8
support. But we are deep into the realm of weird corner cases here, and
the utility of this warning / error-checking doesn't seem high enough to
merit the possible regressions we'd get by trying to make too many
assumptions.

-Peff
