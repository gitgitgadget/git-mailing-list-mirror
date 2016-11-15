Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36B2F203C1
	for <e@80x24.org>; Tue, 15 Nov 2016 01:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941209AbcKOBTH (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 20:19:07 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36124 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940978AbcKOBTD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 20:19:03 -0500
Received: by mail-pf0-f173.google.com with SMTP id 189so32511622pfz.3
        for <git@vger.kernel.org>; Mon, 14 Nov 2016 17:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=8zpgGVODd+wgMngMvewgW0a4xr5ATgDhzA9cZwJQNPM=;
        b=MAGW//0s+SNtlkiOP9R7e26VVmUQDSjhzYDO/C23Ch+88UrQ6dVNd5ftdk1j64I/eY
         Mt9Gi0c8HjxZ65QvFY1D762x3hrYjLIrpbjouUTxbcGmInpKV4XhEQXR+aXpbIYXquZ9
         nIuclKyaTp+Ufj/DDJ9ecJwyB80aqp8JPeZPjKVrEyJnS+oV+mApkhn+zNq6DY/pxqDu
         jjji0d3HzFyNaBCzHXlRJbYCWVW4GLEjwOcPBzi2mHkh8wLG1wQOF1X2beUSnLmy7kru
         VVRiOEMqAa4slru1c6bVcDcnNE9fbEp8NFQLJFmqTEMluqYo//OkBcHfWnhPPSiyvFrL
         W7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8zpgGVODd+wgMngMvewgW0a4xr5ATgDhzA9cZwJQNPM=;
        b=hbOrnu5XCsIB98z081jIC41DGG4x8cXU6lCCfSt3MeY4taSA0LgGlnpdz8zn11Vo2O
         ivhAt5ozb1gsrrrkqNvheHiymLgpfo4o4NrXXj3MQ1cHka1NwH4a/DPFvK5HOYW6X036
         SPxQN0sC4gmuXpgF6hA9SFZzUMvWNYAorEaTLAwDltjSrJYlft73D+1OaJbRRPuZtuIM
         IigF8mYSmfzzqdiXii+KUp4+DpneeRudKoZRZhL5Zcc4yqIEPyLZtuiyKEQjqA+9BmS5
         ulh92JzqtCVb5CkQfEd84xvPq1uG39ZbI0AB5yJ9JfCugPfrU3eOivkVGJa/8S/+Mksx
         dMXQ==
X-Gm-Message-State: ABUngvesDBLkIts5Rv16zBJGIx0GycKOiSwf9pKd2V7+3V1GYwxm877qKES7IJFGRN4qbTxW
X-Received: by 10.98.81.70 with SMTP id f67mr41074871pfb.179.1479172742924;
        Mon, 14 Nov 2016 17:19:02 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id t89sm35655377pfe.50.2016.11.14.17.19.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Nov 2016 17:19:02 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 0/2] bug fix with push --dry-run and submodules
Date:   Mon, 14 Nov 2016 17:18:53 -0800
Message-Id: <1479172735-698-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While trying to understand how the recursive pushing of submodules worked I
discovered that when push was instructed to do a dry-run, while also configured
to push unpushed submodules 'on-demand', that the submodule pushes weren't
configured to perform dry-runs, but actually performed the pushes.  This
resulted in the submodules being pushed while leaving the superproject unpushed
which is undesirable behavior for a dry-run.

This series introduces a test to illustrate the bug as well as a patch to
correct this behavior by passing the --dry-run flag to the child processes
which perform the submodule pushes during a dry-run.

This series is based against 'origin/hv/submodule-not-yet-pushed-fix'

Brandon Williams (2):
  push: --dry-run updates submodules when --recurse-submodules=on-demand
  push: fix --dry-run to not push submodules

 submodule.c                    | 13 ++++++++-----
 submodule.h                    |  4 +++-
 t/t5531-deep-submodule-push.sh | 26 +++++++++++++++++++++++++-
 transport.c                    |  9 ++++++---
 4 files changed, 42 insertions(+), 10 deletions(-)

-- 
2.8.0.rc3.226.g39d4020

