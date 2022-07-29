Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6225C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 14:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbiG2Ofd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 10:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbiG2Ofd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 10:35:33 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2F72714E
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 07:35:31 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r24so3411046qtx.6
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 07:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=JAwTFZY0MW0IcmlKitYMhmp7eDcWm3cqshCz0JmONUA=;
        b=U5GKsODhOiaXduwC+XeMGjKCqQvqwTECENgJQKG9/z6hDdBYKulIuCh92l4W60E7D8
         57/sIKJQovVllcFv2Xmjcwx1LTnfoLKHZAtznb4O6CxQU4zaQn8VBisCIFnWFREO4/bK
         GlzuRaSA2qgZQbCKG0+CVzk3pAs5DSgQ2kQj9VoBXHxmDmegD1nykSe1evxjK6kKivmA
         go6ievxXrImL/Vr2qNnpxCdhLvtx+XxzbcSJ5gQlmmM8leLSzaJHBAwUepC0J8WpbQAs
         Jhgn9n+087VAn53q8YT/4ZmWtMsRRxImMmr9ikOQ3IXWw/Kf1WnNgYRHKZPtCLMMrqFi
         phWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JAwTFZY0MW0IcmlKitYMhmp7eDcWm3cqshCz0JmONUA=;
        b=ip2ck9Z35D4n9a8bPh4bv5yWMybn+M23ram1bDbjf+oNvw/Q0C15/mOF5rmSAuX0qL
         0VN1O7GHlUgJ32MW5VQVcut3gJ6Ww/GRMjyswCEEDHi4KjRClF+aHlYxTVGywkrdTW8g
         yXipav5EIgWZZl9mcSzM/khpeLDDgEa14i04ZD9aPqY8StUwuW8m+8BwZ1vWu85jWXS+
         sE+cbKGhgsWpnJc+Br6skxPIxYiNN3DzBHeD8T2+BB14ugB2zNXtHqjCzOFyItpKS+Pf
         aJ9+hxHzfKfactFZDJySBTfZ11INwGC9iyBzArkAs11J2/n2Cgplffspe79A+Fm1Icxt
         NZqQ==
X-Gm-Message-State: AJIora+wkw7y0mdCK1y+PSq1w6EOdrTd/mcgf/5M1ZPCB/pPY2F15Tvm
        tlDyHp9fWiIWn9uMqd42aFpxqYCqukfyldRQU2qOBYDDkAdeFluA
X-Google-Smtp-Source: AGRyM1sVgI/OXKXrxZvZL3A6ru+cjoBvjXxupeeivRTe+A+pQyXztQLTWMPFNR4+QVmFl0RC+/vv/1pSHhwDe3DNxpU=
X-Received: by 2002:a05:622a:513:b0:31e:cedc:f9ca with SMTP id
 l19-20020a05622a051300b0031ecedcf9camr3644845qtx.486.1659105330838; Fri, 29
 Jul 2022 07:35:30 -0700 (PDT)
MIME-Version: 1.0
From:   Sergey Grunenko <grunenko.serg@gmail.com>
Date:   Fri, 29 Jul 2022 18:35:20 +0400
Message-ID: <CAFRNrRYs5tkTq_Dz3qX+jZ_PJLdUwT4NgabavYeHsGOEtMTq5w@mail.gmail.com>
Subject: [BUG] "git log" command wraps lines not correctly while terminal
 width changed
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, developers. I met some small bug in console report of "git log" command

Short description:
git log --graph command wraps lines incorrectly while I change the
width of terminal. It remember the initial width of terminal and wraps
lines according to the initial width.

How to reproduce:
1. Open terminal
2. go to existing repository with some branches
3. Change terminal width to 50 characters (or less, to be sure, that
first line wraps)
4. process command "git log --graph" and be sure, that a few lines is wrapping
5. Increase terminal width until line breaks stop
6. Lines wrapping is changing and is correct
7. Click <up> <down> buttons or rotate mouse scroll to scroll text two
screens next and back
Incorrect behavior:
8. You'll see that the wrapping behavior is like terminal width didn't changed.
9. But if you touch the terminal width again, wrapping will be correct
Awaited behavior:
8a. Lines wrapping is like terminal has changed value

------------------------------------
mailto: grunenko.serg@gmail.com
------------------------------------
Kind regards, Sergey Grunenko
