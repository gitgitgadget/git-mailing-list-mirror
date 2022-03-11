Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CABDC433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 14:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbiCKOSW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 09:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349439AbiCKOSP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 09:18:15 -0500
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Mar 2022 06:17:10 PST
Received: from mail.vivaldi.com (mail.vivaldi.com [31.209.137.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C241C74E7
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 06:17:10 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.vivaldi.com (Postfix) with ESMTP id F0A7A1F873E
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vivaldi.com; h=
        mime-version:content-transfer-encoding:date:date:subject:subject
        :from:from:message-id:content-type:content-type:received
        :received; s=2019; t=1647007827; bh=jkPnzK1U8U/yhvm7Cyn6lzazS2Ev
        y4ryv45AkH16n8E=; b=g51Zsub2iV9I5k9iqXKeYGW3qo2jyfYACNcHhTUqf2IM
        CX72hVBkbOGJ1eyhF9JqG6ibhSpwvVc+Bhz00YwiAEKumhdI+NCuV/LybJLbPKd/
        kuo9+aqS/+OUpJ1o59erieMQWobXk3wsBpyVdTSKXuXGpMh1RsNPs1ecyAB7ca8n
        mZ7TvRIVFpxOJnTorugof2VR9qpGNx1O09yH4ZnSwR3Li3ew0LFgnUwogpcsUH5o
        TVEQp53D3LMsatHYAOzmBxTRWIlsAJ+24fGoUEzeFb510YGU0KLJReqcLgaMML4z
        Zt5WRoAY1Di9LdDLviMLKeqIMRozvafOZwm8gN3ufA==
X-Virus-Scanned: Debian amavisd-new at vivaldi.com
Received: from mail.vivaldi.com ([127.0.0.1])
        by localhost (mail.vivaldi.com [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Pq5Vkd55G5l4 for <git@vger.kernel.org>;
        Fri, 11 Mar 2022 14:10:27 +0000 (UTC)
Received: from noip.localdomain (ti0182q160-1041.bb.online.no [109.189.134.30])
        by mail.vivaldi.com (Postfix) with ESMTPSA id A51A71F8125
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:10:27 +0000 (UTC)
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1647006095912.1308641200.2893260369@vivaldi.com>
From:   "Yngve N. Pettersen" <yngve@vivaldi.com>
To:     git@vger.kernel.org
Subject: Incorrect work dir for submodule fetch operations
Date:   Fri, 11 Mar 2022 14:10:25 +0000
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
Since Git 2.21 the Windows version have frequently reported 

   error: cannot spawn git: Invalid argument

and still do in 2.34 and 2.35.

The reported error does not seem to have any bad effects, but the error 
report is an irritation.

At the time, this was reported to the Git for Windows team as 
<https://github.com/git-for-windows/git/issues/2126>

As it has not yet been fixed, the past couple of days I have investigated 
more closely.

The error is printed for a submodule.c function submodule_has_commits() 
which starts the command "rev-parse" for a submodule.

The reason for the error is that the function starts the command for 
submodule "foo", which is present in the checkout directory. However, the 
actual CWD dir is the git dir for the current module, not the checkout 
directory, and the change directory operation therefore fails.

The "rev-parse" made it possible for me to connect this problem with a 
different problem that I have been seeing at Linux and Mac, where the error 
message 

   fatal: exec 'rev-list': cd to 'foo' failed: No such file or directory

is frequently reported, especially when a branch in the parent module has 
new submodules defined.

AFAICT, the reason for the CWD being the git dir, not the checkout dir, is 
that  get_next_submodule() in submodule.c starts a fetch operation directly 
in the git dir, instead of the checkout directory

Further, submodule_has_commits() which is called by the fetch command via 
fetch_populated_submodules() assumes that its CWD is in the checkout 
directory.


After a bisect it seems the regression point for this was commit 
be76c2128234d94b47f7087152ee55d08bb65d88 
<https://github.com/git-for-windows/git/commit/be76c2128234d94b47f7087152ee55d08bb65d88>, 
which added the fetch in git dir command in get_next_submodule().

A testcase for reproducing the issue can be found in 
<https://github.com/git-for-windows/git/issues/2126#issuecomment-1064153093>
 (assumes default branch is "main"), which builds up a submodule set based 
on two Chromium repos (chromium src, and depot_tools)

I am uncertain what the proper fix for this issue should be, but my guess 
is that each command need to specify whether it is going to work relative 
to the git dir, or the checkout dir. It is IMO conceivable that other 
commands may have this kind of problem, especially in a submodule context, 
or that future features may encounter them.



-- 
Sincerely,
Yngve N. Pettersen
Vivaldi Technologies AS
