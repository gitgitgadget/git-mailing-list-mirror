Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3CCC433DF
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 03:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B290520757
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 03:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=stripe.com header.i=@stripe.com header.b="NStpLzd9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgFCD2N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 23:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFCD2N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 23:28:13 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158FFC08C5C0
        for <git@vger.kernel.org>; Tue,  2 Jun 2020 20:28:13 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l11so741179wru.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2020 20:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stripe.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=FnOv5yhBnYIcy58FK5FJ6ljb+Uk+XQ8c4T1t8DHnmfI=;
        b=NStpLzd9u+51bz3CDVGQ7i5QnY7s60aIZnNNkQkQ+CXo38NH7+ObQ6O5pRg7JqeeQt
         k3ZmYh7EKLPXRHO8JKRX/6+H0jxQhObneGu7+BI36ZdCGN5asMzrqp0Pp8QKj27Rnrfx
         j2W0bbT+URMaYc0vAz6p7sI+ZEHoK8G9r61yU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FnOv5yhBnYIcy58FK5FJ6ljb+Uk+XQ8c4T1t8DHnmfI=;
        b=Do81B847WTSzE+GUYt48RsD1/QYkfMHwz05YHfer9tb4CedqOoPxXvDanFOK3s7i/Z
         H47IBJGmnsbvcvN2dHDl41kOdMFxsYP0SRCr7SnpdDHpW54UuYzENlaLZC97MEi7XSj7
         wvwTloUNV8Pfs/XD8Z5dcZXq19/iug5N+tYACnF92CQldGvzrwBlEUQvSofN8VMd/Dx1
         PdgGHWOj8/Pi4t6hFVB6NAgJltYE/0z1mTGwmS20SRgBvIOQ5pdgid9YibG0BOdnFrya
         AsHBwsfvW9stZpK2A1HlfBlq79gu1Yj2QCsJSCOCPuhg4A4oHOM50HyYPwic/TOHCeNy
         ruFw==
X-Gm-Message-State: AOAM530TEKyBxjVgGnIE+dT8oUTauZmpelK+xpygqMVN8bhOF/pv6krQ
        OZ2/QxKkhg5Um4rEuj+v3f8jdyrjd/21rvuLRT1+uzZvAYCBag==
X-Google-Smtp-Source: ABdhPJw8x2+RDqw2GcfusgEfHy6/WmPDTg91t0JlswfefEP9AtEDU3Qy862wwYfzO70uGCkvczaMzp3OhspM6G9RTDM=
X-Received: by 2002:a5d:468d:: with SMTP id u13mr31101811wrq.73.1591154891534;
 Tue, 02 Jun 2020 20:28:11 -0700 (PDT)
MIME-Version: 1.0
From:   John Millikin <jmillikin@stripe.com>
Date:   Wed, 3 Jun 2020 12:28:00 +0900
Message-ID: <CAJmdR_pG74x0Zn43MSm7zXNcoitqjjOy+WnhyGBW+oFjVFLbRQ@mail.gmail.com>
Subject: Possible regression in `git grep --untracked` pathspec matching in v2.27.0
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In v2.26.2 and earlier, `git grep --untracked` with negative pathspec patterns
would filter out paths matching those patterns. In v2.27.0, this no longer works
as expected.

Example output:

# v2.26.2 (good)
$ ./git grep --untracked --files-with-matches -e '.' -- 'quote.*' ':!quote.c'
quote.h
$

# v2.27.0 (bad)
$ ./git grep --untracked --files-with-matches -e '.' -- 'quote.*' ':!quote.c'
quote.c
quote.h
$

I've bisected the change to commit 95c11ecc73f286e0a95d9591ae98f1221efe4633,
which changed the handling of path matches in callers of `fill_directory()`.

It's not clear from git-grep(1) whether the old or new behavior is "correct",
so I request that the fix include a clarification of expected semantics.

Thanks,
- John Millikin
