From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] difftool --dir-diff: allow changing any clean working tree file
Date: Wed, 29 May 2013 12:52:20 -0700
Message-ID: <7vfvx5sgwb.fsf@alter.siamese.dyndns.org>
References: <7v7gij0w6z.fsf@alter.siamese.dyndns.org>
	<1369843283-2328-1-git-send-email-nitoyon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: Kenichi Saita <nitoyon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 21:52:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhmQ9-0000N9-Ku
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 21:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759635Ab3E2TwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 15:52:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50645 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759240Ab3E2TwX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 15:52:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F207F2335D;
	Wed, 29 May 2013 19:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DtWIdVnx+m8gCA7qdrCievnaZrg=; b=NvmRBo
	9gXc7WQ/TybhI3Mw20L6LxzE9W5a6QgsZWEmu+uFumxzm1mhQmsKSKar4xziLJpw
	E0kvZ6oFkEFzIrixHAroZcWoPLl9kiIU2kCe0BbXNSBw7HLb/x5FvbLkr+HsHrvp
	8Lj8G26cNdRTE/nx7ClJD8qEBNV0rDOO+qJd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OC9eSPdzEJB23HTUEdRXm2UD5a1pF4Jp
	8kWJ362Y8HrUrHFEkyLtcAjDm7l9YQpOy696wt37Uezog8nrbzqF2sopaK2mjjzH
	14VAlRkVNZnTxMTt/sOq+h7ft1ONnad1ZGauG4TW6ZwhHtvgPmLCubVkEXowpTWZ
	k3hwHAvnshQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E57BD2335C;
	Wed, 29 May 2013 19:52:22 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B69B23356;
	Wed, 29 May 2013 19:52:22 +0000 (UTC)
In-Reply-To: <1369843283-2328-1-git-send-email-nitoyon@gmail.com> (Kenichi
	Saita's message of "Thu, 30 May 2013 01:01:23 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4713873C-C899-11E2-B360-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225879>

Kenichi Saita <nitoyon@gmail.com> writes:

> The temporary directory prepared by "difftool --dir-diff" to
> show the result of a change can be modified by the user via
> the tree diff program, and we try hard not to lose changes
> to them after tree diff program returns to us.

Thanks; will queue (unless there are other suggestions, in which
case we can polish it further while it is on 'pu').

>
> However, the set of files to be copied back is computed
> differently between --symlinks and --no-symlinks modes.  The
> former checks all paths that start out as identical to the
> working tree file, while the latter checks paths that
> already had a local modification in the working tree,
> allowing changes made in the tree diff program to paths that
> did not have any local change to be lost.
>
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
