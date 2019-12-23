Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F558C2D0C0
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 13:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE86D20709
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 13:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfLWNWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 08:22:00 -0500
Received: from gateway23.websitewelcome.com ([192.185.49.124]:49252 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726680AbfLWNWA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Dec 2019 08:22:00 -0500
X-Greylist: delayed 1261 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Dec 2019 08:22:00 EST
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 5171BB1C4
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 07:00:58 -0600 (CST)
Received: from gator4087.hostgator.com ([192.185.4.99])
        by cmsmtp with SMTP
        id jNKUixpWNiJ43jNKUiKf5u; Mon, 23 Dec 2019 07:00:58 -0600
X-Authority-Reason: nr=8
Received: from mail-qt1-f171.google.com ([209.85.160.171]:38544)
        by gator4087.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <xda@abalgo.com>)
        id 1ijNKU-001NgU-2s
        for git@vger.kernel.org; Mon, 23 Dec 2019 07:00:58 -0600
Received: by mail-qt1-f171.google.com with SMTP id n15so15332043qtp.5
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 05:00:58 -0800 (PST)
X-Gm-Message-State: APjAAAWM3jRNlJY3QopZ6OhBJkQUtocScA0rH6ALTIKnpP3CVbxmHkTV
        fSMqn6Uydw/BgwjwktmNywB4PYuEuhrdty2wuNU=
X-Google-Smtp-Source: APXvYqwOCpGcUyuTW/FZp5cStjFYTJHDuJ2T4bYGNhgZIfmP4RFQ8DYgSxJQdFKXlyfzTPaVo+a+ulQTKOd0s2T6dK0=
X-Received: by 2002:ac8:4708:: with SMTP id f8mr22850041qtp.129.1577106057648;
 Mon, 23 Dec 2019 05:00:57 -0800 (PST)
MIME-Version: 1.0
From:   Arnaud Bertrand <xda@abalgo.com>
Date:   Mon, 23 Dec 2019 14:00:46 +0100
X-Gmail-Original-Message-ID: <CAEW0o+gwbNyDqmiouFzO16LsRUfcAnSwj9K77oGe5hi=EVMB=w@mail.gmail.com>
Message-ID: <CAEW0o+gwbNyDqmiouFzO16LsRUfcAnSwj9K77oGe5hi=EVMB=w@mail.gmail.com>
Subject: Possible improvement in DB structure
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4087.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - abalgo.com
X-BWhitelist: no
X-Source-IP: 209.85.160.171
X-Source-L: No
X-Exim-ID: 1ijNKU-001NgU-2s
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: mail-qt1-f171.google.com [209.85.160.171]:38544
X-Source-Auth: abalgo
X-Email-Count: 1
X-Source-Cap: YWJhbGdvO2FiYWxnbztnYXRvcjQwODcuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

According to my understanding, git has only 3 kinds of objects:
(excluding the packed version)
- the blobs
- the trees
- the commits

Today to parse all objects of the same type, it is necessary to parse
all the objects and test them one by one.

It should be so simple to organize objects in
.git/objects/blobs
.git/objects/trees
.git/object/commits

May be due to my limited knowledge of git, I don't see any advantage
to put everything together.
By splitting the objects directory, the gain in performance could be
important, the scripts simplified, the representation more clear.

To be backward compatible, we can imagine a get-object() function that parses
.git/objects/blobs
.git/objects/trees
.git/object/commits
and, when not found
.git/objects

A get-tree() function that first parses
git/objects/trees
and when not found
.git/objects

idem for getblob() and getcommit()

Is there a reason that I don't understand behind the decision to put
everything together ?

Best regards,

Arnaud Bertrand
