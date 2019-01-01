Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E06D1F770
	for <e@80x24.org>; Tue,  1 Jan 2019 23:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfAAXSC (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Jan 2019 18:18:02 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:40218 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfAAXSC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jan 2019 18:18:02 -0500
Received: by mail-wm1-f44.google.com with SMTP id f188so26327114wmf.5
        for <git@vger.kernel.org>; Tue, 01 Jan 2019 15:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=RfA1X/qpSJqLyB3JkF0SuGR/zJ4aqC8+ghqNOI2frAY=;
        b=iMt1kZE7p09g0IerirTa1blYHO1p4sd7fJUmv16JHH+NIPnm1LHXYRNA1zMSQKJlR6
         M+5PNYfGBHX2r/rRQzZc3w8+5QRAIVa3b6mNtcuxF7zwBP8e0xQXNc5/I8C6oXqIMTg1
         iB0IA4KPI/YirdNXetnwMe9ZwU+VNKWZA9zrFjOlAAc76FKcBimQAdoqr8Qh0ErcUTk5
         jubxuA9BAo9PCpB6Nih3T+gGXo9GtyDfjQShDUWN+x9ufG9PW7s0SBhyEW383tTdu6Lf
         57Y6bCLEraKKEBenyvJJaflmFZr0hIlLHvoewD5Wbcl35QpoSVWq2Jj2MicLb6+SBOwD
         Z3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RfA1X/qpSJqLyB3JkF0SuGR/zJ4aqC8+ghqNOI2frAY=;
        b=FYSKXvzPKyXA537l67iBfHlAcGWEexT3JZ/hRI6WCN2rOYYLBHxKJu8NqiZPI4BCLl
         HDCs6d/iyUMhfSEYU8Xtw5DGlrMA9goACXMJXFtcNmNWEPWf/VZ0+EiAzEuMk20Bs/V5
         Zaf5XqZIFPLQRCD5NHdKdi9H8F8Vc983wnqlKA7dHKtzbOntDbzTiy0acmAoK+5pCXcv
         yoLTcxHQ2f8g3aocOGutKWjrBBBw15h33ilyJlCfa6CZBF7mrqa3BxP+hSsJDYQPaji1
         0ygZko4/rOzMJzuXM9UzZ/JjUMGkNpJRozsneYFKQlojQwyHG8jmYKzQAc2qQS1P+chG
         V8Ow==
X-Gm-Message-State: AA+aEWa87VDu+JUC40IcTEPg/Hkdq4UNSlJKnYpBixJMFZLxPDq2CAow
        z7rzthf9GIGZe8GdYJFQ7j9M4BqMOnYlyYCOriYmzpId
X-Google-Smtp-Source: ALg8bN7rfRLYM38qiXriM+olWhToN6S2bda+hU4iX/uKY7PGXhJCcZ3KKK/oQwHrfBedJ/SSl9naaFwZu54XPR+pHJs=
X-Received: by 2002:a1c:8791:: with SMTP id j139mr32859618wmd.86.1546384680283;
 Tue, 01 Jan 2019 15:18:00 -0800 (PST)
MIME-Version: 1.0
From:   Anthony Sottile <asottile@umich.edu>
Date:   Tue, 1 Jan 2019 15:17:49 -0800
Message-ID: <CA+dzEB=DH0irkFaRzkKERSjdZ=EJ+mG3Ri2Xeobx9Yu_eDd+jg@mail.gmail.com>
Subject: Regression `git checkout $rev -b branch` while in a `--no-checkout`
 clone does not check out files
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a simple regression test -- haven't had time to bisect this

```
#!/usr/bin/env bash
set -euxo pipefail

rm -rf src dest

git --version

git init src
echo hi > src/a
git -C src add .
git -C src commit -m "initial commit"
rev="$(git -C src rev-parse HEAD)"

git clone --no-checkout src dest
git -C dest checkout "$rev" -b branch
test -f dest/a

: 'SUCCESS!'
```

With git 2.17.1

```
+ set -euo pipefail
+ rm -rf src dest
+ git --version
git version 2.17.1
+ git init src
Initialized empty Git repository in /tmp/t/src/.git/
+ echo hi
+ git -C src add .
+ git -C src commit -m 'initial commit'
[master (root-commit) 61ae2ae] initial commit
 1 file changed, 1 insertion(+)
 create mode 100644 a
++ git -C src rev-parse HEAD
+ rev=61ae2ae9c9a96de7b1688b095f20a6adf9c20db1
+ git clone --no-checkout src dest
Cloning into 'dest'...
done.
+ git -C dest checkout 61ae2ae9c9a96de7b1688b095f20a6adf9c20db1 -b branch
Switched to a new branch 'branch'
+ test -f dest/a
+ : 'SUCCESS!'
```

With git 2.20.GIT (b21ebb671bb7dea8d342225f0d66c41f4e54d5ca)

```
+ set -euo pipefail
+ rm -rf src dest
+ git --version
git version 2.20.GIT
+ git init src
Initialized empty Git repository in /tmp/t/src/.git/
+ echo hi
+ git -C src add .
+ git -C src commit -m 'initial commit'
[master (root-commit) df4d6dc] initial commit
 1 file changed, 1 insertion(+)
 create mode 100644 a
++ git -C src rev-parse HEAD
+ rev=df4d6dcf02b15bfe2b3f0e4a8aa25ac165b1368c
+ git clone --no-checkout src dest
Cloning into 'dest'...
done.
+ git -C dest checkout df4d6dcf02b15bfe2b3f0e4a8aa25ac165b1368c -b branch
D    a
Switched to a new branch 'branch'
+ test -f dest/a
```

A workaround for my use case is to not use `--no-checkout`, though
this is potentially slow

Anthony
