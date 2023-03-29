Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51195C6FD18
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 22:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjC2WzT convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 29 Mar 2023 18:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjC2WzS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 18:55:18 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2152D5E
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 15:55:17 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id t13so12772328qvn.2
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 15:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680130516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9B9VWFNq0oeH3rRnocpIZ7zKdtYYWZKVn0FhkFlBysY=;
        b=iCwFPQTVdJsMORIHo/N22fj4m+aScP0UyOlwka0+G0p9fXQqK+GGs9uftforbHJXau
         dp00ezQdzvtjaJ2OppfUrBMk8XvUSZo1yUy0X16wTE0gRHxu2LUeNur3QIUlNSahUmis
         L9EJ4jnnxSHpNM17Q5LpWsFpMrmW7Ltow4fQaVyPXXlM5sj9jGh9lOQfPfH/3RwDLFHp
         Ls96LOp7dPyGRtV1T9QAtR6uwymXjZo3QhG16P24iEi6dF1OFbp8g0BP7mjWYhXklwcZ
         3hxdSdmbVON8Lp5+EJV5UPTi7w1BrTEjoD5+lAO6n4MScbhMTDUINVNri8EjQMFXTgUW
         xlTQ==
X-Gm-Message-State: AAQBX9cmda/VvZbTU1GkIeRVRCOokU+h0TeRnxT5Jvg+ye1OOD/j7JVR
        isGBAL8n6QjpZX1r2UOUiRnHS8NCTg3aE424bFOW0vECFhQ=
X-Google-Smtp-Source: AKy350akzBWmRv6zKfKtQ6obmSAyEeEb8JSIN1Q4ELcCIfA1ow6sFSmqxQZL0zcffwftbF3yZ3NQvheB2xvv0ENJGEo=
X-Received: by 2002:ad4:559d:0:b0:56f:a4:d7f5 with SMTP id f29-20020ad4559d000000b0056f00a4d7f5mr3759731qvx.5.1680130516027;
 Wed, 29 Mar 2023 15:55:16 -0700 (PDT)
MIME-Version: 1.0
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 29 Mar 2023 18:55:05 -0400
Message-ID: <CAPig+cSNmws2b7f7aRA2C56kvQYG3w_g+KhYdqhtmf+XhtAMhQ@mail.gmail.com>
Subject: regex compilation error with --color-words
To:     Git List <git@vger.kernel.org>, Diomidis Spinellis <dds@aueb.gr>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        demerphq <demerphq@gmail.com>,
        Mario Grgic <mario_grgic@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm encountering a failure on macOS High Sierra 10.13.6 when using
--color-words:

    % git show --color-words HEAD
    fatal: invalid regular expression:
[[:alpha:]_'][[:alnum:]_']*|0[xb]?[0-9a-fA-F_]*|[0-9a-fA-F_]+(\.[0-9a-fA-F_]+)?([eE][-+]?[0-9_]+)?|=>|-[rwxoRWXOezsfdlpSugkbctTBMAC>]|~~|::|&&=|\|\|=|//=|\*\*=|&&|\|\||//|\+\+|--|\*\*|\.\.\.?|[-+*/%.^&<>=!|]=|=~|!~|<<|<>|<=>|>>|[^[:space:]]|[<C0>-<FF>][<80>-<BF>]+

This crash happens when viewing the commit I sent to Peff today[1],
though it doesn't happen with all commits. The problem bisects to:

    Author: Diomidis Spinellis <dds@aueb.gr>
    Date:   Fri Aug 26 11:58:15 2022 +0300

    grep: fix multibyte regex handling under macOS

    The commit 29de20504e (Makefile: fix default regex settings on
    Darwin, 2013-05-11) fixed t0070-fundamental.sh under Darwin (macOS) by
    adopting Git's regex library.  However, this library is compiled with
    NO_MBSUPPORT, which causes git-grep to work incorrectly on multibyte
    (e.g. UTF-8) files.  Current macOS versions pass t0070-fundamental.sh
    with the native macOS regex library, which also supports multibyte
    characters.

    Adjust the Makefile to use the native regex library, and call
    setlocale(3) to set CTYPE according to the user's preference.
    The setlocale call is required on all platforms, but in platforms
    supporting gettext(3), setlocale was called as a side-effect of
    initializing gettext.  Therefore, move the CTYPE setlocale call from
    gettext.c to common-main.c and the corresponding locale.h include
    into git-compat-util.h.

    Thanks to the global initialization of CTYPE setlocale, the test-tool
    regex command now works correctly with supported multibyte regexes, and
    is used to set the MB_REGEX test prerequisite by assessing a platform's
    support for them.

    Signed-off-by: Diomidis Spinellis <dds@aueb.gr>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

I see that this same commit is also the subject of another bug report
currently being discussed[2], so I've Cc:'d the participants of that
thread, as well.

Any pointers aimed at getting this resolved would be appreciated.

[1]: https://lore.kernel.org/git/CAPig+cQiOGrDSUc34jHEBp87Rx-dnXNcPcF76bu0SJoOzD+1hw@mail.gmail.com/
[2]: https://lore.kernel.org/git/MW4PR20MB5517583CBEEF34B1E87CCF1290859@MW4PR20MB5517.namprd20.prod.outlook.com/
