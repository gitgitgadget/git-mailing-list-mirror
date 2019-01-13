Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19885211B4
	for <e@80x24.org>; Sun, 13 Jan 2019 13:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfAMN6X (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Jan 2019 08:58:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42258 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAMN6X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jan 2019 08:58:23 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so19949983wrx.9
        for <git@vger.kernel.org>; Sun, 13 Jan 2019 05:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5x8WJlnESeRozD2oemgtFEcI4ee/G4TZHJm5VM2QOK4=;
        b=jf3Hstav0cx5P5Sb+tS3HYNx1mfzHt4tpUHewOb/oWDK5iLoEgLA8A4o5Ntnx4mJ99
         s0nDQDjaxz+YHoNBASkP2ioZgVRy8k47QRco8gtDoS+g0/44QUoG2uMT57KqkSZI+eSG
         8cTqMmxAE9mPsmqaOxNUNPMQd+xsdCD3WI7Mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5x8WJlnESeRozD2oemgtFEcI4ee/G4TZHJm5VM2QOK4=;
        b=CfGoJFXr4EVP66abKNIuWQ7kwZsuxm7ezLKNAhMogD2s2eah7Ec8PAPKOGfxtBxvJw
         8r4e9hna3mQA37iWjCKPx/qFWoZQ9bHmFm63YICHpBQuqK0e3IeZaS4gbLL5iIroeB8L
         cDFkl37mP3mKFT5NeOv+FSklrlCf4tFFH0znf0gz9nxrrvk61W4ABiTlwx0UenUkVJq0
         FJ5w843uatlg9y53VytIoCTcXSd3P2yCuMmnwmueB4tYiLG2/tRJaWb41t1C5ocwMHLF
         l5uIa8umZOSIg/CuJZU+OWq3wDqW5ZdqMGvuJhSOc/3U4aajO1PPgXcxkcF31rVG+EUB
         nB4w==
X-Gm-Message-State: AJcUukeQinnW5ek3Pnxq/iMQom7CVA/aeqGbJbbAky9Zll/qy2WESTP2
        anPV2gyN9pIsyA5yRZX0GKMwJEIuwfY=
X-Google-Smtp-Source: ALg8bN6nw4WIXjXRTCq7hWA3Z0Jmx4CP80uK6anxVo6CT6Vy+TIWh8og5Cyf7M7Y0/+v8Zo0cdCtbA==
X-Received: by 2002:adf:9b11:: with SMTP id b17mr21048767wrc.168.1547387901778;
        Sun, 13 Jan 2019 05:58:21 -0800 (PST)
Received: from ethel.corp.roku ([81.145.207.254])
        by smtp.gmail.com with ESMTPSA id o5sm44186864wmg.25.2019.01.13.05.58.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 05:58:21 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org, viniciusalexandre@gmail.com,
        Romain Merland <merlorom@yahoo.fr>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vitor Antunes <vitor.hda@gmail.com>, amazo@checkvideo.com,
        aoakley@roku.com
Cc:     Luke Diamand <luke@diamand.org>
Subject: [PATCH 0/2] git-p4: handle moved files when updating a P4 shelve
Date:   Sun, 13 Jan 2019 13:58:13 +0000
Message-Id: <20190113135815.11286-1-luke@diamand.org>
X-Mailer: git-send-email 2.20.1.100.g9ee79a14a8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I found this bug recently in git-p4 - updating a shelved changelist where files
are being moved doesn't work. The destination of any moves needs to be
added to the list of files passed to P4.

Luke Diamand (2):
  git-p4: add failing test for shelved CL update involving move
  git-p4: handle update of moved files when updating a shelve

 git-p4.py                |  1 +
 t/t9807-git-p4-submit.sh | 53 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 51 insertions(+), 3 deletions(-)

-- 
2.20.1.100.g9ee79a14a8

