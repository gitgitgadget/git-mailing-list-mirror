From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 2/3] t7800: fix tests when difftool uses --no-symlinks
Date: Mon, 25 Mar 2013 08:41:59 +0100
Message-ID: <514FFFC7.3090004@viscovery.net>
References: <cover.1363980749.git.john@keeping.me.uk> <cover.1364045138.git.john@keeping.me.uk> <e44349728c07d8ae22d4b73527b1d124b49cc4a9.1364045138.git.john@keeping.me.uk> <7vd2up4bo7.fsf@alter.siamese.dyndns.org> <20130324123620.GA2286@serenity.lan> <CAJELnLEhcY4Oc-EB=Mi7PKBQQF+EiVpW_dNH6G-abjZj0MAdNw@mail.gmail.com> <20130324151557.GB2286@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matt McClure <matthewlmcclure@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Mar 25 08:42:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK23G-0005ns-Nk
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 08:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756134Ab3CYHmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 03:42:14 -0400
Received: from so.liwest.at ([212.33.55.24]:64275 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756079Ab3CYHmO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 03:42:14 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UK22l-0000eO-JD; Mon, 25 Mar 2013 08:42:11 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 507891660F;
	Mon, 25 Mar 2013 08:42:11 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <20130324151557.GB2286@serenity.lan>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219016>

Am 3/24/2013 16:15, schrieb John Keeping:
> Subject: [PATCH] difftool: don't overwrite modified files
> 
> After running the user's diff tool, git-difftool will copy any files
> that differ between the working tree and the temporary tree.  This is
> useful when the user edits the file in their diff tool but is wrong if
> they edit the working tree file while examining the diff.
> 
> Instead of copying unconditionally when the files differ, store the
> initial hash of the working tree file and only copy the temporary file
> back if it was modified and the working tree file was not.  If both
> files have been modified, print a warning and exit with an error.
> 
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  git-difftool.perl   | 35 +++++++++++++++++++++--------------
>  t/t7800-difftool.sh | 26 ++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+), 14 deletions(-)
> 
> diff --git a/git-difftool.perl b/git-difftool.perl
> index c433e86..be82b5a 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -15,7 +15,6 @@ use strict;
>  use warnings;
>  use File::Basename qw(dirname);
>  use File::Copy;
> -use File::Compare;
>  use File::Find;
>  use File::stat;
>  use File::Path qw(mkpath rmtree);
> @@ -123,7 +122,7 @@ sub setup_dir_diff
>  	my $rindex = '';
>  	my %submodule;
>  	my %symlink;
> -	my @working_tree = ();
> +	my %working_tree;
>  	my @rawdiff = split('\0', $diffrtn);
>  
>  	my $i = 0;
> @@ -175,7 +174,9 @@ EOF
>  
>  		if ($rmode ne $null_mode) {
>  			if (use_wt_file($repo, $workdir, $dst_path, $rsha1, $symlinks)) {
> -				push(@working_tree, $dst_path);
> +				$working_tree{$dst_path} =
> +					$repo->command_oneline('hash-object',
> +						"$workdir/$dst_path");
>  			} else {
>  				$rindex .= "$rmode $rsha1\t$dst_path\0";
>  			}
> @@ -227,7 +228,7 @@ EOF
>  	# not part of the index. Remove any trailing slash from $workdir
>  	# before starting to avoid double slashes in symlink targets.
>  	$workdir =~ s|/$||;
> -	for my $file (@working_tree) {
> +	for my $file (keys %working_tree) {
>  		my $dir = dirname($file);
>  		unless (-d "$rdir/$dir") {
>  			mkpath("$rdir/$dir") or
> @@ -278,7 +279,7 @@ EOF
>  		exit_cleanup($tmpdir, 1) if not $ok;
>  	}
>  
> -	return ($ldir, $rdir, $tmpdir, @working_tree);
> +	return ($ldir, $rdir, $tmpdir, %working_tree);
>  }
>  
>  sub write_to_file
> @@ -376,7 +377,7 @@ sub dir_diff
>  	my $error = 0;
>  	my $repo = Git->repository();
>  	my $workdir = find_worktree($repo);
> -	my ($a, $b, $tmpdir, @worktree) =
> +	my ($a, $b, $tmpdir, %worktree) =
>  		setup_dir_diff($repo, $workdir, $symlinks);
>  
>  	if (defined($extcmd)) {
> @@ -390,19 +391,25 @@ sub dir_diff
>  	# should be copied back to the working tree.
>  	# Do not copy back files when symlinks are used and the
>  	# external tool did not replace the original link with a file.
> -	for my $file (@worktree) {
> +	for my $file (keys %worktree) {
>  		next if $symlinks && -l "$b/$file";
>  		next if ! -f "$b/$file";
>  
> -		my $diff = compare("$b/$file", "$workdir/$file");
> -		if ($diff == 0) {
> -			next;
> -		} elsif ($diff == -1) {
> -			my $errmsg = "warning: Could not compare ";
> -			$errmsg += "'$b/$file' with '$workdir/$file'\n";
> +		my $wt_hash = $repo->command_oneline('hash-object',
> +			"$workdir/$file");
> +		my $tmp_hash = $repo->command_oneline('hash-object',
> +			"$b/$file");

This is gross. Can't we do much better here? Difftool already keeps a
GIT_INDEX of the files in the temporary tree ($tmpdir/rindex). Running
git-diff-files should be sufficient to tell which ones where edited via
the users's diff-tool. Then you can restrict calling hash-object to only
those worktree files where an "edit collision" needs to be checked for.

You could also keep a parallel index that keeps the state of the same set
of files in the worktree. Then another git-diff-files call could replace
the other half of hash-object calls.

> +		my $wt_modified = $wt_hash ne $worktree{$file};
> +		my $tmp_modified = $tmp_hash ne $worktree{$file};
> +
> +		if ($wt_modified and $tmp_modified) {
> +			my $errmsg = "warning: Both files modified: ";
> +			$errmsg .= "'$workdir/$file' and '$b/$file'.\n";
> +			$errmsg .= "warning: Working tree file has been left.\n";
> +			$errmsg .= "warning:\n";
>  			warn $errmsg;
>  			$error = 1;
> -		} elsif ($diff == 1) {
> +		} elsif ($tmp_modified) {
>  			my $mode = stat("$b/$file")->mode;
>  			copy("$b/$file", "$workdir/$file") or
>  			exit_cleanup($tmpdir, 1);

-- Hannes
