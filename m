Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC61C61DA4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 17:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjBPR22 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 12:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjBPR21 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 12:28:27 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D91E4C3F8
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 09:28:26 -0800 (PST)
Received: (qmail 30171 invoked by uid 109); 16 Feb 2023 17:28:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Feb 2023 17:28:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5474 invoked by uid 111); 16 Feb 2023 17:28:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Feb 2023 12:28:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Feb 2023 12:28:25 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] shorten_unambiguous_ref(): avoid sscanf()
Message-ID: <Y+5nuTbsbuqll5YP@coredump.intra.peff.net>
References: <Y+z3MtgayoXsxaHA@coredump.intra.peff.net>
 <Y+z3RfhAxW/2iNYP@coredump.intra.peff.net>
 <20230216055641.brlx3os2ucj3ywer@tb-raspi4>
 <CAPig+cR3fNVnLcfR0K85YgVo3go2p9cbC9ekdmm=orh0WQ+HwQ@mail.gmail.com>
 <xmqqlekxr0fo.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqlekxr0fo.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2023 at 09:21:15AM -0800, Junio C Hamano wrote:

> How about a bit more detail on sscanf(), like this?
> 
>  t/t1401-symbolic-ref.sh | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git c/t/t1401-symbolic-ref.sh w/t/t1401-symbolic-ref.sh
> index be23be30c7..dafcb4d61b 100755
> --- c/t/t1401-symbolic-ref.sh
> +++ w/t/t1401-symbolic-ref.sh
> @@ -192,11 +192,13 @@ test_expect_success 'symbolic-ref pointing at another' '
>  test_expect_success 'symbolic-ref --short handles complex utf8 case' '
>  	name="测试-加-增加-加-增加" &&
>  	git symbolic-ref TEST_SYMREF "refs/heads/$name" &&
> -	# In the real world, we saw problems with this case only
> -	# when the locale includes UTF-8. Set it here to try to make things as
> -	# hard as possible for us to pass, but in practice we should do the
> -	# right thing regardless (and of course some platforms may not even
> -	# have this locale).
> +	# In the real world, we saw this case misbehaved on macOS only
> +	# when the locale includes UTF-8, back when "symbolic-ref --short"
> +	# used sscanf(3) as part of its implementation.  Set it here to
> +	# try to make things as hard as possible for us to pass, but in
> +	# practice we should do the right thing regardless (and of course
> +	# some platforms may not even have this locale), as we no longer
> +	# use platform sscanf(3) there.
>  	LC_ALL=en_US.UTF-8 git symbolic-ref --short TEST_SYMREF >actual &&
>  	echo "$name" >expect &&
>  	test_cmp expect actual

I am OK with that squashed in. I hadn't bothered to mention macOS, etc,
because that was covered in the commit message. My point in this comment
was mostly to say "don't just remove this LC_ALL! It is doing
something".

But your text makes the situation even more clear.

I do kind of wonder if this test is even doing much. It is nice to
verify the fix (and hopefully somebody with macOS did indeed verify that
it fails before the fix!). But it does not seem all that likely that we
are going to regress in this area. I think it's reasonable to include
it, but if the LC_ALL bit starts creating any portability problems, my
first instinct would be to drop the test.

-Peff
