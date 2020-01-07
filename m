Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C98CC33C99
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 11:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F2B2077B
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 11:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=brad-smith.co.uk header.i=@brad-smith.co.uk header.b="Zjcdxajy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgAGLZD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 06:25:03 -0500
Received: from mail-ua1-f51.google.com ([209.85.222.51]:34128 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgAGLZC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 06:25:02 -0500
Received: by mail-ua1-f51.google.com with SMTP id 1so18348380uao.1
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 03:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brad-smith.co.uk; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=x2ICBIARHNjC+obKXdSusrJGR5UodXl/5aqZZkYdhbQ=;
        b=ZjcdxajypJsrvvBgeuVGSR9BXyka+UG0HuwhQQANN9a+YAAPGnYuePO/MaSlHWkA4m
         LtGytX+aJt4WXXa+8+L7vO3wD+XpPK6xdkTj9JuoFx9QBvnvvYEAvcYBPlrjPIjoBPmq
         YLyD5oJLx9LPLMifn0EBJvgkKH0SK6Ud9Mp9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=x2ICBIARHNjC+obKXdSusrJGR5UodXl/5aqZZkYdhbQ=;
        b=iBJJ5T0pinjlcvyWdVEL/evh7VSBrQjEIngIORoIPJedBhGIHFtl1d977hMhwAwLGd
         8E0DSTA2Zi1mjj+sQoETFV54fi7B/zh5rXoWRJek64tZxV2e411k0eGfWVC3tdGISXkZ
         hd2w5eMSqoSwnzPre3HWY/MiOT3cg7bwsX2pbcC+D/dYJ0VTMF+nxcuhTZ3GLx1fAhtK
         FqeXnQTqEqgzBx/3nnvKPvtZ7bTSF/HLgHq7dHsFujLWLxA+W8z4lfOhHawt7Z2/FlWy
         tvGwGiQ5Fy4jx0//blgFIpKa9F4Yb87N1yZ99UZK+7GzhK1uw8N9JStxxj6Flgidqa8g
         I86w==
X-Gm-Message-State: APjAAAV3Q5KMgbXTQYqoxge1G/Js9GexHTw0SnZ2u/y0AjCVgFB9tW8V
        1nhlykyHDty6JaG05oTEuMazMQKnRTjCQP7O2uM73WWfXVA=
X-Google-Smtp-Source: APXvYqwLM+/QKbcnNQFslN0zjHhir5oeWQ1Ee98YXqgtaovWZxiobkpqszU5l9kUnjE86xU6/hkgtFP4wY2VVo4qHpw=
X-Received: by 2002:a9f:3e84:: with SMTP id x4mr61006595uai.83.1578396301589;
 Tue, 07 Jan 2020 03:25:01 -0800 (PST)
MIME-Version: 1.0
From:   Bradley Smith <brad@brad-smith.co.uk>
Date:   Tue, 7 Jan 2020 11:24:50 +0000
Message-ID: <CAHt=fUXTHc4JPsapvHKnw5vHhp2cBOYRNfdaSDWBUnKt8fWfeA@mail.gmail.com>
Subject: Assertion in git log graphing
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

The following git repository (https://github.com/brads55/git-testcase)
causes an assertion when running:

  $ git log --oneline --graph --all

  git-log: graph.c:1228: graph_output_collapsing_line: Assertion
`graph->mapping[i - 3] == target' failed.

The assertion seems to be caused by commit
0f0f389f12029b1c3745f8ed7aacfe6b2fc7a6cc. The graph structure of the
above repository is as follows (as produced by v2.24.1):

*   a0a130c Merge commit '8f076d8' into HEAD
|\
| | *   f0f3be5 Merge commit '1b4b8d0' into HEAD
| | |\
| | | * 1b4b8d0 6
| | * | 2c44f1b 2
| | | | *   dd068b4 Merge commit '8f076d8' into HEAD
| | | | |\
| |_|_|/ /
|/| | | /
| | |_|/
| |/| |
| * | | 8f076d8 5
| | |/
| |/|
* | | a261135 4
| |/
|/|
* | a267dd6 1
|/
* 68f4772 0

Regards,
Bradley Smith
