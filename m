Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F22351F404
	for <e@80x24.org>; Fri,  2 Feb 2018 22:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751792AbeBBWgj (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 17:36:39 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43116 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbeBBWgi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 17:36:38 -0500
Received: by mail-pf0-f194.google.com with SMTP id y26so18038534pfi.10
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 14:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nOALoN+Kagh7eBzDKnWE+QiXnLCoYgPJj3vzzJJvsFU=;
        b=JDb7Vko+mlJwU+ye1nFTRQHRk//NKS1u1Tgsa65bSNU9dukKALtdAhhgEe0foMkyDl
         vzk9jWeA1dADSXtumbsp8/zdsrwXTBW/n5VH4TqfKS1UW/hvSMl+gl8TA3ROCEy6THpw
         1DWwyal/p9mHOm80SSXq0N1P5NHKWTgwJ6DW7loDHZHm/q7Q3aqBlY0PraZc6vhpLHlN
         oDLZ1XHHZeMFC50IZhHQI3aaZjxMFvs+WzP+3wCZqVsbh+xfiHqsfM260d8SS0p4exck
         xWPrsgaLKW9sAU+mkARfwznpqebcNM50A8ajRIps68SJ8ko/3LpNJdJG2Lb4NfYnQUuI
         HRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nOALoN+Kagh7eBzDKnWE+QiXnLCoYgPJj3vzzJJvsFU=;
        b=ZsRkNf8wgAMQ5Gfr1EQaPODn2+h2HWXhk7Hy/yrXcr1DlllUZ8a6LGkXkIEvBs28im
         TObZnBEgSpDWEW2c9Ifh8q53EYZWOF9S3O3phQr1Zhp2IST9c3Q3pBC0FO6q8KyJqAxO
         POAKEDypqjj2Tm85p0n5ywNTNuIS5HVmTE8r5TdSOVBuxnvwTIFN+dNwyIch+Iiell/2
         rt5AqQRRgpjxSV7GGo5YKBpU5jf4Rgs0Pu+Dcb6yOEIdT9RsyBVDmIX6hDPwbCB3IyAW
         ARUw3ApRgxxepTHPZDbE/7/e/dvPPu5FxuZTB4c3x1QJ56te5SuDvoejmZ5hi7I2f9MB
         jN1w==
X-Gm-Message-State: AKwxytfGTLOCGX0OYg0H+kCcj8rbdCr9WRj6Y5a+m61obtdlJAm2RIFS
        +0/L7jsGpvCwMW5k1NfH32DO8TvGmwc=
X-Google-Smtp-Source: AH8x226OwTJxNM0lEBb+0iOKycGheR7QOKDAnkCeykDWNqSBEHiY4Vt3qVkeau7ZYBg0V0XOdsNdXw==
X-Received: by 10.98.196.13 with SMTP id y13mr698163pff.73.1517610997966;
        Fri, 02 Feb 2018 14:36:37 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id b81sm5878168pfm.25.2018.02.02.14.36.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Feb 2018 14:36:37 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com
Subject: [PATCH 0/2] Refactor hash search with fanout table
Date:   Fri,  2 Feb 2018 14:36:29 -0800
Message-Id: <cover.1517609773.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.15.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After reviewing Derrick's Serialized Git Commit Graph patches [1], I
noticed that "[PATCH v2 11/14] commit: integrate commit graph with
commit parsing" contains (in bsearch_graph) a repeat of some packfile
functionality. Here is a pack that refactors that functionality out.

Derrick, consider incorporating these patches in your next reroll.

[1] https://public-inbox.org/git/1517348383-112294-1-git-send-email-dstolee@microsoft.com/

Jonathan Tan (2):
  packfile: remove GIT_DEBUG_LOOKUP log statements
  packfile: refactor hash search with fanout table

 packfile.c    | 30 +++++-------------------------
 sha1-lookup.c | 24 ++++++++++++++++++++++++
 sha1-lookup.h | 21 +++++++++++++++++++++
 3 files changed, 50 insertions(+), 25 deletions(-)

-- 
2.16.0.rc1.238.g530d649a79-goog

