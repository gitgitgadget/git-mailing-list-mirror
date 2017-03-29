Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8642220958
	for <e@80x24.org>; Wed, 29 Mar 2017 15:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752942AbdC2PvG (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 11:51:06 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36346 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752805AbdC2PvD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 11:51:03 -0400
Received: by mail-qk0-f193.google.com with SMTP id r142so2576179qke.3
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 08:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Cj1TpgH3SurDSxv9g8z9eXoWP5mH4LB24RVVJwJ8fFY=;
        b=eV3V9wqZJl1HepHInjDNT11XuZuK154JYr6oVmjP7R08Nes6ANKSjVpl+50T+xGfYL
         1Cak1CyQDyVhNN12ADTMcykaLqHj85KwLCxwmncI+pXjfEX4arBuaTm0qKUZTHL9c7h5
         7rHaMylQPzgtJtyxw0zNAih+m85vsYThOooueVz2sYsRP293BYUa/5C93ZXCjVHYK34S
         DIblVLvX5HXAAZUqWVEfqf+336LG9kzI+/C2GtzYgIbLIfODwdRK3VXRupdqg8u7W3qE
         ljYKKnz32gJpHyFsdShTxLwBm7GOYssSSFKIXnMx1xvseVohvcwm3dPn5JoF0KSCXeZC
         HA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Cj1TpgH3SurDSxv9g8z9eXoWP5mH4LB24RVVJwJ8fFY=;
        b=bQ5uaO1Q3UK1O2NY9MQdyRfq7gWibmIqmGwD1ZJpLSkoewuuUdU8+OyZM8ESe9uxys
         dlSqSAltlhbZQ0Zk1zFGTMJtkUcHJmz5KUP6Bb4MEg+d3r7FBUaAHEOKCQkjmYuLufSI
         hYN+Do6+FxaXloIeWx4yRWcwa74bXS3x7ZSvKjKHbQi4USy6LfYxVe0VG2LNPSmgWPzv
         gFNmB43YnuvmxZndg0K01NbPE/bga3IfWCtt3MXCaOwMRF66OHZbHyJKhrqqaHjQx3pJ
         k0BvVJtFIMxJl0WgE8KhzTRkBLvnd9lokGQcNgNWGxnefJ6SElu4awy7KmXCnvU0dSip
         ZSjg==
X-Gm-Message-State: AFeK/H3JzDNcAGArCygk0SNp2YN+21ayCn+dI4Tg8KwO3H51GG+txYrOnKRjr1Z8ah6YRw==
X-Received: by 10.55.110.129 with SMTP id j123mr1124353qkc.309.1490802657186;
        Wed, 29 Mar 2017 08:50:57 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id p19sm5162760qtp.36.2017.03.29.08.50.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 08:50:56 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     benpeart@microsoft.com, christian.couder@gmail.com,
        larsxschneider@gmail.com
Subject: [PATCH v3 0/8] refactor the filter process code into a reusable module
Date:   Wed, 29 Mar 2017 11:50:32 -0400
Message-Id: <20170329155040.31224-1-benpeart@microsoft.com>
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

