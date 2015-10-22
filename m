From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] difftool: gracefully handle symlinks to directories
Date: Thu, 22 Oct 2015 11:23:54 -0700
Message-ID: <xmqq8u6usqx1.fsf@gitster.mtv.corp.google.com>
References: <1445414673-15307-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ismail Badawi <ismail@badawi.io>,
	John Keeping <john@keeping.me.uk>,
	Tim Henigan <tim.henigan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 20:24:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpKWz-0007xk-5E
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 20:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757458AbbJVSYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 14:24:00 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57773 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757469AbbJVSX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 14:23:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9122723CC0;
	Thu, 22 Oct 2015 14:23:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4bLcv8j2f8gm1WMxlq1m/IJjmr0=; b=rzs5L7
	NO82+EYNAJBGPXeIanwtbrMaHiIRGS3JmwZw73llZrAaCkaIDZkvYF9LAi7DwTiF
	t1PjCaIRi8M6cp7pned8Z6WDLnh1rmg/NUrzF6wp3wltuAfYyLm6Qg+pWhNy3Y/A
	8UXIiHqaJJ1pd+cKhF6MqJqwMZdq983YMt8N0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oYkWmBNBIJIFgKbGxsC8osEEAMUQIzD2
	otfjTwVSax22M3+2/jXGJfeDAf2DiVl+SBvQbZhv8cOrObgB2zoj6bQQz5CAxj8v
	u2I6SIKutM0tW6BNAcjvF+rB4l92R28hU1kInuVf8ce/Zj4n5ZN0zwlJGTa1xvke
	G3xPECfvK1s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8899223CBF;
	Thu, 22 Oct 2015 14:23:56 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F07D623CBE;
	Thu, 22 Oct 2015 14:23:55 -0400 (EDT)
In-Reply-To: <1445414673-15307-1-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Wed, 21 Oct 2015 01:04:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0E2A0E9C-78EA-11E5-986A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280068>

David Aguilar <davvid@gmail.com> writes:

> difftool's dir-diff feature was blindly feeding worktree paths
> to hash-object without checking whether the path was indeed a
> file, causing the feature to fail when repositories contain
> symlinks to directories.

Wait.  Anything that considers symlinks "to directories" any special
smells like a misdesign here.  Why is it safe to substitute a
symbolic link that happens to point at a file with the file it
points at?

Because the way you would hash a symblic link is not by hashing the
file it points at, but by hashing the result of readlink(2) of it,
we must not reuse the working tree files for any symbolic link,
regardless of its target, I would think.

After all, a symbolic link may even be dangling and not pointing at
anything.

>
> Ensure that only files are ever given to hash-object.
> Add a test to demonstrate the breakage.
>
> Reported-by: Ismail Badawi <ismail@badawi.io>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  git-difftool.perl   |  4 +---
>  t/t7800-difftool.sh | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/git-difftool.perl b/git-difftool.perl
> index 7df7c8a..1abe647 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -70,9 +70,7 @@ sub use_wt_file
>  	my ($repo, $workdir, $file, $sha1) = @_;
>  	my $null_sha1 = '0' x 40;
>  
> -	if (! -e "$workdir/$file") {
> -		# If the file doesn't exist in the working tree, we cannot
> -		# use it.
> +	if (! -f "$workdir/$file") {
>  		return (0, $null_sha1);
>  	}
>  
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index 48c6e2b..ec8bc8c 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -504,4 +504,23 @@ test_expect_success PERL 'difftool properly honors gitlink and core.worktree' '
>  	)
>  '
>  
> +test_expect_success PERL,SYMLINKS 'difftool --dir-diff symlinked directories' '
> +	git init dirlinks &&
> +	(
> +		cd dirlinks &&
> +		git config diff.tool checktrees &&
> +		git config difftool.checktrees.cmd "echo good" &&
> +		mkdir foo &&
> +		: >foo/bar &&
> +		git add foo/bar &&
> +		test_commit symlink-one &&
> +		ln -s foo link &&
> +		git add link &&
> +		test_commit symlink-two &&
> +		echo good >expect &&
> +		git difftool --tool=checktrees --dir-diff HEAD~ >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  test_done
