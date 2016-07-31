Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71DDB1F71B
	for <e@80x24.org>; Sun, 31 Jul 2016 00:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbcGaAPh (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 20:15:37 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:41578 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919AbcGaAPf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 20:15:35 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCA581F71B;
	Sun, 31 Jul 2016 00:15:32 +0000 (UTC)
Date:	Sun, 31 Jul 2016 00:15:32 +0000
From:	Eric Wong <e@80x24.org>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7063: work around FreeBSD's lazy mtime update feature
Message-ID: <20160731001532.GA23146@starla>
References: <20160718223038.GA66056@plume>
 <20160730182005.14426-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160730182005.14426-1-pclouds@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> Let's start with the commit message of [1] from freebsd.git [2]
> 
>     Sync timestamp changes for inodes of special files to disk as late
>     as possible (when the inode is reclaimed).  Temporarily only do
>     this if option UFS_LAZYMOD configured and softupdates aren't
>     enabled.  UFS_LAZYMOD is intentionally left out of
>     /sys/conf/options.
> 
>     This is mainly to avoid almost useless disk i/o on battery powered
>     machines.  It's silly to write to disk (on the next sync or when
>     the inode becomes inactive) just because someone hit a key or
>     something wrote to the screen or /dev/null.
> 
>     PR:             5577 [3]
> 
> The short version of that, in the context of t7063, is that when a
> directory is updated, its mtime may be updated later, not
> immediately. This can be shown with a simple command sequence
> 
>     date; sleep 1; touch abc; rm abc; sleep 10; ls -lTd .

Yikes.  I guess FreeBSD doesn't have an in-memory inode cache it
can keep up-to-date without flushing to disk?

> One would expect that the date shown in `ls` would be one second from
> `date`, but it's 10 seconds later. If we put another `ls -lTd .` in
> front of `sleep 10`, then the date of the last `ls` comes as
> expected. The first `ls` somehow forces mtime to be updated.

Fwiw, `stat .` seems to have the same effect as `ls -lTd .`...

> t7063 is really sensitive to directory mtime. When mtime is too "new",
> git code suspects racy timestamps and will not trigger the shortcut in
> untracked cache, in t7063.26 (or t7063.25 before this patch) and
> eventually be detected in t7063.28
> 
> We have two options thanks to this special FreeBSD feature:
> 
> 1) Stop supporting untracked cache on FreeBSD. Skip t7063 entirely
>    when running on FreeBSD
> 
> 2) Work around this problem (using the same 'ls' trick) and continue
>    to support untracked cache on FreeBSD
> 
> I initially wanted to go with 1) because I didn't know the exact
> nature of this feature and feared that it would make untracked cache
> work unreliably, using the cached version when it should not.
> 
> Since the behavior of this thing is clearer now. The picture is not
> that bad. If this indeed happens often, untracked cache would assume
> racy condition more often and _fall back_ to non-untracked cache code
> paths. Which means it may be less effective, but it will not show
> wrong things.
> 
> This patch goes with option 2.
> 
> PS. For those who want to look further in FreeBSD source code, this
> flag is now called IN_LAZYMOD. I can see it's effective in ext2 and
> ufs. zfs is questionable.
> 
> [1] 660e6408e6df99a20dacb070c5e7f9739efdf96d
> [2] git://github.com/freebsd/freebsd.git
> [3] https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=5577
> 
> Reported-by: Eric Wong <e@80x24.org>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  This is only of those commits that commit messages are more important
>  than the patch itself. One of the good notes about directory mtime,
>  if we start to use it in more places in git.

Thanks, Tested-by: Eric Wong <e@80x24.org>

>  t/t7063-status-untracked-cache.sh | 4 ++++
>  t/test-lib.sh                     | 6 ++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
> index a971884..08fc586 100755
> --- a/t/t7063-status-untracked-cache.sh
> +++ b/t/t7063-status-untracked-cache.sh
> @@ -419,6 +419,10 @@ test_expect_success 'create/modify files, some of which are gitignored' '
>  	rm base
>  '
>  
> +test_expect_success FREEBSD 'Work around lazy mtime update' '
> +	ls -ld . >/dev/null
> +'

	stat . >/dev/null

would be more to the point of what is going on, here.   But I
also wonder if untracked cache itself could/should be doing this
internally.

(I'm not familiar with that code, of course)

Thanks again for looking into this.
