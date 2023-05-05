Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E189C77B75
	for <git@archiver.kernel.org>; Fri,  5 May 2023 17:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjEERle convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 5 May 2023 13:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjEERla (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 13:41:30 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E2D1A481
        for <git@vger.kernel.org>; Fri,  5 May 2023 10:41:28 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-74e462a540aso103510785a.1
        for <git@vger.kernel.org>; Fri, 05 May 2023 10:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683308488; x=1685900488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhCF21d9nMyVg4inFkojr99oHy00U1EGQAjwuiPaNRA=;
        b=bGi9jK+RpizXbxoEqQCBCzIXF3PdEOkO8nIGXQxwGC4VE4r3Rb7MzmN7kCITjuduPB
         DMtyEqzVOWwmFZjJyr3xcBm5tq6puOH70c8GOscD5OUkInGeMf9lHiaarqsoqeVHbKjM
         DX0//prNaVmKJm5n9YxnNGc4EmmuOd42wUnFFxm2688tCmUwL70xWDbYBUQVXxGfVhg6
         Y6s/+8fn3M+I6hdEwpZPXBF8c35ovFIizpInB6ZorCqUFWh/GgUSPwQACy2BGfiORYOI
         zVbPaXsedTn2KI5TQfAfRQ5Td1+UUnyKqRJE8J0hK9SBOt6KtVhrRM/9zfiPZZ5IOmXJ
         j3OQ==
X-Gm-Message-State: AC+VfDwQsggw2Z23KIbx5Y/HgppUXc+Qzrd2FgOlumPZHxHPfdJbCyX0
        s2UNpPa374pXRVewV4XHiIu7W7xR43WEd+LDA6p92etLtQ8=
X-Google-Smtp-Source: ACHHUZ7cj9QaPFNNn9E9Db79I2HjH9Mwiyz2iJEHQbI2RBRuC/pHZCT26HWhjJf1TbJTknxdbYy43tjlwe6kCHV+6Qw=
X-Received: by 2002:a05:6214:234a:b0:61b:7aa5:d063 with SMTP id
 hu10-20020a056214234a00b0061b7aa5d063mr3669903qvb.41.1683308487704; Fri, 05
 May 2023 10:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqfs8bith1.fsf_-_@gitster.g> <20230505165952.335256-1-gitster@pobox.com>
In-Reply-To: <20230505165952.335256-1-gitster@pobox.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 5 May 2023 13:41:16 -0400
Message-ID: <CAPig+cT=3dmtEEApiPUvB9+5ZHx+uwc1NXhYsf4peYiSwPYPsQ@mail.gmail.com>
Subject: Re: [PATCH v2] diff: fix interaction between the "-s" option and
 other options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 5, 2023 at 1:02 PM Junio C Hamano <gitster@pobox.com> wrote:
> Sergey Organov noticed and reported "--patch --no-patch --raw"
> behaves differently from just "--raw".  It turns out that there are
> a few interesting bugs in the implementation and documentation.
>
>  * First, the documentation for "--no-patch" was unclear that it
>    could be read to mean "--no-patch" countermands an earlier
>    "--patch" but not other things.  The intention of "--no-patch"
>    ever since it was introduced at d09cd15d (diff: allow --no-patch
>    as synonym for -s, 2013-07-16) was to serve as a synonym for
>    "-s", so "--raw --patch --no-patch" should have produced no
>    output, but it can be (mis)read to allow showing only "--raw"
>    output.
>
>  * Then the interaction between "-s" and other format options were
>    poorly implemented.  Modern versions of Git uses one bit each to
>    represent formatting options like "--patch", "--stat" in a single
>    output_format word, but for historical reasons, "-s" also is
>    represented as another bit in the same word.  This allows two
>    interesting bugs to happen, and we have both X-<.
>
>    (1) After setting a format bit, then setting NO_OUTPUT with "-s",
>        the code to process another "--<format>" option drops the
>        NO_OUTPUT bit to allow output to be shown again.  However,
>        the code to handle "-s" only set NO_OUTPUT without unsetting
>        format bits set earlier, so the earlier format bit got
>        revealed upon seeing the second "--<format>" option.  This is

Glad to see "THis" from v1 fixed.

>        the problem Sergey observed.
>
>    (2) After setting NO_OUTPUT with "-s", code to process
>        "--<format>" option can forget to unset NO_OUTPUT, leaving
>        the command still silent.
>
> It is tempting to change the meaning of "--no-patch" to mean
> "disable only the patch format output" and reimplement "-s" as "not
> showing anything", but it would be an end-user visible change in
> behavior.  Let's fix the interactions of these bits to first make
> "-s" work as intended.
>
> The fix is conceptually very simple.
>
>  * Whenever we set DIFF_FORMAT_FOO because we saw the "--foo"
>    option (e.g. DIFF_FORMAT_RAW is set when the "--raw" option is
>    given), we make sure we drop DIFF_FORMAT_NO_OUTPUT.  We forgot to
>    do so in some of the options and caused (2) above.
>
>  * When processing "-s" option, we should not just set
>    DIFF_FORMAT_NO_OUTPUT bit, but clear other DIFF_FORMAT_* bits.
>    We didn't do so and retained format bits set by options
>    previously seen, causing (1) above.

The above description is very clear and well stated, even to someone
like me who didn't follow the discussion which culminated in this
patch.

> It is even more tempting to lose NO_OUTPUT bit and instead take
> output_format word being 0 as its replacement, but that would break
> the mechanism "git show" uses to default to "--patch" output, where
> the distinction between telling the command to be silent with "-s"
> and having no output format specified on the command line matters,
> and an explicit output format given on the command line should not
> be "combined" with the default "--patch" format.
>
> So, while we cannot lose the NO_OUTPUT bit, as a follow-up work, we
> may want to replace it with OPTION_GIVEN bit, and
>
>  * make "--patch", "--raw", etc. set DIFF_FORMAT_$format bit and
>    DIFF_FORMAT_OPTION_GIVEN bit on for each format.  "--no-raw",
>    etc. will set off DIFF_FORMAT_$format bit but still record the
>    fact that we saw an option from the command line by setting
>    DIFF_FORMAT_OPTION_GIVEN bit.
>
>  * make "-s" (and its synonym "--no-patch") clear all other bits
>    and set only the DIFF_FORMAT_OPTION_GIVEN bit on.
>
> which I suspect would make the code much cleaner without breaking
> any end-user expectations.
>
> Once that is in place, transitioning "--no-patch" to mean the
> counterpart of "--patch", just like "--no-raw" only defeats an
> earlier "--raw", would be quite simple at the code level.  The
> social cost of migrating the end-user expectations might be too
> great for it to be worth, but at least the "GIVEN" bit clean-up

s/worth/worthwhile/

> alone may be worth it.

And this final part addresses the big question which v1 left dangling
(specifically, "why the proposed patch doesn't eliminate NO_OUTPUT
altogether). Good.

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
