Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D154120229
	for <e@80x24.org>; Fri, 21 Oct 2016 21:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934831AbcJUVki (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 17:40:38 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:34300 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934208AbcJUVkh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 17:40:37 -0400
Received: by mail-yw0-f181.google.com with SMTP id w3so116700412ywg.1
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 14:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=xg6UNTZp/vB+qp9Mo71oCYf7pmm+eQv4sUrpLJQXodU=;
        b=jBkHtRmjCzBrCAlNC+iQcO10fGKtkSIUCIFEWf4k5uXcf4CIFfRxM1J0uMYJTHzqlW
         9K4HJ+rHR9gPZddRPUQcvWTt69Wg3lkenhkbSOIW0RW4l7eAop1zJ4ZPyfvbharDu4bW
         Hiv6S7sPYy/b3LFAGw96gZ3QsKzxx+2RcUWNrDI1s1RzyYD+7W5/DGPjLUX91VD/b2eY
         2M+XzFBtvYmtTP/GD150fH1Kmfh3+agXugJRiMaQcAWoDzP8bdVOpZ9atKRMY2uAZqZs
         4hnmEAnXQ2Th72UCuPp7bTYCq7RAC/9mgnpazFmFaQNjULgaEo0otoTQuoolpPtrl+99
         dWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xg6UNTZp/vB+qp9Mo71oCYf7pmm+eQv4sUrpLJQXodU=;
        b=A0W2Tw22sTEZ7bFVp/e89RyegnabgbmNV1xT4jaM4Npnrb4Y1Wx0pnK53B/57KLhfB
         9hHMZES4BZO9dlZhdcQpQZiCkEX7jw0f7gH+6MaQwHm2jPVQYrLCyykXd5J/LIUyztyA
         If9B9EQHc9VAVGX7TCPwBbu3fUfyr7WumlpO9ZkakeOeg6D8lRAcKpRp+bGRu96ZATp6
         APk9QdhX6CePQflrWk5GsMJE3rjmdX0lDaKdKIO0OZekAUJolrMChMmr9BKLwYQT4GZl
         Dg0ZEcvxZg0lf7Dbrnne2PGbh7FO/JdLtzPJFFOMCN6rjggwnUz+HxRMGPpi8x8rOg1e
         +sVQ==
X-Gm-Message-State: ABUngvd1GnEq8bGf9vzl1BLB7JSMw2QMh5m8vW0LH1aM6vmuA3YNccSpg3L/MN6LU0vNpsrbhoZZGPD0RIJt/Q==
X-Received: by 10.13.244.69 with SMTP id d66mr3867682ywf.318.1477086036711;
 Fri, 21 Oct 2016 14:40:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.10.2 with HTTP; Fri, 21 Oct 2016 14:40:16 -0700 (PDT)
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 21 Oct 2016 14:40:16 -0700
Message-ID: <CA+P7+xrN-_zP40uAUGtqZW+OO4D4Z65SiPRykdKvauO1zgNNcQ@mail.gmail.com>
Subject: generating combined diff without an existing merge commit
To:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I recently determined that I can produce an interdiff for a series
that handles rebasing nicely and shows the conflicts resolved when
rebasing plus any other changes.

The basic idea is something like the following, assuming that v1 is a
tag that points to the first version, v2 is a tag that points to the
rebased new version, and base is a tag that points to the new base of
the series (ie: the upstream if the v2 is on a branch and has been
fully rebased)

git checkout v1
git merge base
#perform any further edits to get everything looking like v2
git commit
git show -cc HEAD

This is also equivalent to the following without having to actually do
the merge manually:

git commit-tree v2^{head} -p v1 -p master -m "some merge message"
git show <output from the commit tree above)

this nicely shows us the combined diff format which correctly shows
any conflicts required to fix up during the rebase (which we already
did because we have v2) and it also shows any *other* changes caused
by v2 but without showing changes which we didn't actually make. (I
think?)

The result is that we can nicely see what was required to produce v2
from v1 but without being cluttered by what changed in base.

However, I have to actually generate the commit to do this. I am
wondering if it is possible today to actually just do something like:

git diff <treeish> <treeish> <treeish> and get the result that I want?

I've already started digging to see if I can do that but haven't found
anything yet.

Thanks,
Jake
