Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B424CEEB57D
	for <git@archiver.kernel.org>; Sun, 10 Sep 2023 06:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241759AbjIJGjL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Sep 2023 02:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237352AbjIJGjL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2023 02:39:11 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E981BD
        for <git@vger.kernel.org>; Sat,  9 Sep 2023 23:39:07 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-26ef24b8e5aso2682686a91.0
        for <git@vger.kernel.org>; Sat, 09 Sep 2023 23:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694327946; x=1694932746; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L9G4lJHNJRCMkqHJXhj+rP/1SboK06GBw+jpieoSgDU=;
        b=h4Fr8Ne9/WTk8KceInVQvDdMsA3TYZxpHrkx61XMZ2DncDPmj6VQwfvXlW0GJZonCB
         Senhfy0tnKPgNK9ppNCaRTVQ9WTejkN9YK61vZifG3Bns7sLhzxc/rds5lT58KGv9/tv
         lS9v1+/sNNo0FOHFgEWWeN4d2YeQvl2mVxWUTGVSsWUbFB+jygvnOBd+Mz4u9/d3Uswu
         IBWoAp9Uh266cDxVdI/8SMnT6qZH1JLFy+7Re96dfuxz8bA/xAai95xw6S8MjUXIWdyQ
         JftYkfYOY/oDXHC1SENr2hiORKa0Cs7Lwl24mbieqa2FMXKNotsljGKtwTxYR03/QAfB
         1q5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694327946; x=1694932746;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L9G4lJHNJRCMkqHJXhj+rP/1SboK06GBw+jpieoSgDU=;
        b=qAkoW+bbh1Ipsr2FKU2goirWxTAFQPns7B9WqBgsj2F7wa94mMq7LWbVdWEPca+zoc
         BWk7U3ZzwR5fNteKfqpe40W48u+X4tq4O8CdPMa9NNmDqFg1hmzW+OK8+zBkFfUI1r47
         shQbDnVjv8p4DFs0y3ZCxRS4x9cxsBETkU8slVWoXh3KRgnRttfeNP/F7dRVnhfCV0V9
         9vewEbO8T7GDFZrKnoyLuiub+2sYq9HHu5mQBz4867zH8FvDnkFwCVUYoj+jdUCXfU7Q
         M+49dWVX4xx/6qc0wDVxztuEV87ugEEd5A09JknC4aS4/hirEtHrPu8FpBRtJuZUGtTW
         J5ag==
X-Gm-Message-State: AOJu0YwWYiZG4a6Vs9iMhRv9LFWsk+w6SMcUjRnnomfx/JX0a+cx1W43
        23FOlZ5c+IzFIgcFGIR7eaq/CmWIPaJj3aPcNAI4P1UDx2o=
X-Google-Smtp-Source: AGHT+IEBBFMikVBxa2pI75UprpnG8vI7d00PAaBmLz0rJFdfqqf7ob8MpgBDSumPHYW/IpUvAk8r9lbVj/VFUgKXl5Q=
X-Received: by 2002:a17:90a:b395:b0:273:dfb2:2632 with SMTP id
 e21-20020a17090ab39500b00273dfb22632mr4851579pjr.15.1694327946217; Sat, 09
 Sep 2023 23:39:06 -0700 (PDT)
MIME-Version: 1.0
From:   Max Amelchenko <maxamel2002@gmail.com>
Date:   Sun, 10 Sep 2023 09:38:54 +0300
Message-ID: <CAN47KsV0E+XC2F+TVKXnnJnkATRp7eM7=-ZJFyZcoTz9SJmcHQ@mail.gmail.com>
Subject: [bug] git clone command leaves orphaned ssh process
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

Run the command:
ps aux
Observe no ssh processes running on system.

Run git clone against a non-existent hostname:
git clone -v --depth=1 -b 3.23.66
ssh://*****@*****lab-prod.server.sim.cloud/terraform/modules/aws-eks
/tmp/dest
Observe the command fails with:

Could not resolve hostname *****lab-prod.server.sim.cloud: Name or
service not known

Run:
ps aux

Observe a defunct ssh process is left behind.


What did you expect to happen? (Expected behavior)
I expected the command to quit without leaving any processes behind.

What happened instead? (Actual behavior)
The command quit and left a defunct ssh process on the system.

What's different between what you expected and what actually happened?
I don't want zombie processes left after any git command (either failed or not).

Anything else you want to add:
These processes are zombie orphaned, meaning we're stuck with them
until system reboot (which is bad).

Please review the rest of the bug report below.

You can delete any lines you don't wish to share.



[System Info]

git version:

git version 2.40.1

cpu: aarch64

no commit associated with this build

sizeof-long: 8

sizeof-size_t: 8

shell-path: /bin/sh

compiler info: gnuc: 7.3

libc info: glibc: 2.26

$SHELL (typically, interactive shell): <unset>



[Enabled Hooks]

not run from a git repository - no hooks to show
