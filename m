Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA731C433DB
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 21:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5304D23A82
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 21:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbhAIVlB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 16:41:01 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51479 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbhAIVlB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 16:41:01 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 44A04113DD7;
        Sat,  9 Jan 2021 16:40:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YVTMcT22FAl9
        TuYBLGiFq3BSEgs=; b=VRoVXAKKcM8M+mD38EhOUqdgUDKKuASRp060kWtv87SX
        pWvV3TgA7OTjEeBo59OYMuq35oWzH0lMWN6wIdzq7NaKRc2qv5qIBDDmfWvEy5kn
        eMM5jyF7tLBrialSfmnD+sSqhiINyIA83I++qIo6LdL3qVw/UUm7ECtm7/+n9rQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=AlqqZ3
        LA2Nuvk8euX1fzMzq9DYDFkbXTxa6/UiWNPlLtud5CX+70I1F8NjzakiQdR5jRSD
        ccyKr0SDujBzc3wE9Ccqm4fIYpNfWUCW+0AMiKGRnF9ubRL+4DpnF4gPdtWWHenF
        jZzZ2A9IJ1u80zd3wgu6sgJIdPO/JiPu/bvmM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3D8FF113DD6;
        Sat,  9 Jan 2021 16:40:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 834A5113DD5;
        Sat,  9 Jan 2021 16:40:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] t7800-difftool: don't accidentally match tmp dirs
References: <20210108092036.GR8396@szeder.dev>
        <20210109170513.31084-1-szeder.dev@gmail.com>
Date:   Sat, 09 Jan 2021 13:40:09 -0800
In-Reply-To: <20210109170513.31084-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Sat, 9 Jan 2021 18:05:13 +0100")
Message-ID: <xmqqft39g56u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 40481532-52C3-11EB-AB52-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> In a bunch of test cases in 't7800-difftool.sh' we 'grep' for specific
> filenames in 'git difftool's output, and those test cases are prone to
> occasional failures because those filenames might be part of the name
> of difftool's temporary directory as well, e.g.:
>
>   +git difftool --dir-diff --no-symlinks --extcmd ls v1
>   +grep sub output
>   +test_line_count =3D 2 sub-output
>   test_line_count: line count for sub-output !=3D 2
>   /tmp/git-difftool.Ssubfq/left/:
>   sub
>   /tmp/git-difftool.Ssubfq/right/:
>   sub
>   error: last command exited with $?=3D1
>   not ok 50 - difftool --dir-diff v1 from subdirectory --no-symlinks
>
> Fix this by tightening the 'grep' patterns looking for those
> interesting filenames to match only lines where a filename stands on
> its own.

OK.  I thought that your previous "we know not just we want to see
sub and file anywhere in the output, but we want them to appear in
this order" attempt was nicer, especially when dealing with the
directory diff output.  That was why I suggested to "normalize" the
lines that report the directory path with a sed script, instead of
removing them with "grep -v", and change the condition to tell if a
line is a directory from "^/" to "/:$".

But the approach taken with this round is much simpler.  When we
only care about 'sub' and 'file' in the output, for example, we used
to just grep for these strings, allowing substring matches.  Now we
make sure the lines we consider matches contain these tokens we want
to see and nothing else.  It focuses on only fixing the bug, without
attempting to "improve" the tests while at it.  And it is certainly
simpler to explain the change between the version before this patch
and the version with this patch.

Thanks.



> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  t/t7800-difftool.sh | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index a578b35761..32291fb67b 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -440,20 +440,20 @@ run_dir_diff_test () {
> =20
>  run_dir_diff_test 'difftool -d' '
>  	git difftool -d $symlinks --extcmd ls branch >output &&
> -	grep sub output &&
> -	grep file output
> +	grep "^sub$" output &&
> +	grep "^file$" output
>  '
> =20
>  run_dir_diff_test 'difftool --dir-diff' '
>  	git difftool --dir-diff $symlinks --extcmd ls branch >output &&
> -	grep sub output &&
> -	grep file output
> +	grep "^sub$" output &&
> +	grep "^file$" output
>  '
> =20
>  run_dir_diff_test 'difftool --dir-diff ignores --prompt' '
>  	git difftool --dir-diff $symlinks --prompt --extcmd ls branch >output=
 &&
> -	grep sub output &&
> -	grep file output
> +	grep "^sub$" output &&
> +	grep "^file$" output
>  '
> =20
>  run_dir_diff_test 'difftool --dir-diff branch from subdirectory' '
> @@ -462,11 +462,11 @@ run_dir_diff_test 'difftool --dir-diff branch fro=
m subdirectory' '
>  		git difftool --dir-diff $symlinks --extcmd ls branch >output &&
>  		# "sub" must only exist in "right"
>  		# "file" and "file2" must be listed in both "left" and "right"
> -		grep sub output >sub-output &&
> +		grep "^sub$" output >sub-output &&
>  		test_line_count =3D 1 sub-output &&
> -		grep file"$" output >file-output &&
> +		grep "^file$" output >file-output &&
>  		test_line_count =3D 2 file-output &&
> -		grep file2 output >file2-output &&
> +		grep "^file2$" output >file2-output &&
>  		test_line_count =3D 2 file2-output
>  	)
>  '
> @@ -477,11 +477,11 @@ run_dir_diff_test 'difftool --dir-diff v1 from su=
bdirectory' '
>  		git difftool --dir-diff $symlinks --extcmd ls v1 >output &&
>  		# "sub" and "file" exist in both v1 and HEAD.
>  		# "file2" is unchanged.
> -		grep sub output >sub-output &&
> +		grep "^sub$" output >sub-output &&
>  		test_line_count =3D 2 sub-output &&
> -		grep file output >file-output &&
> +		grep "^file$" output >file-output &&
>  		test_line_count =3D 2 file-output &&
> -		! grep file2 output
> +		! grep "^file2$" output
>  	)
>  '
> =20
> @@ -491,9 +491,9 @@ run_dir_diff_test 'difftool --dir-diff branch from =
subdirectory w/ pathspec' '
>  		git difftool --dir-diff $symlinks --extcmd ls branch -- .>output &&
>  		# "sub" only exists in "right"
>  		# "file" and "file2" must not be listed
> -		grep sub output >sub-output &&
> +		grep "^sub$" output >sub-output &&
>  		test_line_count =3D 1 sub-output &&
> -		! grep file output
> +		! grep "^file$" output
>  	)
>  '
> =20
> @@ -503,9 +503,9 @@ run_dir_diff_test 'difftool --dir-diff v1 from subd=
irectory w/ pathspec' '
>  		git difftool --dir-diff $symlinks --extcmd ls v1 -- .>output &&
>  		# "sub" exists in v1 and HEAD
>  		# "file" is filtered out by the pathspec
> -		grep sub output >sub-output &&
> +		grep "^sub$" output >sub-output &&
>  		test_line_count =3D 2 sub-output &&
> -		! grep file output
> +		! grep "^file$" output
>  	)
>  '
> =20
> @@ -518,8 +518,8 @@ run_dir_diff_test 'difftool --dir-diff from subdire=
ctory with GIT_DIR set' '
>  		cd sub &&
>  		git difftool --dir-diff $symlinks --extcmd ls \
>  			branch -- sub >output &&
> -		grep sub output &&
> -		! grep file output
> +		grep "^sub$" output &&
> +		! grep "^file$" output
>  	)
>  '
> =20
> @@ -527,7 +527,7 @@ run_dir_diff_test 'difftool --dir-diff when worktre=
e file is missing' '
>  	test_when_finished git reset --hard &&
>  	rm file2 &&
>  	git difftool --dir-diff $symlinks --extcmd ls branch master >output &=
&
> -	grep file2 output
> +	grep "^file2$" output
>  '
> =20
>  run_dir_diff_test 'difftool --dir-diff with unmerged files' '
