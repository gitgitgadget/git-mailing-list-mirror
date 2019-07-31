Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA9FD1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 18:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbfGaSgQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 14:36:16 -0400
Received: from m12-16.163.com ([220.181.12.16]:33704 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727342AbfGaSgP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 14:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=9xM7yKUvelPBnNYk1Y
        VE68s7Pd/SeYV9pE7sGbiSqIs=; b=Yq02XNBRz7174ZlxLNYP/HacLKXQU4Z0zm
        tEbSNc6SaQNx24ehDd3Oi7ZZ9BIXrvEZex2fqu8dM31Ntg0MqjlRDy7Q/NvW5I9Q
        OvjuIgEP4ONGQFkD1ADXgW/WLHsi/eCi3YVa8oFYPDAX8hHZ3I2i+FVV5JiBGzz5
        0bqwvjwIg=
Received: from localhost.localdomain (unknown [113.118.224.79])
        by smtp12 (Coremail) with SMTP id EMCowAB3PyuM30FdnWFpAA--.16797S3;
        Thu, 01 Aug 2019 02:35:56 +0800 (CST)
From:   16657101987@163.com
To:     peff@peff.net
Cc:     16657101987@163.com, git@vger.kernel.org, gitster@pobox.com,
        mhagger@alum.mit.edu, sunchao9@huawei.com, worldhello.net@gmail.com
Subject: [PATCH v2 0/1] pack-refs: always refreshing after take the lock file
Date:   Thu,  1 Aug 2019 02:35:43 +0800
Message-Id: <20190731183544.24406-1-16657101987@163.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190730063634.GA4901@sigill.intra.peff.net>
References: <20190730063634.GA4901@sigill.intra.peff.net>
In-Reply-To: <20190730063634.GA4901@sigill.intra.peff.net>
References: <20190730063634.GA4901@sigill.intra.peff.net>
X-CM-TRANSID: EMCowAB3PyuM30FdnWFpAA--.16797S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFy7CrW5tF1fJF1rKw4rZrb_yoW5uFyfpr
        Z0kwsxKr4DA3WIgF17uw4UXFyrAw4rtryYqas3tr12vws5Wry0vr1SgryY9FW7Gr93G3yj
        qr4vga97Cwn0vaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYiifUUUUU=
X-Originating-IP: [113.118.224.79]
X-CM-SenderInfo: rprwlkyxrqimiyx6il2tof0z/1tbiPg0DglxBdC+fFgAAs9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sun Chao <16657101987@163.com>

On Tue, 30 Jul 2019 02:36:35 -0400, Jeff King wrote:

> You can do this step without the fetch, which makes it hit the race more
> quickly. :) Try this:
> 
>   # prime it with a single commit
>   git commit --allow-empty -m foo
>   while true; do
>     us=$(git commit-tree -m foo -p HEAD HEAD^{tree}) &&
>     git update-ref refs/heads/newbranch $us &&
>     git update-ref refs/heads/master $us &&
>     git update-ref -d refs/heads/newbranch &&
>     them=$(git rev-parse master) &&
>     if test "$them" != "$us"; then
>       echo >&2 "lost commit: $us"
>       exit 1
>     fi
>     # eye candy
>     printf .
>   done

Thanks, this could hit the race more quickly and I update it to the
commit log.

> I don't think this is quite the same as racy-git. There we are comparing
> stat entries for a file X to the timestamp of the index (and we are
> concerned they were written in the same second).
> 
> But here we have no on-disk stat information to compare to. It's all
> happening in-process. But you're right that it's a racy stat-validity
> problem.

Yes, I agree with you.

> The stat-validity check here is actually more than the timestamp.
> Specifically it's checking the inode and size. But because of the
> specific set of operations you're performing, this ends up correlating
> quite often:
> 
>   - because our operations involve updating a single ref or
>     adding/deleting another ref, we'll oscillate between two sizes
>     (either one ref or two)
> 
>   - likewise if nothing else is happening on the filesystem, pack-refs
>     may flip back and forth between two inodes (not the same one,
>     because our tempfile-and-rename strategy means we're still using the
>     old one while we write the new packed-refs file).
> 
> So I actually find this to be a fairly unlikely case in the real world,
> but as your script demonstrates, it's not that hard to trigger it if
> you're trying.
>
> I'm not sure the second one actually fixes things entirely. What if I
> have an older refs/heads/foo, and I do this:
> 
>   git pack-refs
>   git pack-refs --all --prune
> 
> We still might hit the race here. The first pack-refs does not pack foo
> (because we didn't say --all), then a simultaneous "update-ref -d" opens
> `packed-refs`, then the second pack-refs packs it all in the same
> second. Now "update-ref -d" uses the old packed-refs file, and we lose
> the ref.

Yes, I agree with you. And in the real word if the git servers has some
3rd-service which update repositories refs or pack-refs frequently may
have this problem, my company's git servers works like this unfortunately.

> So I actually think the best path forward is just always refreshing when
> we take the lock, something like:
> 
> Ultimately the best solution there is to move to a better format (like
> the reftables proposal).

I do not know if we could get the new reftables in the next few versions,
So I commit the changes as you suggested, which is also the same as
another way I metioned in `PATCH v1`:

**force `update-ref -d` to update the snapshot before rewrite packed-refs.**

But if the reftables is comeing soon, please just ignore my PATCH :)

**And thank a lot for your reply, it's great to me, because it's my first
PATCh to git myself :)**

Sun Chao (1):
  pack-refs: always refreshing after take the lock file

 refs/packed-backend.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

-- 
2.22.0.214.g8dca754b1e


