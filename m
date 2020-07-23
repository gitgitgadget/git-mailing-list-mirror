Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26954C433E1
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 04:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01A84207F5
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 04:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgGWEyh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 00:54:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45862 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgGWEyg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 00:54:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id z18so277782wrm.12
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 21:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f98F8J3sIqZ969i6zUuAXhc+g1l7Saz/GibvwN3XKxQ=;
        b=tdgP9LhvR8uJjumK1sUL8DdvrfcdK6f/w6PYz3XNTM0JvUD1bB0AXQ14g9p85/DvOi
         JFVJzCHYvJUOCIm4UX1RnWwDeAZVcQImhASq+GkpCURBbm3gBAOUKfjcew+fs11AmYjN
         TC8F3B+4Ud7K1zncIhojQIqcKPFC7YPgYv9GnZGgtJfpKsbAeuso/V2NQSBF1gjyRMDP
         Egpzwa6wunL9G9Haql3JwsQ/66c2bGjqGPaaXO3EMZ2ejIorw30Dr2jwfS5+u8nes+Pi
         bNb6w0wfv6rnZgPHTO+skzxjbgnIWgXUNAndEPluBU9QNDxDUXBJ+hpx+vGtwfR+1pAU
         6hhA==
X-Gm-Message-State: AOAM530UqXdCT0kB+Q+p9Rjmc7HJ/PsH6+yHLc9yJcXTlr+ff8zD1ksv
        BWpn9JJRCN5lEITnF14+wIMDKkZ8pMsLYef/yzU=
X-Google-Smtp-Source: ABdhPJzE/00SCWtqbNSG0LeJU9eJvYGxFXirXcoOs4Bjyiv9z2DvWNQIwXGkqP3SthYeSZ64sm5IK5PF7W5+DNpxNGA=
X-Received: by 2002:adf:b352:: with SMTP id k18mr2405574wrd.386.1595480074805;
 Wed, 22 Jul 2020 21:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net> <20200723010943.2329634-31-sandals@crustytoothpaste.net>
In-Reply-To: <20200723010943.2329634-31-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 23 Jul 2020 00:54:23 -0400
Message-ID: <CAPig+cT21mc5USWW2Xy1KY0-eRykkmJEkwuTcouBqsPAbUoRfQ@mail.gmail.com>
Subject: Re: [PATCH v3 30/39] builtin/verify-pack: implement an
 --object-format option
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 22, 2020 at 9:10 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Since we're not in a repository here, we need to provide git verify-pack
> help to set things up properly.  git index-pack already knows an
> --object-format option, so let's accept one as well and pass it down to
> our git index-pack invocation.  Since this argument is optional, let's
> dynamically determine the proper location to insert it into the array.
> Finally, let's make t5702 pass the proper argument on down to its git
> verify-pack caller.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
> @@ -7,21 +7,27 @@
> +static int verify_one_pack(const char *path, unsigned int flags, const char *hash_algo)
>  {
> -       const char *argv[] = {"index-pack", NULL, NULL, NULL };
> +       const char *argv[] = {"index-pack", NULL, NULL, NULL, NULL };
> +       int argno = 1;
>
> +       if (hash_algo) {
> +               strbuf_addf(&hash_arg, "--object-format=%s", hash_algo);
> +               argv[argno++] = hash_arg.buf;
> +       }

This seems like a good candidate for 'struct argv_array' (but perhaps
that's too significant a change or out of scope of this patch?).
