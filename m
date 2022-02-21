Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBD9C433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 22:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbiBUWpN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 17:45:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbiBUWpM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 17:45:12 -0500
X-Greylist: delayed 361 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Feb 2022 14:44:48 PST
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BA11D0CB
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 14:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1645483126;
    s=strato-dkim-0002; d=pdev.de;
    h=Subject:From:To:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=Tpu99CEHyAk3eAYlcYK5vNPe58wPnRSYqgWzN+5lqzk=;
    b=UCsPKrJXolHJdpBpwTSr7Und/SSpNrFyr7bpy0Ee2NVL38hFndaTN5cWR14+J+IAfD
    Qo0Gr3JMi00iLJJzjBC+KTeWW9vg2DVNKRM1hIc/faov+4EK2fQeoU4j43wQxS2I1s4+
    dXqTHAEsddIx0UWcnL2B4it6gsKgw0TXjK1DRp1WTnS51m7rcvmnYhdM5PlO71hIVnR1
    FhhEsfcN+v0f/Fx4v3zJg5xs81ndBVX1JdXtDxmysoncJBnBl7l7O8xCuF7AN6UGjMmh
    W1iA/KEv/gBflSO0zW0Jy53sz7JPlAG+ImwhhAkwyNinPHKgyjm8QJ+MOP2mb0J2hKhr
    pXtg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":Pm0UfUGtd9+G9p9stmxCE5ta4sApnuCD/i3TNd+y2/o2oXSBVgRMI6humKUuomjdJSO4CKUOGw7k50PtgI8HBmdjCdGTAIhx"
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2003:c8:d70b:fc00:6600:6aff:fe94:255]
    by smtp.strato.de (RZmta 47.40.0 AUTH)
    with ESMTPSA id Zd5b25y1LMck1Sq
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate)
    for <git@vger.kernel.org>;
    Mon, 21 Feb 2022 23:38:46 +0100 (CET)
Message-ID: <b5b7cb21-30a9-32b8-cadd-1a768f5b98b2@pdev.de>
Date:   Mon, 21 Feb 2022 23:38:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
To:     git@vger.kernel.org
Content-Language: en-US
From:   Raphael Bauer <raphael@pdev.de>
Subject: Pretty format color bug
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I think I found a minor formatting bug when using the custom pretty format:

* What did you do before the bug happened? (Steps to reproduce your issue)
git log --pretty=format:'%h%Cred%+d test'

* What did you expect to happen? (Expected behavior)
A listing of commit hashes and, if ref names for this commit exist, a 
second line.
This line should be colored in red and contain the ref names as well as 
the string 'test'.
In the case of no refs, the string 'test' should appear in line with the 
commit hash, also in red.

* What happened instead? (Actual behavior)
In case of ref names / a second line, the color is missing completely.
The colors work correctly for the single line case (when no ref names 
are available).

* What's different between what you expected and what actually happened?
The %+d placeholder inserts newlines if the string is non-empty, but in 
doing so, resets any coloring information.
This is demonstrated by the string 'test' which should always show in 
red, but does so only if %+d is not expanded.
This makes it currently impossible to color anything with the %+ 
placeholder.

[System Info]
git version:
git version 2.35.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.16.10-arch1-1 #1 SMP PREEMPT Wed, 16 Feb 2022 19:35:18 
+0000 x86_64
compiler info: gnuc: 11.1
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash

[Enabled Hooks]
