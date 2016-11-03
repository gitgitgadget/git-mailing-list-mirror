Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCF372021E
	for <e@80x24.org>; Thu,  3 Nov 2016 14:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754749AbcKCOxs (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 10:53:48 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36826 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756281AbcKCOxr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 10:53:47 -0400
Received: by mail-lf0-f50.google.com with SMTP id t196so40855153lff.3
        for <git@vger.kernel.org>; Thu, 03 Nov 2016 07:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=uy51hh6N6LbnF645W/mqoNu3IekjUDfPLEVHzkpsiJU=;
        b=RtTWQfnc0pYPWyhsw7dMgTzJMn5OeABeNHRcQ2mnQn9WPbjJAZN3jSonTX6pE0m00G
         zF+nBzgNO2zU5LUALbr9G7/E4B4f9tVPRkOUJwfUReIgEWkeqwb9zg7ygdfogeJy7931
         r2+yJJwVfMBkEUJwPW36yyjDQQ3VeNAawfv0RO0d/LVDw3wLpbDWc8gC5amg94SskllF
         j6/Mp+HDZFHjiA7CqaN/TZK+mu/gdIEMifQvuvrV1hHDKBVwUNtOk6q4510g4GQ+pLhY
         R2JN+VCmTzR4zdkYs8bIcqb7O7syeWlpzswAFponoc5Jnm5agRmYSJuipp47FuliNfmk
         z9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=uy51hh6N6LbnF645W/mqoNu3IekjUDfPLEVHzkpsiJU=;
        b=l4d4OZUuWw9ABAOEr1oqdS1QLkxw5RhjOrCAo8fA1CxAHSzOEbv2lM1YdVCzfq85rE
         pBh0Rk0Vm2XyLnbDXfrv68NaC8PBPIaJEjhjSKlf+GGrImQBX5/4miCVk2tpssuUyo0+
         7j2DWYll4B5ArOIYpVcgZa3+9voL/0ZOjttyuF1X+6+WLLrCB4YyBjAJguKh+HfwJgFC
         hvA9fZ0GTIuCViBwct3ExOEhgu+Gpu+7pRNZmlkQRzTB3kJD1vCLGfFDzkxdPfQ0v65q
         OrF3b7KWYLEFYOGuSa63AEGYNY5FYMYjHB6k6FaPNVxr/r6/wFIpwlqlbs62A7NS0tRe
         urbQ==
X-Gm-Message-State: ABUngvdB1jqvTbGMa4Bi+dGUe9/JHuNSMsLtYUkGxQHPYtEhxXIzV6Nd2KzGuzX9pP4Zgz4fArULuTeemGx/Qw==
X-Received: by 10.25.217.82 with SMTP id q79mr4600773lfg.13.1478184825326;
 Thu, 03 Nov 2016 07:53:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.215.102 with HTTP; Thu, 3 Nov 2016 07:53:44 -0700 (PDT)
From:   Chris Purcell <chris.purcell.39@gmail.com>
Date:   Thu, 3 Nov 2016 14:53:44 +0000
Message-ID: <CAJUoZVYF=ZCBUX6jztwhJX3BZdq4JEfrSRbi4cFPwn+7yA=VjA@mail.gmail.com>
Subject: Bug in git rev-parse @{push}?
To:     git@vger.kernel.org
Cc:     peff@peff.net
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I think I have discovered a bug in rev-parse's handling of @{push}:

$ git push
Everything up-to-date
$ git rev-parse @{push}
fatal: cannot resolve 'simple' push to a single destination

The documentation for rev-parse says that "the suffix @{push} reports
the branch 'where we would push to' if git push were run while
branchname was checked out", so I would not expect this to error
unless git push does.

The relevant parts of my configuration are:

[push]
    default = simple
[remote]
    pushdefault = origin
[branch "foo"]
    remote = origin
    merge = refs/heads/develop

The code in branch_get_push_1 (remote.c) in the PUSH_DEFAULT_SIMPLE
case is calling both branch_get_upstream and tracking_for_push_dest
and erroring if they don't return the same result, which I assume is
incorrect for a triangular workflow?

Please let me know if I've missed out important information by
mistake. I'm happy to work on a patch if given guidance, but this is
definitely outside my comfort zone for an unfamiliar codebase
otherwise! e.g. I can't find the test suite.

Cheers,
Chris
