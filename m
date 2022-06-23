Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646A6C433EF
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 15:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiFWPjU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 11:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiFWPjT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 11:39:19 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15271EE37
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 08:39:19 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d5so18463403plo.12
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 08:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=danil-cz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ewxGlB+E2ocVl736D7aw473itpsth+LjKZvCCEVBGXU=;
        b=jlPvZBFJEct27y0se3xW3yWIW6PR2TDeO9HR+pO+AFFO2rbx67vSv1J96mPMKzgTGy
         2yHO4Azl8YCUqCpFAHxNs0krBn7vEXvEP00QOH/UUZDdpy8+ISUWSqCFj+Iv7pVXmgHd
         I7EmqeWbM4oeJ+Ju7bYbzKwIETLQoVpXhWOr2cMIMRJx5nyQkot3VB8NO3UQdyF/FuPN
         aTuYVmZncOAvX603TKLjcc+XRr7GPpJFcsL0x/JPL4epDam1nK3N3ZFFSmwQM8NT7sM6
         yNpzPm1GHDzlmgXGXSRQod5R6CnmS4iGVSWtLRaLsb0Mup34354i6zB6H49MzYmF+6ho
         WGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ewxGlB+E2ocVl736D7aw473itpsth+LjKZvCCEVBGXU=;
        b=AaZ6eb3Ijm7kh+cR4QiRrQESPMKo1ZdqJ8b7WK0Y3TqE1cYcSb5lhyyIVrG/3RaQ7R
         Xm9Xz+fSuQA8TUDSrD9Q3JeDAHx36n7cUtlkm3sd8tv9a10KP4qNEPLUqdaP9DafnXss
         4KSYEBVbjdyMJ5j2o31IDGoLJgpjoyuHUoS/LGxK7GWpZWmxUWxN6LvbBSnTHvTclW+F
         lhF/teAAI9sN9E/kw55vWwDEv7BB03RNKEIJp/PZsPRg77w4v6q6QLn4cjgoArd1Y9v2
         Ul4cvHeU8I2sAURCHG3V23xdYVTok2lRztSLscQWcHeyIMTmdoJyUhlZUSm1Z4ACEqX9
         3JGQ==
X-Gm-Message-State: AJIora/O6Ju6d9rT5b8KI0QUfoEbJ5IA5+QFlt11QNxt2D74vUT3bwCg
        CxL+nXDXRMob5H7+16Qd7/Im1xWj1OsWmqO/e0/nqonFhkX9DNx5
X-Google-Smtp-Source: AGRyM1sCAloYVC0seOT3972UqFh6+aI4/qQ5swZrn7CJBKPTxv4y5xn1xJn+HjbX2kvdrZ6NT2EvQIPXbmTtUTarto8=
X-Received: by 2002:a17:90b:4f45:b0:1ed:3fe:e54 with SMTP id
 pj5-20020a17090b4f4500b001ed03fe0e54mr4801513pjb.32.1655998758557; Thu, 23
 Jun 2022 08:39:18 -0700 (PDT)
MIME-Version: 1.0
From:   Danil Pristupov <danil@danil.cz>
Date:   Thu, 23 Jun 2022 17:39:07 +0200
Message-ID: <CAKdzDnn7KkRpXta1LiHcDPCztPcPRTFv8zTW_v+GpBAuSTW6yg@mail.gmail.com>
Subject: Diff for unmerged files always misses the `\ No newline at end of
 file` mark
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some time ago I reported a bug there, but got no response. I hope it's
OK if I post it again.

Diff for unmerged files always misses the `\ No newline at end of file` mark.

I was able to reproduce this with all git versions on all platforms.

Steps to reproduce (macOS, 2.32.0 (Apple Git-132)):

```
git init
echo "line1\nline2" > eol.txt
echo -n "line1\nline2" > noeol.txt
git add .
git commit -m "initial"
git branch br1
echo "line11\nline2" > eol.txt
echo -n "line11\nline2" > noeol.txt
git add .
git commit -m "line1"
git checkout br1
echo "line12\nline2" > eol.txt
echo -n "line12\nline2" > noeol.txt
git add .
git commit -m "line2"
git merge master
git diff -- eol.txt > eol.diff
git diff -- noeol.txt > noeol.diff
```

Expected behavior: `noeol.diff` must have the `\\ No newline at end of
file` mark (I guess double slash `\` must be used as a prefix)

```
$ git diff -- eol.txt
diff --cc eol.txt
index 3dc0c7e,5328e33..0000000
--- a/eol.txt
+++ b/eol.txt
@@@ -1,2 -1,2 +1,6 @@@
++<<<<<<< HEAD
 +line12
++=======
+ line11
++>>>>>>> master
  line2
\\ No newline at end of file
```

Actual behavior: `noeol.diff` does NOT have the `\\ No newline at end
of file` mark

```
$ git diff -- eol.txt
diff --cc eol.txt
index 3dc0c7e,5328e33..0000000
--- a/eol.txt
+++ b/eol.txt
@@@ -1,2 -1,2 +1,6 @@@
++<<<<<<< HEAD
 +line12
++=======
+ line11
++>>>>>>> master
  line2
```
