Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E3771FD99
	for <e@80x24.org>; Mon, 15 Aug 2016 01:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186AbcHOB3a (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 21:29:30 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:37095 "EHLO
	mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbcHOB33 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 21:29:29 -0400
Received: by mail-it0-f46.google.com with SMTP id f6so32643201ith.0
        for <git@vger.kernel.org>; Sun, 14 Aug 2016 18:29:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=barzilay-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=Az4KcDuP7MNcTSyyiXOXpSVi1CiQ4YigmpLviMbkz60=;
        b=PFgEipFa1nhkVGdNt2LmYAKq8Ld563z3s57j53QEb60kVHVo1Ubl5ff6yJyv47xYOx
         JmLofNlUdzL+7NBilZJZ3/PJn2tyiZET+p3MMp8+P7U2HnETbLLPinLd4dkZzINTVXGr
         ZGV7wmjlpoPwDprRd1rSstEhKgGBspL6eYOdnpqExOqaDDMZa5OJyp68FWLPZolXp/GR
         UcPBGEy3JOXeK+C239E2d5cR3roFWwR/XsjmMj4C1KSJm1a6DcLivW0jztseQlGweySW
         WGom7gvIgxdlSp39IyuHGus5NsY8E0MNn+fbN/bVDPaXy79MxyS4+91rD0300kEbJRto
         tKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Az4KcDuP7MNcTSyyiXOXpSVi1CiQ4YigmpLviMbkz60=;
        b=HQvbVGtv0EuYOPf4e2HBjoZWSWHspeEDVw0kMuQ/cfF6jk6dJ83KO4fSgYv/1YrCAM
         VBHQgiEc4ufcSdJPeQ1CdBImW2qI169Kp5NqBmcrl6c9SIDi0m7tX/vyNxy6Brrnhi57
         guUSyyrMnA2ElAyPzo/TTz8vIPuZU/Pf9YUJt3FQtF4eLGTBbBDgx9hc5GZRhgGyM9yu
         iFhHgNKfghJ5YLR5a8nn6S5uTbN7QE3S15l7jVBqQvQ0W9mf/isJSM1hxlvx6R5LM/ij
         LUYACK08fhHFDhP5Kh3KEkpd34e4iZ4JYBOLal5QF6I7YCuy0q/zNuAOIssfFwct6+my
         OWcQ==
X-Gm-Message-State: AEkoouuLWcA/trTt4aSIgy90pf9KYvyPJ56wxRlxMBK2e6l/3LodXzrpgmBCv11Tz3R1wfQj4AdUCuXpsK+QIQ==
X-Received: by 10.36.33.17 with SMTP id e17mr11493620ita.41.1471224568382;
 Sun, 14 Aug 2016 18:29:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.32.147 with HTTP; Sun, 14 Aug 2016 18:29:27 -0700 (PDT)
From:	Eli Barzilay <eli@barzilay.org>
Date:	Sun, 14 Aug 2016 21:29:27 -0400
Message-ID: <CALO-gutdz5VMgoRmbqEa9UiaTC+L2Sy2n-3AF+zfPr-X8+1U4A@mail.gmail.com>
Subject: Minor bug: git config ignores empty sections
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Looks like there's a problem with setting a config with an empty
section, making it create a new section.  The result is:

    $ git --version
    git version 2.9.2
    $ git init
    Initialized empty Git repository in /home/eli/t/.git/
    $ t() { git config x.y x; git config --unset x.y; }
    $ t;t;t
    $ grep -c '\[x\]' .git/config
    3
    $ git config x.z x
    $ t;t;t
    $ git config x.z x     # adds another [x], but leaves it populated
    $ t;t;t;t;t;t;t;t
    $ grep -c '\[x\]' .git/config
    4

-- 
                   ((x=>x(x))(x=>x(x)))                  Eli Barzilay:
                   http://barzilay.org/                  Maze is Life!
