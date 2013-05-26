From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] difftool --dir-diff: copy back all files matching the
 working tree
Date: Sun, 26 May 2013 16:44:29 +0100
Message-ID: <20130526154429.GK27005@serenity.lan>
References: <1369580446-32597-1-git-send-email-nitoyon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Kenichi Saita <nitoyon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 26 17:44:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ugd7s-0006BP-Kv
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 17:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048Ab3EZPoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 May 2013 11:44:37 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:50227 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018Ab3EZPoh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 May 2013 11:44:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 6EC616064EC;
	Sun, 26 May 2013 16:44:36 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b8S0vxmw0upy; Sun, 26 May 2013 16:44:35 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 67F536064E5;
	Sun, 26 May 2013 16:44:30 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1369580446-32597-1-git-send-email-nitoyon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225554>

On Mon, May 27, 2013 at 12:00:46AM +0900, Kenichi Saita wrote:
> After running the user's diff tool, "git difftool --dir-dif --no-symlink"
> currently copied back a temporary file to working tree only when a file
> contains unstaged changes in the working tree.
> 
> Change this behavior so that temporary files are copied back to working
> tree whenever the right-hand side of the comparison has the same SHA1
> as the file in the working tree.
> 
> Signed-off-by: Kenichi Saita <nitoyon@gmail.com>

This change looks sensible to me, but I found the commit message quite
confusing.

The code being changed here is to do with choosing whether to copy the
working tree file to the temporary directory (or symlink it) and hence
only indirectly related to whether it will be copied back.  It might be
clearer to phrase it like this:

    difftool --dir-diff: always use identical working tree file

    When deciding whether or not we should link a working tree file into
    the temporary right-hand directory for a directory diff, we
    currently behave differently in the --symlink and --no-symlink
    cases.  If using symlinks any identical files are linked across but
    with --no-symlink only files that contain unstaged changes are
    copied.

    Change this so that identical files are copied across as well.  This
    is beneficial because it widens the set of circumstances in which we
    copy changes made by the user back into the working tree.

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
> -- 
> 1.7.1
