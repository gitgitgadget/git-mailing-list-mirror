Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10F7C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 00:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2AB22D71
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 00:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbhAFAVl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 19:21:41 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:55437 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbhAFAVk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 19:21:40 -0500
Received: from oxbsltgw67.schlund.de ([172.19.249.174]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MQdtO-1kaUEk0Rew-00Ni26 for <git@vger.kernel.org>; Wed, 06 Jan 2021 01:19:08
 +0100
Date:   Wed, 6 Jan 2021 01:19:07 +0100 (CET)
From:   - - <sven@nichtgerade.de>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <898607890.216528.1609892347792@email.ionos.de>
Subject: [Bug] 'git submodule update --single-branch' still fetching master
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.3-Rev28
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:APP1JJYhlS6L8moaY9APdVHsyKhvtAVNmNMuGkTOjc4VxB3iraD
 l1GQPwmMjJOWOjWfr1sP+3vRUfXFDq97rgxB0gzu3xeIcOUq3PXAxBlIEv651EI5QPLRGfi
 RX8WvmoZWPKcNySmXq8nQdrNrfFCZH8pGllNZm+Xp5064FnPXg2dFzvnn48gGrs3qV31+cJ
 AgKMek6bjOowJhQNZuIaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4Lx/EDBipZo=:7JP9hjYjafkrf0fel94jz1
 bvqBy6JjsbAm1M9z0vPTAzBZspcNYcwgzDtTTwIkch3tvWIWiN193o+yUdIIYS36KdNZFvdkS
 C+doRzjOYoS80NOKGlNzQrAoLOrPqjPk9znKjW/J49jlHEurh+ecB+ypgb2v5NkFdhMqi7S64
 FSEON3yhkWG4XKTGORzASeFZ2ETMW1miVMgJEVRVhg4PHNUR7vryJSXXlFCrvynoeYkZujlW4
 7+vdQUA3mAQyIaF8SoFtstyKmXnO7epJnR6/qdim9iJLuC3VnYQisYXWLK/cNIDdjAdqxacYJ
 zvvbbXzxejYm16n5xveMXAPqXJY86XCx3JkXCMvqyYe+iYG12HHCoLT+dLXNB9nrlgsOhHWzA
 Ie4I1+mBlV91zITZHuLAW50KfAkgfzcj940DJSpAyLte9R5wFAD+VFoZbALXQoGyNTdNJGXt2
 wtaqwyHjew==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I encountered today some problems while trying to track a single branch with 'git submodule add' and 'git submodule update'. Please find my bug report below.
Any help would be very welcome! :)

Kind regards,
Sven Krummen


What did you do before the bug happened? (Steps to reproduce your issue)
I've got two repositories, 'project' and 'lib', and I want to add 'lib' into 'project' as a git submodule.
The 'lib' repository contains the 'master' branch, which is quite heavy-weighted (~900MB), and a 'light' branch (~10MB) with a mostly unrelated history to 'master'. The 'master' branch is the default branch.
Similar to using 'git clone -b light --single-branch path/to/lib' I want to track only the 'light' branch as a submodule to reduce traffic on our build server.

To add the submodule to 'project' I tried to run:
(a) 'git submodule add -b light path/to/lib'
(b) 'git submodule add -b light --single-branch path/to/lib'
But git was always fetching the whole 'master' branch of 'lib' before switching to 'light'.

After commiting & pushing everything to 'project''s remote, I started over with a fresh clone of 'project' to test whether 'git submodule update' would only fetch the 'light' branch (typical use-case for our build jobs):
(c) 'git clone path/to/project && cd project'
(d) 'git submodule update --init --remote --single-branch lib'
But again, git was fetching the whole 'master' branch of 'lib' before switching to 'light'. This behaviour seems to be independent of the used options of 'git submodule update'.


What did you expect to happen? (Expected behavior)
(a) or (b) To create a submodule which is tracking the 'light' branch of 'lib' and to fetch *only* this branch.
(d) To fetch and checkout *only* the 'light' branch of 'lib'.


What happened instead? (Actual behavior)
(a) Fetching 'master' (or the full 'lib' repo?), then checking out the 'light' branch.
(b) Error as option '--single-branch' is not supported for 'git submodule add'.
(d) Fetching 'master' (or the full 'lib' repo?), then checking out the 'light' branch.


What's different between what you expected and what actually happened?
As the 'master' branch of 'lib' is quite heavy-weighted, I do not want to fetch 'master' at all. By using the option '-b light' to specify which branch shall be tracked, there is no need to fetch other branches besides 'light'. I'm not sure if it is really necessary for 'git submodule add' to fetch anything, as this could also be done by a subsequent 'git submodule update'.


Anything else you want to add:
This issue could be related to: https://stackoverflow.com/questions/61483547/how-to-shallow-pull-submodule-that-is-tracked-by-branch-name


[System Info]
git version:
git version 2.29.2.windows.2
cpu: x86_64
built from commit: 3464b98ce6803c98bf8fb34390cd150d66e4a0d3
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
uname: Windows 10.0 17763 
compiler info: gnuc: 10.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]
