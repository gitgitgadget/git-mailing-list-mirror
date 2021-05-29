Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F23C4708E
	for <git@archiver.kernel.org>; Sat, 29 May 2021 15:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D29B611AB
	for <git@archiver.kernel.org>; Sat, 29 May 2021 15:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhE2PCC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 11:02:02 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:58801 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229636AbhE2PCB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 11:02:01 -0400
Received: from host-92-14-216-189.as13285.net ([92.14.216.189] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ln0Rq-0001xY-3Q; Sat, 29 May 2021 16:00:22 +0100
To:     Git List <git@vger.kernel.org>
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Subject: [RFH] CMake: detect if being run via Visual Studio, independent of
 build generator?
Message-ID: <013f42a4-19f4-a935-7068-db3f7ff40446@iee.email>
Date:   Sat, 29 May 2021 16:00:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
cc'ing those who've been involved with the CMake tool recently.

I've been looking at part of the Git-for-Windows (GfW) Visual Studio
build process that uses the CMakeLists.txt approach [A,B], which is
based on the git.git version. In part it's now, for an uninformed user,
broken, in an awkward way, hence the subject line question.

An uniformed user is expected to clone git, download Visual Studio, and
file-open the /git directory. Visual Studio will then find the
CMakeLists.txt and create a hidden .sln/.vcproj project ready to build.

In recent times Visual Studio has added the Ninja build generator, in
addition to it's historic visual studio generator, and made Ninja the
default (unless specifically configured otherwise e.g. [1]). This change
of generator breaks the detection of being in Visual Studio (using Win32
and MSVC flags). We used these flags as a cue to pre-load the vcpkg
libraries, but no longer. Also note Visual Studio embeds its own CMake
version.


One issue for creating an update is that the CMake file is meant to be
OS independent, and the Ninja generator is also OS independent, so
shouldn't be used as the indicator of working with Visual Studio.
Likewise using the Win32 CMake flag isn't appropriate for those not
using Visual Studio. So the issue, as best I see it, is how to decide
when to pre-load the vcpkg libraries needed for the build.

The CI for the git.git test of CMake preloads it's essential
pre-requites (as an informed user;-) so avoids those Visual Studio
changes to it's defaults.

The ultimate aim is to make it as simple as possible for GfW users to
browse the Git code, without feeling that they have taken the
developer/contributor commitment step, which appears to scare off some
users.

Part of that simple usage is that existing Visual Studio support tools
can expect  .sln/.vcproj files to be available to 'just work' out of the
box. In particular (for me) Sourcetrail [2,3], with it's easy graphic
visualisation and tracing through the code, is one target. Sourcetrail
isn't quite there yet but..[4]

This issue is tricky to test as it (pretend to be that inexperienced
user) expects a clean VS install and no vcpkg prior install.

I could be totally confused (I am feeling rather dumb on this one), but
I'd be grateful of any help in clarifying a way out for detecting if the
conditions are right to pre-load the vcpkg libraries. I've also raised
an issue at [5]

--
Philip
earlier discussions at
https://github.com/git-for-windows/git/discussions/3176

[A]
https://github.com/git/git/blob/master/contrib/buildsystems/CMakeLists.txt
[B]
https://github.com/git-for-windows/git/blob/main/contrib/buildsystems/CMakeLists.txt
[1] https://github.com/microsoft/vscode-cmake-tools/issues/1084
[2] https://github.com/CoatiSoftware/Sourcetrail
[3]
https://github.com/git-for-windows/git/wiki/Sourcetrail-code-viewer-and-linkage-to-Visual-Studio,-for-Git
[4] https://github.com/CoatiSoftware/Sourcetrail/issues/1179
[5] https://github.com/MicrosoftDocs/cpp-docs/issues/3167
