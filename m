Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DB401F404
	for <e@80x24.org>; Tue, 18 Sep 2018 01:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbeIRH1Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 03:27:16 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:35696 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbeIRH1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 03:27:16 -0400
Received: by mail-qt0-f173.google.com with SMTP id j7-v6so330898qtp.2
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 18:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jBmAse9exVpwuIXBO14ylUb4dLLPefAxtM0XyjH3ais=;
        b=PmT2ejVoEbGrV2APsXhuOajFIBZ55ZBgRZt/DseH2uXiC0d5wA85uWbC895ecNWCzB
         lN2FUkPCPNAs/M3SqBqA3mM7RjvFLX5CjUd0xOhvaMJwV1h3cngI/DHTxKRbussjAJ5T
         HFcXgY+ugIsHzLyRR0iFNaOBINkzgWTRj/0/N9m8HFvWiHWrNMhfl/+XrdqAjyyc1oIm
         QTRdhPVflo66TAJ2CSHzAXkglrzVBOHjr+YPd46T/ZfOcjPshOViCm8QT3bLdlxB2QGU
         bMh7urApQv1GEwzHeSK2PGxP3TAa6d6OH2GNwFJkEPa2XJkhpTUBt6DoKQQH9D7o2g60
         h8og==
X-Gm-Message-State: APzg51CheqEsRUQTCQ8tHiKzNd5bB+I5UvDLSkQW4VhX0wXa67jvDEdG
        fGxFyvTeP4gWUy+S+1xBn3m65l+VoZfQXXNIam4=
X-Google-Smtp-Source: ANB0VdYpdQ2tmg8EPPOl2iE9s0Wc9fWuKkoqP2KTlhZQgtMXS3lCe+Zel0xsq8LuwJdiGHQc9QKhHbngMD3nPRUIgTk=
X-Received: by 2002:a0c:c503:: with SMTP id x3-v6mr19574218qvi.82.1537235827470;
 Mon, 17 Sep 2018 18:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1537223021.git.matvore@google.com>
 <e01b719de662f0b150f78b5a6ab6ccfce9c675fa.1537223021.git.matvore@google.com>
In-Reply-To: <e01b719de662f0b150f78b5a6ab6ccfce9c675fa.1537223021.git.matvore@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 17 Sep 2018 21:56:55 -0400
Message-ID: <CAPig+cT5BLu2onbuTBbZ_mMzNMkEuPk5-g2d5YKw4V6Z42Y3aQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] t9109-git-svn-props.sh: split up several pipes
To:     matvore@google.com
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrn@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 6:25 PM Matthew DeVore <matvore@google.com> wrote:
> t9109-git-svn-props.sh: split up several pipes

Similar to my comment about 5/6, this title talks about the mechanical
changes made by the patch but not the intent. Perhaps reword it like
this:

    t9109: avoid swallowing Git exit code upstream of a pipe

> A test uses several separate pipe sequences in a row which are awkward
> to split up. Wrap the split-up pipe in a function so the awkwardness is
> not repeated.
>
> Signed-off-by: Matthew DeVore <matvore@google.com>
> ---
> diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
> @@ -190,16 +190,21 @@ EOF
> +# Note we avoid using pipes in order to ensure that git exits with 0.

This new comment doesn't really add value for someone reading the
patch without knowing the history leading up to the point the comment
was added. It should probably be dropped. (The actual text of the
comment is rather confusing anyhow since avoiding pipes has nothing to
do with ensuring that git exits with 0, thus another reason why this
comment ought to be dropped.)

>  test_expect_success 'test propget' "
> -       git svn propget svn:ignore . | cmp - prop.expect &&
> +       test_propget () {
> +               git svn propget $1 $2 >observed

The &&-chain is broken here, which means you're losing the exit status
from the Git command anyhow (despite the point of the patch being to
avoid losing it).

Also, for consistency, how about calling this "actual" rather than "observed"?

> +               cmp - $3

This is just wrong. The "-" argument to 'cmp' says to read from
standard input, but there is nothing being passed to 'cmp' on standard
input anymore now that you're removed the pipe. I'm guessing that you
really meant to use "observed" here (and reverse the order of
arguments to be consistent with the expect-then-actual idiom).
Finally, since these (apparently) might be binary, you can use
test_cmp_bin() instead.

> +       } &&
> +       test_propget svn:ignore . prop.expect &&
>         cd deeply &&
> -       git svn propget svn:ignore . | cmp - ../prop.expect &&
> -       git svn propget svn:entry:committed-rev nested/directory/.keep \
> -         | cmp - ../prop2.expect &&
> -       git svn propget svn:ignore .. | cmp - ../prop.expect &&
> -       git svn propget svn:ignore nested/ | cmp - ../prop.expect &&
> -       git svn propget svn:ignore ./nested | cmp - ../prop.expect &&
> -       git svn propget svn:ignore .././deeply/nested | cmp - ../prop.expect
> +       test_propget svn:ignore . ../prop.expect &&
> +       test_propget svn:entry:committed-rev nested/directory/.keep \
> +               ../prop2.expect &&
> +       test_propget svn:ignore .. ../prop.expect &&
> +       test_propget svn:ignore nested/ ../prop.expect &&
> +       test_propget svn:ignore ./nested ../prop.expect &&
> +       test_propget svn:ignore .././deeply/nested ../prop.expect
>         "

After this patch, the test is even more broken than appears at first
glance since the test body is inside double-quotes. This means that
the $1, $2, $3 inside the test_propget() function are getting expanded
_before_ the function itself is ever defined, to whatever bogus values
$1, $2, $3 hold at that point. I can't see how this could ever have
worked (except only appearing to work by pure accident).
