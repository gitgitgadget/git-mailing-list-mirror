From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] untracked-cache: support sparse checkout
Date: Mon, 3 Aug 2015 17:23:01 +0700
Message-ID: <CACsJy8AjDzkGW9MnkJX7GVof4+czm-sbHQhD7F5TFKg16NxAgg@mail.gmail.com>
References: <1438364101-6597-1-git-send-email-dturner@twopensource.com> <CACsJy8C6TiwQQKsaaMTZpAcgC=ma-yW5AR5i7vZnx6JBWSjRTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 12:23:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMCu9-0007Le-MX
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 12:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbbHCKXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 06:23:33 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:34315 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbbHCKXb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 06:23:31 -0400
Received: by ioea135 with SMTP id a135so139837016ioe.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 03:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6+qs94wotkXOA901+339CSeCaLm+WdFmHTx9wX/3SDs=;
        b=r1BOqNfLVShwVePUVo/vMYokPNPid6faSfsZL9Tzv249KJxHaJXS8HRhiHQP/s11CK
         aQqB0EsmQ60g4JcAuqhYnn3md7bTAGmYxhiRbIcgcM0ZKCIOvDASp9Vc9ukXz4LGxQDc
         WRhDNYw9H4xIJsNWaKQ7fA/qz+IhJkeDLWKBeUQNutb+FM+W8rBzXe8f2gwTRv432THS
         R1sE99WQgXjkvQopr1Hlsea8gKNfTOhuv0yUTJ9psyT3IGqhO6FqsM2qV3lbis8pGJPA
         lKLRtwzmbzGMBdBvH77cSUKimL6hYHmF+KXW9sUb8cznDt6o5WGXdPbxftTpHlJMLgjq
         DUyQ==
X-Received: by 10.107.4.1 with SMTP id 1mr18999889ioe.10.1438597410790; Mon,
 03 Aug 2015 03:23:30 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Mon, 3 Aug 2015 03:23:01 -0700 (PDT)
In-Reply-To: <CACsJy8C6TiwQQKsaaMTZpAcgC=ma-yW5AR5i7vZnx6JBWSjRTA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275160>

On Mon, Aug 3, 2015 at 5:18 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Aug 1, 2015 at 12:35 AM, David Turner <dturner@twopensource.com> wrote:
>> Remove a check that would disable the untracked cache for sparse
>> checkouts.  Add tests that ensure that the untracked cache works with
>> sparse checkouts -- specifically considering the case that a file
>> foo/bar is checked out, but foo/.gitignore is not.
>
> I have looked some more at the code (sorry for being slow these days,
> $DAY_JOB can be exhausting). The reason 27b099a (untracked cache:
> don't open non-existent .gitignore - 2015-03-08) avoids skip-worktree
> is because when that patch is added, index changes do not affect
> untracked cache (yet). So when you delete the on-worktree .gitignore,
> untracked cache is invalidated and it falls back to the index version.
> exclude_sha1 would reflect the content in the index. If the in-index
> .gitignore is deleted, without feedback from the index, untracked
> cache remains unchanged (i.e. valid) and assumes that .gitignore is
> still there. Which is wrong.

Hmm.. I got it backward: it should be like this: delete .gitignore on
worktree and in index, exclude_sha1 is null. then add .gitignore in
index only. exclude_sha1 remains null because the cache is still valid
even though we should .gitignore from the index.

> That's fixed in e931371 (untracked cache:
> invalidate at index addition or removal - 2015-03-08).
>
> With that out of the way,
>
> Acked-by: Duy Nguyen <pclouds@gmail.com>
>
>> Signed-off-by: David Turner <dturner@twopensource.com>
>> ---
>>  dir.c                             |  17 +-----
>>  t/t7063-status-untracked-cache.sh | 119 ++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 122 insertions(+), 14 deletions(-)
>>
>> diff --git a/dir.c b/dir.c
>> index 8209f8b..e7b89fe 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -1078,10 +1078,9 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
>>                     (!untracked || !untracked->valid ||
>>                      /*
>>                       * .. and .gitignore does not exist before
>> -                     * (i.e. null exclude_sha1 and skip_worktree is
>> -                     * not set). Then we can skip loading .gitignore,
>> -                     * which would result in ENOENT anyway.
>> -                     * skip_worktree is taken care in read_directory()
>> +                     * (i.e. null exclude_sha1). Then we can skip
>> +                     * loading .gitignore, which would result in
>> +                     * ENOENT anyway.
>>                       */
>>                      !is_null_sha1(untracked->exclude_sha1))) {
>>                         /*
>> @@ -1880,7 +1879,6 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
>>                                                       const struct pathspec *pathspec)
>>  {
>>         struct untracked_cache_dir *root;
>> -       int i;
>>
>>         if (!dir->untracked || getenv("GIT_DISABLE_UNTRACKED_CACHE"))
>>                 return NULL;
>> @@ -1932,15 +1930,6 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
>>         if (dir->exclude_list_group[EXC_CMDL].nr)
>>                 return NULL;
>>
>> -       /*
>> -        * An optimization in prep_exclude() does not play well with
>> -        * CE_SKIP_WORKTREE. It's a rare case anyway, if a single
>> -        * entry has that bit set, disable the whole untracked cache.
>> -        */
>> -       for (i = 0; i < active_nr; i++)
>> -               if (ce_skip_worktree(active_cache[i]))
>> -                       return NULL;
>> -
>>         if (!ident_in_untracked(dir->untracked)) {
>>                 warning(_("Untracked cache is disabled on this system."));
>>                 return NULL;
>> diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
>> index bd4806c..ff23f4e 100755
>> --- a/t/t7063-status-untracked-cache.sh
>> +++ b/t/t7063-status-untracked-cache.sh
>> @@ -354,4 +354,123 @@ EOF
>>         test_cmp ../expect ../actual
>>  '
>>
>> +test_expect_success 'set up for sparse checkout testing' '
>> +       echo two >done/.gitignore &&
>> +       echo three >>done/.gitignore &&
>> +       echo two >done/two &&
>> +       git add -f done/two done/.gitignore &&
>> +       git commit -m "first commit"
>> +'
>> +
>> +test_expect_success 'status after commit' '
>> +       : >../trace &&
>> +       GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
>> +       git status --porcelain >../actual &&
>> +       cat >../status.expect <<EOF &&
>> +?? .gitignore
>> +?? dtwo/
>> +EOF
>> +       test_cmp ../status.expect ../actual &&
>> +       cat >../trace.expect <<EOF &&
>> +node creation: 0
>> +gitignore invalidation: 0
>> +directory invalidation: 0
>> +opendir: 1
>> +EOF
>> +       test_cmp ../trace.expect ../trace
>> +'
>> +
>> +test_expect_success 'untracked cache correct after commit' '
>> +       test-dump-untracked-cache >../actual &&
>> +       cat >../expect <<EOF &&
>> +info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
>> +core.excludesfile 0000000000000000000000000000000000000000
>> +exclude_per_dir .gitignore
>> +flags 00000006
>> +/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
>> +.gitignore
>> +dtwo/
>> +/done/ 0000000000000000000000000000000000000000 recurse valid
>> +/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
>> +/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
>> +two
>> +EOF
>> +       test_cmp ../expect ../actual
>> +'
>> +
>> +test_expect_success 'set up sparse checkout' '
>> +       echo "done/[a-z]*" >.git/info/sparse-checkout &&
>> +       test_config core.sparsecheckout true &&
>> +       git checkout master &&
>> +       git update-index --untracked-cache &&
>> +       git status --porcelain >/dev/null && # prime the cache
>> +       test_path_is_missing done/.gitignore &&
>> +       test_path_is_file done/one
>> +'
>> +
>> +test_expect_success 'create files, some of which are gitignored' '
>> +       echo three >done/three && # three is gitignored
>> +       echo four >done/four && # four is gitignored at a higher level
>> +       echo five >done/five # five is not gitignored
>> +'
>> +
>> +test_expect_success 'test sparse status with untracked cache' '
>> +       : >../trace &&
>> +       avoid_racy &&
>> +       GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
>> +       git status --porcelain >../status.actual &&
>> +       cat >../status.expect <<EOF &&
>> +?? .gitignore
>> +?? done/five
>> +?? dtwo/
>> +EOF
>> +       test_cmp ../status.expect ../status.actual &&
>> +       cat >../trace.expect <<EOF &&
>> +node creation: 0
>> +gitignore invalidation: 1
>> +directory invalidation: 2
>> +opendir: 2
>> +EOF
>> +       test_cmp ../trace.expect ../trace
>> +'
>> +
>> +test_expect_success 'untracked cache correct after status' '
>> +       test-dump-untracked-cache >../actual &&
>> +       cat >../expect <<EOF &&
>> +info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
>> +core.excludesfile 0000000000000000000000000000000000000000
>> +exclude_per_dir .gitignore
>> +flags 00000006
>> +/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
>> +.gitignore
>> +dtwo/
>> +/done/ 1946f0437f90c5005533cbe1736a6451ca301714 recurse valid
>> +five
>> +/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
>> +/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
>> +two
>> +EOF
>> +       test_cmp ../expect ../actual
>> +'
>> +
>> +test_expect_success 'test sparse status again with untracked cache' '
>> +       avoid_racy &&
>> +       : >../trace &&
>> +       GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
>> +       git status --porcelain >../status.actual &&
>> +       cat >../status.expect <<EOF &&
>> +?? .gitignore
>> +?? done/five
>> +?? dtwo/
>> +EOF
>> +       test_cmp ../status.expect ../status.actual &&
>> +       cat >../trace.expect <<EOF &&
>> +node creation: 0
>> +gitignore invalidation: 0
>> +directory invalidation: 0
>> +opendir: 0
>> +EOF
>> +       test_cmp ../trace.expect ../trace
>> +'
>> +
>>  test_done
>> --
>> 2.0.4.315.gad8727a-twtrsrc
>>
>
>
>
> --
> Duy



-- 
Duy
