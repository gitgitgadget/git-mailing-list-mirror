Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0350C433F5
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 10:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbiDLKcM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 06:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379558AbiDLKTp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 06:19:45 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BDA2665
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 02:20:32 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id cw11so889557pfb.1
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 02:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=5I7ugsaEpepiYXkn13g1cXB2PdcUn4R2Gd/wnyIaXOE=;
        b=IxRoT8Xc3yaTG0AyjU+HMZkQdaQqfzOtJnsPgtYY2cpvSt5eFYqHN0kQj6ubdsB6SA
         qXsgiRQLlC56dxc4CJv2GYXTM/VlrLzrYuqEmeTWl9ZybdhMiv0B7raj8zjqtZF+o3Kp
         NdjMcHhR+7w6dZY8LdCw2ZtONUjy/Br6ZblPJyOhJoyruMyELwGVqAwcRmKr/neSrmLi
         MMNQwXBJwLch/ovwFdow/8xU8AiJ+3NwAWWO8ajvwE4KvJqxr3W03auugC0z2yru95cT
         1I7cNaX+UzRjX2XPAxm56aCuaF6rAKb2YtQYkJJPnAL9i/aqvPis5HAxuZAOSURdBoMr
         s3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=5I7ugsaEpepiYXkn13g1cXB2PdcUn4R2Gd/wnyIaXOE=;
        b=CD6j+V+XCDu0GGZVsq2Tk0Y1d34R6KJNFB8WZh/eemkRiH37DQhCLnVmsCViZm+tLW
         lqzgWeHWMfljoXmmBPWaCcDtX0s95bvf3biTqD8/rBr2RThbWsELPGXJcmMcOIiwT9qp
         FcxFzbJ14M2ZQRvBvq1rzoOLnLSrdf6uCX43M5KXrwK8I72Ps1ju53diMLLSxOOK1JYK
         FyF7VT1z2hbfjvtVZeI0ksDk/7ZRoMUeaR2HCx4DCB/OHRZa7G6nm9QN7wdTjC8Aqsn+
         Az3hsM0VqeHND5may/CT7GVGA4gF9476tB3qJms/po76UPe2ob1SFP/YToNYIld3R6Fb
         kMIA==
X-Gm-Message-State: AOAM5300jSBD8Qa84UNDPX2TI8pdIpQn2jTvUojyDFTshBUq1L5eSFcJ
        N+6blmyOZaeZlF4fvwT1YbtUhcW5In+U14fFmotsckiNWFE=
X-Google-Smtp-Source: ABdhPJz161SFu0B+XXLoBIw367Wt5VXpL6eR6m4Nj5D8VIvFxTqPZoJdRZeTK+/u26UyCQyGZB47Pk172llFGOHp2NQ=
X-Received: by 2002:aa7:92c8:0:b0:4fd:c1aa:3e11 with SMTP id
 k8-20020aa792c8000000b004fdc1aa3e11mr37383335pfa.29.1649755231769; Tue, 12
 Apr 2022 02:20:31 -0700 (PDT)
MIME-Version: 1.0
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 12 Apr 2022 02:20:21 -0700
Message-ID: <CAGyf7-GYYA2DOnAVYW--=QEc2WjSHzUhp2OQyuyOr3EOtFDm6g@mail.gmail.com>
Subject: reference-transaction regression in 2.36.0-rc1
To:     Git Users <git@vger.kernel.org>
Cc:     Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It looks like Git 2.36.0-rc1 includes the changes to eliminate/pare
back reference transactions being raised independently for loose and
packed refs. It's a great improvement, and one we're very grateful
for.

It looks like there's a regression, though. When deleting a ref that
_only_ exists in packed-refs, by the time the "prepared" callback is
raised the ref has already been deleted completely. Normally when
"prepared" is raised the ref is still present. The ref still being
present is important to us, since the reference-transaction hook is
frequently not passed any previous hash; we resolve the ref during
"prepared", if the previous hash is the null SHA1, so that we can
correctly note what the tip commit was when the ref was deleted.

Here's a reproduction:
git init ref-tx
cd ref-tx
git commit -m "Initial commit" --allow-empty
git branch to-delete
git pack-refs --all
echo 'echo "Callback: $1"; cat; git rev-parse refs/heads/to-delete --;
exit 0' > .git/hooks/reference-transaction
chmod +x .git/hooks/reference-transaction
git branch -d to-delete

If you _skip_ the pack-refs, you'll get output like this:
$ git branch -d to-delete
Callback: prepared
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/to-delete
aab0f2e707acd1b84e81f4e4b833ff0d9ee7cc50
--
Callback: committed
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/to-delete
fatal: bad revision 'refs/heads/to-delete'
Deleted branch to-delete (was aab0f2e).

You can see that, during "prepared", rev-parse returns aab0f2e7 and
after "committed" the ref no longer exists.

With the pack-refs, you get this:
$ git branch -d to-delete
Callback: prepared
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/to-delete
fatal: bad revision 'refs/heads/to-delete'
Callback: committed
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/to-delete
fatal: bad revision 'refs/heads/to-delete'
Deleted branch to-delete (was aab0f2e).

In both cases, the reference-transaction isn't invoked with the hash
of the ref being deleted (even though Git clearly _knows_ it, since it
outputs it itself afterward), but if the ref exists loose we can at
least find out what it was.

Contrast this to Git 2.35.1:
$ git branch -d to-delete
Callback: prepared
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/to-delete
aab0f2e707acd1b84e81f4e4b833ff0d9ee7cc50
--
Callback: committed
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/to-delete
fatal: bad revision 'refs/heads/to-delete'
Callback: aborted
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/to-delete
fatal: bad revision 'refs/heads/to-delete'
Callback: prepared
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/to-delete
fatal: bad revision 'refs/heads/to-delete'
Callback: committed
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/to-delete
fatal: bad revision 'refs/heads/to-delete'
Deleted branch to-delete (was aab0f2e).

With the reference-transactions for both packed and loose, when the
packed reference transaction runs we can still see the commit hash.

It seems like Git should either:
- Provide the PREPARED callback before _either_ packed or loose refs
are updated, or
- Provide the actual SHA as the old hash when invoking the hook (which
would be great because it would save us the overhead of resolving it
ourselves)

It's probably complicated to do either of those, but without one or
the other this change makes it very difficult to replicate updates
reliably via reference-transaction because we can't be 100% sure we're
applying the same deletion on replicas without knowing the old hash.

Best regards,
Bryan Turner

(Apologies for the double-send; forgot to enable plain text mode the
first time.)
