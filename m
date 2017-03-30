Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CADA20966
	for <e@80x24.org>; Thu, 30 Mar 2017 15:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933975AbdC3Pya (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 11:54:30 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35483 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933392AbdC3Py3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 11:54:29 -0400
Received: by mail-qk0-f195.google.com with SMTP id v5so2127599qkb.2
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 08:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IqbgqkQ/VOwQpYxmJiuMQhnZUTiEaHS1cSOrKYil3Yc=;
        b=F03h8G4lNZ7e2XV/umtIbFc+z38LxW10rLW3x1Xa3dN+oV+//OUqA/4XJQ92MuQuy0
         C36Bq+dLSTUowZASk6q80WigrVzMwv8Tl9+NTurMv95TCgsfsnfUsb6TRIf7aTXWQMA+
         7x0gZCGsww8onPiqgPBLut8s8HOp5WJlRBT57zcQDG1wfMfGhUOGHSVEyqRoy25sICR/
         tN1xvlVWBwM0qPlcYbc5gmgRc2o724siPG+LwSTGS8kO9flh2J20XqD2l6K5+fKh2gUW
         5BTvr1ATJJ6TJNJSC1ist9IR21J9i5fP2WaSShyDClmRTAYkI4Zg6UdbXQOKRz00Nwyh
         BG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IqbgqkQ/VOwQpYxmJiuMQhnZUTiEaHS1cSOrKYil3Yc=;
        b=JAeKnfvDiFK6t8x9/4mKxMFf0qFwNSZ2gPQUYluGNsKWNrvGFBlKSOldA7iFO/XUxM
         A2GWtId7hDJdjhALStMTSHJiJ0z7BQ0/8GeAsSGhdaKvUF2Up8t72iP7G6cZjWmYq/QJ
         PRDr61ewZXzO6aDv8aFfOXsnLkkMALkwCrP8x3SPibY25r5Ai4dIuvoaOr2Ix8I4KLZY
         UtfiyS3x+ypzID7DkkrL6bIYPwADT5UaBQ6xbIE3A3Ornaqjbk9EEP+UW+VbS9Cbu0Fn
         n0lKkaPckPayutiijFl1Zk4pXB+nV0LYkyCNCLz7EyZCMSpFsqzajiALi/WHMbcwDnln
         T3RQ==
X-Gm-Message-State: AFeK/H1lKtoxRQhb9SvWrlL2Nu5ROWlK2c+J6pbTMQiSrdtyifK+J3Osae2H9+ApuuMrxA==
X-Received: by 10.55.210.4 with SMTP id f4mr399908qkj.71.1490889267941;
        Thu, 30 Mar 2017 08:54:27 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id k5sm1665671qtb.12.2017.03.30.08.54.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Mar 2017 08:54:27 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v4 0/8] refactor the filter process code into a reusable module
Date:   Thu, 30 Mar 2017 11:54:08 -0400
Message-Id: <20170330155417.8928-1-benpeart@microsoft.com>
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
2.12.1.gvfs.1.18.ge47db72

