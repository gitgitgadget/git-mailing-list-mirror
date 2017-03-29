Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E9CD20958
	for <e@80x24.org>; Wed, 29 Mar 2017 15:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932153AbdC2Pxp (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 11:53:45 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33133 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752609AbdC2Pxo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 11:53:44 -0400
Received: by mail-qk0-f193.google.com with SMTP id p22so2587895qka.0
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 08:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Cj1TpgH3SurDSxv9g8z9eXoWP5mH4LB24RVVJwJ8fFY=;
        b=I0ihA/xWWFesd5TRmKQBzu/sId1J14T9nhAZoH2S/s6V3O8bgGIu8zxYjG4g5ZLH2l
         Y0+a/T9iswce48Sjk0hMVtPc8Y9X9jEE54bXwp8gp1IA5ifbB3vXU/HzV0I+rncgQXcr
         NbGwIcOHDgTA4LFHs+q3pJQMDwuNEgDYozrk3ugzTIsYks5Ye7tNIn0daY8B4/v6H7/y
         04W2gW2Lg4LALL3Qm8K+Q7iC/xM35d6Ekhfy3IqtuqX4wjYWmpGO5aF9Ty3kNnjSDS9T
         8+bij0UBLfi9ZLukKMJxieOTRf6nbkXg1kBQFJ9Wv3d22LzEvwaNSF2hN1bub9Gei77a
         8J/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Cj1TpgH3SurDSxv9g8z9eXoWP5mH4LB24RVVJwJ8fFY=;
        b=KJc1yNKF0lkAzUzJgxDxazJD/3Hfc2vfbOl3sLKw/ZwlL1wuhEAwAyNYqhlZcGIpOD
         yTBgHHMiHgV3s4fg6nHEZaEF4F9xkK2Nqvi/v49gk4Hag2IucsC5SIFwpefj2hdMF2Rp
         FrEAzGIPdr031HfLs+w34AukojLD/fJasQLR4klTrOspnmzlYByOPW1VbGCQ8eXVgQrY
         xOx3eC6YjskYPcIoyPX1v04Bbkx7Haelj9m7F2ummsxAJYCvtvpMa8/zrZOqK6MWyRsm
         h48vBk5Aehc+J+inEsAKXq5esVXGrPyxufbJEtrz2Pf9m6QnujHeqUwZhuZ1q5BWSvmD
         B7VQ==
X-Gm-Message-State: AFeK/H2qimR0reVpx+dztwTYDhrlWmWfeTf75aeQicpJAyMDMnsbduq1cwjG80wduei0rw==
X-Received: by 10.55.27.137 with SMTP id m9mr1153106qkh.224.1490802822669;
        Wed, 29 Mar 2017 08:53:42 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id o92sm5148566qkh.48.2017.03.29.08.53.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 08:53:42 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v3 0/8] refactor the filter process code into a reusable module
Date:   Wed, 29 Mar 2017 11:53:22 -0400
Message-Id: <20170329155330.12860-1-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.1.gvfs.1.18.ge47db72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
  pkt-line: add packet_writel() and packet_read_line_gently()
  convert: Update convert to use new packet_writel() function
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
2.12.1.gvfs.1.18.ge47db72

