Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371BBC433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 16:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E9E361250
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 16:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351399AbhI3QhX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 12:37:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55835 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349182AbhI3QhW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 12:37:22 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC857EA445;
        Thu, 30 Sep 2021 12:35:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BCmYmJ56Yf7d
        Q87x4hcBHYMZm0sXXKB4M86JrYgQ10k=; b=PPRmnrF1QR/oBzfih9YoWpZjvBVu
        zr+0UltZAa1u1ojQ5O26BxJehzykeju7ShHdzeXFLGp0X+tE5CEZD2w7+GPQbWOC
        hFf5kXmhra1rnOwYerL1BTAzmdohIRt64cBWH3kZO+TJoOWxPiZ4EjY06TgQ6P+G
        fNY8LkQspTYkXMM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1CB1EA444;
        Thu, 30 Sep 2021 12:35:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0EE7DEA443;
        Thu, 30 Sep 2021 12:35:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Robert Leftwich <robert@gitpod.io>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: Bug/regression report - 'git stash push -u' fatal errors when
 sub-repo present
References: <CACr9BXmP1vQMK4b27Uc4R-3WWYHUYfCEEMN+hnth4yUg+UN7Zg@mail.gmail.com>
        <7b83c77e-dd87-f688-3da1-7826cf6b0d4e@web.de>
Date:   Thu, 30 Sep 2021 09:35:36 -0700
In-Reply-To: <7b83c77e-dd87-f688-3da1-7826cf6b0d4e@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 30 Sep 2021 12:06:37 +0200")
Message-ID: <xmqqk0iydns7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 71800240-220C-11EC-9364-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Looping in Stolee as the author of 6e773527b6 (sparse-index: convert
> from full to sparse, 2021-03-30).
>
> Here's a raw patch for that.  Versions before 6e773527b6 pass the
> included test.
>
> The magic return value of 2 is a bit ugly, but allows adding the
> additional check only to the call-site relevant to the bug report.
>
> I don't know if other callers of verify_path() might also need that
> check, or if it is too narrow.

The callers inside read-cache.c, which I think were the original
intended audiences of the function, always call verify_path() with
the pathname suitable to be stored as a cache entry.

The callee never has to assume an extra trailing slash might exist
at the end.  And verify_path() said "no", if any caller passed an
extra trailing slash before the commit in question.

I _think_ we defined the new "tree" type entries the sparse index
stuff added to be the _only_ cache entries whose path always ends
with a slash?  If so, perhaps we should audit the existing callers=20
and move the "paths that come from end-users to be entered to the
index must never end with a slash" sanity check this function gave
us, which was broken by 6e773527b6, perhaps?

"git update-index" should never allow to create a "tree" kind of
cache entry (making it sparse again should be the task of systems
internal, and should not be done by end-user feeding a pre-shrunk
"tree" kind of entry to record a sparsely populated state, if I
understand correctly), so its call to verify_path(), if it ends with
a directory separator, should say "that's not a good path".

Prehaps we can rename verify_path() to verify_path_internal() that
is _known_ to be called with names that are already vetted to be
stored in ce_name and convert callers inside read-cache.c to call
it, and write verify_path() as a thin wrapper of it to fail when the
former stops by returning S_ISDIR() at the place your fix touched,
or something?

Thanks.

>
> Ren=C3=A9
>
>
> ---
>  builtin/update-index.c             | 15 ++++++++++++++-
>  read-cache.c                       |  2 +-
>  t/t3905-stash-include-untracked.sh |  6 ++++++
>  3 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 187203e8bb..3d32db7304 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -445,10 +445,22 @@ static void chmod_path(char flip, const char *pat=
h)
>  	die("git update-index: cannot chmod %cx '%s'", flip, path);
>  }
>
> +static int is_nonbare_repo_dir(const char *path)
> +{
> +	int ret;
> +	struct strbuf sb =3D STRBUF_INIT;
> +
> +	strbuf_addstr(&sb, path);
> +	ret =3D is_nonbare_repository_dir(&sb);
> +	strbuf_release(&sb);
> +	return ret;
> +}
> +
>  static void update_one(const char *path)
>  {
>  	int stat_errno =3D 0;
>  	struct stat st;
> +	int ret;
>
>  	if (mark_valid_only || mark_skip_worktree_only || force_remove ||
>  	    mark_fsmonitor_only)
> @@ -458,7 +470,8 @@ static void update_one(const char *path)
>  		stat_errno =3D errno;
>  	} /* else stat is valid */
>
> -	if (!verify_path(path, st.st_mode)) {
> +	ret =3D verify_path(path, st.st_mode);
> +	if (ret =3D=3D 0 || (ret =3D=3D 2 && is_nonbare_repo_dir(path))) {
>  		fprintf(stderr, "Ignoring path %s\n", path);
>  		return;
>  	}
> diff --git a/read-cache.c b/read-cache.c
> index f5d4385c40..0188b5b798 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1040,7 +1040,7 @@ int verify_path(const char *path, unsigned mode)
>  			 * sparse directory entries.
>  			 */
>  			if (c =3D=3D '\0')
> -				return S_ISDIR(mode);
> +				return S_ISDIR(mode) ? 2 : 0;
>  		} else if (c =3D=3D '\\' && protect_ntfs) {
>  			if (is_ntfs_dotgit(path))
>  				return 0;
> diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include=
-untracked.sh
> index dd2cdcc114..5390eec4e3 100755
> --- a/t/t3905-stash-include-untracked.sh
> +++ b/t/t3905-stash-include-untracked.sh
> @@ -422,4 +422,10 @@ test_expect_success 'stash show --{include,only}-u=
ntracked on stashes without un
>  	test_must_be_empty actual
>  '
>
> +test_expect_success 'stash -u ignores sub-repository' '
> +	test_when_finished "rm -rf sub-repo" &&
> +	git init sub-repo &&
> +	git stash -u
> +'
> +
>  test_done
> --
> 2.33.0
