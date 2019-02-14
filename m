Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9119E1F453
	for <e@80x24.org>; Thu, 14 Feb 2019 22:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438135AbfBNWRl convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 14 Feb 2019 17:17:41 -0500
Received: from elephants.elehost.com ([216.66.27.132]:54749 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfBNWRl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 17:17:41 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1EMHXSG038027
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 14 Feb 2019 17:17:34 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Johannes Schindelin via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Max Kirillov'" <max@max630.net>
References: <pull.126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.126.git.gitgitgadget@gmail.com>
Subject: RE: [PATCH 0/1] Fix hang in t5562, introduced in v2.21.0-rc1
Date:   Thu, 14 Feb 2019 17:17:26 -0500
Message-ID: <005401d4c4b3$147aa8c0$3d6ffa40$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJRGauSxHI8crErjTmvoq3vRhvAD6TnMGtw
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 14, 2019 16:33, Johannes Schindelin wrote:
> To: git@vger.kernel.org
> Cc: Randall Becker <rsbecker@nexbridge.com>; Junio C Hamano
> <gitster@pobox.com>
> Subject: [PATCH 0/1] Fix hang in t5562, introduced in v2.21.0-rc1
> 
> The last-minute patch to replace /dev/zero with a Perl script snippet broke
> the Linux part of the CI builds on Azure Pipelines: it timed out. The culprit is
> the rb/no-dev-zero-in-test branch (see the build for this branch here
> [https://dev.azure.com/gitgitgadget/git/_build/results?buildId=1727]).
> 
> All of master, next, jch and pu are broken that way. You might see it in the
> commit status of the active branches
> [https://github.com/gitgitgadget/git/branches/active].
> 
> Turns out that it is that particular Perl script snippet which for some reason
> hangs the build. If you kill it, t5562.15 succeeds, if you don't kill it, it will hang
> indefinitely (or until killed).
> 
> Sadly, despite my earnest attempts, I could not figure out why it hangs in
> those Linux agents (I could not reproduce that hang locally), or for that
> matter, why it does not hang in the Windows and macOS agents.
> 
> Let's avoid that hang. This patch fixes things on Azure Pipelines, and my hope
> is that it also fixes the hang on NonStop.
> 
> Johannes Schindelin (1):
>   tests: teach the test-tool to generate NUL bytes and use it
> 
>  Makefile                               |  1 +
>  t/helper/test-genzeros.c               | 22 ++++++++++++++++++++++
>  t/helper/test-tool.c                   |  1 +
>  t/helper/test-tool.h                   |  1 +
>  t/t5562-http-backend-content-length.sh |  2 +-
>  t/test-lib-functions.sh                |  8 +-------
>  6 files changed, 27 insertions(+), 8 deletions(-)  create mode 100644
> t/helper/test-genzeros.c
> 
> 
> base-commit: 8989e1950a845ceeb186d490321a4f917ca4de47
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-
> 126%2Fdscho%2Ffix-t5562-hang-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-126/dscho/fix-
> t5562-hang-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/126

Unfortunately, subtest 13 still hangs on NonStop, even with this patch, so our Pipeline still hangs. I'm glad it's better on Azure, but I don't think this actually addresses the root cause of the hang. This is now the fourth attempt at fixing this. Is it possible this is not the test that is failing, but actually the git-http-backend? The code is not in a loop, if that helps. It is not consuming any significant cycles. I don't know that part of the code at all, sadly. The code is here:

* in the operating system from here up *
  cleanup_children + 0x5D0 (UCr)
  cleanup_children_on_exit + 0x70 (UCr)
  git_atexit_dispatch + 0x200 (UCr)
  __process_atexit_functions + 0xA0 (DLL zcredll)
  CRE_TERMINATOR_ + 0xB50 (DLL zcredll)
  exit + 0x2A0 (DLL zcrtldll)
  die_webcgi + 0x240 (UCr)
  die_errno + 0x360 (UCr)
  write_or_die + 0x1C0 (UCr)
  end_headers + 0x1A0 (UCr)
  die_webcgi + 0x220 (UCr)
  die + 0x320 (UCr)
  inflate_request + 0x520 (UCr)
  run_service + 0xC20 (UCr)
  service_rpc + 0x530 (UCr)
  cmd_main + 0xD00 (UCr)
  main + 0x190 (UCr)

Best guess is that a signal (SIGCHLD?) is possibly getting eaten or neglected somewhere between the test, perl, and git-http-backend.

Stuck,
Randall

