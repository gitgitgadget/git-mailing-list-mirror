Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11D391F453
	for <e@80x24.org>; Sun, 10 Feb 2019 02:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfBJCFP (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 21:05:15 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:44822 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfBJCFP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 21:05:15 -0500
Received: by mail-qt1-f172.google.com with SMTP id n32so8400399qte.11
        for <git@vger.kernel.org>; Sat, 09 Feb 2019 18:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4fuMAf+4YwPIpXQ5Fb6ldLbgQtrQeO/N6j4Cyl9gsJg=;
        b=gkMAtaX8D0aE/vFyEK0eC6oCkDDOgq0STcsGJjuiTEsRL9yPB6eid5GqYPNJnVLzR2
         rzs4YNmjHfo/n2qcJKlgSGHFoLi31HTjGpuyeZIu4uW1tTKOkEXjj6gblm99KXk/xeoo
         pkOwsW0VU/NYdxw9xHl789M7h+ZO6gMZtozwJ0jVSWUh6mwI9i8pdpRdhYFFwh31lsd1
         /xs+KGiRxTntG0s6S01oGaylzOBG4kVRLZWeqmFw2vQajTr4ki/++m2hqfHFHmBRItsF
         YWpG7ML6cTMmRcg+Y74wssMDq8YNXUKKHEvS9gsN9fG/TBYAjvh/wER3sdjUA/a2LsQf
         HqBg==
X-Gm-Message-State: AHQUAuZ5/4n3IXCnH9Ykzi1xzELgvkRS5lKwz09pdRAz7uLcFfJ9U3tB
        KJNl3CJPKbg2mUngmvqqzO2CgcSKolUlbHINI0s=
X-Google-Smtp-Source: AHgI3IY5D7xt3C3GVx7GsShlN4yTyIK8tOV7PeJk/c5i4l6ps1boyuyChY9ctmBO1EP4CgrcaczTvF8EVZpbDHnPO3A=
X-Received: by 2002:ac8:101a:: with SMTP id z26mr22528046qti.184.1549764314532;
 Sat, 09 Feb 2019 18:05:14 -0800 (PST)
MIME-Version: 1.0
References: <20190209185930.5256-1-randall.s.becker@rogers.com> <20190209185930.5256-2-randall.s.becker@rogers.com>
In-Reply-To: <20190209185930.5256-2-randall.s.becker@rogers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 9 Feb 2019 21:05:04 -0500
Message-ID: <CAPig+cRARdkKN-wR4EzVSzxuK51VOPf-kFFG57kkEsnFBfe4TA@mail.gmail.com>
Subject: Re: [Patch v1 1/3] test-lib-functions.sh: add generate_zero_bytes function
To:     randall.s.becker@rogers.com
Cc:     Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 9, 2019 at 1:59 PM <randall.s.becker@rogers.com> wrote:
> t5318 and t5562 used /dev/zero, which is not portable. This function
> provides both a fixed block of NUL bytes and an infinite stream of NULs.
>
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> @@ -116,6 +116,19 @@ remove_cr () {
> +# Generate an output of $1 bytes of all zeroes (NULs, not ASCII zeroes).
> +# If $1 is 'infinity', output forever or until the receiving pipe stops reading,
> +# whichever comes first.

This is a somewhat unusual API. A (perhaps) more intuitive behavior
would be for it to emit an infinite stream of NULs when given no
argument, and a limited number of NULs when given an argument.
Redefining the behavior like that also fixes the "problem" with the
current implementation erroring-out if no argument is provided.

> +generate_zero_bytes () {
> +       perl -e 'if ($ARGV[0] == "infinity") {

s/perl/"$PERL_PATH"/

> +               while (-1) {
> +                       print "\0"
> +               }

Or, more compactly:

    print "\0" while 1;

> +       } else {
> +               print "\0" x $ARGV[0]
> +       }' "$@"
> +}
