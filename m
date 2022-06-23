Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0519BC433EF
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 16:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbiFWQ0f convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 23 Jun 2022 12:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiFWQ0c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 12:26:32 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEEC45505
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 09:26:31 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 25NGQR53071023
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Jun 2022 12:26:28 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "=?utf-8?Q?'Ren=C3=A9_Scharfe'?=" <l.s.r@web.de>,
        "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     <git-packagers@googlegroups.com>
References: <002401d88700$7908f6d0$6b1ae470$@nexbridge.com> <664fcc55-1cd3-eb01-9be6-80bc4492e849@web.de>
In-Reply-To: <664fcc55-1cd3-eb01-9be6-80bc4492e849@web.de>
Subject: RE: v2.37.0-rc2 - Additional Breakages on NonStop x86 (was RE: [ANNOUNCE] Git v2.37.0-rc2)
Date:   Thu, 23 Jun 2022 12:26:22 -0400
Organization: Nexbridge Inc.
Message-ID: <004201d8871d$fd402370$f7c06a50$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQG9ZjXt9GR0lcb9Gr0IyPgtUzJLgAGjwnUArYZBBLA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 23, 2022 11:22 AM, René Scharfe wrote:
>Am 23.06.22 um 14:55 schrieb rsbecker@nexbridge.com:
>> On June 22, 2022 3:32 PM, Junio C Hamano wrote:
>>> A release candidate Git v2.37.0-rc2 is now available for testing at the usual
>places.
>>> It is comprised of 378 non-merge commits since v2.36.0, contributed
>>> by 64 people,
>>> 19 of which are new faces [*].
>>
>> RC2 had numerous new test failures on NonStop that were not present in RC1,
>RC0, or prior git releases, ignoring the @2 problem previously reported. Failures
>are:
>>
>> t5516.113
>> t5601.8
>> t7031.3, 11
>> t7421 (all subtests)
>> t7500.46-50
>> t7528.4,5,8,15,16,20
>
>That's curious.  Here are the test names:
>
>   t5516-fetch-push.sh
>      113 - fetch warns or fails when using username:password
>   t5601-clone.sh
>      8 - clone warns or fails when using username:password
>   t7031-verify-tag-signed-ssh.sh
>      3 - verify and show ssh signatures
>      11 - verify multiple tags ssh
>   t7421-submodule-summary-add.sh
>      1 - summary test environment setup
>      2 - submodule summary output for initialized submodule
>      3 - submodule summary output for deinitialized submodule
>      4 - submodule summary output for submodules with changed paths
>   t7500-commit-template-squash-signoff.sh
>      46 - commit --squash works with -c
>      47 - commit --squash works with -C for same commit
>      48 - commit --squash works with -c for same commit
>      49 - commit --squash works with editor
>      50 - invalid message options when using --fixup
>   t7528-signed-commit-ssh.sh
>      4 - verify and show signatures
>      5 - verify-commit exits failure on untrusted signature
>      8 - verify-commit succeeds with commit date and key validity matching
>      15 - show signed commit with signature
>      16 - detect fudged signature
>      20 - show bad signature with custom format
>
>rc2 changed the following files:
>
>   $ git diff --stat v2.37.0-rc1 v2.37.0-rc2
>    Documentation/git-gc.txt         |  3 +--
>    GIT-VERSION-GEN                  |  2 +-
>    builtin/name-rev.c               |  2 +-
>    contrib/completion/git-prompt.sh | 32 +++++++++++++++++---------------
>    t/t9903-bash-prompt.sh           |  2 +-
>    5 files changed, 21 insertions(+), 20 deletions(-)
>
>The name-rev change only modifies a help message.  At first glance there doesn't
>seem to be a way that these changes may influence the outcome of those tests.

Just to confirm, this is commit f770e9f39, correct?

I found a few related issues here. The biggest one is that we use Jenkins for our build. It looks like the TTY determinations are failing when in Jenkins but not outside. So an inaccessible stdin is causing test issues. Also when stderr=stdout is also causing issues. For t7031, there is a library conflict when we run with OpenSSH 8 with Git built with OpenSSL 1.1.1 vs. 3.0.4 - so that conflict is a configuration issue. We do all kinds of built/tests with those, so that explains that.

So other than t7031, the tests ran correctly when I did them manually, but not in Jenkins.

