Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E3BC3A5A7
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 22:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiLFWFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 17:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLFWFv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 17:05:51 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9115A45A35
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 14:05:50 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1441d7d40c6so19094043fac.8
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 14:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P6P/v62bIowotT4/CCsyxm2AegmiXO5uhTp6P1mGCqk=;
        b=nv3tY+PU4326gs7S5IuYfLbih1X3TwMOYkcJ2AMDphFMAcKHtro3zJfl0hLQG6w+DU
         zitUY6PExgVGgCzYzeJlv4FsavwrTh66l1FNw/v73+X6MBGRjmpDgEH/2qouxnrn2Igz
         mMqMxeJMlZHQJtYRbr3C4s7aEASp3k6Won69IpetmhpNfa7k3sLMb28IfLVaKZt/A2y0
         HDFUQdCiRMGWE+Ox+A8kfSWcD4lBT1b89TZ3G+kgxGqwq+lZ1aqY2CaSGNJZnbiQTnx4
         5xEMzLJ8FkNGOna/l3+xpC1OZEb/DPbHaevwjVhleW0oqygFRexj+DwgIIuuDWHS8AI+
         n3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P6P/v62bIowotT4/CCsyxm2AegmiXO5uhTp6P1mGCqk=;
        b=Jg6F9/c3MPqrNHUxuQVmnfdrZhuUHBu0gUDQ8SFiG85J8+G3ro7+zyGpi68zZZcKbZ
         B6IEPCazV3YXoaY46Kl2Zk/dYQB/pbJxGPOfCkaRoYsZJqSy7tTCl15KPunHskB55xy0
         v8Vph+7krn+2HCmj0vgvgZkvi2xGSbR9xim1RrW4us9WV+UBkjMKTYB3ptsOTqMUfhJo
         2KGICLR+kfv8wNyTBstWGtFK2FiwwfYrNWEzhR/4c5yL1FlrKV+UzlfgDenkt/vIEZSi
         axGHnT74I8kj5vdl/FxzIbnAEYzZsqUsNoJWe4IIoNrobAWB49bof6f1uosU6N4qRs48
         Hq6Q==
X-Gm-Message-State: ANoB5pknwh4PVxgtk5avQwt1feFx95jOSKAx4X/OH9fN1glT+v1jZvc2
        mDHUXduCbL+NnopLblavZHBxIvQ43OqXe4eaSBIREfiXihzldg==
X-Google-Smtp-Source: AA0mqf5/gBHtsSggSxEl9b4MquVxR4D6v16sFhRXty77JWr1XFuwK/mc8nBNsw9e586FVCPr257ZUMrKB6GfX+VPtmI=
X-Received: by 2002:a05:6870:a78c:b0:142:f72a:8d4c with SMTP id
 x12-20020a056870a78c00b00142f72a8d4cmr39459806oao.109.1670364349626; Tue, 06
 Dec 2022 14:05:49 -0800 (PST)
MIME-Version: 1.0
From:   Gennady Uraltsev <gennady.uraltsev@gmail.com>
Date:   Tue, 6 Dec 2022 17:05:22 -0500
Message-ID: <CACH4KQSutGnoyFGP2RmkwQT3yhnEg1RcvedXVSMOVVDAnz_aFg@mail.gmail.com>
Subject: Git credential store conflicting configuration leads to unexpected behavior
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,

I have an issue with git credential-store. In my global configuration
dir  (.config/git/config) I had the line

[credential]
helper = store

while ini a repository's .git/config while I have

[credential]
helper = "store --file=./.git/git-credentials"

to store credentials "locally".

I thought the latter would overrule the former However what happens is
the following:

1) On first run the file repo-local file ./.git/git-credentials gets
created and the credentials are saved there after the user is queried
for a password
2) On subsequent runs the credentials get recovered from
./.git/git-credentials and the user is NOT asked for credentials
2b) **Here is the weird behavior** git ALSO creates the
.git-credentials file in the home directory and saves a copy of
credentials there.

The behavior 2b leads to exfiltration of passwords to a location a
user might not expect.

Workaround: Remove the line

[credential]
helper = store

in the global config.

It seems that the global config somehow does not get shadowed by the local one!

I think this is a bug with mild security implications.

Let me  know.

Best,

Gennady

--
Gennady Uraltsev
<gennady.uraltsev@gmail.com>
(https://guraltsev.github.io)
