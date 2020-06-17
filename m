Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D75C433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 19:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28021206F1
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 19:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="UG2IH602"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgFQTPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 15:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQTPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 15:15:16 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83463C06174E
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 12:15:14 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r15so3203744wmh.5
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 12:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6aHOPSKjWLWt7/LA1Fcf9n7HJASYYBDNtuTJd7y2faU=;
        b=UG2IH602lfiOoprKUGb377dvBcwAgBTl5hluzk6SRdRgO0hqsxEqLGA9RHXhfz4IUd
         NZ+maUjnw/+Tg8w7WBjsc2vZvyy1HA8PBV+Hdk7nF5/x8qjqfgtcI/Jvomrt1a/kAXYN
         qL/An4MW2WXg3EnoCu9xtzQt2Uj01yauLMrQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6aHOPSKjWLWt7/LA1Fcf9n7HJASYYBDNtuTJd7y2faU=;
        b=U3E3bsiLx0LHQHrqWEb2oIBbL/cpPo/t6a8HPqCSzZfK8vvyyKCmfSoWq0e9ia2ywW
         p4MiB1DTvLyDMsgtk9E+Ken4R3zww504/LhY0KgoIsuBXNPxJ1Eh/Z3j46l1za0xLYJ2
         4jidKLNFkdC3gazcRoFhJ3CODHggyz7qSKUR2ItB02LPNINJQ32tRdp92WwGYgKPYmLr
         iWbjBMFxepOV3pLsIbkO+nqXjQxexKvnyS5a4hTgk9UoI6HWa2F6BPcJkuidwIn3I69b
         +flz0IR0DMov8Tg5i2z7I0GUYm4yVeF7ZciH8gaWmipnY+YQr+dRV747BrJi/YB+uB/a
         AdwQ==
X-Gm-Message-State: AOAM5316c8HMIHPMSrGZJfPYf8hWKdQOlxR34YGgPkXlKg8QvRZDoHzd
        PVmo11+yMmknNapAncD0m+I60m2CGFk0LctZWb9eLnIuz0k=
X-Google-Smtp-Source: ABdhPJzqcXeA5H0nQfcAeSn1oZbF5tNQjgYAHdnc1d2Ey+N4lSIAOqrMeZxLlMCPwThA+sHDwkuRmE8sENLI1Z/+bRc=
X-Received: by 2002:a1c:9ec4:: with SMTP id h187mr219946wme.27.1592421311182;
 Wed, 17 Jun 2020 12:15:11 -0700 (PDT)
MIME-Version: 1.0
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 17 Jun 2020 20:14:59 +0100
Message-ID: <CAE5ih79vZDzKQ1TSNTrL_64XjZH-DJTPqdPH5NMwOrsbaH=n+g@mail.gmail.com>
Subject: git clone --filter=blob:limit=X interaction with submodules?
To:     Git Users <git@vger.kernel.org>
Cc:     Andrew Oakley <andrew@adoakley.name>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed that if I do git clone with submodules, using
"--filter=blob:limit=whatever" that the filter is applied in the super
project, but appears to be ignored in the sub modules.

Is that expected behaviour? Or am I just doing it wrong?

I'm using git 2.27.0.90.geebb51ba8c.

Thanks
Luke
