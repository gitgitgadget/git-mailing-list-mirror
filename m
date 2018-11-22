Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B5F61F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 16:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437251AbeKWClz (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 21:41:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:48596 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2391701AbeKWClz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 21:41:55 -0500
Received: (qmail 22648 invoked by uid 109); 22 Nov 2018 16:01:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Nov 2018 16:01:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23214 invoked by uid 111); 22 Nov 2018 16:01:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Nov 2018 11:01:20 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2018 11:01:55 -0500
Date:   Thu, 22 Nov 2018 11:01:55 -0500
From:   Jeff King <peff@peff.net>
To:     Greg Hurrell <greg@hurrell.net>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Ann T Ropea <bedhanger@gmx.de>, git@vger.kernel.org
Subject: Re: Document change in format of raw diff output format
Message-ID: <20181122160154.GA28192@sigill.intra.peff.net>
References: <20181122105836.GA36193@retiro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181122105836.GA36193@retiro.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 22, 2018 at 11:58:36AM +0100, Greg Hurrell wrote:

> I was troubleshooting some breakage in some code that consumes the
> output of `git log --raw` and looking on two machines with different
> versions of Git just now I discovered the output format has changed
> somewhere between v2.14.5:
> 
> :000000 100644 000000000... 9773b7718... A      content/snippets/1157.md
> 
> and v2.19.0:
> 
> :000000 100644 000000000 9773b7718 A    content/snippets/1157.md
> 
> A quick search turns up some patches related to the
> GIT_PRINT_SHA1_ELLIPSIS env variable, which can be used to force the
> old output format, and which landed in v2.16.0, I think.

Yes. The actual commit that flipped the default is 7cb6ac1e4b (diff:
diff_aligned_abbrev: remove ellipsis after abbreviated SHA-1 value,
2017-12-03). There's more discussion of the possibility of breakage in
this subthread:

  https://public-inbox.org/git/83D263E58ABD46188756D41FE311E469@PhilipOakley/

> Does it sound right that we should update the documentation in
> diff-format.txt to show what the new output format is? The examples
> all show the old output format, which isn't produced by default any
> more.

Yes, we should definitely update the documentation to show the modern
format. I think that was just an oversight in the original series.

> diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
> index 706916c94c..33776459d0 100644
> --- a/Documentation/diff-format.txt
> +++ b/Documentation/diff-format.txt
> @@ -26,12 +26,12 @@ line per changed file.
>  An output line is formatted this way:
> 
>  ------------------------------------------------
> -in-place edit  :100644 100644 bcd1234... 0123456... M file0
> -copy-edit      :100644 100644 abcd123... 1234567... C68 file1 file2
> -rename-edit    :100644 100644 abcd123... 1234567... R86 file1 file3
> -create         :000000 100644 0000000... 1234567... A file4
> -delete         :100644 000000 1234567... 0000000... D file5
> -unmerged       :000000 000000 0000000... 0000000... U file6
> +in-place edit  :100644 100644 bcd123456 012345678 M file0
> +copy-edit      :100644 100644 abcd12345 123456789 C68 file1 file2
> +rename-edit    :100644 100644 abcd12345 123456789 R86 file1 file3
> +create         :000000 100644 000000000 123456789 A file4
> +delete         :100644 000000 123456789 000000000 D file5
> +unmerged       :000000 000000 000000000 000000000 U file6
>  ------------------------------------------------

Yeah, this looks like an improvement.

I think in general that we'd continue to show 7 characters now, just
without the extra dots (though it's auto-scaled based on the number of
objects in the repo these days, so it's not even really a constant).

>  That is, from the left to the right:
> @@ -75,7 +75,7 @@ and it is out of sync with the index.
>  Example:
> 
>  ------------------------------------------------
> -:100644 100644 5be4a4...... 000000...... M file.c
> +:100644 100644 5be4a4abc 000000000 M file.c
>  ------------------------------------------------

I'm not even sure what this original was trying to show. I don't think
we ever produced that any dots. :)

Thanks for noticing.

-Peff

PS As you noticed, "git log" we don't promise that git-log output will
   never change between versions. For machine-consumption you probably
   want to use plumbing like "git rev-list | git diff-tree --stdin",
   which produces unabbreviated hashes.
