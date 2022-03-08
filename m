Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D5EC433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 11:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239523AbiCHL2s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 06:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237609AbiCHL2s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 06:28:48 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300F111A3A
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 03:27:51 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id kt27so38619952ejb.0
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 03:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=TrHCsfz5j/MoXWWvctgqlGVkYrMtKJUqvL4D9JEN1fo=;
        b=rXIv+dd4siIy4Sl5gLaMKJPtstOXttByEIN/kua89thE0PdxibbpA7O4bPj3MeZ0UE
         wXEN51X8eJWWKIInujyngrDnlN0rkGTX+WNcgfVd/Rdlk/r9UlI0RwWX9cGXGmIVoIFB
         E2ly8hq6ECrE2Y47JBsKFCisostxgBYCuLalBRapvq2hqLWGNBVFefWCrD8O96+u9Xkq
         ZlgnoeWTIfuiAotx9pMf8UHAASpyx0oVs+zMKMFMfC+7pae+0d+GeSCdaJ+cbpv3Tyst
         gjxRx0/I4fSujzNsPNXi2f5QYOM5+g02pW13tx2Npfj8L88U13GkB/vuBMHFTm+LSlUD
         rFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TrHCsfz5j/MoXWWvctgqlGVkYrMtKJUqvL4D9JEN1fo=;
        b=7MOyeQZTSxK9MrlXHqCvjsvguMaet9GKYEEzEnV1lOuDQ2sDFmWbWoqR9X8Wp5nSix
         FjqW0HIKNdGbGgZZICRVnY/TyvN7QxdNx/RcOPJjjhiqLM6IQsczF04PXIzd5yHLhh6V
         gNRQOBJBxNlMcDJZHN7+TELQ0FqeFlwf936bYbfHKcRRMWoEEKNs0c6/W0KDbHWi+tlh
         nZVCb94+ow/w8qy0MQzmjgxIot+F4gB/1piEfk4rhhY1c7BcI1f5i7XJA/fWJ461F2X/
         7ZMDYVQBVCWFoGOA4eewXbrg6vpSsADXPHcj3EXUkJActk0E6cX6G4WArhKJDyl4rvat
         IeiA==
X-Gm-Message-State: AOAM5333QlEFiikkKs0pt6LtMl+CyU49/4D48bskRTJXlKrpWa6A1nAy
        9B+aIYjLCwaJLJMigfBBYMqLECxegmR6RtUgIV8Y79xitowhDQ==
X-Google-Smtp-Source: ABdhPJyk5euCj1NRHqZ6xz8Tn8Vc2RialZf3rkWGqGNxkrPSEdPp4GW5ifr9L22Zc+LMPn28a2/p/hfJAUNW05fydp4=
X-Received: by 2002:a17:907:161f:b0:6da:aaaf:770f with SMTP id
 hb31-20020a170907161f00b006daaaaf770fmr13530366ejc.540.1646738869489; Tue, 08
 Mar 2022 03:27:49 -0800 (PST)
MIME-Version: 1.0
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 8 Mar 2022 12:27:38 +0100
Message-ID: <CAPMMpog=qBwLrxss_ci6ZMM+AjbdrF8tszXLW7YH1Zqr+m7mPQ@mail.gmail.com>
Subject: Keep reflogs for deleted (remote tracking) branches?
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I have a practical question in case I missed something.

Imagine a small team (10ppl) working on a single centralized repo, in
github for example. They regularly create new branches, and typically
delete them eventually - after merging, or at other times when
branches were a dead end or whatever. The members of this team all
have a "simple" git remote configuration, the result of a "git clone"
with no special configuration. One exception is that they have set
"fetch.prune" to "true", because otherwise remote branches that have
been deleted (in the context of completed merges, or arbitrarily by
other team members) accumulate locally and having to explicitly prune
them from time to time is a pain. Every time someone says "why do I
still see these branches in my repo?", someone else replies "oh, just
run 'git config fetch.prune true'".

Now, one day someone deletes a branch accidentally from the server,
and the sole author of that branch has gone on vacation (or has an IT
failure, or has left the company, or whatever). Other team members
have seen this branch go by, it's appeared in their "fetch" output,
but no-one remembers checking it out, so it's not in their main
"HEAD" reflogs.

Even though the ref was at one point on every team member's computer,
and they still undoubtedly have a dangling commit in their repos,
they're going to have a hard time finding it - there are many dangling
commits in any given repo.

Now my question: is there any way to (temporarily) keep a reflog for
that deleted/pruned branch, in those team members' repos?

As far as I can tell, even "core.logAllRefUpdates=always" does *not*
keep any reflog entries around, even temporarily (until reflog
expiry), once a ref  is deleted - do I understand that correctly? Is
this behavior intentional / reasoned, or just a consequence of the
fact that it's *hard* to keep "managing" per-branch reflogs for
branches that don't exist?

I am planning a workaround using server hooks to "back up" refs that
are being deleted from specific namespaces, in my specific case, and I
imagine that a system like github keeps track of deleted stuff itself
for a while, but I find this "per-ref reflog disappearance" behavior
puzzling / out-of-character, so wanted to make sure I'm not missing
something.

Thanks,
Tao
