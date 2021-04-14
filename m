Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FE4C43460
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 10:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85303613BB
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 10:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbhDNK2K convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 14 Apr 2021 06:28:10 -0400
Received: from mgw1.skoda-auto.cz ([193.108.106.128]:43745 "EHLO
        mgw1.skoda-auto.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbhDNK2J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 06:28:09 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Apr 2021 06:28:08 EDT
X-AuditID: 0ad97bd3-ee1ff70000001ea8-2f-6076c01dee41
From:   "Simon, Martin (Digiteq Automotive)" 
        <Martin.Simon@digiteqautomotive.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: possible race condition (fetch-pack: unexpected disconnect while
 reading sideband packet)
Thread-Topic: possible race condition (fetch-pack: unexpected disconnect while
 reading sideband packet)
Thread-Index: AdcxFpFxVJyPPoSiSP2vYNdrOOqJAw==
Date:   Wed, 14 Apr 2021 10:12:44 +0000
Message-ID: <df13300936784af7bb6c23f9fe0465c9@digiteqautomotive.com>
Accept-Language: en-US
Content-Language: cs-CZ
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.217.145.207]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginalArrivalTime: 14 Apr 2021 10:12:45.0757 (UTC) FILETIME=[B6DB0ED0:01D73116]
X-EEG-SA-PASSED: outgoing
X-EEG-SA-LOOP-COUNT: 1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsXCdbNSVFf2QFmCwbz5FhZdV7qZHBg9Pm+S
        C2CM4rZJSiwpC85Mz9O3S+DO2PBiOXPBe8GKeyeFGhin8HcxcnIICehLzJ1zlxHElhAwkVh+
        ZQ0TiM0mECixrO8eSxcjB4cIUE3fBVGQsLBAisStdUeZQWwRgUyJJc/uMkOU6EnsXqcLEmYR
        UJVYMWki2EReAReJkwfugpUzCohJfD8FMZ1ZQFzi3fMvTBBbBSSW7DnPDGGLSrx8/I8VwlaS
        WLj0ATtEvY7Egt2f2CBsbYllC18zQ8wXlDg58wkLRH2wxOU7z6HmSErcXDObHcIWk3g47Rf7
        BEaRWUhWz0IydhaSsbOQjF3AyLKKUaQ4Nyk3vdxQL61crzg7PyVRr6w8fRMjOOCrL+9gfLfI
        4BAjEwfjIUYJDmYlEV63KSUJQrwpiZVVqUX58UWlOanFhxilOViUxHlNWIFSAumJJanZqakF
        qUUwWSYOTpBuLimR4tS8lNSixNKSjHhQzMUXA6NOqoGxgnd9OU/fHn3zuVGsEaemHbh1PzMh
        /qpw21QX+/sfV9Sey7XVWsp1ePe2J5Xzwyfenj7tG3taqG9/4/f104LXmfP76iw4orDK7MSu
        EK8rnI8kvliIpZlfNwo7v3uhf1PaP9fTmU6L/35+sFPWTDaqMi447OeU5Lktt5mDlB6JnWX3
        kal+941FiaU4I9FQi7moOBEA4uEGUoECAAA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'd like to report a bug, if it's not already known, but I wasn't able to find it on https://lore.kernel.org/git/.

Setup:
We use Git for Windows in version 2.31.0 on MS Windows Server 2019, to access repository on Gitlab 13.10. Both machines are virtual under different physical machines, but still in the same server room connected with high speed network to each other.

Reproducibility:
random (like 50:50)

Reproducer:
Try to clone (initial clone, or initial init && fetch, doesn't matter) a repo from the gitlab to the machine

Expected results:
Repository cloned/fetched successfully


Actual result (when failed):
Cloning into 'local-repo-name'...
remote: Enumerating objects: 237, done.
remote: Counting objects: 100% (237/237), done.
remote: Compressing objects: 100% (129/129), done.
fetch-pack: unexpected disconnect while reading sideband packet
fatal: early EOF
fatal: fetch-pack: invalid index-pack output

Notes:
Some repositories are almost always successful (doesn't matter if they are bigger or smaller), clone and init+fetch seem to behave similarly (from the perspective of the issue). From any machine on the same network, but e.g. through several network routers or VPN, the issue was never observed.
Our current git config:
C:\Users\username>git config --list
diff.astextplain.textconv=astextplain
filter.lfs.clean=git-lfs clean -- %f
filter.lfs.smudge=git-lfs smudge -- %f
filter.lfs.process=git-lfs filter-process
filter.lfs.required=true
http.sslbackend=schannel
core.autocrlf=true
core.fscache=true
core.symlinks=false
core.editor=notepad
pull.rebase=false
credential.helper=manager-core
credential.https://dev.azure.com.usehttppath=true
init.defaultbranch=master
http.postbuffer=512000000*
core.compression=9*
core.packedgitlimit=512m*
core.packedgitwindowsize=512m*
pack.deltacachesize=2047m*
pack.packsizelimit=2047m*
pack.windowmemory=2047m*
sendpack.sideband=false*

These marked with asterisk(*) were added to localize this issue, without any observable effect.

I'm willing to provide more information or even contribute on the fix, just let me know what should I do/try. Thank you.

Best Regards,
Martin Simon
