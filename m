Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705AF44C76
	for <git@vger.kernel.org>; Sat, 23 Nov 2024 04:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732336572; cv=none; b=eMwbsswtn+g4w0yg5gUUv8hxX9KD8oS1/I1MEh7HPQ2Bd+k6c1WswHPwmyDLFYpm3bUCN6vLOAqAESHOclGqW4p6CP6EOojevnjrSCot8M7mauR+hUfv9qLJ0e7iQn/tBYLMr4vQ6GrF0e54EcwwT0oYmUF9/r5iktsUnI7B0j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732336572; c=relaxed/simple;
	bh=g+t1iA8oi/dPOmv6bvPxFyNfrajifBPGhd8BX4b4BYc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HVuZWW2dp21MTUrKihd04VNoiea3ds8W+eoeeKEcRZoQ3TaXCxAZUML1ZKTx+ZNyiyBSGrI4n0RSkL3MR6BM2aMxwHJG4qTBOoOcUXiqystXeMen3Hyf9fSXHYnyKZrH464Vkf8uAo2uL/fnT5tiqirXu+7xzKkSKYEeMMcLnUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=kEhDGfsl; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="kEhDGfsl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732336567; x=1732595767;
	bh=wZe5koiX+w9XlelStvxjf+G/rXPTYeAI9PbJ5LrN690=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=kEhDGfslacM1aCeQUilNseJ7StDEnyvVvLNTIq/kjeIrYXaHCncUt54zyPrnkncRd
	 YzflpUaHvZ91/OeZSfc9ojRGU5MWjzPSwQGBsqO+c9JAsJfUly7Ph0b4mDEDCZcR2G
	 7iiT24eFcwfxBmZ9jNFk6gUxFFDmNDDR436Fjyc/QexmCCWBullajtcLLSeyZDE7L0
	 iK+PjI91R18HDy9wNQJL65mR0GRgG6cqZ7iOONCA4Ytlihf5oq8ZWeo+whvsUCXRjN
	 juvF9CzHRoI/2962ehebYgGYZLg0T+6xe23LZl3AlfdSi8bKZ0HXa+XoY237BGiqZh
	 3Ov4RyE9w8SEw==
Date: Sat, 23 Nov 2024 04:36:02 +0000
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 8/8] worktree: refactor `repair_worktree_after_gitdir_move()`
Message-ID: <D5TA24EUHQ7N.XV0HCIO6MRS6@pm.me>
In-Reply-To: <50187d7d-2a96-4df2-baaa-ea27c9bd5dcf@gmail.com>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me> <20241031-wt_relative_options-v4-8-07a3dc0f02a3@pm.me> <50187d7d-2a96-4df2-baaa-ea27c9bd5dcf@gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: d7978030d4d4a4c8b1c9510c490c4ed433ac8023
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Nov 22, 2024 at 9:58 AM CST, Phillip Wood wrote:
> On 01/11/2024 04:39, Caleb White wrote:
>> This refactors `repair_worktree_after_gitdir_move()` to use the new
>> `write_worktree_linking_files` function. It also preserves the
>> relativity of the linking files; e.g., if an existing worktree used
>> absolute paths then the repaired paths will be absolute (and visa-versa)=
.
>
> It would be helpful to give a brief explanation of what this function is
> used for as it seems to be called from setup.c rather than as part of
> "git worktree repair"

I updated the commit message to include a brief explanation of what the
function does.

>> This also adds a test case for reinitializing a repository that has
>> relative worktrees.
>
> I'm not sure exactly what this is doing - are we breaking something and
> then calling "git init" to repair it?

Apparently (I didn't know this either, and this is likely a rare use-case),
`git init` allows you to "re-initialize" an existing repository which
can move the .git directory. After which, git would just repair all the
worktrees. This worked fine for absolute paths as the `gitdir` files
still contained the absolute paths. However, for relative paths, both
of the linking files need to be updated (and I need to know the original
location of the `.git` directory to do so). This function was created
in the previous topic to handle this case.

> My understanding of what this function is trying to do is rather limited
> but as far as I can see the conversion looks OK though the strbuf
> changes are quite distracting.

Yeah, I was able to clean up a lot because of the new `write_worktree_linki=
ng_files()`
function.

>> +++ b/t/t0001-init.sh
>> @@ -434,6 +434,12 @@ test_expect_success SYMLINKS 're-init to move gitdi=
r symlink' '
>>   sep_git_dir_worktree ()  {
>>   =09test_when_finished "rm -rf mainwt linkwt seprepo" &&
>>   =09git init mainwt &&
>> +=09if test "relative" =3D $2
>> +=09then
>> +=09=09git -C mainwt config worktree.useRelativePaths true
>
> test_config is your friend here (it accepts -C <repo>)

Updated, thanks!

Best,

Caleb

