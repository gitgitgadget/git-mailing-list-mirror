From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] difftool: fix dir-diff when file does not exist in working tree
Date: Fri, 17 May 2013 11:10:40 -0700
Message-ID: <7v38tlzdcv.fsf@alter.siamese.dyndns.org>
References: <de6690bea81de561747ca49893fbc77fa3eb8529.1368811736.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kevin Bracey <kevin@bracey.fi>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri May 17 20:10:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdP7A-0002ZG-Aw
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 20:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753749Ab3EQSKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 14:10:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43756 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752927Ab3EQSKn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 14:10:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DF6B1C72C;
	Fri, 17 May 2013 18:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+WLs+CwIZw3rCVWJq40cfI3oCUo=; b=lIgBv8
	EORrGiDzKQfGl2AQAD0MixBtvnAlh/0Aq0K2GJSrWrvukREv6sN8ld7Q/wiGf6zu
	PqXPE82QMCegMIZyUEXku+7PO6UfTsR/vJvS5Bv5Fjx3oNmMYt9saxag19wgDMhP
	/63zXtSqlU+jXNtLn5VRyo46boNdc1RHsRjfY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fbK8EZvHXPes2TqPBwk+T/wVDM+UiOln
	Q1b13r2uZe3LHyupnFqpPv1SvQeYFSB9XaEo8JBjjMrXqbLTYDPvHy68ycPaYN6y
	ToBqwTvMUWXcmR+eWGlzoCqFh2sf4vlDYLPexz9SBzErKlwXrte4pvAhxlJBYxlZ
	ppSyl5HivnI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 101651C72B;
	Fri, 17 May 2013 18:10:43 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5AAA61C725;
	Fri, 17 May 2013 18:10:42 +0000 (UTC)
In-Reply-To: <de6690bea81de561747ca49893fbc77fa3eb8529.1368811736.git.john@keeping.me.uk>
	(John Keeping's message of "Fri, 17 May 2013 18:29:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 164F3D24-BF1D-11E2-92BC-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224726>

John Keeping <john@keeping.me.uk> writes:

> Commit 02c5631 (difftool --dir-diff: symlink all files matching the
> working tree, 2013-03-14) does not handle the case where a file that is
> being compared does not exist in the working tree.  Fix this by checking
> for existence explicitly before running git-hash-object.
>
> Reported-by: Kevin Bracey <kevin@bracey.fi>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
> This fixes a regression in 1.8.3-rc0.
>
>  git-difftool.perl   | 9 ++++++++-
>  t/t7800-difftool.sh | 7 +++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/git-difftool.perl b/git-difftool.perl
> index 6780292..0a1cb0a 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -92,7 +92,14 @@ sub use_wt_file
>  		return 0;
>  	}
>  
> -	my $wt_sha1 = $repo->command_oneline('hash-object', "$workdir/$file");
> +	my $wt_sha1;
> +	if (-e "$workdir/$file") {
> +		$wt_sha1 = $repo->command_oneline('hash-object', "$workdir/$file");
> +	} else {
> +		# If the file doesn't exist in the working tree, use something
> +		# that cannot match a SHA-1.
> +		$wt_sha1 = '';

Yuck.

"that cannot match" might be a good justification to say "this does
not break the next line to set $use and forces it to false", but
"when we return false in $use, the value of $wt_sha1 is not used"
needs to be said to convince why this is a safe change.

But if $sha1 is $null_sha1, we do end up setting $use to true and
the caller would stuff the empty $wt_sha1 to form:

	$wtindex .= "$rmode \$dst_path\0";

Is that what we want to do here, or is it a "will never happen"
condition?  If the latter, the reason need to be described in this
comment (and in the log).

Thanks.

> +	};
>  	my $use = ($sha1 eq $null_sha1) || ($sha1 eq $wt_sha1);
>  	return ($use, $wt_sha1);
>  }
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index a6bd99e..d46f041 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -356,6 +356,13 @@ run_dir_diff_test 'difftool --dir-diff from subdirectory' '
>  	)
>  '
>  
> +run_dir_diff_test 'difftool --dir-diff when worktree file is missing' '
> +	test_when_finished git reset --hard &&
> +	rm file2 &&
> +	git difftool --dir-diff $symlinks --extcmd ls branch master >output &&
> +	grep file2 output
> +'
> +
>  write_script .git/CHECK_SYMLINKS <<\EOF
>  for f in file file2 sub/sub
>  do
