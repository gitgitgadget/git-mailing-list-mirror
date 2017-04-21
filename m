Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B4B0207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 18:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1041589AbdDUScF (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 14:32:05 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34865 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1041547AbdDUSb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 14:31:57 -0400
Received: by mail-qt0-f195.google.com with SMTP id o36so12937504qtb.2
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 11:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=y3fTTRmqTrzj/orzSglRjs4Ij/6/57I9H8Y0TfChTT8=;
        b=LfaSD12gNtvRcXxjkRXAH9i5CECJngixiMSKHzykptd3m2ca402xBAMfXuQC3hzeMZ
         UB48FWeGUOYv03qu3pyKnuRbyLPrqeOvyH5OX2C1rqG/HNqY5v6VTZD5yZeUZYIJyW9f
         Q2uVTD0IrglhqW6f11bIUqKSPMDiv24tce3scTNgzgcwBerWktlhjUnwgknMKCh0WH2B
         AKaN8pd1/JCa1vHD33IZ45pvhB/aQdeUTumBwqjktEXab5a1esGRgQY9uK/L/MBEJMi4
         FL4UPpSawKaBDS/Ts4OwBwl9usUpgsSUkgKOe3YT4PrI4fVJ/MuqvpN7elvbFn/w9xlT
         jq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y3fTTRmqTrzj/orzSglRjs4Ij/6/57I9H8Y0TfChTT8=;
        b=Y8Ntt1KflXoCLw3rFEZIoPA7WQ1twA6/lnirz6jhnBGi0ucJhM8pczGFNtNj3FTXsa
         h4xCkwY9c5n/mzA2XpmJps6S8kZN/K0kRDmrHEiJA7cfmSRAwgQXwnZ6PUQd94vxasTT
         zrBJQCypu4/o5028eJT51IDTE+VTfGxug0pjfACASqBI8pkZEe40U2mRzSA0xhOpnfL6
         EBbHtm9fy3glYaochKZZtdBjNha6vBXPhVSrcNLsqK2T5GWyWWxm+0orhQvR8gOVmTNu
         9ty3b5NVADGIRkE/GuLonocSvpfvcf6wo24M7E5m9WBCjOyk5nTckYXUfdwqoDjg8W2h
         tLFQ==
X-Gm-Message-State: AN3rC/40UQp/UbOCYvUUUO9t4XsvOQUSNeqD4lYrXkm6ba1eGEc/sZ6u
        c9T/L/mAd8fC1uyXkEA=
X-Received: by 10.200.54.237 with SMTP id b42mr14207257qtc.233.1492795596243;
        Fri, 21 Apr 2017 10:26:36 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id g66sm6700551qkb.55.2017.04.21.10.26.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Apr 2017 10:26:34 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v6 0/8] refactor the filter process code into a reusable module
Date:   Fri, 21 Apr 2017 13:26:03 -0400
Message-Id: <20170421172611.12152-1-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.0.windows.1.33.g243d9b384c
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
  pkt-line: add packet_read_line_gently()
  convert: move packet_write_list() into pkt-line as packet_writel()
  convert: Split start_multi_file_filter into two separate functions
  convert: Separate generic structures and variables from the filter
    specific ones
  convert: Update generic functions to only use generic data structures
  convert: rename reusable sub-process functions
  sub-process: move sub-process functions into separate files
  convert: Update subprocess_read_status to not die on EOF

 Documentation/technical/api-sub-process.txt |  59 ++++++++++
 Makefile                                    |   1 +
 convert.c                                   | 161 ++++++----------------------
 pkt-line.c                                  |  33 +++++-
 pkt-line.h                                  |  11 ++
 sub-process.c                               | 106 ++++++++++++++++++
 sub-process.h                               |  49 +++++++++
 7 files changed, 291 insertions(+), 129 deletions(-)
 create mode 100644 Documentation/technical/api-sub-process.txt
 create mode 100644 sub-process.c
 create mode 100644 sub-process.h

-- 
2.12.0.windows.1.33.g243d9b384c

