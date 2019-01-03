Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 750F41F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 09:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbfACJxC (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 04:53:02 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40995 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729819AbfACJxB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 04:53:01 -0500
Received: by mail-oi1-f194.google.com with SMTP id j21so27251650oii.8
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 01:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=a3gncglhnGDGGh1extC0hsrIb9LH8OZC33ieTVoOV1U=;
        b=Hf5wI7w7rAHJ25iQjcYLfuQQ66pTgz53baLeXV+s49QkFFFSeaEpTgoQXSuy+31o0C
         WM7glt+pbsFX9qS0vApX+DzW6eZyv+jP/qhh62pmwTaFu8LSYWk2H7SHYeJjpf68A56b
         h6vIeXbiU30JAuugbrkQh5QOZ4dA7EOu6qAE2TCvk8YrLOyEaoLOu4mw30Sg0/f7f2wx
         y/K1oMpT31kN+6fSFes7vAI4udCZcLK8pXktk2C1As+d14JwMWjalzViGvjnPwihrlOH
         bgI4f19DCrR/Qtev37UxRp5ZIDOlHvq/MqBg1/g1rEt16TgnxsjgI1LbWP9BrVg1z4a1
         Obog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=a3gncglhnGDGGh1extC0hsrIb9LH8OZC33ieTVoOV1U=;
        b=mUnuxy3cRHteqQi4mAO7gNKbhh05z2YriYqmi6bAuhwQO6P1MikLvNC3JJwv3Bs6Zl
         qxMqSfDymdFPqfi2XgnD7zm+FONlHo3J0+fkyvP9roVR4jrmcMolCCysslYqEFaMGtWe
         p671mET7fls6AYMNUWYTiGxLqDpElGP2rbRkXtt/rMUdHJ4izKKinMw9sY0ZGH2OyA3t
         EAyHSH+4RUgX1FDSooRXscDPzCbjggw9CW7tcDD9p/gc0hXAitL3YTAS6gHZ0tXzTwPA
         xbR7zpFoN2XI9H5xvhCojSjw5fHQ44Fp3BFM973UlWrYKMntc2o4ilbf7tOIQ61nfPIi
         DtNw==
X-Gm-Message-State: AA+aEWZaYN8oC+sdGVKtdZOy5I/zn0qnvxAz+5RvBT8T9DsXbW/m6ukZ
        8IgjYpA27DCym9RATDpGDvjbjbxBwd58HyMJ+25zt3lZ
X-Google-Smtp-Source: AFSGD/XnbBqJHdElwvsZELas6Jo2TQoko50WqnZX5iSnjOSMJuEZmWB/zwgbqEsfdXgnyl2QjAagx0tdV3nfL4XWRqc=
X-Received: by 2002:aca:b05:: with SMTP id 5mr32531265oil.258.1546509179733;
 Thu, 03 Jan 2019 01:52:59 -0800 (PST)
MIME-Version: 1.0
From:   Guilhem Bonnefille <guilhem.bonnefille@gmail.com>
Date:   Thu, 3 Jan 2019 10:52:48 +0100
Message-ID: <CA+BUw6jXTt6QGXvdFjRDNqJcij+1hNP5xybUUuGqo3bY0=ueuA@mail.gmail.com>
Subject: Suspicious fetch-pack behaviour
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

One of my users reported a strange problem: a simple HTTPS clone did
not work with Git 1.8.3.1 on RedHat 7.
I did many tests and I was not able to understand why his clone don't
work while I'm able to do it on other similar host.

Nevertheless, we did more investigations. One of them: a raw strace.
I discovered two strange behaviours:
- fetch-pack closes its standard input and standard output and then
tries to print the references on standard input and finaly dies.
- git-remote-https does not react to fetch-pack death and continue
polling an empty set of FD.

Reading fetch-pack code, the behaviour is explicit:
When "--stateless-rpc" is provided, fd is filled with standard input
and standard ouput which are then closed.
https://git.kernel.org/pub/scm/git/git.git/tree/builtin/fetch-pack.c?h=v1.8.3.1#n156

Reading this, I did not understand why it could work.
Any help appreciated.

Here is the strace's extract:

2801  getdents(3, /* 2 entries */, 32768) = 48
2801  getdents(3, /* 0 entries */, 32768) = 0
2801  close(3)                          = 0
2801  close(0)                          = 0
2801  close(1)                          = 0
2801  fstat(1, 0x7ffe10ab4730)          = -1 EBADF (Bad file descriptor)
2801  mmap(NULL, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f220c9e3000
2801  fstat(1, 0x7ffe10ab5040)          = -1 EBADF (Bad file descriptor)
2801  write(1, "4df1dbf3224064cc5dd2e4c095da2dda"..., 159) = -1 EBADF
(Bad file descriptor)
2801  exit_group(0)                     = ?
2801  +++ exited with 0 +++
2769  <... poll resumed> )              = ? ERESTART_RESTARTBLOCK
(Interrupted by signal)
2769  --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=2801,
si_uid=7561, si_status=0, si_utime=0, si_stime=0} ---
2769  restart_syscall(<... resuming interrupted poll ...>) = 0
2769  poll(NULL, 0, 1000)               = 0 (Timeout)
2769  poll(NULL, 0, 1000)               = 0 (Timeout)
2769  poll(NULL, 0, 1000)               = 0 (Timeout)
2769  poll(NULL, 0, 1000)               = 0 (Timeout)
2769  poll(NULL, 0, 1000)               = 0 (Timeout)
2769  poll(NULL, 0, 1000)               = 0 (Timeout)

-- 
Guilhem BONNEFILLE
-=- JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
-=- mailto:guilhem.bonnefille@gmail.com
-=- http://nathguil.free.fr/
