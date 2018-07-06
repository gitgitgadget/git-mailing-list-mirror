Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 703E81F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 06:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753688AbeGFGKb (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 02:10:31 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:37656 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753165AbeGFGI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 02:08:29 -0400
Received: by mail-yb0-f196.google.com with SMTP id r3-v6so4147137ybo.4
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 23:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ip6o/N+hRobsGMlmbUxlVxgiJt/OUz0ws1QNCt4QLR4=;
        b=HABmdgTLqNMVfjDKkJD2ItOrzmfmaeqA0D4pXjgH2AqI3wGBr57NTRy1IFTD5DwrlE
         9m4rk6R+Z0u3JPhRxYgFGApsuKxLf8kQznEKxtF7csDEgEsCUdrjNdlHwSF2ubNjAEnc
         Yytf4uvOUEQ2D/kQDL6WH+8xOpTsVPQmL2xJmnpYxZVfHtgcBTxbY4wnV5HDN6hWfxHU
         7fFKEok/YuIw9gRUfMGzJuWkA0ezPSZoC4IAFxD5g8Lwd4sBwAlKSz9sHFoBUGE1QuRR
         EOgB3DE7bdQCX21ITyVbTiJFJZo77VhpwnYpEcApXmx2LUBmlLREUVSox5vMZcACQvuj
         B4RQ==
X-Gm-Message-State: APt69E0CB6fZ66FwUmxHzO3BCXw/3kVIwEjdBoVeLtqjFv9Ps6qkKejr
        b9E1SkfezOrQ6Pd+7Lpt+vK/u7YZMXHALfiyuf8=
X-Google-Smtp-Source: AAOMgpfwKdw6nTKaSfMxTaU4Y6pSDvzXHeTDKS93Ma23JmNC4qXns1ZbE83ZJMFimsqWRqOpp+y+jA4tTVYjFBL/F+I=
X-Received: by 2002:a25:d38f:: with SMTP id e137-v6mr4496320ybf.287.1530857308422;
 Thu, 05 Jul 2018 23:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180706022357.739657-1-sandals@crustytoothpaste.net> <20180706022357.739657-3-sandals@crustytoothpaste.net>
In-Reply-To: <20180706022357.739657-3-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 6 Jul 2018 02:08:17 -0400
Message-ID: <CAPig+cTNGNCUxoBdunAvjAKy5w_oYaLJ7HiAp1vYCtPmDEOUww@mail.gmail.com>
Subject: Re: [PATCH 2/3] send-email: accept long lines with suitable transfer encoding
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>, sir@cmpwn.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 5, 2018 at 10:24 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> With --validate (which is the default), we warn about lines exceeding
> 998 characters due to the limits specified in RFC 5321.  However, if
> we're using a suitable transfer encoding (quoted-printable or base64),
> we're guaranteed not to have lines exceeding 76 characters, so there's
> no need to fail in this case.  The auto transfer encoding handles this
> specific case, so accept it as well.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> @@ -401,8 +401,9 @@ have been specified, in which case default to 'compose'.
> -               *       Warn of patches that contain lines longer than 998 characters; this
> -                       is due to SMTP limits as described by http://www.ietf.org/rfc/rfc2821.txt.
> +               *       Warn of patches that contain lines longer than 998 characters unless
> +                       a suitable transfer encoding is used; this is due to SMTP limits as
> +                       described by http://www.ietf.org/rfc/rfc2821.txt.

A reader might like to know what "a suitable transfer encoding" is.
Perhaps add a "such as 'auto', 'quoted-printable' and 'base64'"
comment?

> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> @@ -480,6 +480,19 @@ test_expect_success $PREREQ 'long lines with auto encoding are quoted-printable'
> +test_expect_success $PREREQ '--validate passes with certain encodings' '
> +       for enc in auto quoted-printable base64
> +       do
> +               git send-email \
> +                       --from="Example <nobody@example.com>" \
> +                       --to=nobody@example.com \
> +                       --smtp-server="$(pwd)/fake.sendmail" \
> +                       --transfer-encoding=$enc \
> +                       --validate \
> +                       $patches longline.patch
> +       done
> +'

If you turn this inside out, it will be easier to figure out which
encoding fails (if one ever does). That is:

    for enc in auto quoted-printable base64
    do
        test_expect_success $PREREQ "--validate passes with encoding $enc" '
            git send-email ...
        '
    done
