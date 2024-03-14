Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3D974415
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434757; cv=none; b=ZGJNx/Zc79o+JdwPjHiJhvSoZbZkVwgPc6FzbijekwgdAHxH7IPNaDjcIFmvXEX0zFNTLLmgo52K7tJteHBBkJLrGX2EHIbFZe8Cg5ZqTpa8KH0AzSxfhFBnqomcGrpKzMWsnzerEyRFkXLK6RPF6Z+kESkgz7DZD2GbLyxDwhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434757; c=relaxed/simple;
	bh=j5ilpmJi35WnDORndLDceeqivm9VRYtEu3x5pcfUY+4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kQxsVYkIiXpLmfzSmYwIGqxS9EIDchnP/ZcUifGrehWrl3rHVJ5kRhwxenz03chAjW+ldeuV/J+qw1xLmBeMYP+Br3UNehKkI9+Acr75+xsPBc8zzeF0HGdOWi84HmlkKzyaZTMLVMA9w/kzx0QwXkA0s2IP3/v1GFb3yJ35nLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jCERF9af; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jCERF9af"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D151E29750;
	Thu, 14 Mar 2024 12:45:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=j5ilpmJi35Wn
	DORndLDceeqivm9VRYtEu3x5pcfUY+4=; b=jCERF9afXIV0jVKBVKejJlbOptgI
	rm0PxMxRKKvbgmUJ+Bo6zucUF/5QmsPBMcrLJarIDfJjm5fP4HttqYTPshYuVcc/
	d6xRO39qS5+C2NpQQUSq9lMbcUG6h5iM+wY33PkuR1HN5U6Ru+ombZ1zt4kFbHSc
	II5dkGu7UezPuCo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C9C632974F;
	Thu, 14 Mar 2024 12:45:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 68C1F2974B;
	Thu, 14 Mar 2024 12:45:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] checkout: plug some leaks in git-restore
In-Reply-To: <8faa0cd5-25e8-4a8f-ad8b-5fc1b6e5138b@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Thu, 14 Mar 2024 08:36:25 +0100")
References: <04a9e001-5cd6-402c-86eb-f3751aa6f354@gmail.com>
	<8faa0cd5-25e8-4a8f-ad8b-5fc1b6e5138b@gmail.com>
Date: Thu, 14 Mar 2024 09:45:51 -0700
Message-ID: <xmqqbk7gwym8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 51D01556-E222-11EE-AD04-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> In git-restore we need to free the pathspec and pathspec_from_file
> values from the struct checkout_opts.
>
> A simple fix could be to free them in cmd_restore, after the call to
> checkout_main returns, like we are doing [1][2] in the sibling function
> cmd_checkout.
>
> However, we can do better.

Quite honestly, my knee-jerk raction against _main_1() was "Yuck".

If the repetition of "here are the things we need to clean up"
shared in the current checkout_main() looks so disturbing, I would
have gone in the opposite direction: the current callers of _main()
will do these clean-up actions after the call to _main() returns, so
bundle them into a helper function and call it from the callers of
_main(), without introducing an extra layer of opacity, and I would
have thought that would be what we would call "doing better".

Even better, shouldn't you be able to do much better by not doing
the _main_1() thing at all?  If you look at checkout_main(), the
only way to leave thsi function, aside from die()'s, are "return"
statements to the caller at the very end of the function.  You
should be able to, instead of returning, capture the value you
receive from calling either checkout_paths() or checkout_branch(),
and then do the common "clean-up" you stole from existing calls and
moved into _main_1(), and after doing so, return the value you
captured from one of these calls that used to directly return, no?

Perhaps something along this line, which should be an equilvalent to
what your patch did?

 builtin/checkout.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git c/builtin/checkout.c w/builtin/checkout.c
index 15293a3013..a8ccdfa1f2 100644
--- c/builtin/checkout.c
+++ w/builtin/checkout.c
@@ -1706,6 +1706,7 @@ static int checkout_main(int argc, const char **arg=
v, const char *prefix,
 			 struct branch_info *new_branch_info)
 {
 	int parseopt_flags =3D 0;
+	int retval;
=20
 	opts->overwrite_ignore =3D 1;
 	opts->prefix =3D prefix;
@@ -1900,9 +1901,16 @@ static int checkout_main(int argc, const char **ar=
gv, const char *prefix,
 	}
=20
 	if (opts->patch_mode || opts->pathspec.nr)
-		return checkout_paths(opts, new_branch_info);
+		retval =3D checkout_paths(opts, new_branch_info);
 	else
-		return checkout_branch(opts, new_branch_info);
+		retval =3D checkout_branch(opts, new_branch_info);
+
+	branch_info_release(new_branch_info);
+	clear_pathspec(&opts->pathspec);
+	free(opts->pathspec_from_file);
+	FREE_AND_NULL(options);
+
+	return retval;
 }
=20
 int cmd_checkout(int argc, const char **argv, const char *prefix)
@@ -1953,10 +1961,6 @@ int cmd_checkout(int argc, const char **argv, cons=
t char *prefix)
=20
 	ret =3D checkout_main(argc, argv, prefix, &opts,
 			    options, checkout_usage, &new_branch_info);
-	branch_info_release(&new_branch_info);
-	clear_pathspec(&opts.pathspec);
-	free(opts.pathspec_from_file);
-	FREE_AND_NULL(options);
 	return ret;
 }
=20
@@ -1997,8 +2001,6 @@ int cmd_switch(int argc, const char **argv, const c=
har *prefix)
=20
 	ret =3D checkout_main(argc, argv, prefix, &opts,
 			    options, switch_branch_usage, &new_branch_info);
-	branch_info_release(&new_branch_info);
-	FREE_AND_NULL(options);
 	return ret;
 }
=20
@@ -2036,7 +2038,5 @@ int cmd_restore(int argc, const char **argv, const =
char *prefix)
=20
 	ret =3D checkout_main(argc, argv, prefix, &opts,
 			    options, restore_usage, &new_branch_info);
-	branch_info_release(&new_branch_info);
-	FREE_AND_NULL(options);
 	return ret;
 }



[Footnote]

It is somewhat funny that we are moving more things into the
checkout_main() common function.  Maybe the true culprit of this
mess was that the approach for splitting "switch" and "restore" out
of "checkout" was misdesigned.

People were so loudly against "checkout" that can check out a
branch, or check out files and directories out of a commit, and that
was why these two separate commands to do these two separate things
were created.  But instead of two separate functions that do two
separate and unrelated things, and making "checkout" call either one
of these depending on which one of the two separate things it is
asked to do, we ended up in a state where a single function _main()
is shared among the three, which may have solved the "these two are
separate operations and having them crammed together into one
command is confusing from the user's point of view" complaint, but
these two operations are still tightly coupled.  The fact that the
things that need to be cleaned up after calling checkout_paths() and
checkout_branch() are identical is quite telling ;-)

