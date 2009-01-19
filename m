From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2] git-svn: Add --localtime option to "fetch"
Date: Sun, 18 Jan 2009 16:43:18 -0800
Message-ID: <20090119004318.GA5128@untitled>
References: <496D35B8.70203@pcharlan.com> <20090117103711.GB29598@dcvr.yhbt.net> <4972A896.5050205@pcharlan.com> <4972ABA6.7060207@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Harlan <pgit@pcharlan.com>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 01:44:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOiFw-0005ld-F3
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 01:44:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273AbZASAnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 19:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755108AbZASAnW
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 19:43:22 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:57322 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753819AbZASAnT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 19:43:19 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBB5D1F602;
	Mon, 19 Jan 2009 00:43:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4972ABA6.7060207@pcharlan.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106296>

Pete Harlan <pgit@pcharlan.com> wrote:
> By default git-svn stores timestamps of fetched commits in
> Subversion's UTC format.  Passing --localtime to fetch will convert
> them to the timezone of the server on which git-svn is run.
> 
> This makes the timestamps of a resulting "git log" agree with what
> "svn log" shows for the same repository.
> 
> Signed-off-by: Pete Harlan <pgit@pcharlan.com>

Thanks Peter,

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
> 
> Changes to v2 after feedback from Eric Wong:
> 
> 1. "--convert-timezones" renamed to "--localtime".
> 
> 2. Removed warnings about breaking interoperability with Subversion,
>    because the option doesn't do that.  Instead warn about
>    interoperability with other git-svn users cloning from the same
>    repository if they don't all use or not use --localtime.
> 
> 3. Move config variable into Git::SVN namespace.
> 
> 4. Better conformance to coding guidelines.
> 
>  Documentation/git-svn.txt              |   11 ++++++
>  contrib/completion/git-completion.bash |    2 +-
>  git-svn.perl                           |   54 ++++++++++++++++++++++++++++++-
>  3 files changed, 64 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index 8d0c421..63d2f5e 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -92,6 +92,17 @@ COMMANDS
>  	.git/config file may be specified as an optional command-line
>  	argument.
> 
> +--localtime;;
> +	Store Git commit times in the local timezone instead of UTC.  This
> +	makes 'git-log' (even without --date=local) show the same times
> +	that `svn log` would in the local timezone.
> +
> +This doesn't interfere with interoperating with the Subversion
> +repository you cloned from, but if you wish for your local Git
> +repository to be able to interoperate with someone else's local Git
> +repository, either don't use this option or you should both use it in
> +the same local timezone.
> +
>  'clone'::
>  	Runs 'init' and 'fetch'.  It will automatically create a
>  	directory based on the basename of the URL passed to it;
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index f8b845a..c9d2c02 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1575,7 +1575,7 @@ _git_svn ()
>  			--follow-parent --authors-file= --repack=
>  			--no-metadata --use-svm-props --use-svnsync-props
>  			--log-window-size= --no-checkout --quiet
> -			--repack-flags --user-log-author $remote_opts
> +			--repack-flags --user-log-author --localtime $remote_opts
>  			"
>  		local init_opts="
>  			--template= --shared= --trunk= --tags=
> diff --git a/git-svn.perl b/git-svn.perl
> index ad01e18..0adc8db 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -84,6 +84,7 @@ my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
>  		   \$Git::SVN::_repack_flags,
>  		'use-log-author' => \$Git::SVN::_use_log_author,
>  		'add-author-from' => \$Git::SVN::_add_author_from,
> +		'localtime' => \$Git::SVN::_localtime,
>  		%remote_opts );
> 
>  my ($_trunk, $_tags, $_branches, $_stdlayout);
> @@ -1364,7 +1365,7 @@ use constant rev_map_fmt => 'NH40';
>  use vars qw/$default_repo_id $default_ref_id $_no_metadata $_follow_parent
>              $_repack $_repack_flags $_use_svm_props $_head
>              $_use_svnsync_props $no_reuse_existing $_minimize_url
> -	    $_use_log_author $_add_author_from/;
> +	    $_use_log_author $_add_author_from $_localtime/;
>  use Carp qw/croak/;
>  use File::Path qw/mkpath/;
>  use File::Copy qw/copy/;
> @@ -2526,12 +2527,61 @@ sub get_untracked {
>  	\@out;
>  }
> 
> +# parse_svn_date(DATE)
> +# --------------------
> +# Given a date (in UTC) from Subversion, return a string in the format
> +# "<TZ Offset> <local date/time>" that Git will use.
> +#
> +# By default the parsed date will be in UTC; if $Git::SVN::_localtime
> +# is true we'll convert it to the local timezone instead.
>  sub parse_svn_date {
>  	my $date = shift || return '+0000 1970-01-01 00:00:00';
>  	my ($Y,$m,$d,$H,$M,$S) = ($date =~ /^(\d{4})\-(\d\d)\-(\d\d)T
>  	                                    (\d\d)\:(\d\d)\:(\d\d).\d+Z$/x) or
>  	                                 croak "Unable to parse date: $date\n";
> -	"+0000 $Y-$m-$d $H:$M:$S";
> +	my $parsed_date;    # Set next.
> +
> +	if ($Git::SVN::_localtime) {
> +		# Translate the Subversion datetime to an epoch time.
> +		# Begin by switching ourselves to $date's timezone, UTC.
> +		my $old_env_TZ = $ENV{TZ};
> +		$ENV{TZ} = 'UTC';
> +
> +		my $epoch_in_UTC =
> +		    POSIX::strftime('%s', $S, $M, $H, $d, $m - 1, $Y - 1900);
> +
> +		# Determine our local timezone (including DST) at the
> +		# time of $epoch_in_UTC.  $Git::SVN::Log::TZ stored the
> +		# value of TZ, if any, at the time we were run.
> +		if (defined $Git::SVN::Log::TZ) {
> +			$ENV{TZ} = $Git::SVN::Log::TZ;
> +		} else {
> +			delete $ENV{TZ};
> +		}
> +
> +		my $our_TZ =
> +		    POSIX::strftime('%Z', $S, $M, $H, $d, $m - 1, $Y - 1900);
> +
> +		# This converts $epoch_in_UTC into our local timezone.
> +		my ($sec, $min, $hour, $mday, $mon, $year,
> +		    $wday, $yday, $isdst) = localtime($epoch_in_UTC);
> +
> +		$parsed_date = sprintf('%s %04d-%02d-%02d %02d:%02d:%02d',
> +				       $our_TZ, $year + 1900, $mon + 1,
> +				       $mday, $hour, $min, $sec);
> +
> +		# Reset us to the timezone in effect when we entered
> +		# this routine.
> +		if (defined $old_env_TZ) {
> +			$ENV{TZ} = $old_env_TZ;
> +		} else {
> +			delete $ENV{TZ};
> +		}
> +	} else {
> +		$parsed_date = "+0000 $Y-$m-$d $H:$M:$S";
> +	}
> +
> +	return $parsed_date;
>  }
> 
>  sub check_author {
> -- 
> 1.6.1.77.g953e7
