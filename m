Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730B3C636D7
	for <git@archiver.kernel.org>; Sat, 18 Feb 2023 09:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjBRJik (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Feb 2023 04:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBRJij (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2023 04:38:39 -0500
Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D9D31E1C
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 01:38:37 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4PJkBy1VcJz5tlD
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 10:38:33 +0100 (CET)
Content-Type: multipart/mixed; boundary="------------Y0x6Zb5YMgeEl0sunWLQPSd1"
Message-ID: <c6246ed5-bffc-7af9-1540-4e2071eff5dc@kdbg.org>
Date:   Sat, 18 Feb 2023 10:38:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Subject: Bug: fsck and repack don't agree when a worktree index extension is
 "broken"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------Y0x6Zb5YMgeEl0sunWLQPSd1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I came into a situation where a worktree index contains an invalid
object ID in an extension. This causes git gc to abort half-way:

$ git gc
Enumerating objects: 6, done.
Counting objects: 100% (6/6), done.
fatal: unable to read d3e1a3edd7d7851bbf811064090e03475d62fd44
fatal: failed to run repack

However, fsck does not find any problem:

$ git fsck
Checking object directories: 100% (256/256), done.

The problem is an invalid object ID that occurs in a worktree index. If
I copy the index to the main worktree, fsck does find the culprit:

$ cp .git/worktrees/wt/index .git/index
$ git fsck
Checking object directories: 100% (256/256), done.
error: d3e1a3edd7d7851bbf811064090e03475d62fd44: invalid sha1 pointer in
resolve-undo
error: 4b40bf1072d6dfeebc09b11ee4d4f22ca2ce3109: invalid sha1 pointer in
resolve-undo
error: 5a494fd3a2182795e0723300ab1ac75c0797be5b: invalid sha1 pointer in
resolve-undo

and git gc fails in the same way as before (of course).

I see three problems here:

- git fsck should detect the problem (if it really is one) in the
worktree index. It seems that it is just an index extension that is
affected. Perhaps it should be just a warning, not an error.

- If the objects mentioned in the index extension are precious, they
should not have been garbage-collected in earlier rounds of git gc
(which I certainly did at some point).

- I can't git gc the repository now, which is particularly annoying when
auto-gc is attempted after almost every git command. Of course, I know
how to get out of the situation, but it took some time to identify the
worktree index as the culprit. Not something that a beginner would be
able to do easily.

The repository I use for the above commands is attached. I hope vger
doesn't strip it away.

-- Hannes
--------------Y0x6Zb5YMgeEl0sunWLQPSd1
Content-Type: application/gzip; name="git-bug-gc-w-worktree-index.tar.gz"
Content-Disposition: attachment; filename="git-bug-gc-w-worktree-index.tar.gz"
Content-Transfer-Encoding: base64

H4sIAAAAAAAAA+2df4wcZRnH91oNuZNg0YigwUxstFR6c+/vd+a0SNOWthRSLBATCpHZ3dm7
bW93jt057ioEwUiIwcQQJaDGP0A0/kBQMYEYfiiJIiSQEJASTMoPCSEEoUETJMbEmbktNzuz
3ZnZnX2Xu30+Tbu9m5t7b+7d7/O8z/O+7/PqUxdZS7ttq2w3mlMzVXeyuDAzOVOarNbL9lIh
H5CHYCx49Yi+IkxxATMqGcYMYVHwPkGYKGh5td+VhaZrNbwfRUVbH0Ao0mputWZvxUIKibHJ
kY4EYpIITCeIqVntV4kuhMGRNOiEd2vpxLcO+8GAVEQlPzWANnyNS879Vyz5su7xij0IbEG7
/hmTuKDxAfwsMY7r/2CzuuR2/TrPQna5HjVuq4RY/4fcge5dzKONZPtP3u9/LAL7LwUG+6+C
iP0niDNdIm4YnJumb+KttqvC0IlpIGFiKqIOIHLvsJ8MSENM/77oc3YCWez/sv45ZQjsvwo6
93/ICRQbVr00a3d79CSS7D+SzO9/ITgRgkm//7mQYP9VELHwmCPfwjNGDISN2BDfG9zrUviX
KCNg4dcAnfV/XPT5OIKU9j+kf+k5ArD/Kki0/7t3btvRZxuZ7D+nfvzHvctg/xUQtf/YxDoN
wnBCGdj/NU9n/ecg+hAh/Xe2/4RH9M+lJAVNiSZH3P437Mq05v3TnJr1DH5zqmZV6yDs0SHR
/1frFafPNjLk/whB/viPSQTzP0qIzv+0e3iIDtc6nfXviz6/JGCG/F9L/4IIDvGfCrr0f8gJ
2EuluYWy3WMbyfEfjcT/gvr9D/Z/8ERn+AkRusEEx0iCgR8Buui/P9GHSIr/qIjl/4SA+E8J
GzWvv7W55mSlOmc3tclJx531HtT7T6v7JysNp7Y19q6Y2KhdUK17d7izlqv5v0NXW6y6s9qm
jZs0q2FrJadWs+tuU/e+8jynoVnafMM5aJdcreY03bnDWrWubd/i3W5rFWduzlms1me0RWdh
rqwVbe+rZxynrDVtV3Mq3ndotarNW65rN+pN7ayFeqsF/1vUtGpFO+wsaIuW/wlH83or+Pzm
ae/mL+gHHOsK/z/XgdGKkBj/OUW/0/qZ/ssS/1G2PP/LMAP/r4Jo/Ccp06kwOZNyOcJrGx1I
hnRheMMzyjiJDQ/a7x32kwFp6Kz/luhzCgEzxH8t/QvphQQQ/ymge//nkwdMjv+i6z+8+A/y
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
ErL6/+T5X/D/q4kU+u9N9CES/X+H9V8c6n8rAc5/Gm2y+f/gSzK3kej/iYzs/5Gcw/pvJXTd
/xMp/x27CNt/Vj0p9N+b6EMk+X//sN/2/T8Y+fO/4P8Hz449+7d7L+u8v2OlY7efsv7IXw4c
f/U+ZxTe2f6RQuGGuwqF9a97H5f9e1778Ss/+t3Tz23fe/PmexYve/7RV79z8S2FD9u1efdw
8D0v2b9zp/dyRgFraGLbtWN/PXwZf+B1fur0jT/9458e+8bMf/fvvNRv9PKGXVyozpX15mwB
L79F2l+eefkn/zxy5MZPP3LDhvL4Ket3XVH834695z6yofHci289OP7bz7z67Dtb7nwKj1+2
Z98zd56+6daXGrTwq089dvlJtz18YOyBL1951b1n3H/J+j+/WDv9DuftLcU7hvQ7/iCTWP+h
b/Vni/+xCOq/Ign1H5QQif8J4kyXiBsGb83wW12vlk58ddhPBqShs/5zEH2IJP9PMI7oX1DB
wP+roN3/3/qPiQ3Xf9R7vei0r26aLAT+f9t7ufv/m7ZYJVZ949Xq0R9+/nvN04xPPHHTQ8P6
BYw4Mf2HXP9Kj/ZHsv9fOf+LE+Sf/0Hg/C81xM7/ZIbu9YSBEcM0dv4XNqV/OjQyJeWx9D81
uY6F5/0px+D+Vwkx/ecl+hCJ+f+V9d8t/XNOBfh/FXSz//1V/Vwhg/1vzf9SzmD+Vwnd53+7
JoBh+ncN0KneQ95t+BrPVv+PY0Jh/48KOvV/yAX42YC+28iS/2ud/8cQjP+VAPUfRpsT1fvJ
s43E8b+kUfsvEdR/UMJyca9pLbEOVGxeGAS+Fkjw/7lkA3rw/xLB+V9KgPW/o00n/eedAsyQ
/zt+/gOWUP8RAAAAAAAAAAAgV/4PlXIMPAAYAQA=

--------------Y0x6Zb5YMgeEl0sunWLQPSd1--
