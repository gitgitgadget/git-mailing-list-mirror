Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05E84201A4
	for <e@80x24.org>; Fri, 12 May 2017 05:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754967AbdELFEF (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 01:04:05 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35432 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbdELFEE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 01:04:04 -0400
Received: by mail-pf0-f177.google.com with SMTP id n23so19375781pfb.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 22:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=SBXj3HBiKYWFKBsc/gjVPGu40EEJyG441sJvVevI+Ek=;
        b=Yp6N7zIWV1s7ycskfvwgCA2XRJJJzPyaFKbaQSASgb/6rsBDy9S5FDyqT0AQliFegW
         Cy2giGYfc4Nzwg+SYxCs9PZkR1zlTzYTgKsQ596/pKD6HHleIggaC9cioFortFwNph0w
         A92oJ4Z/mNlcHq1+bEOAaJd+YoVouQkyd0dHTBBan0CICD9lTYyhA8e0oYS6DXy/5m9q
         jgDLGpdx3nyMP4zCYfec+kj8l/oWe8k7FFLkUqQZwr2awV1o3Cj5B7Nvwju8+JB6wVPU
         scG5Xkb89l5ptoHr9U5xoqbtm35tiZjofEJPjDJUsqjMEXGjMg1Up2xQkXd7RYMal5Ch
         r/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=SBXj3HBiKYWFKBsc/gjVPGu40EEJyG441sJvVevI+Ek=;
        b=iJqEtCF0y09vC3emETerBsHxoraAobGY+koOXOGlm56sLutToptDwylnQ/y515V6Iv
         WHjTOJ2bWTmM/ZvQXEL2Of+jMXYFN499dteYwh/c+htTlgl2rkwg83dUW9j0ChH7RCEM
         31R9IwkSCwcMMHH5z6AcrK9l68LP6al+P3a+Wx6P/ewNfSYrgHzQU7/SPwer1tODSM4K
         6mC6K/fmRvA9REVOYqyqYcAOuOr6X9yFL0x8e3gexvIPEZc3JHIek7jAtPJZ0cjGW5Uo
         x4Zq1cWKtyRmBgwFJIuyUTQjD9mD9s9W1bFklddTv6B4fP0jayY+T1woJgkWTQ8KnLDZ
         smlg==
X-Gm-Message-State: AODbwcC3RSDcbpI+sXlZTFawic1uJea++i5rpk4Swl1DDsDMoK/6l0wD
        WZL5Uu2u7bRe92REfjg=
X-Received: by 10.98.36.22 with SMTP id r22mr2437376pfj.25.1494565443272;
        Thu, 11 May 2017 22:04:03 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:3:1ec0:ad55:5f17:47e6:6202])
        by smtp.gmail.com with ESMTPSA id p3sm2747654pgd.36.2017.05.11.22.04.01
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 May 2017 22:04:02 -0700 (PDT)
From:   Brian Malehorn <bmalehorn@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/3] interpret-trailers + commit -v bugfix
Date:   Thu, 11 May 2017 22:03:44 -0700
Message-Id: <20170512050347.30765-1-bmalehorn@gmail.com>
X-Mailer: git-send-email 2.12.3.3.g39c96af
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi all,

This patch series addresses a bug in interpret-trailers. If the commit
that is being editted is "verbose", it will contain a scissors string
("-- >8 --") and a diff. interpret-trailers doesn't interpret the
scissors and therefore places trailer information after the diff. A
simple reproduction is:

	git config commit.verbose true
	GIT_EDITOR='git interpret-trailers --in-place --trailer Acked-by:me' \
		git commit --amend

This patch series fixes the issue by obeying scissors when computing
trailers location.

P.S. This is my first patch series to the git mailing list, to feel free
to point out any mistakes I made when submitting.

 commit.c                      | 65 ++++++++++++++++++++++++++++++++++++++++---
 commit.h                      |  1 +
 mailinfo.c                    | 53 +----------------------------------
 t/t7513-interpret-trailers.sh | 17 +++++++++++
 4 files changed, 80 insertions(+), 56 deletions(-)
