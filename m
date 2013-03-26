From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2] difftool: don't overwrite modified files
Date: Tue, 26 Mar 2013 09:31:41 +0000
Message-ID: <20130326093141.GI2286@serenity.lan>
References: <cover.1364045138.git.john@keeping.me.uk>
 <e44349728c07d8ae22d4b73527b1d124b49cc4a9.1364045138.git.john@keeping.me.uk>
 <7vd2up4bo7.fsf@alter.siamese.dyndns.org>
 <20130324123620.GA2286@serenity.lan>
 <CAJELnLEhcY4Oc-EB=Mi7PKBQQF+EiVpW_dNH6G-abjZj0MAdNw@mail.gmail.com>
 <20130324151557.GB2286@serenity.lan>
 <514FFFC7.3090004@viscovery.net>
 <20130325104219.GD2286@serenity.lan>
 <20130325214430.GG2286@serenity.lan>
 <51515E92.4030009@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt McClure <matthewlmcclure@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 26 10:32:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKQFA-0002Cl-9B
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 10:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759776Ab3CZJcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 05:32:07 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:53429 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759589Ab3CZJcE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 05:32:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 3691C161E52C;
	Tue, 26 Mar 2013 09:32:04 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PYJXZ6aOwh1z; Tue, 26 Mar 2013 09:31:54 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 90F53161E325;
	Tue, 26 Mar 2013 09:31:43 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <51515E92.4030009@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219148>

On Tue, Mar 26, 2013 at 09:38:42AM +0100, Johannes Sixt wrote:
> Am 3/25/2013 22:44, schrieb John Keeping:
> > After running the user's diff tool, git-difftool will copy any files
> > that differ between the working tree and the temporary tree.  This is
> > useful when the user edits the file in their diff tool but is wrong if
> > they edit the working tree file while examining the diff.
> > 
> > Instead of copying unconditionally when the files differ, create and
> > index from the working tree files and only copy the temporary file back
> > if it was modified and the working tree file was not.  If both files
> > have been modified, print a warning and exit with an error.
> > 
> > Note that we cannot use an existing index in git-difftool since those
> > contain the modified files that need to be checked out but here we are
> > looking at those files which are copied from the working tree and not
> > checked out.  These are precisely the files which are not in the
> > existing indices.
> > 
> > Signed-off-by: John Keeping <john@keeping.me.uk>
> > ---
> > On Mon, Mar 25, 2013 at 10:42:19AM +0000, John Keeping wrote:
> >> On Mon, Mar 25, 2013 at 08:41:59AM +0100, Johannes Sixt wrote:
> >>> This is gross. Can't we do much better here? Difftool already keeps a
> >>> GIT_INDEX of the files in the temporary tree ($tmpdir/rindex). Running
> >>> git-diff-files should be sufficient to tell which ones where edited via
> >>> the users's diff-tool. Then you can restrict calling hash-object to only
> >>> those worktree files where an "edit collision" needs to be checked for.
> >>
> >> That's only the case for files that are not copied from the working
> >> tree, so the temporary index doesn't contain the files that are of
> >> interest here.
> >>
> >>> You could also keep a parallel index that keeps the state of the same set
> >>> of files in the worktree. Then another git-diff-files call could replace
> >>> the other half of hash-object calls.
> >>
> >> I like the idea of creating an index from the working tree files and
> >> using it here.  If we create a "starting state" index for these files,
> >> we should be able to run git-diff-files against both the working tree
> >> and the temporary tree at this point and compare the output.
> > 
> > Here's an attempt at taking this approach, built on
> > jk/difftool-dir-diff-edit-fix.
> > 
> >  git-difftool.perl   | 73 +++++++++++++++++++++++++++++++++++++++++++----------
> >  t/t7800-difftool.sh | 26 +++++++++++++++++++
> >  2 files changed, 85 insertions(+), 14 deletions(-)
> > 
> > diff --git a/git-difftool.perl b/git-difftool.perl
> > index c433e86..d10f7d2 100755
> > --- a/git-difftool.perl
> > +++ b/git-difftool.perl
> > @@ -13,9 +13,9 @@
> >  use 5.008;
> >  use strict;
> >  use warnings;
> > +use Error qw(:try);
> >  use File::Basename qw(dirname);
> >  use File::Copy;
> > -use File::Compare;
> >  use File::Find;
> >  use File::stat;
> >  use File::Path qw(mkpath rmtree);
> > @@ -88,14 +88,45 @@ sub use_wt_file
> >  	my ($repo, $workdir, $file, $sha1, $symlinks) = @_;
> >  	my $null_sha1 = '0' x 40;
> >  
> > -	if ($sha1 eq $null_sha1) {
> > -		return 1;
> > -	} elsif (not $symlinks) {
> > +	if ($sha1 ne $null_sha1 and not $symlinks) {
> >  		return 0;
> >  	}
> >  
> >  	my $wt_sha1 = $repo->command_oneline('hash-object', "$workdir/$file");
> > -	return $sha1 eq $wt_sha1;
> > +	my $use = ($sha1 eq $null_sha1) || ($sha1 eq $wt_sha1);
> > +	return ($use, $wt_sha1);
> > +}
> > +
> > +sub changed_files
> > +{
> > +	my ($repo_path, $index, $worktree) = @_;
> > +	$ENV{GIT_INDEX_FILE} = $index;
> > +	$ENV{GIT_WORK_TREE} = $worktree;
> > +	my $must_unset_git_dir = 0;
> > +	if (not defined($ENV{GIT_DIR})) {
> > +		$must_unset_git_dir = 1;
> > +		$ENV{GIT_DIR} = $repo_path;
> > +	}
> > +
> > +	my @refreshargs = qw/update-index --really-refresh -q --unmerged/;
> > +	my @gitargs = qw/diff-files --name-only -z/;
> > +	try {
> > +		Git::command_oneline(@refreshargs);
> > +	} catch Git::Error::Command with {};
> > +
> > +	my $line = Git::command_oneline(@gitargs);
> > +	my @files;
> > +	if (defined $line) {
> > +		@files = split('\0', $line);
> > +	} else {
> > +		@files = ();
> > +	}
> > +
> > +	delete($ENV{GIT_INDEX_FILE});
> > +	delete($ENV{GIT_WORK_TREE});
> > +	delete($ENV{GIT_DIR}) if ($must_unset_git_dir);
> > +
> > +	return map { $_ => 1 } @files;
> >  }
> >  
> >  sub setup_dir_diff
> > @@ -121,6 +152,7 @@ sub setup_dir_diff
> >  	my $null_sha1 = '0' x 40;
> >  	my $lindex = '';
> >  	my $rindex = '';
> > +	my $wtindex = '';
> >  	my %submodule;
> >  	my %symlink;
> >  	my @working_tree = ();
> > @@ -174,8 +206,12 @@ EOF
> >  		}
> >  
> >  		if ($rmode ne $null_mode) {
> > -			if (use_wt_file($repo, $workdir, $dst_path, $rsha1, $symlinks)) {
> > -				push(@working_tree, $dst_path);
> > +			my ($use, $wt_sha1) = use_wt_file($repo, $workdir,
> > +							  $dst_path, $rsha1,
> > +							  $symlinks);
> > +			if ($use) {
> > +				push @working_tree, $dst_path;
> > +				$wtindex .= "$rmode $wt_sha1\t$dst_path\0";
> >  			} else {
> >  				$rindex .= "$rmode $rsha1\t$dst_path\0";
> >  			}
> > @@ -218,6 +254,12 @@ EOF
> >  	$rc = system('git', 'checkout-index', '--all', "--prefix=$rdir/");
> >  	exit_cleanup($tmpdir, $rc) if $rc != 0;
> >  
> > +	$ENV{GIT_INDEX_FILE} = "$tmpdir/wtindex";
> > +	($inpipe, $ctx) =
> > +		$repo->command_input_pipe(qw(update-index --info-only -z --index-info));
> > +	print($inpipe $wtindex);
> > +	$repo->command_close_pipe($inpipe, $ctx);
> > +
> >  	# If $GIT_DIR was explicitly set just for the update/checkout
> >  	# commands, then it should be unset before continuing.
> >  	delete($ENV{GIT_DIR}) if ($must_unset_git_dir);
> > @@ -390,19 +432,22 @@ sub dir_diff
> >  	# should be copied back to the working tree.
> >  	# Do not copy back files when symlinks are used and the
> >  	# external tool did not replace the original link with a file.
> > +	my %wt_modified = changed_files($repo->repo_path(),
> > +		"$tmpdir/wtindex", "$workdir");
> > +	my %tmp_modified = changed_files($repo->repo_path(),
> > +		"$tmpdir/wtindex", "$b");
> >  	for my $file (@worktree) {
> >  		next if $symlinks && -l "$b/$file";
> >  		next if ! -f "$b/$file";
> >  
> > -		my $diff = compare("$b/$file", "$workdir/$file");
> > -		if ($diff == 0) {
> > -			next;
> > -		} elsif ($diff == -1) {
> > -			my $errmsg = "warning: Could not compare ";
> > -			$errmsg += "'$b/$file' with '$workdir/$file'\n";
> > +		if (exists $wt_modified{$file} and exists $tmp_modified{$file}) {
> > +			my $errmsg = "warning: Both files modified: ";
> > +			$errmsg .= "'$workdir/$file' and '$b/$file'.\n";
> > +			$errmsg .= "warning: Working tree file has been left.\n";
> > +			$errmsg .= "warning:\n";
> >  			warn $errmsg;
> >  			$error = 1;
> > -		} elsif ($diff == 1) {
> > +		} elsif ($tmp_modified{$file}) {
> >  			my $mode = stat("$b/$file")->mode;
> >  			copy("$b/$file", "$workdir/$file") or
> >  			exit_cleanup($tmpdir, 1);
> 
> I don't have a lot to say about the patch text, except that there is
> nothing obvious out of the ordinary, but please take this with a large
> grain of salt, as I'm lacking context. (It's the first time these days
> that I'm looking at difftool.)
> 
> BTW, did you know that perl is mostly a write-only language? ;-)
> 
> > diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> > index db3d3d6..be2042d 100755
> > --- a/t/t7800-difftool.sh
> > +++ b/t/t7800-difftool.sh
> > @@ -407,4 +407,30 @@ test_expect_success PERL 'difftool --dir-diff from subdirectory' '
> >  	)
> >  '
> >  
> > +write_script modify-file <<\EOF
> > +echo "new content" >file
> > +EOF
> > +
> > +test_expect_success PERL 'difftool --no-symlinks does not overwrite working tree file ' '
> > +	echo "orig content" >file &&
> > +	git difftool --dir-diff --no-symlinks --extcmd "$(pwd)/modify-file" branch &&
> > +	echo "new content" >expect &&
> > +	test_cmp expect file
> > +'
> > +
> > +write_script modify-both-files <<\EOF
> > +echo "wt content" >file &&
> > +echo "tmp content" >"$2/file" &&
> > +echo "$2" >tmpdir
> > +EOF
> > +
> > +test_expect_success PERL 'difftool --no-symlinks detects conflict ' '
> > +	echo "orig content" >file &&
> > +	test_must_fail git difftool --dir-diff --no-symlinks --extcmd "$(pwd)/modify-both-files" branch &&
> > +	echo "wt content" >expect &&
> > +	test_cmp expect file &&
> > +	echo "tmp content" >expect &&
> > +	test_cmp expect "$(cat tmpdir)/file"
> > +'
> 
> The new tests look good.
> 
> One question though: Do I understand correctly that the temporary
> directories are leaked in the case of an "edit conflict"? If so, is it
> worth a warning for the user to clean up the garbage?

Do you mean for normal users or for those running the tests?  In normal
usage we do print a warning - it's in the existing code, triggered by
setting "$error = 1" - you can see that if you run the tests with "-v".

The last test does result in /tmp filling up with temporary directories
though, it would be good if the test could clean up after itself.  The
best I can come up with is adding something like this immediately after
running difftool but I'm not entirely happy with the ".." in the
argument to rm:

	test_when_finished rm -rf "$(cat tmpdir)/.."
