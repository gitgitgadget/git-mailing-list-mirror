Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9665720966
	for <e@80x24.org>; Fri,  7 Apr 2017 12:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933473AbdDGMEU (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 08:04:20 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:35029 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933147AbdDGMEN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 08:04:13 -0400
Received: by mail-yb0-f193.google.com with SMTP id k6so2382955ybk.2
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 05:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KyyZLCWDrXvxrsdmaS01sMFPkCup5J2tNWBt1pK30i8=;
        b=RUUCTrQaWTAvqcyphV+hnNbxvpj10aZ3dngZMCHK4WJsL4d/JH1Ao54TgxunOEiYdd
         7/s9f463TYBHXweA2qA24i9MIEFOBTXFZe6XY+CXo7g194NEwpukOvPEyyCtvL/zVTn7
         TaXAS/sKNnES8bImxlccGUYmoikEyO3WfzKzahTmC1b3qDhh0u4aKNtlIE1lkEQW/vCl
         o19cwfppJlrUmvPgZ9S1AohRodKl3csUpL/JwqZWza7o7fG3Pj4VaWLYMSp/Ctxtwfvm
         2B30rE/cTadJPX477gAbrgiDwxrbUvVBsJgNU7LWpgtCalgzjZ86YGNyN6JpWXF8div9
         xXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KyyZLCWDrXvxrsdmaS01sMFPkCup5J2tNWBt1pK30i8=;
        b=aZgH7Mj02veWqMwcvy2qf2fvl4mFNIKUKvesfzWgRYQfsY4SQWEXC/JW8prtHHGORq
         TD8K8LOOR74OYUcnHaF6J5CCngTp1e93GmIKF/nDM9zWltVwvFsMhn1L6eq4qjygP6Nd
         zsY93xmeBsGK/jpZrn0UPDabXZZDFOzZRfIOEoT10S2pMhROzNSrc1s/JwTl7oagdhPl
         DZzMgumwTaXyE3uYHgNAyYn43kG5+BsDiMWvZa+pWcisAKMgXsWHhNNWALgjHT0wIT8p
         xpMV5XlBP5PksXHN4n3b/PdUp2LgScMJCJL4yxiiz/ipuJqpqa2q/1eli/ZWw19FvTbF
         FVxQ==
X-Gm-Message-State: AFeK/H32eSPc/9Nz570Q3xoi19NzVqvmNbu+xKBQQvbOeTwUEi8KVwTCj6fHpwHH6Yg8yw==
X-Received: by 10.37.42.205 with SMTP id q196mr25242956ybq.49.1491566652125;
        Fri, 07 Apr 2017 05:04:12 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id z194sm1874038ywg.73.2017.04.07.05.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Apr 2017 05:04:11 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v5 0/8] refactor the filter process code into a reusable module
Date:   Fri,  7 Apr 2017 08:03:46 -0400
Message-Id: <20170407120354.17736-1-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.0.windows.1.33.g243d9b384c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hopefully final spin.  Updates patch 6 to rename additional instances
of "filter" in comment and error messages.

Refactor the filter.<driver>.process code into a separate sub-process
module that can be used to reduce the cost of starting up a sub-process
for multiple commands.  It does this by keeping the external process
running and processing all commands by communicating over standard input
and standard output using the packet format (pkt-line) based protocol.
Full documentation is in Documentation/technical/api-sub-process.txt.

This code is refactored from:

	Commit edcc85814c ("convert: add filter.<driver>.process option", 2016-10-16)
	keeps the external process running and processes all commands

Ben Peart (8):
  pkt-line: add packet_read_line_gently()
  convert: move packet_write_list() into pkt-line as packet_writel()
  convert: Split start_multi_file_filter into two separate functions
  convert: Separate generic structures and variables from the filter
    specific ones
  convert: Update generic functions to only use generic data structures
  convert: rename reusable sub-process functions
  sub-process: move sub-process functions into separate files
  convert: Update subprocess_read_status to not die on EOF

 Documentation/technical/api-sub-process.txt |  54 ++++++++++
 Makefile                                    |   1 +
 convert.c                                   | 159 +++++-----------------------
 pkt-line.c                                  |  31 ++++++
 pkt-line.h                                  |  11 ++
 sub-process.c                               | 120 +++++++++++++++++++++
 sub-process.h                               |  46 ++++++++
 7 files changed, 292 insertions(+), 130 deletions(-)
 create mode 100644 Documentation/technical/api-sub-process.txt
 create mode 100644 sub-process.c
 create mode 100644 sub-process.h

-- 
2.12.0.windows.1.31.g1548525701.dirty

