Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B2DF1F462
	for <e@80x24.org>; Fri, 31 May 2019 04:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfEaERK (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 00:17:10 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:35288 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfEaERK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 00:17:10 -0400
Received: by mail-lj1-f170.google.com with SMTP id h11so8231827ljb.2
        for <git@vger.kernel.org>; Thu, 30 May 2019 21:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=OTlVkxcczYS9GfnfvDYTQdNLsF5gIrjnMfEj3qALng8=;
        b=pYTOtIQdfKLQIGyofWzgo2VIKwFKAT88ctzHBZE0EtnmlEXs34buEnez+KVHLy9WZf
         L1nXckCUQaW9O0XqvaP6vMbYZIv2gEVuyoxUdbCFQkaM9WPCw5C/KaXmO8Qakv3i9FSo
         fie6R0iIUutHkT0nctbxivO4f1WhDZ4XXpFQN/X5Z/aL+kRl5li1Qs/tFa7BJKww/s/1
         L3+qrnk9epFkYwwSNjpWjkA4bCNq24ClstP7kiENWYXFhihQ8193zyPDRkmIaOcrITPU
         ScHYE4QvKZg1LyWoTBIdpfUDf6YmEuIhhZkl/YTkKE+WJp6I9/+/SbHgerLE0JQqek4O
         b8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OTlVkxcczYS9GfnfvDYTQdNLsF5gIrjnMfEj3qALng8=;
        b=uG485hWbxBGVzOSc1MDYKdkG7STEIgjXSPNdt+WgclrS2Lan0Jg0xWqPUPQkPBL9KV
         /alTAEd2D0L7UDMsDQ2eqrRJ/nwShHZ9p2AtrFPyROwuF/IMDBERxOKlrReRXQG/czLy
         gx1QHdx91IJzqE9tGOXU1GJEHTJy7qIPCMAESrC2jjG+lX+xDlje1K/ik2WbPosKcrwt
         J54UR+ha6iG33MwKkbF6X6FR9/oceEI+3Ou7ygYfFmxAkOxE6jkGeuhNQlZ054gtMhGa
         PiIOTIawbWoXpUShCdWMIRIExHgsWe32Za5J0tj6JwF/XJUL07Mnmh7R90wrwyZFgHIp
         n/Ww==
X-Gm-Message-State: APjAAAUK01yL3jteBd04yitxOSzPys2DttDeQyW/IjQsKzNhVMl527Qo
        5zVvDVbB+TE7VRW1McoTsT0vQWyYmGxCZAtXulnKmy4/whhiKQ==
X-Google-Smtp-Source: APXvYqyWEF4++h1FTDFI0SHufkSepVUYkGb8glcD+fr64wA5wHKAQshRA4e6aCui+syFasQA68X7h3mNIh6nfYfGFFQ=
X-Received: by 2002:a2e:3e14:: with SMTP id l20mr4417049lja.40.1559276227914;
 Thu, 30 May 2019 21:17:07 -0700 (PDT)
MIME-Version: 1.0
From:   Bryan Turner <bturner@atlassian.com>
Date:   Thu, 30 May 2019 21:16:56 -0700
Message-ID: <CAGyf7-EgiWtt0xu9nfYdhafZ6D70nSxbNYAguFrN8OWRqWmzGQ@mail.gmail.com>
Subject: "Losing" MERGE_HEAD
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was looking through the commit history in a repository I work in and
I found a place where someone had created a merge, but somewhere
between "git merge" and "git commit" the fact that it was a merge was
"lost". Instead they ended up with a really big commit that applied
all the changes from the merged-in branch.

A really easy way to reproduce this is:
git merge master #Assume this has conflicts, or use --no-commit
git checkout -b some-new-branch

When the checkout runs, MERGE_HEAD et al are deleted without any sort
of warning, but the uncommitted changes are not lost. If a user then
runs "git commit", and doesn't notice that there's no helpful "It
looks like you may be committing a merge", they'll create a new,
non-merge commit that essentially reapplies all the changes they
merged in.

I'm pretty familiar with Git and I make this mistake at least a few
times a year. So far I've always caught it during the commit, though.
Unfortunately, in this case, the bad "merge" wasn't noticed before it
made its way to master, so now it's there for good.

I'm not sure what there is to do about this. It's clear it's a
long-standing behavior. One approach might be to introduce a warning
when changing branches deletes MERGE_*. A different one might be to
fail to change branches without something like --force. I'm not sure
either is _better_ than the current behavior, but they're certainly
_clearer_. That said, perhaps this behavior is something someone
relies on.

Best regards,
Bryan Turner
