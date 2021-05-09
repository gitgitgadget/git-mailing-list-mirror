Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADD0C433B4
	for <git@archiver.kernel.org>; Sun,  9 May 2021 21:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A38A61377
	for <git@archiver.kernel.org>; Sun,  9 May 2021 21:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhEIVhG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 17:37:06 -0400
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:48280 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229662AbhEIVhG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 17:37:06 -0400
Received: from coruscant.lhuard.fr (unknown [IPv6:2a0d:e487:11f:fd59:c265:f799:b7d8:2f59])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id C5AA745FE52;
        Sun,  9 May 2021 23:35:57 +0200 (CEST)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1620596159; bh=zWxmlrmGg1PjrZhTPEhk8BNposPAQ8/7TJ7GAabdf7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iyY/ofdiNJbdzV3hls407gxjEeC4SHHyAKoa1K6B15yX0axRZsbGMZfReOQdsJbKF
         HS2bp7CYXzJwi6D//VHLDDq9DLGrZYF3xUR92liIcRkJSh6TWnxD1XKL3ogtXHDENX
         xyUmDnSNc+z1OfCXpHlixhU+W3mrh1yWa90I9Mag=
From:   =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
Subject: [PATCH v2 0/1] maintenance: use systemd timers on Linux
Date:   Sun,  9 May 2021 23:32:16 +0200
Message-Id: <20210509213217.449489-1-lenaic@lhuard.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210501145220.2082670-1-lenaic@lhuard.fr>
References: <20210501145220.2082670-1-lenaic@lhuard.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Thank you all for your valuable feedback!
I tried to address all the discussed points in this new version of the
patch.
Do not hesitate to let me know if I forgot anything.

The main new thing in this version is the `--scheduler=<scheduler>`
parameter that has been added to `git maintenance start` command. It
allows the end user to choose between `cron` or user systemd timers
for scheduling git maintenance tasks.

I also addressed the migration problematic during an upgrade.
If a user invokes `git maintenance start --scheduler=systemd-timer`
first, and then invokes `git maintenance start --scheduler=cron`
without invoking `git maintenance stop` in between, the git
maintenance tasks will be removed from `systemd-timer` to be sure that
the same tasks won’t be scheduled concurrently twice by both
`systemd-timer` and `cron`. And the same in the other way round.

On its side, `git maintenance stop` don’t have any
`--scheduler=<scheduler>` parameter as it will try to remove the git
maintenance tasks from all the schedulers available on the system.

The default scheduler when `--scheduler=<scheduler>` isn’t specified
is `auto` which means “choose an appropriate scheduler”.

On Windows and MacOS, it always chooses the specific scheduler on
those platforms, `schtasks` and `launchctl`.

On Linux, it chooses user systemd timers if they are available and
`cron` otherwise.
This order has been a subject of discussion so, let me explain why I
chose this order.

On my system, I uses systemd and all the packages of my distribution
that are needing regular scheduled tasks are defining systemd timers
instead of cron task.
So, I don’t use crontab anymore. However, a cron package is installed
because it is an indirect dependency of a package I installed through
my Linux distribution package manager. But the cron daemon isn’t
started.

`systemctl --user list-timers` is the CLI command that actually talks
to the daemon in charge of scheduling timers. So, if `systemctl --user
list-timers` succeed, we can be sure that user systemd timers are
functional.
Concretely, the `is_systemd_timer_available` function of this patch is
reliable.

`crontab`, on the other hand, only reads and writes to
`/var/spool/cron/$USER` but this command can work also if the `cron`
daemon isn’t running. In this case, the scheduled tasks will never
run.
Concretely, the `is_crontab_available` function of this patch is less
reliable.

We would need to check if the `cron` daemon is really running.
Relying on `systemctl` to check if the service is enabled and running
isn’t ideal since we want to support systems that don’t have systemd.
Parsing directly `/proc` is challenging since its content is OS
specific. `/proc` content on a Solaris system is different than its
content on a Linux system.
We could rely on `ps` but we must keep in mind its interface is very
different from one system to another. It doesn’t implement both the
standard syntax and the BSD syntax for its arguments on all platforms
for example.

Moreover, Linux distributions are proposing several different
implementations of `cron`: `cronie`, `fcron`, `dcron`, `vixie-cron`,
`scron`, `bcron`.

See:
* https://wiki.archlinux.org/title/Cron#Installation
* https://wiki.gentoo.org/wiki/Cron#Which_cron_is_right_for_the_job.3F

Depending on the `cron` implementation, the name of the `cron` daemon
process might differ.
So, reliably detecting if a `cron` daemon is running may require to
review each `cron` implementation.

With this new version of the patch, advanced users that care about
systemd timers versus `cron` can explicitly choose which one they want to
use.
For less advanced users that don’t care, I prefer to choose the method
which has the higher probability of working.

But since this order is a subject of debate, what I can propose is a
`./configure` compile time option to select which `cron` or systemd
timers should be chosen in priority if both are available.



In addition to this big change, this new version of the patch also honors
the `XDG_CONFIG_HOME` environment variable and removes the code
duplication between `systemd_timer_timer_filename()` and
`systemd_timer_service_filename()`.

It also fixes other points raised in the code review.

Lénaïc Huard (1):
  maintenance: use systemd timers on Linux

 Documentation/git-maintenance.txt |  60 +++++
 builtin/gc.c                      | 375 ++++++++++++++++++++++++++++--
 t/t7900-maintenance.sh            |  51 ++++
 3 files changed, 462 insertions(+), 24 deletions(-)

-- 
2.31.1

