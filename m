From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC] git svn: handle errors and concurrent commits in
 dcommit
Date: Thu, 2 Aug 2012 03:44:21 -0700
Message-ID: <20120802104421.GA13271@dcvr.yhbt.net>
References: <1343856397-6536-1-git-send-email-robert@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Luberda <robert@debian.org>
X-From: git-owner@vger.kernel.org Thu Aug 02 12:44:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwstH-0003Ri-Nu
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 12:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754366Ab2HBKoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 06:44:22 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57429 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754326Ab2HBKoV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 06:44:21 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F5DE1F42D;
	Thu,  2 Aug 2012 10:44:21 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1343856397-6536-1-git-send-email-robert@debian.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202750>

Robert Luberda <robert@debian.org> wrote:
> dcommit didn't handle errors returned by SVN and coped very
> poorly with concurrent commits that appear in SVN repository
> while dcommit was running. In both cases it left git repository
> in inconsistent state: index (which was reset with `git reset
> --mixed' after a successful commit to SVN) no longer matched the
> checkouted tree, when the following commit failed or needed to be
> rebased. See http://bugs.debian.org/676904 for examples.
> 
> This patch fixes the issues by:
> - introducing error handler for dcommit. The handler will try
>   to rebase or reset working tree before returning error to the
>   end user. dcommit_rebase function was extracted out of cmd_dcommit
>   to ensure consistency between cmd_dcommit and the error handler.
> - calling `git reset --mixed' only once after all patches are
>   successfully committed to SVN. This ensures index is not touched
>   for most of the time of dcommit run.

Thanks, this seems to make sense.  I'm not sure why we didn't use
SVN::Error::handler here earlier :x

A few minor comments inline...

> +	if ($svn_error)
> +	{
> +		die "ERROR: Not all changes have been committed into SVN"
> +			.($_no_rebase ? ". " : ", however the committed ones (if any) seem to be successfully integrated into the working tree. ")
> +			."Please see the above messages for details.\n";
> +	}

Please ensure all error messages and code are readable in
80-column terminals.

Also, keep opening "{" on the same line as the if/unless.

> +	return @diff;
> +}
> +
>  sub cmd_dcommit {
>  	my $head = shift;
>  	command_noisy(qw/update-index --refresh/);
> @@ -904,6 +942,7 @@ sub cmd_dcommit {
>  	}
>  
>  	my $rewritten_parent;
> +	my $current_head =  command_oneline(qw/rev-parse HEAD/);
>  	Git::SVN::remove_username($expect_url);
>  	if (defined($_merge_info)) {
>  		$_merge_info =~ tr{ }{\n};
> @@ -943,6 +982,13 @@ sub cmd_dcommit {
>  			                },
>  					mergeinfo => $_merge_info,
>  			                svn_path => '');
> +
> +			my $err_handler = $SVN::Error::handler;
> +			$SVN::Error::handler = sub {
> +				my $err = shift;
> +				dcommit_rebase(1, $current_head, $gs->refname, $err);
> +			};
> +
>  			if (!Git::SVN::Editor->new(\%ed_opts)->apply_diff) {
>  				print "No changes\n$d~1 == $d\n";
>  			} elsif ($parents->{$d} && @{$parents->{$d}}) {
> @@ -950,31 +996,16 @@ sub cmd_dcommit {
>  				                               $parents->{$d};
>  			}
>  			$_fetch_all ? $gs->fetch_all : $gs->fetch;
> +			$SVN::Error::handler = $err_handler;
>  			$last_rev = $cmt_rev;
>  			next if $_no_rebase;
>  
> -			# we always want to rebase against the current HEAD,
> -			# not any head that was passed to us
> -			my @diff = command('diff-tree', $d,
> -			                   $gs->refname, '--');
> -			my @finish;
> -			if (@diff) {
> -				@finish = rebase_cmd();
> -				print STDERR "W: $d and ", $gs->refname,
> -				             " differ, using @finish:\n",
> -				             join("\n", @diff), "\n";
> -			} else {
> -				print "No changes between current HEAD and ",
> -				      $gs->refname,
> -				      "\nResetting to the latest ",
> -				      $gs->refname, "\n";
> -				@finish = qw/reset --mixed/;
> -			}
> -			command_noisy(@finish, $gs->refname);
> +			my @diff = dcommit_rebase(@$linear_refs == 0, $d, $gs->refname, undef);
>  
> -			$rewritten_parent = command_oneline(qw/rev-parse HEAD/);
> +			$rewritten_parent = command_oneline(qw/rev-parse/, $gs->refname);
>  
>  			if (@diff) {
> +				$current_head = command_oneline(qw/rev-parse HEAD/);
>  				@refs = ();
>  				my ($url_, $rev_, $uuid_, $gs_) =
>  				              working_head_info('HEAD', \@refs);
> @@ -1019,6 +1050,7 @@ sub cmd_dcommit {
>  				}
>  				$parents = \%p;
>  				$linear_refs = \@l;
> +				undef $last_rev;
>  			}
>  		}
>  	}
> diff --git a/t/t9164-git-svn-dcommit-concrrent.sh b/t/t9164-git-svn-dcommit-concrrent.sh
> new file mode 100755
> index 0000000..7916a63
> --- /dev/null
> +++ b/t/t9164-git-svn-dcommit-concrrent.sh
> @@ -0,0 +1,173 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2012 Robert Luberda
> +#
> +
> +test_description='concurrent git svn dcommit'
> +. ./lib-git-svn.sh
> +
> +
> +
> +test_expect_success 'setup svn repository' '
> +	svn_cmd checkout "$svnrepo" work.svn &&
> +	(
> +		cd work.svn &&
> +		echo >file && echo > auto_updated_file
> +		svn_cmd add file auto_updated_file &&
> +		svn_cmd commit -m "initial commit"
> +       ) &&
> +	svn_cmd checkout "$svnrepo" work-auto-commits.svn
> +'
> +N=0
> +next_N()
> +{
> +	N=`expr $N + 1`

Backticks don't nest properly, nowadays, we prefer:

	N=$(expr $N + 1)

or even

	N=$(( $N + 1 ))

ref: Documentation/CodingGuidelines

> +
> +# Setup SVN repository hooks to emulate SVN failures or concurrent commits
> +# The function adds either
> +# either pre-commit  hook, which causes SVN commit given in second argument to fail
> +# or     post-commit hook, which creates a new commit (a new line added to
> +#                    auto_updated_file) after given SVN commit
> +# The second argument contains a number (not SVN revision) of commit the the hook
> +# should be applied for.
> +setup_hook()
> +{
> +	hook_type="$1"  # pre-commit to fail commit or post-commit to make concurrent commit
> +	skip_revs="$2"  # skip number of revisions before applying the hook
> +			# the number is decremented by one each time hook is called until
> +			# it gets 0, in which case the real part of hook is executed
> +	[ "$hook_type" = "pre-commit" ] || [ "$hook_type" = "post-commit" ] ||



> +		{ echo "ERROR: invalid argument ($hook_type) passed to setup_hook" >&2 ; return 1; }
> +	echo "cnt=$skip_revs" > "$hook_type-counter"
> +	rm -f "$rawsvnrepo/hooks/"*-commit # drop previous hooks
> +	hook="$rawsvnrepo/hooks/$hook_type"
> +	cat > "$hook" <<- 'EOF1'
> +		#!/bin/sh
> +		set -e
> +		cd "$1/.."  # "$1" is repository location
> +		exec >> svn-hook.log 2>&1
> +		hook="`basename "$0"`"
> +		echo "*** Executing $hook $@"
> +		set -x
> +		. ./$hook-counter
> +		cnt=`expr "$cnt" - 1` || [ $? = 1 ] # expr returns error code 1 if expression is 0
> +		echo "cnt=$cnt" > ./$hook-counter
> +		[ "$cnt" = "0" ] || exit 0
> +EOF1
> +	if [ "$hook_type" = "pre-commit" ]; then
> +		echo "echo 'commit disallowed' >&2; exit 1" >> "$hook"
> +	else
> +		echo "PATH=\"$PATH\"; export PATH" >> $hook
> +		echo "svnconf=\"$svnconf\"" >> $hook
> +		cat >> "$hook" <<- 'EOF2'
> +			cd work-auto-commits.svn
> +			svn up --config-dir "$svnconf"

That doesn't seem to interact well with users who depend on
svn_cmd pointing to something non-standard.  Not sure
what to do about it, though....

> +			echo "$$" >> auto_updated_file
> +			svn commit --config-dir "$svnconf" -m "auto-committing concurrent change from post-commit hook"
> +			exit 0
> +EOF2
> +	fi
> +	chmod 755 "$hook"
> +}
> +
> +check_contents()
> +{
> +	gitdir="$1"
> +	(cd ../work.svn && svn_cmd up) &&
> +	test_cmp file ../work.svn/file &&
> +	test_cmp auto_updated_file ../work.svn/auto_updated_file
> +}
> +
> +test_expect_success 'check if svn post-commit hook creates a concurrent commit' '
> +	setup_hook post-commit 1 &&
> +	(cd work.svn &&
> +		cp auto_updated_file auto_updated_file_saved

Need "&&" to check for failure on cp

> +test_expect_success 'git svn dcommit concurrent non-conflicting change in changed file' '
> +	setup_hook post-commit 2 &&
> +	next_N && git svn clone "$svnrepo" work$N.git &&
> +	( cd work$N.git &&
> +		cat file >> auto_updated_file && git commit -am "commit change $N.1" &&
> +		sed -i 1d auto_updated_file && git commit -am "commit change $N.2" &&
> +		sed -i 1d auto_updated_file && git commit -am "commit change $N.3" &&

I don't believe "sed -i" is portable enough for this test.

The only places we currently use "sed -i" is scripts/tests which are
hardly run (fixup-builtins and t9810-git-p4-rcs.sh).

(I didn't expect "grep -q" to be portable enough, either,
 but apparently it is portable enough nowadays :)
