Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB4DC433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 14:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58A77611C1
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 14:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbhJDONG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 10:13:06 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:43931 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhJDONF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 10:13:05 -0400
Received: by mail-vs1-f53.google.com with SMTP id n17so19695181vsr.10
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 07:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3GB8++UopuTzoNTwkHhvFFQ3fLVEloKoLcIh6e2gXW0=;
        b=WYHcI5u2hkZpmLU2lzjpEywRgdv+rd/JMcExxBaWMFaUYAt7FaIL613+TvDEkRJy9j
         o/ZKaBT0va1RRebvvqvz5Py/LPcR0SxEB7p3DJ0YDWWDKQcIiLY5fm2cC69Mcz65WKm6
         rMkRXsihzRAzhWPPicJFNrRxSTxvGz94QaqOkGf9ls/Gr5fuXmwx7xzER0CubZiyhmQE
         H3IbQ5c3cvWJEjNhCTeShsQBhuLGJxqmgISIyKJxpc6rH5sjEcR2tZ4RlZa/yPwiixhU
         LSDbfTdGq6A6VDrDFK6vxy1Ep1U2hR5frBgcD1GKODUbpHg4kAzwhhZOcQJRTFzfnTps
         XOvg==
X-Gm-Message-State: AOAM5323ZEKirw+jmqeIj6F8LsYwl1f3PCLSyCrOq1Y2zGcM1LLp+T2x
        jGB1HtG6diZKnZPGKPDt5EtVabEJ46Kkw7y3j7T4yl1t2Hs=
X-Google-Smtp-Source: ABdhPJz3BNoSzA8t1jNfUEjeGj3Iuh/rQWhqEnCzdrPp7lDjDYrUj9RLLI00cCsOJFYwuohg4SwDXZoII2MeauhsHzY=
X-Received: by 2002:a67:f147:: with SMTP id t7mr12795563vsm.41.1633356675836;
 Mon, 04 Oct 2021 07:11:15 -0700 (PDT)
MIME-Version: 1.0
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Oct 2021 16:11:04 +0200
Message-ID: <CAMuHMdXuTqUu6-b0y6VSFbEz7HKdH6U+__n7B8JRnO_ZWNeeLQ@mail.gmail.com>
Subject: git send-email splits name with comma
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

If the name of an email address contains a comma, it will be split
incorrectly into multiple addresses.  A public example can be found
at[1].  I originally say this with git 2.25.1, as packaged by my distro,
but I could reproduce it with the latest version from git:

    $ git send-email  --to "foo bar, geert <geert@linux-m68k.org>"
/tmp/dummy.patch
    /tmp/dummy.patch
    (mbox) Adding cc: Geert Uytterhoeven <geert@linux-m68k.org> from
line 'From: Geert Uytterhoeven <geert@linux-m68k.org>'

    From: Geert Uytterhoeven <geert@linux-m68k.org>
    To: foo,
            bar,
            geert <geert@linux-m68k.org>
    Subject: [PATCH] dummy test
    Date: Mon,  4 Oct 2021 15:52:53 +0200
    Message-Id: <git-2.33.0.610.3.git.geert@linux-m68k.org
    X-Mailer: git-send-email 2.33.0.610.gcefe983a320c03d7
    MIME-Version: 1.0
    Content-Transfer-Encoding: 8bit

        The Cc list above has been expanded by additional
        addresses found in the patch commit message. By default
        send-email prompts before sending whenever this occurs.
        This behavior is controlled by the sendemail.confirm
        configuration setting.

        For additional information, run 'git send-email --help'.
        To retain the current behavior, but squelch this message,
        run 'git config --global sendemail.confirm auto'.

    Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll):
    OK. Log says:
    Sendmail: /usr/sbin/sendmail -i foo bar geert@linux-m68k.org
    From: Geert Uytterhoeven <geert@linux-m68k.org>
    To: foo,
            bar,
            geert <geert@linux-m68k.org>
    Subject: [PATCH] dummy test
    Date: Mon,  4 Oct 2021 15:52:53 +0200
    Message-Id: <git-2.33.0.610.3.git.geert@linux-m68k.org
    X-Mailer: git-send-email 2.33.0.610.gcefe983a320c03d7
    MIME-Version: 1.0
    Content-Transfer-Encoding: 8bit

    Result: OK

So "foo bar, geert <geert@linux-m68k.org>" is split in three parts,
and /usr/sbin/sendmail (exim 4.93 in my case) will have sent the email to
"foo" and "bar" (both  extended with my local non-public domain) and
"geert <geert@linux-m68k.org>".

Thanks!

[1] "Enrico Weigelt, metux IT consult <lkml@metux.net>" is split in 3 parts
    https://lore.kernel.org/linux-gpio/c987d0bf744150ca05bd952f5f9e5fb3244d27b0.1633350340.git.geert+renesas@glider.be/raw

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
