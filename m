Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EFAD1F453
	for <e@80x24.org>; Thu, 14 Feb 2019 20:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406849AbfBNUcr (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 15:32:47 -0500
Received: from elephants.elehost.com ([216.66.27.132]:53694 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387975AbfBNUcr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 15:32:47 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1EKWaJn032924
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 14 Feb 2019 15:32:36 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Jeff King'" <peff@peff.net>
Cc:     "'Duy Nguyen'" <pclouds@gmail.com>,
        "'Git Mailing List'" <git@vger.kernel.org>
References: <000801d4c174$05b76860$11263920$@nexbridge.com>     <CACsJy8Bn+2zY6y_QqCjbB3qWM-F=3d0H5vgWj4az=md2FZ8RhA@mail.gmail.com>    <xmqqftsughks.fsf@gitster-ct.c.googlers.com>    <20190212002705.GD13301@sigill.intra.peff.net> <xmqqef8a86sr.fsf_-_@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqef8a86sr.fsf_-_@gitster-ct.c.googlers.com>
Subject: RE: Re* [Breakage] 2.20.0-rc0 t1404: test_i18ngrep reports 1 instead of 0 on NonStop in one case
Date:   Thu, 14 Feb 2019 15:32:29 -0500
Message-ID: <005001d4c4a4$6af097a0$40d1c6e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQNDD1TD3hXIgmvW3x+/7VSnrDKF3gHnalkaAbpdw+EA7tFcEQJL2QeCosxDkaA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 14, 2019 15:16, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Mon, Feb 11, 2019 at 01:07:15PM -0800, Junio C Hamano wrote:
> >
> >> >> test_i18ngrep "Unable to create $Q.*packed-refs.lock$Q: File
> >> >> exists" err
> >> >
> >> > The message does not match, does it? Here we grep for "File exists"
> >> > but the message you showed says "File already exists".
> >>
> >> Hmph, this is from strerror(), right?
> >>
> >> The question is if we should be using grep to match on strerror()
> >> result in the C locale.
> >
> > Yeah, I agree that's questionable. And I'm mildly surprised it hasn't
> > been a problem before now.
> >
> >> Do we really care that the reason of the failure is due to EEXIST for
> >> this particular test?
> >
> > Hmm. We care to _some_ degree, since that's the condition we set up
> > for making sure that update-ref cannot take the lock. But it would
> > probably be fine to just confirm that we failed to take the lock. And
> > there, checking for just "Unable to create $Q.*packed-refs.lock" would
> > be sufficient.
> 
> Yup.
> 
> As this came from 6a2a7736 ("t1404: demonstrate two problems with
> reference transactions", 2017-09-08), that is as old as Git 2.15, I'd
throw it
> into "not so urgent" pile.
> 
> -- >8 --
> Subject: [PATCH] t1404: do not rely on the exact phrasing of strerror()
> 
> Not even in C locale, it is wrong to expect that the exact phrasing "File
> exists" is used to show EEXIST.
> 
> Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
> Helped-by: Duy Nguyen <pclouds@gmail.com>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>     I've grepped in t/ directory for the exact phrases of all errno on a
>     recent Debian box, and this was the only hit it found.  There
>     are two other hits but both in the comments.
> 
>  t/t1404-update-ref-errors.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index
> 51a4f4c0ac..f95a64c911 100755
> --- a/t/t1404-update-ref-errors.sh
> +++ b/t/t1404-update-ref-errors.sh
> @@ -614,7 +614,7 @@ test_expect_success 'delete fails cleanly if packed-
> refs file is locked' '
>  	test_when_finished "rm -f .git/packed-refs.lock" &&
>  	test_must_fail git update-ref -d $prefix/foo >out 2>err &&
>  	git for-each-ref $prefix >actual &&
> -	test_i18ngrep "Unable to create $Q.*packed-refs.lock$Q: File exists"
> err &&
> +	test_i18ngrep "Unable to create $Q.*packed-refs.lock$Q:" err &&
>  	test_cmp unchanged actual
>  '

This passes on NonStop. Thanks.

Randall

