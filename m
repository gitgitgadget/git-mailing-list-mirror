Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2E3C433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 00:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A0EB61B98
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 00:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239473AbhKRApL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 19:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbhKRApK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 19:45:10 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3269CC061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 16:42:11 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso7842279otf.12
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 16:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waleedkhan-name.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=n678nEbKQUrYB8DlL55VvNczMtn++EWKcVu2ZLHaYjg=;
        b=MNKLNCwOk25sDAFS2yrrI9bjyXOF86IVneKmbyReWD9KCcMooaCl+fS8wK8isxHZ8T
         VY3q451Zli9Ej4j9Mp8bW4dRDYcglOAj98YlS2LaWXC9d3sP0DYJ1aI6zQ5J2np9wnkt
         rr5gdNcdy7a4TY8CPeieJCctLtFC9fZYEztySDQ/gcpal6kervoa87Q89VgSS48wWZIC
         HTLOdDLGZvQ78nq7jZFKU3pSFf8HInslBq8jAvp+6MabNfmt4G/c48vQE5uPpMB1DaHK
         85FSLrCOsHOIm9wQHtWKgC1rFAUnZY7EVEpUsMkcde1XyNAWgTiGFy3WivKx1zjxn/pU
         Lshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=n678nEbKQUrYB8DlL55VvNczMtn++EWKcVu2ZLHaYjg=;
        b=XA2KLnOUtUAcqoDn3kJs+LAKjW0mw5I6pzZyY8oBNcbju66b/PxYsNOcHmQWXve/23
         e+NcO9+737FeQrrjD52/7rlZHT585XbWPmBKzj5Z3x/SWkhe13b8vqPgE9I7z0pA1vQG
         9+yX6Q9FplHkHhlqbrIKGW/euAivd3i7+1DhQ73C2hHzV0r1WD0J7tvHwCqHzAGiqNFI
         QMrwtbhRBsctz+dbYbGDcq60K4Iko3UXYUpuaxamF/2yp8v/Zcyg8YBWtIaTIrUWH77i
         EYdZItcuSXJ2rsubbHioNnLHOiWikh3XwX2lGTUWangiaEVedy4MKwKWGWkROZHe50Qu
         J+MA==
X-Gm-Message-State: AOAM530YWcwakORn3yqyGQ2T5c+gvX0Da69oVaQBySMoIed7pXZGavlG
        NHReVCkwWbU7y4JWO/lee19gL57udbWMIdtybrDrjnjssZv0u41m
X-Google-Smtp-Source: ABdhPJwXFFogotLLRtfFrwddzPezUeHV6lffLYr5uLVtoTKjquGOMXNOVL6kgXUumkK7jDC1bYtsROBW2Rydx6utZjA=
X-Received: by 2002:a9d:5c2:: with SMTP id 60mr17440922otd.104.1637196130223;
 Wed, 17 Nov 2021 16:42:10 -0800 (PST)
MIME-Version: 1.0
From:   Waleed Khan <me@waleedkhan.name>
Date:   Wed, 17 Nov 2021 16:41:34 -0800
Message-ID: <CAKjfCeBcuYC3OXRVtxxDGWRGOxC38Fb7CNuSh_dMmxpGVip_9Q@mail.gmail.com>
Subject: Bug report: Strange behavior with `git gc` and `reference-transaction`
 hook
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I'm seeing unusual behavior on Git built from source at
cd3e606211bb1cf8bc57f7d76bab98cc17a150bc, but which appears to extend
back to Git v2.29.

This is a repro script:

```
#!/bin/sh

temp_dir=$(mktemp -d)
echo "git dir is: $temp_dir"
mkdir -p "$temp_dir"
trap "rm -rf $temp_dir" EXIT

cd "$temp_dir" || exit 1
git init -q
date='Thu, 07 Apr 2005 22:13:13 +0200'
GIT_AUTHOR_DATE="$date" GIT_COMMITTER_DATE="$date" git commit -q
--allow-empty -m 'Initial commit'

mkdir -p '.git/hooks'
cat >.git/hooks/reference-transaction <<'EOT'
#!/bin/sh

[[ "$1" != 'committed' ]] && exit 0
echo 'New reference-transaction invocation'

while read old new ref; do
  echo "  old: $old, new: $new, ref: $ref"
done
EOT
chmod +x .git/hooks/reference-transaction

git gc --prune=now -q
git show-ref refs/heads/master
```

And this is the output it produces:

```
git dir is: /var/folders/gn/gdp9z_g968b9nx7c9lvgy8y00000gp/T/tmp.b3Jc6qnb
New reference-transaction invocation
  old: 0000000000000000000000000000000000000000, new:
e197d18c017d4038418be8b1cd38f4503e289165, ref: refs/heads/master
New reference-transaction invocation
  old: e197d18c017d4038418be8b1cd38f4503e289165, new:
0000000000000000000000000000000000000000, ref: refs/heads/master
e197d18c017d4038418be8b1cd38f4503e289165 refs/heads/master
```

These hooks are invoked a few milliseconds one after another.

The expected behavior would be that the latest reference transaction
hook refers to the state of the references on disk. That is, either
`master` should point to 0 (be deleted), or it should have said that
`master` pointed to `e197d1`.

But if we actually examine `master`, it's set to `e197d1`, just as you
would expect. The GC should have been a no-op overall.

Best,
Waleed
