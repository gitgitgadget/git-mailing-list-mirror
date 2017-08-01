Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE7082047F
	for <e@80x24.org>; Tue,  1 Aug 2017 18:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbdHASYE (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 14:24:04 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35969 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752015AbdHASYD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 14:24:03 -0400
Received: by mail-pg0-f53.google.com with SMTP id v77so5438024pgb.3
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 11:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=uknDXauGvtmIODi9V4qVXH8FNtw6s8OVkMHkEKQLHC4=;
        b=a+vOobBLG7+7G1n7MR1LJVZ2ayLY9uCtWXl6IaiI5CChzzbdzqBzUoxU597ejw5oBV
         cd9Jle3EsP/KUUOnbresY/1/EClL9tfr1ZwSAkY96qMVy0sYTiburvE8ertcHi6FzSQo
         BWoK7c3LT9nDgZ0jLMlUJeyPi8BJyTXOhKpdeRDrOkrPdunimqZ/hPkokOi35lI2YzHv
         iyVfgcvZ5F9BkkPdNcw3Yj+slQyZu1O0OUUldUGJ/2ZPqXE7kWixtEvA8Lcth2CyKFqG
         cbsSgcSO0Lz+FGw0oGQlfR92l6wo8lhRqtqZQJfpmUWYeKZHuY3XYvfGgVV7fR1LVqau
         BvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=uknDXauGvtmIODi9V4qVXH8FNtw6s8OVkMHkEKQLHC4=;
        b=BAowti58gATfvdODZXqZTLekgnvy/5R9dZJF1M3AMb4zMB138maTxI4Gj3w0pD+Twj
         eT1t3+40WFO8lQPufdQlI9kbVjcufukoXjlGmTdIjbEyVDa+kxKuy5lIG/1Azrr4DMmZ
         E/ip+9WuvVGyekA7olUz4FYmj+Ci7WhcOJHg2pifOOZ2KLrgg4OUea64LYvDGTsD2U4V
         nJGBEzJRXDb1fzEz32GnEI9wv/R3qMknsnxWULjCY8kfMWqMgPnSCE1EVkPsCOoFpOKx
         NwILk3I6an4ripnD4R1UHqqjM48DllpgaXy8QVMSRIMZq2DQc8o6bk5mr6WpnAvDzbBI
         S1HQ==
X-Gm-Message-State: AIVw112VG+1XRbzVqSeOf7y8ynp7/wOXMvmVmP7/FWzkV22IcWEjVCiq
        1gU9+wV7KN2O05eQgRpeFrZp+nS0V6EpPuQ=
X-Received: by 10.84.146.140 with SMTP id g12mr12204934pla.80.1501611841977;
 Tue, 01 Aug 2017 11:24:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.132.193 with HTTP; Tue, 1 Aug 2017 11:24:01 -0700 (PDT)
From:   Anthony Sottile <asottile@umich.edu>
Date:   Tue, 1 Aug 2017 11:24:01 -0700
Message-ID: <CA+dzEBmsgUjmf5fUmeiwS=Q81OgpL6K5p=8dBuTjuZ4XE1V5SA@mail.gmail.com>
Subject: core.autocrlf=true causes `git apply` to fail on patch generated with
 `git diff-index HEAD --patch`
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's my minimal reproduction -- it's slightly far-fetched in that it
involves *committing crlf* and
then using `autocrlf=true` (commit lf, check out crlf).

```
#!/bin/bash
set -ex

rm -rf foo
git init foo
cd foo

# Commit crlf into repository
git config --local core.autocrlf false
python3 -c 'open("foo", "wb").write(b"1\r\n2\r\n")'
git add foo
git commit -m "Initial commit with crlf"

# Change whitespace mode to autocrlf, "commit lf, checkout crlf"
git config --local core.autocrlf true
python3 -c 'open("foo", "wb").write(b"1\r\n2\r\n\r\n\r\n\r\n")'

# Generate a patch, check it out, restore it
git diff --ignore-submodules --binary --no-color --no-ext-diff > patch
python3 -c 'print(open("patch", "rb").read())'
git checkout -- .
# I expect this to succeed, it fails
git apply patch
```

And here's the output:

```
+ rm -rf foo
+ git init foo
Initialized empty Git repository in /tmp/foo/.git/
+ cd foo
+ git config --local core.autocrlf false
+ python3 -c 'open("foo", "wb").write(b"1\r\n2\r\n")'
+ git add foo
+ git commit -m 'Initial commit with crlf'
[master (root-commit) 02d3246] Initial commit with crlf
 1 file changed, 2 insertions(+)
 create mode 100644 foo
+ git config --local core.autocrlf true
+ python3 -c 'open("foo", "wb").write(b"1\r\n2\r\n\r\n\r\n\r\n")'
+ git diff --ignore-submodules --binary --no-color --no-ext-diff
+ python3 -c 'print(open("patch", "rb").read())'
b'diff --git a/foo b/foo\nindex bd956ea..fbf7936 100644\n---
a/foo\n+++ b/foo\n@@ -1,2 +1,5 @@\n 1\r\n 2\r\n+\r\n+\r\n+\r\n'
+ git checkout -- .
+ git apply patch
patch:8: trailing whitespace.

patch:9: trailing whitespace.

patch:10: trailing whitespace.

error: patch failed: foo:1
error: foo: patch does not apply
```

I also tried with `git apply --ignore-whitespace`, but this causes the
line endings of the existing contents to be changed to *lf* (there may
be two bugs here?)

Thanks,

Anthony
