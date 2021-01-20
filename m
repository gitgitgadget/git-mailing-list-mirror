Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE48C433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 11:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70F1123159
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 11:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbhATLcw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 06:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730711AbhATKNq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 05:13:46 -0500
Received: from forward100j.mail.yandex.net (forward100j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACD6C061575
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 02:13:02 -0800 (PST)
Received: from myt5-d6370c626f9b.qloud-c.yandex.net (myt5-d6370c626f9b.qloud-c.yandex.net [IPv6:2a02:6b8:c12:208f:0:640:d637:c62])
        by forward100j.mail.yandex.net (Yandex) with ESMTP id A6F1450E1249
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 13:12:59 +0300 (MSK)
Received: from myt6-efff10c3476a.qloud-c.yandex.net (myt6-efff10c3476a.qloud-c.yandex.net [2a02:6b8:c12:13a3:0:640:efff:10c3])
        by myt5-d6370c626f9b.qloud-c.yandex.net (mxback/Yandex) with ESMTP id 1PiiqRMRAC-CxECxGBk;
        Wed, 20 Jan 2021 13:12:59 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dragonsoul.com; s=mail;
        t=1611137579; bh=4gxoqf+OYhJKrFR5LURuiYS1V26IklOJmgMLvGG3sc0=;
        h=Subject:From:To:Message-ID:Date;
        b=sMZn2wCAL+eb1c2+XQEbA7ZNlEFEplqcrRpmPXQ/aLmtnYRrzZRbgqbSrFIZ9Wq1Q
         /kNYMpJ2QbsfOavZuwsG6nw0MIZeeJf66uRZVofjjUEu6uWGrXUoTeSbrxKkJrrtia
         xxeAcUJg5EH9QuQuwbZFzWB0HGHNY0yT2vpfXRsc=
Authentication-Results: myt5-d6370c626f9b.qloud-c.yandex.net; dkim=pass header.i=@dragonsoul.com
Received: by myt6-efff10c3476a.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id EJTe6vZJtz-CxHumQMm;
        Wed, 20 Jan 2021 13:12:59 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
To:     git@vger.kernel.org
From:   Mail <mail@dragonsoul.com>
Subject: Incorrect $HOME value when using runas on Windows
Message-ID: <b2b0fd42-14a8-fbb6-8817-4e53efb9e730@dragonsoul.com>
Date:   Wed, 20 Jan 2021 13:12:57 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To reproduce the issue:
1. Install git-windows x32 or x64 for all users.
2. Install Total Commader or any other file manager that support system 
context menu
3. Add user in Windows via msc or settings app and set password. Don't 
forget to disable "User must change password on first login" in case 
user created via msc
4. In current user session execute runas.exe /user:NewlyCreatedUser 
"Path To File Manager"
5. Right click on empty space in file list and choose Git bash here
6. Type `echo $HOME` in bash console and press enter
7. The $HOME is `/c/Windows/System32`. Expected `/c/Users/NewlyCreatedUser`
It seems git for windows uses HOMEPATH that points to system32 in case 
of runas command. Might be using USERPROFILE variable is better.
