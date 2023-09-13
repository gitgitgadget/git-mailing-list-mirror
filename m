Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84D0EE0212
	for <git@archiver.kernel.org>; Wed, 13 Sep 2023 22:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjIMW7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 18:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjIMW7x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 18:59:53 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358C21BCB
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 15:59:49 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-500c7796d8eso529615e87.1
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 15:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694645987; x=1695250787; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tTN6e3q3cFA9m5x25Y17TZK1CUN8Ok2Qrd+7uNMKPVw=;
        b=H036/rVCFzLLVroBUWVeoJhejE13WZxwQbqNsXjt4IwerSJQLtH7PyI+UyvckdW8eL
         tFM52PtEBBCB0qTUkb27YHT++RhAleOeC2bvTmNzhJHsamLYtyceGthcd61EebkNuOAc
         VM2uOUrl1owHsa0j0EXmUz9cmlhCma4srmoLZV/OTgcleNeWmb0qqKVzrNdEEP68IFuo
         xwSaBnWP8BEyAYwc1exUylA3VZoX34suKdHxCv9nbPYSREPXwuxXbssC3+owivUare6S
         M7aW/Iwm88v+ClinorFSw8stKjV4DYa1Y3v8vZNOM31TM7hUX2olv6kcJKPYkggYmLG5
         JdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694645987; x=1695250787;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tTN6e3q3cFA9m5x25Y17TZK1CUN8Ok2Qrd+7uNMKPVw=;
        b=Ge6de1pkY/WPD1T5mK/jYtyXdy0Vio0kHK8fak96SvS40qoI68UXUB0YSVsyLtZ4MN
         LUN+aZTqo+jO3y2AgVaSc7G2fIYnv5OS41scEHi6OSCC7LpQRKfUGizUhQn3/mIf4jW1
         2zlDlCkK7jt2skgDhVFh4sJj2ghfIN653aT7UDfEc1+sWHIEriHGUsmP06LpheaezwMO
         PSAFdBzsVaczqkVOJKoHBHDjNTOxfa+sYqCafGOXYGixV9syPdn7MPIWgolE31IurILH
         +uXQfk7/f0WgnpK0qwcLkvM5123wt6kZSvbhCG2T2Gbd4U9r78Z35KRyXyHDJH/JDEHa
         1brA==
X-Gm-Message-State: AOJu0Yyfk+DnGa/aNKgGOBc2iBV457dnOl/iY/nJemS1XFxqfJx2+QKx
        JJI0znk6ECJ75yYNsz+7pKIHIfOgzr8uxE496D87HX/kYPLB8qIk
X-Google-Smtp-Source: AGHT+IFmVEs81olX0f/APwakOotmZygHoY8VYm4r3UDwXN/htV0GLU0KISegCy2Gm8ie5uDKZEEvk4PQfXnGRcOIt1Q=
X-Received: by 2002:a05:6512:3988:b0:500:9a29:bcb0 with SMTP id
 j8-20020a056512398800b005009a29bcb0mr3790031lfu.42.1694645987220; Wed, 13 Sep
 2023 15:59:47 -0700 (PDT)
MIME-Version: 1.0
From:   Javier Mora <cousteaulecommandant@gmail.com>
Date:   Wed, 13 Sep 2023 23:59:35 +0100
Message-ID: <CAH1-q0iV+E73RrUDA8jcoFgNEfQDNwRnX5P5Z7r3Qj3GESV_7g@mail.gmail.com>
Subject: [BUG] `git push` sends unnecessary objects
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I came across this issue accidentally when trying to move a directory
containing a very large file, and deleting another file in that
directory while I was at it.
It seems to be caused by `pack.useSparse=true` being the default since
v2.27 (which I found out after spending quite a while manually
bisecting and compiling git since I noticed that this didn't happen in
v2.25; commit de3a864 introduces this regression).

* Expected:
    Pushing a commit that moves a file without modifying it shouldn't
require sending a blob object for that file, since the remote server
already has that blob object.
* Observed:
    Pushing a commit that moves a directory containing a file and also
adds/deletes other files in that directory will for some reason also
send blobs for all the files in that directory, even the ones that
were already in the remote.
* Consequences:
    This has a very big impact in push times for very small commits
that just move around files, if those files are very big (I had this
happen with a >100MB file over a problematic connection... yikes!)
* Note:
    The commit introducing the regression does warn about possible
scenarios involving a special arrangement of exact copies across
directories, but these are not "copies", I just moved a file, which
seems like a rather common operation.

Code snippet for reproduction:
```
mkdir TEST_git
cd TEST_git

mkdir -p local remote/origin.git
cd remote/origin.git
git init --bare
cd ../../local
git init
git remote add origin file://"${PWD%/*}"/remote/origin.git

mkdir zig
for i in a b c d e; do
    dd if=/dev/urandom of=zig/"$i" bs=1M count=1
done
git add .
git commit -m 'Add big files'
git push -u origin master
#>> Writing objects: 100% (8/8), 5.00 MiB | 13.27 MiB/s, done.
#^ makes sense: 1 commit + 2 trees (/ and /zig) + 5 files = 8;
#  5 MiB in total for the 5x 1 MiB binary files

git mv zig zag
git commit -m 'Move zig'
git push
#>> Writing objects: 100% (2/2), 233 bytes | 233.00 KiB/s, done.
#^ makes sense: 1 commit + 1 tree (/ renames /zig to /zag) = 2;
#  a,b,c,d,e objects already in remote

git mv zag zog
touch zog/f
git add zog/f
git commit -m 'For great justice'
git push
#>> Writing objects: 100% (9/9), 5.00 MiB | 24.63 MiB/s, done.
#^ It re-uploaded the 5x 1 MiB blobs
#  even though remote already had them.
```

Note that the latter doesn't happen if I use `git -c pack.useSparse=false push`.
