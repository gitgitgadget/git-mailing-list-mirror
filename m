From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] untracked-cache: support sparse checkout
Date: Mon, 3 Aug 2015 17:18:06 +0700
Message-ID: <CACsJy8C6TiwQQKsaaMTZpAcgC=ma-yW5AR5i7vZnx6JBWSjRTA@mail.gmail.com>
References: <1438364101-6597-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 12:18:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMCpS-0005b5-SA
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 12:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbbHCKSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 06:18:37 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34055 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbbHCKSg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 06:18:36 -0400
Received: by igk11 with SMTP id 11so68694212igk.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 03:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=G0iRyn+JWBtO+YDP0x7J0xIuE+sFH3syUR4JAuujZe8=;
        b=vVQzXjZiTf/Od69Edpz8kMMtkIGlCzQQSTUfhQUhkc6QHJ3ssgVqnO1/yBbxahfr8l
         qbSgpRe3hsa9pOsDxKS1m+YvtY2yHLfNB2jpcx0ShzDo/fza/GeRMo8t1ydJ4YbYLemK
         r8FaY1V1QmWmXsnn2AvBhAg0+AYO3bIeIcl4qt7Rey2y9VygyyBUP1FJGXj2YD1SMC6g
         VxHNLiOrZfhSENnLOX1yQ67m4ptZcWF8v0O0U7DDksoLBS/dSe09tbgjU1/8KoICiCls
         pMJetCXe03/WjalISvkt5L1jQs7RxI18M2mxhN1s34QGo8eVDpZVcNFAWDzBa+cCWxuN
         +c8A==
X-Received: by 10.50.2.9 with SMTP id 9mr19778535igq.42.1438597115315; Mon, 03
 Aug 2015 03:18:35 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Mon, 3 Aug 2015 03:18:06 -0700 (PDT)
In-Reply-To: <1438364101-6597-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275158>

On Sat, Aug 1, 2015 at 12:35 AM, David Turner <dturner@twopensource.com> wrote:
> Remove a check that would disable the untracked cache for sparse
> checkouts.  Add tests that ensure that the untracked cache works with
> sparse checkouts -- specifically considering the case that a file
> foo/bar is checked out, but foo/.gitignore is not.

I have looked some more at the code (sorry for being slow these days,
$DAY_JOB can be exhausting). The reason 27b099a (untracked cache:
don't open non-existent .gitignore - 2015-03-08) avoids skip-worktree
is because when that patch is added, index changes do not affect
untracked cache (yet). So when you delete the on-worktree .gitignore,
untracked cache is invalidated and it falls back to the index version.
exclude_sha1 would reflect the content in the index. If the in-index
.gitignore is deleted, without feedback from the index, untracked
cache remains unchanged (i.e. valid) and assumes that .gitignore is
still there. Which is wrong. That's fixed in e931371 (untracked cache:
invalidate at index addition or removal - 2015-03-08).

With that out of the way,

Acked-by: Duy Nguyen <pclouds@gmail.com>

> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  dir.c                             |  17 +-----
>  t/t7063-status-untracked-cache.sh | 119 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 122 insertions(+), 14 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 8209f8b..e7b89fe 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1078,10 +1078,9 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
>                     (!untracked || !untracked->valid ||
>                      /*
>                       * .. and .gitignore does not exist before
> -                     * (i.e. null exclude_sha1 and skip_worktree is
> -                     * not set). Then we can skip loading .gitignore,
> -                     * which would result in ENOENT anyway.
> -                     * skip_worktree is taken care in read_directory()
> +                     * (i.e. null exclude_sha1). Then we can skip
> +                     * loading .gitignore, which would result in
> +                     * ENOENT anyway.
>                       */
>                      !is_null_sha1(untracked->exclude_sha1))) {
>                         /*
> @@ -1880,7 +1879,6 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
>                                                       const struct pathspec *pathspec)
>  {
>         struct untracked_cache_dir *root;
> -       int i;
>
>         if (!dir->untracked || getenv("GIT_DISABLE_UNTRACKED_CACHE"))
>                 return NULL;
> @@ -1932,15 +1930,6 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
>         if (dir->exclude_list_group[EXC_CMDL].nr)
>                 return NULL;
>
> -       /*
> -        * An optimization in prep_exclude() does not play well with
> -        * CE_SKIP_WORKTREE. It's a rare case anyway, if a single
> -        * entry has that bit set, disable the whole untracked cache.
> -        */
> -       for (i = 0; i < active_nr; i++)
> -               if (ce_skip_worktree(active_cache[i]))
> -                       return NULL;
> -
>         if (!ident_in_untracked(dir->untracked)) {
>                 warning(_("Untracked cache is disabled on this system."));
>                 return NULL;
> diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
> index bd4806c..ff23f4e 100755
> --- a/t/t7063-status-untracked-cache.sh
> +++ b/t/t7063-status-untracked-cache.sh
> @@ -354,4 +354,123 @@ EOF
>         test_cmp ../expect ../actual
>  '
>
> +test_expect_success 'set up for sparse checkout testing' '
> +       echo two >done/.gitignore &&
> +       echo three >>done/.gitignore &&
> +       echo two >done/two &&
> +       git add -f done/two done/.gitignore &&
> +       git commit -m "first commit"
> +'
> +
> +test_expect_success 'status after commit' '
> +       : >../trace &&
> +       GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
> +       git status --porcelain >../actual &&
> +       cat >../status.expect <<EOF &&
> +?? .gitignore
> +?? dtwo/
> +EOF
> +       test_cmp ../status.expect ../actual &&
> +       cat >../trace.expect <<EOF &&
> +node creation: 0
> +gitignore invalidation: 0
> +directory invalidation: 0
> +opendir: 1
> +EOF
> +       test_cmp ../trace.expect ../trace
> +'
> +
> +test_expect_success 'untracked cache correct after commit' '
> +       test-dump-untracked-cache >../actual &&
> +       cat >../expect <<EOF &&
> +info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
> +core.excludesfile 0000000000000000000000000000000000000000
> +exclude_per_dir .gitignore
> +flags 00000006
> +/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
> +.gitignore
> +dtwo/
> +/done/ 0000000000000000000000000000000000000000 recurse valid
> +/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
> +/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
> +two
> +EOF
> +       test_cmp ../expect ../actual
> +'
> +
> +test_expect_success 'set up sparse checkout' '
> +       echo "done/[a-z]*" >.git/info/sparse-checkout &&
> +       test_config core.sparsecheckout true &&
> +       git checkout master &&
> +       git update-index --untracked-cache &&
> +       git status --porcelain >/dev/null && # prime the cache
> +       test_path_is_missing done/.gitignore &&
> +       test_path_is_file done/one
> +'
> +
> +test_expect_success 'create files, some of which are gitignored' '
> +       echo three >done/three && # three is gitignored
> +       echo four >done/four && # four is gitignored at a higher level
> +       echo five >done/five # five is not gitignored
> +'
> +
> +test_expect_success 'test sparse status with untracked cache' '
> +       : >../trace &&
> +       avoid_racy &&
> +       GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
> +       git status --porcelain >../status.actual &&
> +       cat >../status.expect <<EOF &&
> +?? .gitignore
> +?? done/five
> +?? dtwo/
> +EOF
> +       test_cmp ../status.expect ../status.actual &&
> +       cat >../trace.expect <<EOF &&
> +node creation: 0
> +gitignore invalidation: 1
> +directory invalidation: 2
> +opendir: 2
> +EOF
> +       test_cmp ../trace.expect ../trace
> +'
> +
> +test_expect_success 'untracked cache correct after status' '
> +       test-dump-untracked-cache >../actual &&
> +       cat >../expect <<EOF &&
> +info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
> +core.excludesfile 0000000000000000000000000000000000000000
> +exclude_per_dir .gitignore
> +flags 00000006
> +/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
> +.gitignore
> +dtwo/
> +/done/ 1946f0437f90c5005533cbe1736a6451ca301714 recurse valid
> +five
> +/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
> +/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
> +two
> +EOF
> +       test_cmp ../expect ../actual
> +'
> +
> +test_expect_success 'test sparse status again with untracked cache' '
> +       avoid_racy &&
> +       : >../trace &&
> +       GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
> +       git status --porcelain >../status.actual &&
> +       cat >../status.expect <<EOF &&
> +?? .gitignore
> +?? done/five
> +?? dtwo/
> +EOF
> +       test_cmp ../status.expect ../status.actual &&
> +       cat >../trace.expect <<EOF &&
> +node creation: 0
> +gitignore invalidation: 0
> +directory invalidation: 0
> +opendir: 0
> +EOF
> +       test_cmp ../trace.expect ../trace
> +'
> +
>  test_done
> --
> 2.0.4.315.gad8727a-twtrsrc
>



-- 
Duy
