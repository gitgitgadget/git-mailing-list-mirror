Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EBFC00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 13:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245342AbiHRN4M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 09:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245500AbiHRNzr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 09:55:47 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2E55788D
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 06:54:50 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso2119376pjh.5
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 06:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=danil-cz.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=VPGmQqOkJTRe9Jw+oF4kWjTnu9ETkz4a5dspM71M/Kw=;
        b=nSCCTtoYKL5qiWPyAJSOBSwt/YEE9L7NrAYvpFg9OD120EOE6HeeR0sgYrNLg/rS1l
         Zcy9YIwFaRDv68RqksNuPV1N2bnIbti+MB7kmA5hP0lXVOgbg/o1ZQwcPyVA+ngqKJ52
         oHhlx0SdurvqfMC62OvPjygps1Fv64Q0hEF2XETPP9R9RDWU1QupUsI+CjNdpAnHb1wC
         2776VNROd1GTpyVFcGKlSdVynsX4DS1Ap0zS/JQ5aGVJrsWFZnApgAfNf7sWkEvpMTEc
         43K3DJTxaHzIJV2DwKN7jFYvzwY+sYYhTUDpXSN3opIad2pmXcNsnCKZztrmBxVSaw09
         BAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=VPGmQqOkJTRe9Jw+oF4kWjTnu9ETkz4a5dspM71M/Kw=;
        b=qTRRhECvDhGi9AHbhJdqy2toGdnNt960QSqtsup5zCwydrs+9fE+mwah5dIZbtVowj
         T9N9dD6iVXJJzGJoAZDXYiJ+Z8rfsrZIQBg+cqRazD12lafgXKfXKO8SqP5119Tgg2uB
         vNxqw0weMVQ0vzskGTpdFkIrHGq8+/hdIKn7NAU09aEMKaRh5HBNOfRExR3HpzmPHHpc
         g3ca2l7RVwcxE/1Dw3lZSg+takgLmBqgGeLQUaxte6e0TnhHTGYwXHd7uvswvUYGQsnE
         r/wEnnkqcHFAgGiRx5xMEjxtCKNtROYSKKfeEZVLXtnmuWuUXIlIneFDjzqRa/Ryc/LH
         fstA==
X-Gm-Message-State: ACgBeo1zcqko79WThacRbJFzOTI+C2Q2/ias0+O0e1s2fUh4zcflh1ON
        VBjBIrCDPLvTL+72F9Q01PDbZntHUnUr0nP5hycLdOx6RZoDj3D+
X-Google-Smtp-Source: AA6agR6aMuboVRhWvqrIC56DIawUpMfu2Sy5ZzjIuIs850/M0PgNRyzkBxJ0iihGyKtbTW500JBK9q87Ap9KX8ACd3w=
X-Received: by 2002:a17:902:f550:b0:172:b0f3:6ff3 with SMTP id
 h16-20020a170902f55000b00172b0f36ff3mr2691245plf.71.1660830889868; Thu, 18
 Aug 2022 06:54:49 -0700 (PDT)
MIME-Version: 1.0
From:   Danil Pristupov <danil@danil.cz>
Date:   Thu, 18 Aug 2022 15:54:38 +0200
Message-ID: <CAKdzDnnE3cOsfdQ+HFY76kNB1W2sSm-5EyY7JDe=MsvH4dBZpw@mail.gmail.com>
Subject: Bug: conflict in the last file line results in wrong combined diff
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I found another bug in the combined diff. It is slightly related to
the one I reported some time ago (combined diff always misses
'NoEolAtEof' pragma), but it's different.

Description:
A simple conflict in the last line in a file with no EOL at EOF
results in a wrong -cc diff with a weird (invalid?) formatting.

Steps to reproduce:

```
git init

echo -n "1\n2" > m.txt
git add m.txt
git commit -m "initial commit"

echo -n "1m\n2m" > m.txt
git commit -am "master change"

git checkout -b branch1 HEAD^
echo -n "1b\n2b" > m.txt
git commit -am "branch1 change"

git merge master

git log --all --graph --oneline
git diff m.txt
```

Actual diff:

```
diff --cc m.txt
index d53cefe,cf67f83..0000000
--- a/m.txt
+++ b/m.txt
@@@ -1,2 -1,2 +1,7 @@@
++<<<<<<< HEAD
 +1b
- 2b      <- wrong! there was no '2b' in the initial commit
++2b      <- wrong! '++' ('both added') doesn't make sense inside a
conflict block
++=======
+ 1m
 -2m      <- wrong! there was no '2m' in the initial commit
++2m      <- wrong! '++' ('both added') doesn't make sense inside a
conflict block
++>>>>>>> master
```

Expected diff (I intentionally missed `\ No newline at end of file`
pragmas to simplify the idea):
```
$ git diff m.txt
diff --cc m.txt
index 7d8e479,73a8b45..0000000
--- a/m.txt
+++ b/m.txt
@@@ -1,2 -1,2 +1,7 @@@
++<<<<<<< HEAD
 +1b
 +2b
++=======
+ 1m
+ 2m
++>>>>>>> master
```

It looks like `\ No newline at end of file` handling is involved
because removing `-n` from the `echo` command in the steps to
reproduce makes diff to produce the correct output.
