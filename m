From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] difftool: don't overwrite modified files
Date: Fri, 29 Mar 2013 13:20:50 -0700
Message-ID: <7v38venejh.fsf@alter.siamese.dyndns.org>
References: <cover.1364555970.git.john@keeping.me.uk>
 <8028ebdca0a219b44123a813d6bd8b95d076f2e9.1364555970.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Matt McClure <matthewlmcclure@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Mar 29 21:21:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULfnf-0002vm-Ai
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 21:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756769Ab3C2UUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 16:20:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52123 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756478Ab3C2UUw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 16:20:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42A0DFF76;
	Fri, 29 Mar 2013 20:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UzubmoGR+KLs0kC66hql4pBsJDs=; b=A0gu/3
	qvMTcahCVsDCWFGDjXq+VZqFH/JgNqGBthxQq91d4OJoNamMqAga8c2o8v/87HPy
	BUI75JhMINSVKE1rGWrLTcWhIiMml50ChmsyOIGhaXWOuErhiIIXVPUQZIVVfrYX
	anoEf9RfwK2jf5enp5XnZkr0u3IZnH+yuryvY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dsao+ljvuu7a8557D4m1plsAnopttatv
	nVLqKadWaKesmMwQVrE4ZbaKK4Bq6WRN+QtTImKF/Dsdd4mHijZnHW161Cm9vUeB
	q8BIrN4wtlThR3/35cOAtqvVOiD3Xit8oPi0LnvtddgG+9OqPWVVndrufXpXkTr4
	Iw4lO8Ozoh8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A801FF75;
	Fri, 29 Mar 2013 20:20:52 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 66885FF73; Fri, 29 Mar 2013
 20:20:51 +0000 (UTC)
In-Reply-To: <8028ebdca0a219b44123a813d6bd8b95d076f2e9.1364555970.git.john@keeping.me.uk>
 (John Keeping's message of "Fri, 29 Mar 2013 11:28:33 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 26AC7DCA-98AE-11E2-8247-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219526>

John Keeping <john@keeping.me.uk> writes:

> After running the user's diff tool, git-difftool will copy any files
> that differ between the working tree and the temporary tree.  This is
> useful when the user edits the file in their diff tool but is wrong if
> they edit the working tree file while examining the diff.

Thanks.

I should drop the t7800-modernize topic and queue this under a
better name.  Perhaps "difftool-no-overwrite-on-copyback", or
something.

> Instead of copying unconditionally when the files differ, create and
> index from the working tree files and only copy the temporary file back
> if it was modified and the working tree file was not.  If both files
> have been modified, print a warning and exit with an error.
>
> Note that we cannot use an existing index in git-difftool since those
> contain the modified files that need to be checked out but here we are
> looking at those files which are copied from the working tree and not
> checked out.  These are precisely the files which are not in the
> existing indices.


>
> Signed-off-by: John Keeping <john@keeping.me.uk>
>
> ---
> Changes since v2:
> - Set TMPDIR to $TRASH_DIRECTORY in the test where difftool fails
>
>  git-difftool.perl   | 73 +++++++++++++++++++++++++++++++++++++++++++----------
>  t/t7800-difftool.sh | 30 ++++++++++++++++++++++
>  2 files changed, 89 insertions(+), 14 deletions(-)
>
> diff --git a/git-difftool.perl b/git-difftool.perl
> index 663640d..844f619 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -13,9 +13,9 @@
>  use 5.008;
>  use strict;
>  use warnings;
> +use Error qw(:try);
>  use File::Basename qw(dirname);
>  use File::Copy;
> -use File::Compare;
>  use File::Find;
>  use File::stat;
>  use File::Path qw(mkpath rmtree);
> @@ -88,14 +88,45 @@ sub use_wt_file
>  	my ($repo, $workdir, $file, $sha1, $symlinks) = @_;
>  	my $null_sha1 = '0' x 40;
>  
> -	if ($sha1 eq $null_sha1) {
> -		return 1;
> -	} elsif (not $symlinks) {
> +	if ($sha1 ne $null_sha1 and not $symlinks) {
>  		return 0;
>  	}
>  
>  	my $wt_sha1 = $repo->command_oneline('hash-object', "$workdir/$file");
> -	return $sha1 eq $wt_sha1;
> +	my $use = ($sha1 eq $null_sha1) || ($sha1 eq $wt_sha1);
> +	return ($use, $wt_sha1);
> +}
> +
> +sub changed_files
> +{
> +	my ($repo_path, $index, $worktree) = @_;
> +	$ENV{GIT_INDEX_FILE} = $index;
> +	$ENV{GIT_WORK_TREE} = $worktree;
> +	my $must_unset_git_dir = 0;
> +	if (not defined($ENV{GIT_DIR})) {
> +		$must_unset_git_dir = 1;
> +		$ENV{GIT_DIR} = $repo_path;
> +	}
> +
> +	my @refreshargs = qw/update-index --really-refresh -q --unmerged/;
> +	my @gitargs = qw/diff-files --name-only -z/;
> +	try {
> +		Git::command_oneline(@refreshargs);
> +	} catch Git::Error::Command with {};
> +
> +	my $line = Git::command_oneline(@gitargs);
> +	my @files;
> +	if (defined $line) {
> +		@files = split('\0', $line);
> +	} else {
> +		@files = ();
> +	}
> +
> +	delete($ENV{GIT_INDEX_FILE});
> +	delete($ENV{GIT_WORK_TREE});
> +	delete($ENV{GIT_DIR}) if ($must_unset_git_dir);
> +
> +	return map { $_ => 1 } @files;
>  }
>  
>  sub setup_dir_diff
> @@ -121,6 +152,7 @@ sub setup_dir_diff
>  	my $null_sha1 = '0' x 40;
>  	my $lindex = '';
>  	my $rindex = '';
> +	my $wtindex = '';
>  	my %submodule;
>  	my %symlink;
>  	my @working_tree = ();
> @@ -174,8 +206,12 @@ EOF
>  		}
>  
>  		if ($rmode ne $null_mode) {
> -			if (use_wt_file($repo, $workdir, $dst_path, $rsha1, $symlinks)) {
> -				push(@working_tree, $dst_path);
> +			my ($use, $wt_sha1) = use_wt_file($repo, $workdir,
> +							  $dst_path, $rsha1,
> +							  $symlinks);
> +			if ($use) {
> +				push @working_tree, $dst_path;
> +				$wtindex .= "$rmode $wt_sha1\t$dst_path\0";
>  			} else {
>  				$rindex .= "$rmode $rsha1\t$dst_path\0";
>  			}
> @@ -218,6 +254,12 @@ EOF
>  	$rc = system('git', 'checkout-index', '--all', "--prefix=$rdir/");
>  	exit_cleanup($tmpdir, $rc) if $rc != 0;
>  
> +	$ENV{GIT_INDEX_FILE} = "$tmpdir/wtindex";
> +	($inpipe, $ctx) =
> +		$repo->command_input_pipe(qw(update-index --info-only -z --index-info));
> +	print($inpipe $wtindex);
> +	$repo->command_close_pipe($inpipe, $ctx);
> +
>  	# If $GIT_DIR was explicitly set just for the update/checkout
>  	# commands, then it should be unset before continuing.
>  	delete($ENV{GIT_DIR}) if ($must_unset_git_dir);
> @@ -390,19 +432,22 @@ sub dir_diff
>  	# should be copied back to the working tree.
>  	# Do not copy back files when symlinks are used and the
>  	# external tool did not replace the original link with a file.
> +	my %wt_modified = changed_files($repo->repo_path(),
> +		"$tmpdir/wtindex", "$workdir");
> +	my %tmp_modified = changed_files($repo->repo_path(),
> +		"$tmpdir/wtindex", "$b");

Do we need to run these two comparisons unconditionally?

It appears to me that in a sane and safe setting (i.e. $symlinks is
set and the "diff viewer" touches the file through the symbolic
link) does not ever look at wt_modified/tmp_modified at all because
the first check in the loop will always trigger.

I wonder if it makes sense to populate these two hashes lazily so
that the safe case does not have to pay the penalty at all.

>  	for my $file (@worktree) {
>  		next if $symlinks && -l "$b/$file";
>  		next if ! -f "$b/$file";
>  
> +		if (exists $wt_modified{$file} and exists $tmp_modified{$file}) {
> +			my $errmsg = "warning: Both files modified: ";
> +			$errmsg .= "'$workdir/$file' and '$b/$file'.\n";
> +			$errmsg .= "warning: Working tree file has been left.\n";
> +			$errmsg .= "warning:\n";
>  			warn $errmsg;
>  			$error = 1;
> +		} elsif ($tmp_modified{$file}) {

"exists" if only for consistency?
