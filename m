Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64AC5207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 22:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755468AbcILWCa (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 18:02:30 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34816 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbcILWC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 18:02:29 -0400
Received: by mail-qt0-f195.google.com with SMTP id 38so6319505qte.2
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 15:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=mG3EU7lSnK47hHTpmrDldM6kA5p6fHQWVW+cZgOOR5w=;
        b=n/RZisAwOcb9EDU3ME4UAevfQMBIqsUeRrs1ro2zufgdTTJaBPdAskUbhQ9r5RFNde
         RQozu9FV3Qh/dlbBQ/REE03ayOVmAd3sRiQVpTRKbZOMI1qFu8J2D8CyOdZN4CCV6zyi
         Ztdp3TJ862LrOQDKu5Z3+53AjAQglb0SdJLZIadQ+vTOv3BR/LymCrpmqrc/CGgUCbwZ
         R87LYXMmy3bWt2AYRcsAUVx/PKzk9MaDgfTWUwUhmrisOsB7WYu92vsG4cPy4oQ2oGYB
         cJPvBX3VFR/7T5IXtQOF2D4hFLaAmD2VgMoiNPHgqYd3r4ILbzpyp0eySBtc8hIwpXj7
         Ayyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mG3EU7lSnK47hHTpmrDldM6kA5p6fHQWVW+cZgOOR5w=;
        b=W8qpoGtm9tAQZyD9au3AHOHemHpGdKzKvXpGMlc2qlIi8qR/cT/EP+wM5W2BaVLliJ
         EBBTg6wzaZvvcye6TlA+8QqTUCh4Fs5PuhDnOJ4uLE1l1PS8PtLNieNhtZ1kAj7SVV3T
         s0X4jVB90382YDGBzUBuDdJ050KPz+HICTKdTjswwa670Ccpzc6uoYE6dlD1cmq0SVIE
         P1PHtflAJ3nnPDPKAAVQtojQ941HdqqY/9G4bvMvBhm7V7TKHb/tLkapoHPd2FedhUCT
         ZesRbTzj2wCST+1vsshW9JL4ozrxXsnZ49vPw9bEVmcEKQ4XdlNluyqC29BJgQ38qABJ
         D2Hg==
X-Gm-Message-State: AE9vXwOeKzuPRtnlc74OFxGqkVMlKK8GVPZYgCfdRssqX2I3P9ecQR4n6onECv2rff+ZuA==
X-Received: by 10.237.57.162 with SMTP id m31mr22835879qte.6.1473717748300;
        Mon, 12 Sep 2016 15:02:28 -0700 (PDT)
Received: from CHIC02QV065G8WN.sea.corp.expecn ([172.56.13.215])
        by smtp.gmail.com with ESMTPSA id o65sm11724292qkc.48.2016.09.12.15.02.25
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 12 Sep 2016 15:02:27 -0700 (PDT)
From:   Ori Rawlings <orirawlings@gmail.com>
To:     git@vger.kernel.org
Cc:     Vitor Antunes <vitor.hda@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>, Pete Wyckoff <pw@padd.com>,
        Ori Rawlings <orirawlings@gmail.com>
Subject: [PATCH] [git-p4.py] Add --checkpoint-period option to sync/clone
Date:   Mon, 12 Sep 2016 17:02:12 -0500
Message-Id: <1473717733-65682-1-git-send-email-orirawlings@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Importing a long history from Perforce into git using the git-p4 tool
can be especially challenging. The `git p4 clone` operation is based
on an all-or-nothing transactionality guarantee. Under real-world
conditions like network unreliability or a busy Perforce server,
`git p4 clone` and  `git p4 sync` operations can easily fail, forcing a
user to restart the import process from the beginning. The longer the
history being imported, the more likely a fault occurs during the
process. Long enough imports thus become statistically unlikely to ever
succeed.

I'm looking for feedback on a potential approach for addressing the
problem. My idea was to leverage the checkpoint feature of git 
fast-import. I've included a patch which exposes a new option to the 
sync/clone commands in the git-p4 tool. The option enables explict 
checkpoints on a periodic basis (approximately every x seconds).

If the sync/clone command fails during processing of Perforce changes, 
the user can craft a new git p4 sync command that will identify 
changes that have already been imported and proceed with importing 
only changes more recent than the last successful checkpoint.

Assuming this approach makes sense, there are a few questions/items I
have:

  1. To add tests for this option, I'm thinking I'd need to simulate a 
     Perforce server or client that exits abnormally after first 
     processing some operations successfully. I'm looking for 
     suggestions on sane approaches for implementing that.
  2. From a usability perspective, I think it makes sense to print 
     out a message upon clone/sync failure if the user has enabled the 
     option. This message would describe how long ago the last 
     successful checkpoint was completed and document what command/s 
     to execute to continue importing Perforce changes. Ideally, the 
     commmand to continue would be exactly the same as the command 
     which failed, but today, clone will ignore any commits already 
     imported to git. There are some lingering TODO comments in 
     git-p4.py suggesting that clone should try to avoid reimporting
     changes. I don't mind taking a stab at addressing the TODO, but 
     am worried I'll quickly encounter edge cases in the clone/sync 
     features I don't understand.
  3. This is my first attempt at a git contribution, so I'm definitely 
     looking for feedback on commit messages, etc.


Cheers!

Ori Rawlings (1):
  [git-p4.py] Add --checkpoint-period option to sync/clone

 git-p4.py | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.7.4 (Apple Git-66)

