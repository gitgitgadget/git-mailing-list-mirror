Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6000C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 07:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238126AbiBWHsn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 02:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238857AbiBWHsh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 02:48:37 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EEC6D846
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 23:48:07 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id r13so27515795ejd.5
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 23:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=fcrr2cvHL5zHM03LQtfL4DyfRWqOq1y42FIeM9tqxGc=;
        b=j6o+aLIatVXyWovVGqkjbU+49j10QdNgJNPkqKWRoUaviK8jK3+4cLGlYqPDNdn+4m
         +GwqMXM3+aLSzCiEDxrIvMzpAlYnUbfQmLZH7XsIEeBoBMOFeGMAzyMMpPx4yw8sbbdf
         ntMIui/mIDWXJpo/cob0jPGx6QOHC0hWpWTq2x5jD1XdjbjaYHw5wB5a8IEjgn74pqBq
         r73PrFdVkmGeXJPw6XcPRJRJUOz43Bf9OhqhWkDf6M7Wgf7olC0UNpx1WfissHX8IKgN
         HjKF1B0PxhIjRKoMJB79f/GhAUoQZKkD69PNNKstXH8k8efcKMoKRWX3C/dHeg6uWX8G
         368g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=fcrr2cvHL5zHM03LQtfL4DyfRWqOq1y42FIeM9tqxGc=;
        b=IwFLs9AVC19mNbRvG4ASt2gkpLLdr7h55M9Ssdxxr7kVYnYcr0TlsDzlbPEi4Iytt4
         4y0zOJbuDty/e3/KvgvaCevt9K7XaN7e65O/jbz5He0QFzHR36/Oxa1udusljF+1qV3M
         NWHMo6FwHnj2XNTt4wn9z54mipy5eIszbBk0AtN/vuRyTB/v8TN6r7xnPJ6gfhBS6SpW
         on/EhQ1WFQdmAKJCmvXuNyqA+z7O06hjeS21fAx4RGIwSBpVXWPSm0QNKGbvjrL9BBcn
         p1c+7P+BMx0Yu+7ZXJnkAsGbwn7eJZCiWC3TrrsUtZBD1LmvsnOhZZl5nrokJAvsEfgV
         yR9w==
X-Gm-Message-State: AOAM531hQiPGq+ASD/7eSQu9W2EKHb/NQ7583vwHgyrQr6aGL7MUU3tV
        XQ/6PK5jFK8nC/RYHAnTgJoMtlwTOBbREnJ1Wed6drU8tKwYNw==
X-Google-Smtp-Source: ABdhPJybgEF08Vm7gJQIx2nxNne5czpvQrx+Q5JUhZAZBJ5ukx2RNGOOqBY4ey53E8SVhDI4td0Nfq6ly2YYaojgSmU=
X-Received: by 2002:a17:907:11c1:b0:6cf:723b:37af with SMTP id
 va1-20020a17090711c100b006cf723b37afmr22014780ejb.476.1645602485205; Tue, 22
 Feb 2022 23:48:05 -0800 (PST)
MIME-Version: 1.0
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 22 Feb 2022 23:47:53 -0800
Message-ID: <CABPp-BERVCynOVvBq0QL49Ah+gy3W2snUVWBHfzXaVpXX3Dpyg@mail.gmail.com>
Subject: BUG: fast-import, ftruncate, and file mode
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

fast-import makes use of odb_mkstemp(), which creates a secure
temporary file and opens it with mode 0444, and then uses it for its
packfile writing.  Sometimes, fast-import will call its
truncate_pack() function, which makes use of ftruncate().

According to my local manpage, "With ftruncate(), the file must be
open for writing; with truncate(), the file must be writable."

The writable requirement does not appear to be enforced by the kernel
on common filesystems like ext4 or zfs, but this is enforced on some
filesystems.  Apparently a "VxFS Veritas filesystem" got triggered by
this...and some helpful bug reporters tracked this problem down and
found a workaround (for the filter-repo usecase, they recompiled a
special copy of git using mode 0644 for odb_mkstemp, since it was just
an intermediate step anyway and won't be used elsewhere).

I'm not sure if we should (1) just stop calling truncate_pack() in
fast-import (it's merely an optimization), or (2) modify odb_mkstemp()
to allow specifying a mode and also have something like
finalize_object_file() modify the mode before renaming, or (3) if we
should do something else entirely.  Someone more familiar with the
object storage side of things probably knows.  But I'm guessing that
once someone who knows the area states what should be done, that this
might be a small micro-project suitable for the GSoC interns (or
anyone else wanting to get involved)?

Original details from here:
https://github.com/newren/git-filter-repo/issues/342#issuecomment-1047638304
