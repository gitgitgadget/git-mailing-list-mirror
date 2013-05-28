From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] difftool --dir-diff: always use identical working tree file
Date: Tue, 28 May 2013 11:06:13 -0700
Message-ID: <7vbo7v0yju.fsf@alter.siamese.dyndns.org>
References: <20130526154429.GK27005@serenity.lan>
	<1369668697-1016-1-git-send-email-nitoyon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: Kenichi Saita <nitoyon@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 28 20:06:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhOHu-0006oQ-4P
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 20:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936Ab3E1SGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 14:06:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54000 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964931Ab3E1SGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 14:06:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1D292377A;
	Tue, 28 May 2013 18:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6ovcPk7YDwwFYssuAzP1FlwXlxA=; b=gquaY+
	0t0+Kty7/zTlIsCJPfMBRI/XrXDQKazbBIP5pwDoqKpT/8VUPSCBLMJIEHtRdMpr
	0J241ZqB1zGH4jX8W6Ru9b08bj8FtcSlnnEUK3UC5nVyn4gyMkeGChu2Fh4RR4lU
	Ydl0QFKQQiEnIUiI34WJJib3O8z6pxSK6oyQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uqeTIzFOU7h7M6VTIIh5N58qa3fOgAcF
	T4P9Pn9+X2nip0zfJFC/Pq+BqrvIoE/I3ty2USPPVV5x8SnY/lF1XYvjLjIZ2o2C
	y4sqmrP6O41PgCuvt4MawOn89roTFFfhAq5adzXjkLU+sYjFnyi8qIYOMuvv/1i/
	Q75Vn0HDRkc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5BC323779;
	Tue, 28 May 2013 18:06:15 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF78623777;
	Tue, 28 May 2013 18:06:14 +0000 (UTC)
In-Reply-To: <1369668697-1016-1-git-send-email-nitoyon@gmail.com> (Kenichi
	Saita's message of "Tue, 28 May 2013 00:31:37 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 49666758-C7C1-11E2-A602-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225677>

Kenichi Saita <nitoyon@gmail.com> writes:

> When deciding whether or not we should link a working tree file into
> the temporary right-hand directory for a directory diff, we
> currently behave differently in the --symlink and --no-symlink
> cases.  If using symlinks any identical files are linked across but
> with --no-symlink only files that contain unstaged changes are
> copied back into the working tree.

I may have missed an earlier discussion, but I do not follow the
last sentence.  The former part (i.e. symlinks) talks about what is
done to populate the temporary tree (i.e. everything is linked), but
the latter part (i.e. not symlinks) only talks about what is copied
back, i.e. it is not a contrast between the behaviour of symlink vs
no-symlink case wrt how the temporary tree is populated.

Confused...

> Change this so that identical files are copied back as well.  This
> is beneficial because it widens the set of circumstances in which we
> copy changes made by the user back into the working tree.

Ah, OK, you meant that the set of files we keep in @working_tree
array for later copying back are different between the two.

> Signed-off-by: Kenichi Saita <nitoyon@gmail.com>
> ---
>  git-difftool.perl   |    9 ++-------
>  t/t7800-difftool.sh |   19 +++++++++++++++++++
>  2 files changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/git-difftool.perl b/git-difftool.perl
> index 8a75205..e57d3d1 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -85,13 +85,9 @@ sub exit_cleanup
>  
>  sub use_wt_file
>  {
> -	my ($repo, $workdir, $file, $sha1, $symlinks) = @_;
> +	my ($repo, $workdir, $file, $sha1) = @_;
>  	my $null_sha1 = '0' x 40;
>  
> -	if ($sha1 ne $null_sha1 and not $symlinks) {
> -		return 0;
> -	}
> -
>  	if (! -e "$workdir/$file") {
>  		# If the file doesn't exist in the working tree, we cannot
>  		# use it.
> @@ -213,8 +209,7 @@ EOF
>  
>  		if ($rmode ne $null_mode) {
>  			my ($use, $wt_sha1) = use_wt_file($repo, $workdir,
> -							  $dst_path, $rsha1,
> -							  $symlinks);
> +							  $dst_path, $rsha1);
>  			if ($use) {
>  				push @working_tree, $dst_path;
>  				$wtindex .= "$rmode $wt_sha1\t$dst_path\0";
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index d46f041..2418528 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -385,6 +385,25 @@ test_expect_success PERL,SYMLINKS 'difftool --dir-diff --symlink without unstage
>  	test_cmp actual expect
>  '
>  
> +write_script modify-right-file <<\EOF
> +echo "new content" >"$2/file"
> +EOF
> +
> +run_dir_diff_test 'difftool --dir-diff syncs worktree with unstaged change' '
> +	test_when_finished git reset --hard &&
> +	echo "orig content" >file &&
> +	git difftool -d $symlinks --extcmd "$(pwd)/modify-right-file" branch &&
> +	echo "new content" >expect &&
> +	test_cmp expect file
> +'
> +
> +run_dir_diff_test 'difftool --dir-diff syncs worktree without unstaged change' '
> +	test_when_finished git reset --hard &&
> +	git difftool -d $symlinks --extcmd "$(pwd)/modify-right-file" branch &&
> +	echo "new content" >expect &&
> +	test_cmp expect file
> +'
> +
>  write_script modify-file <<\EOF
>  echo "new content" >file
>  EOF
