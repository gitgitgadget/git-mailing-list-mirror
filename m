Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BB0C433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 20:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiKAU4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 16:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKAUz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 16:55:58 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7101DA6E
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 13:55:56 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bp15so25049025lfb.13
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 13:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cPDNKeE4VzCc/eVkM7CocE0XoUqoA0JqDmFH2huoLsI=;
        b=kLoTG2P7PDX+YBHnCA+JDoEGev64YzSdvTsiw9RsSYgrhmqJy5QvKauIpdRvOQYy5k
         jJSnBlgMcC6ObX+BidpMwgQh6Keeg0aLq9ruxUnrQ87QVyL5/cInIxxHBH8+m+Chac0S
         +KSADRWyzsLjRIm8SOCSqWPQCM+BSN8pX16lD56Ws1mH8bLn6Zvk8oYxgPIDiu2KLB/m
         D0OGGjXC0dJhFltiwQSFjaMWIj7LO13RXQa0f+2TJxGsm4bpsPixzsBW2gQClUvdPNhz
         MiYAAYYxKCY8VwkmPLdFiPQ7U1UYUXD1dHgI7sw9UKjJC6qqaSJY/9GH04zNyAwXCLoL
         5KAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cPDNKeE4VzCc/eVkM7CocE0XoUqoA0JqDmFH2huoLsI=;
        b=ZLvTuvVEA7qerY7vqnW8rqXFPz2ks/6nuBOu7bFSn1ueG9m80c9SGkBgvQISdc341U
         RkIa8Z6lHcOBmjIo8ugwkCxu/szHYKUeq6v6YPTNkX3iDfQtaXUaALqJCupagkxhHgGw
         MUxVkR0wfDCluwAd9oJQ24LFc03H1Df9fzLSo4yiKWPQwOnwLoJwn94IFpTMay/w7tmJ
         QeOwxb/ScBPtvgS5mGD7MgwJBuk/qLqcMHqK3ygbUrNqW16Rl2t2eAvRS8E2C6c25qfH
         xWhOhOjGkZpA04o86xLPsWKGF15jFneNXVVWbJiVCh/eHXIImnMbdOp9PDA78dTv0A7X
         wbjg==
X-Gm-Message-State: ACrzQf1vus7Ybp6L89K9r/3BVou42izgJV/Ac1yMN/CQVScV9EJLwgs9
        skcXtufraBf/Tt9EoS09Kwff4kGqG+MZpjPXd6aYMaqz1sGmNA==
X-Google-Smtp-Source: AMsMyM5tfvzoILUqwVMlnoLGKb7I0DpEqPvpRlF++8ISuGxuTV9fIhpRqCCBhV9ERzzdspUX0qji/3/1+Dqb2QZOt7I=
X-Received: by 2002:a19:7009:0:b0:4b1:11a3:789e with SMTP id
 h9-20020a197009000000b004b111a3789emr1383977lfc.39.1667336154804; Tue, 01 Nov
 2022 13:55:54 -0700 (PDT)
MIME-Version: 1.0
From:   Anthony Sottile <asottile@umich.edu>
Date:   Tue, 1 Nov 2022 16:55:42 -0400
Message-ID: <CA+dzEB=acvDob10gCaWBgVcd3E5VEX+chTKsvxZ3VAUh4Dhrow@mail.gmail.com>
Subject: smudge filters do not round trip through `git diff` / `git apply`
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

this is boiled down from a larger problem outlined here:
https://github.com/pre-commit/pre-commit/issues/776

I've had some time to sit down and poke at this today -- here's my
minimal reproduction using just `git` and `git-crypt` -- though my
users have reported this also seems to affect other smudge filters.

I understand `git-crypt` is not associated with the git project,
however it was an easy, readily-available smudge filter to demonstrate
the problem.  I'm using git-crypt 0.6.0 (from ubuntu 22.04).

(the key material below is not sensitive -- I generated it afresh in a
docker container)

```bash
#!/usr/bin/env bash
set -euxo pipefail

rm -rf repo

git --version
git init --quiet repo -b main
cd repo
git commit --allow-empty -m 'Initial empty commit'

# determinstic git-crypt key so the output is stable
base64 -d > keyfile <<EOF
AEdJVENSWVBUS0VZAAAAAgAAAAAAAAABAAAABAAAAAAAAAADAAAAIIBi0O4iuCHghpYj4Teb6F72
KjTRHePBTf/6XC6fiVqvAAAABQAAAECTwWTDHfx0/Ytw3IZrVhonb5IPTr7kio27u0prnb8X25ui
9k4UqrdRQy8ZtBERv6wnHwC8A6q7CamRZ22L4q7UAAAAAA==
EOF
git-crypt unlock keyfile

echo 'f filter=git-crypt diff=git-crypt' > .gitattributes
git add .gitattributes
echo 'hello world' > f
git add f
rm f && touch f

tree="$(git write-tree)"
! git diff-index \
    --ignore-submodules \
    --binary \
    --exit-code \
    --no-color \
    --no-ext-diff \
    --no-textconv \
    "$tree" -- > patch

git checkout -- .
git apply patch || (echo FAILED && cat patch && exit 1)
```

here's my output:

```console
$ bash t.sh
+ rm -rf repo
+ git --version
git version 2.38.1.381.gc03801e19c
+ git init --quiet repo -b main
+ cd repo
+ git commit --allow-empty -m 'Initial empty commit'
[main (root-commit) 97d9520] Initial empty commit
+ base64 -d
+ git-crypt unlock keyfile
+ echo 'f filter=git-crypt diff=git-crypt'
+ git add .gitattributes
+ echo 'hello world'
+ git add f
+ rm f
+ touch f
++ git write-tree
+ tree=beca08f8b3c0774060f3e28e081ac69a80a1a10d
+ git diff-index --ignore-submodules --binary --exit-code --no-color
--no-ext-diff --no-textconv beca08f8b3c0774060f3e28e081ac69a80a1a10d
--
+ git checkout -- .
+ git apply patch
error: binary patch to 'f' creates incorrect result (expecting
2f89279ce748725a41cec60d5025b22efc863b42, got
e69de29bb2d1d6434b8b29ae775ad8c2e48c5391)
error: f: patch does not apply
+ echo FAILED
FAILED
+ cat patch
diff --git a/f b/f
index ee7d1b67cd31482ae9bc772a0b2d016c81e1c613..2f89279ce748725a41cec60d5025b22efc863b42
100644
GIT binary patch
literal 0
HcmV?d00001

literal 34
qcmZQ@_Y83kiVO&0IB9<_f2(d}=e+;CXFaaIzZ@c>%yE8!<X-^jJPz&v

+ exit 1
```

I traced through the execution and it appears that smudge filters are
maybe still running despite the `--no-textconv` setting which may
explain this?

```
+ GIT_TRACE=2
+ git diff-index --ignore-submodules --binary --exit-code --no-color
--no-ext-diff --no-textconv beca08f8b3c0774060f3e28e081ac69a80a1a10d
--
20:40:21.551771 git.c:455               trace: built-in: git
diff-index --ignore-submodules --binary --exit-code --no-color
--no-ext-diff --no-textconv beca08f8b3c0774060f3e28e081ac69a80a1a10d
--
20:40:21.552190 run-command.c:668       trace: run_command: '"git-crypt" clean'
20:40:21.555249 git.c:455               trace: built-in: git rev-parse --git-dir
```

as shown in the output I'm using the current primary branch revision
of git -- though I usually use 2.34.1 (ubuntu 22.04)

oddly enough, using `--textconv` instead of `--no-textconv` "fixes" --
but is unsatisfactory for my use case (I don't want to rely on the
state of filters installed, etc.)

the error message seems to occur due to the comparison of the hash in
the `index a...b` line above the patch hunk

`e69de29bb2d1d6434b8b29ae775ad8c2e48c5391` is the hash of an empty file:

```console
$ git hash-object -w /dev/null
e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
```

`2f89279ce748725a41cec60d5025b22efc863b42` appears to be the hash of
the smudged empty file (I used base64 here since it's binary nonsense
-- I got the contents of this blob by committing the empty file and
then fished the object out of the git database instead of trying to do
the patch dance):

```console
$ base64 -d <<< 'AEdJVENSWVBUAGoDwWO5GXWQ4B1kIQ==' | git hash-object
-w /dev/stdin
2f89279ce748725a41cec60d5025b22efc863b42
```

I *believe* the fix here is to avoid smudging in `git diff
--no-textconv` -- I started a patch where I added a `HASH_NO_TEXTCONV`
flag to `cache.h` but wasn't super sure on where to go from there and
decided I should ask first whether this is the right approach to take!

anthony
