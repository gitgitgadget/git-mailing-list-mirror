Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58F701F4FF
	for <e@80x24.org>; Tue, 20 Sep 2016 17:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755019AbcITRSC (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 13:18:02 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34064 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754694AbcITRSB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 13:18:01 -0400
Received: by mail-pf0-f172.google.com with SMTP id p64so9404355pfb.1
        for <git@vger.kernel.org>; Tue, 20 Sep 2016 10:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PO98Fb60QN4kWCvkh2s19Ix6dBr2g8omwmcqjAIby7g=;
        b=PbNcT3ORZGJKApjFUG5YpYSnsDrT4BKjEvrswTMC9gg9AZAO8vUTR8rObvTMIAzI28
         dd++/xTgQhIROH/FsmORP8NJJhR41cEjoe4TcJsAF0hUPoWEbanmXn/+UR3DERDbxVdc
         2spsQdbWXE3lkerC5nVabxf6W2XG1D/Z0Sjg29K/bYF1at3xB8ZdW4YsVKycZVA5fw1Y
         3Qk/lzUnGcm/o1pOTGGYEPaiCQmdXigPVOknIrDXsU6MpF1bmwTlbyt+844F5Jx15qii
         aEmUq0DOSvxU3OPKHqV1FMdpx+3+OPJL5itzqBDUQZmrrfvMMYk7T61xg5vX7g7Kq3xH
         tEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PO98Fb60QN4kWCvkh2s19Ix6dBr2g8omwmcqjAIby7g=;
        b=RTyJS0iT8w01KaagDw14vtWNOqnjv5sVfXt3FehETb1Yp3LMmm1QFk+xEEZw7x7gJE
         ftW2vVqJrUGkJiAoeHrbYvw27VBxZTQcQW8ybVwerp5W9tR4LE2fcmmDpOlTmZMxBsOb
         LAAUjHIc875yCeD2fW/Kc44NTSFcHcbJ8juNjAC7qvcfuL3GgRir/6NK5p4JascQPKLQ
         QNGibA12AusGo1kNCWYOJI263n0xIT+iboipei+g6NCJdHl8VZefdxV+3J3N9CKOVuNG
         3vBGOLWtByDksAV5gKXUkPYSDYGNQVwP/Gmxc2Zdg5cnu37mgs0n0b9LPiPhwzYEC3LR
         iaRA==
X-Gm-Message-State: AE9vXwMI3VUCTX0MalXmQtP4UkpWO9YyqsTv2smzimHs1XdX8cP2QoFX7FMO+LrjnqZ2jEXZ
X-Received: by 10.98.77.70 with SMTP id a67mr56351423pfb.151.1474391880308;
        Tue, 20 Sep 2016 10:18:00 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id x9sm80586932pfd.70.2016.09.20.10.17.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Sep 2016 10:17:58 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 0/3] handle multiline in-body headers
Date:   Tue, 20 Sep 2016 10:17:50 -0700
Message-Id: <cover.1474391594.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.10.0.rc2.20.g5b18e70
In-Reply-To: <cover.1474319086.git.jonathantanmy@google.com>
References: <cover.1474319086.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2:
o Removed utf8 translation before scissors line check in
  check_inbody_header (I was thinking of support for encodings like
  UTF-16, but I guess those don't work with the current reencode_string
  anyway since it uses strlen internally)

With the above change, it is actually no longer necessary to make
is_scissors_line take plain char * (the second patch) - I think that
that patch still improves the code, but let me know if you want me to
remove it from this patch set.

Jonathan Tan (3):
  mailinfo: separate in-body header processing
  mailinfo: make is_scissors_line take plain char *
  mailinfo: handle in-body header continuations

 mailinfo.c                           | 116 +++++++++++++++++++++++++----------
 mailinfo.h                           |   1 +
 t/t4150-am.sh                        |  23 +++++++
 t/t5100-mailinfo.sh                  |   2 +-
 t/t5100/info0018                     |   5 ++
 t/t5100/info0018--no-inbody-headers  |   5 ++
 t/t5100/msg0015                      |   2 -
 t/t5100/msg0018                      |   2 +
 t/t5100/msg0018--no-inbody-headers   |   8 +++
 t/t5100/patch0018                    |   6 ++
 t/t5100/patch0018--no-inbody-headers |   6 ++
 t/t5100/sample.mbox                  |  19 ++++++
 12 files changed, 159 insertions(+), 36 deletions(-)
 create mode 100644 t/t5100/info0018
 create mode 100644 t/t5100/info0018--no-inbody-headers
 create mode 100644 t/t5100/msg0018
 create mode 100644 t/t5100/msg0018--no-inbody-headers
 create mode 100644 t/t5100/patch0018
 create mode 100644 t/t5100/patch0018--no-inbody-headers

-- 
2.10.0.rc2.20.g5b18e70

