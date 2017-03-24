Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C651C1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 15:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757269AbdCXP16 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 11:27:58 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36053 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965865AbdCXP1p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 11:27:45 -0400
Received: by mail-qk0-f195.google.com with SMTP id n141so850400qke.3
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 08:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uKvspCDv9hoL8DZ/zTYr+WUbMLoQnTE3IeTofOGUKGU=;
        b=PLQlhvGHYpUNnvlTHBQze8TOVFnlK2NYODSWIHILtw6S558zvIRhGGs60QA8JGMBzq
         JXUSZ67smm7ldnGRI/+p5rzCIQVBoqv5UuP9pACyqoLDcAaolmTgjadxgqEK676fOaXc
         4aTJLJmSuzdm5l88yynfNmyXsUbDVBYUMTsHjRUX0VwTNCDmLRBZYYXzxpu/svPPDgfo
         CdvtfI829XG4NLF24/kIjfdVniSzuM6oCDa46yW43mPCVo4xBo4KCPevvThy2TLNZren
         XvPKRJqDGilnTrdk1LNR6by/yJv/wlKrtCY2gHAijjFoJBnVKA422dmEmeqL0LUtrF71
         /1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uKvspCDv9hoL8DZ/zTYr+WUbMLoQnTE3IeTofOGUKGU=;
        b=gmbP6jPo1LaH5OpW36cNmrtgmmM4edrJHrWpRstzaWxU+GAyC3/xQEECNXLbfXzBuZ
         0TgKmL6VkzcVxQwhY9daMo5F/Pt1VXHByYbRBClc7a3Y22D49GmsQ87LeLbu1ItmNzEE
         yGk4Mt31iC2ugfIGwF03BwQFkGTtXFFK+fYz5ei3wuyiD3gUSmj+KqCe3SkGMOPNmAIF
         YbyhJP9vbFqi7FWrH3Q56b6qzX999xuNenanVJ+6uFRXBkjsw2uR2tfc0317xUT47bC/
         nWA1GP0Xqxxln4w+fhI9J04u40dKCvPi4tadpbZ3C62VkJuBQ+eV3dgUeXenv0RkgzSs
         Hbcg==
X-Gm-Message-State: AFeK/H0CWNae5ovIPYClZPVK8oO/SFeBaQdx1wghxv/oFl5i02UPHjUtEZowMgW8iHiujQ==
X-Received: by 10.55.116.71 with SMTP id p68mr8390344qkc.278.1490369258882;
        Fri, 24 Mar 2017 08:27:38 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id d23sm1717589qta.32.2017.03.24.08.27.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 08:27:38 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     benpeart@microsoft.com, christian.couder@gmail.com,
        larsxschneider@gmail.com
Subject: [PATCH v2 0/2] Refactor the filter process code into a reusable module
Date:   Fri, 24 Mar 2017 11:27:20 -0400
Message-Id: <20170324152726.14632-1-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.0.gvfs.1.43.g876ba2a
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a couple of patch series we’re working on (ObjectDB/Read-Object,
Watchman integration) where we need the ability to have a background
process running that can accept multiple commands thus avoiding the
overhead of spawning a new process for every command.

The ability to do this was added in:

	Commit edcc85814c ("convert: add filter.<driver>.process option", 2016-10-16)
	keeps the external process running and processes all commands

but it is integrated into the convert code.  This patch series takes the
code from convert.c and refactors it into a separate "sub-process"
module so that we can centralize and reuse this logic in other areas.

Ben Peart (2):
  pkt-line: add packet_writel() and packet_read_line_gently()
  sub-process: refactor the filter process code into a reusable module

 Documentation/technical/api-sub-process.txt |  54 ++++++++++
 Makefile                                    |   1 +
 convert.c                                   | 160 ++++++----------------------
 pkt-line.c                                  |  31 ++++++
 pkt-line.h                                  |  11 ++
 sub-process.c                               | 117 ++++++++++++++++++++
 sub-process.h                               |  46 ++++++++
 7 files changed, 290 insertions(+), 130 deletions(-)
 create mode 100644 Documentation/technical/api-sub-process.txt
 create mode 100644 sub-process.c
 create mode 100644 sub-process.h

-- 
2.12.0.gvfs.1.43.g876ba2a

