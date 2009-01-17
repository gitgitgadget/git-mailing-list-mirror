From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC] git-svn: Add --convert-timezone option
Date: Sat, 17 Jan 2009 02:37:11 -0800
Message-ID: <20090117103711.GB29598@dcvr.yhbt.net>
References: <496D35B8.70203@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 11:38:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO8Zb-0001Or-FI
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 11:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548AbZAQKhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 05:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752404AbZAQKhP
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 05:37:15 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:34974 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751744AbZAQKhM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 05:37:12 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 683031F44D;
	Sat, 17 Jan 2009 10:37:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <496D35B8.70203@pcharlan.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106038>

Pete Harlan <pgit@pcharlan.com> wrote:
> By default git svn stores timestamps of fetched commits in
> Subversion's UTC format, to facilitate interoperating with a
> Subversion repository.
> 
> If you're using git svn to convert a repository to Git and aren't
> interested in pushing Git commits back to Subversion, you can use this
> option to store timestamps of fetched commits as though they were made
> in the local timezone of the host on which git svn is run.  This makes
> the times and timezones of a resulting "git log" agree with what "svn
> log" shows for the same repository.
> 
> Signed-off-by: Pete Harlan <pgit@pcharlan.com>
> ---
> 
> This is a patch I've had floating around for a while.  I haven't
> submitted it before because I find the solution ungainly.  There has
> to be a better way to convert from one timezone to the other, but I
> didn't run across it and now that I've converted away from Subversion
> I'm sort of done thinking about it.  I'm submitting it now because
> even in its current state it would have saved me some headache.
> 
> Also, I'm not sure I'm correct when asserting that converting
> timezones like this will break Subversion interoperability.  Eric, if
> that isn't true then I can remove that claim and resubmit.  If
> converting timezones breaks nothing, then maybe it could even be the
> default.

Hi,

It'll break interoperability between multiple users of git-svn
tracking the same repo.  But several options already allow for
this (authors file, noMetdata, ...), so I'm fine with it as long
as it's optional.

> One improvement that I didn't bother to make would be to convert to
> different local timezones based on author.  This change uses the
> timezone of the machine running git-svn, which in my case was fine.
> Using per-author timezones would be nice, but since parse_svn_date()
> doesn't already know which author the date is associated with it would
> be a more intrusive change.

Could be an interesting idea, but on the other hand I doubt many people
would bother configuring the authors-file for it.

On a side note, for the total conversions I've done, I've found it
easier/faster/more bandwidth efficient to just forgo authors-file
entirely and use git-filter-branch after-the-fact.

> My primary motivation in this was to reduce transition shock among our
> development team.  The fewer ways "git log" looks unhelpfully
> different than the old "svn log" the better; converting all commit
> times into GMT wasn't going to look friendly.
> 
> Comments welcome.

My usual coding style nits apply (pretty much git (and Linux kernel)
standard coding style things, too).

No space between "function(arguments)".

lower_snake_case, especially for local variables.  mixedCase requires
more effort to read IMO.

More comments inline...

> --Pete
> 
>  Documentation/git-svn.txt              |    8 ++++
>  contrib/completion/git-completion.bash |    2 +-
>  git-svn.perl                           |   56 ++++++++++++++++++++++++++++++-
>  3 files changed, 63 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index 8d0c421..8811bf0 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -92,6 +92,14 @@ COMMANDS
>  	.git/config file may be specified as an optional command-line
>  	argument.
> 
> +--convert-timezones;;

Is it "timezone" or "timezones" here?  I think "convert-timezone" is
more correct since we only use the local timezone, not different
ones for each author.  On the other hand, maybe "--localtime" is
an even better name for this option...

Any other opinions out there?

> +	Store Git commit times in the local timezone instead of UTC.  This
> +	makes 'git-log' (even without --date=local) show the same times
> +	that `svn log` would in the local timezone.
> +
> +This breaks interoperability with SVN, but may be cosmetically
> +desirable when converting a repository from SVN to Git.

Again, this only breaks interoperability with other users of git-svn
using the default configuration on the same repo.

>  'clone'::
>  	Runs 'init' and 'fetch'.  It will automatically create a
>  	directory based on the basename of the URL passed to it;
> diff --git a/git-svn.perl b/git-svn.perl
> index ad01e18..c2f600d 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -66,7 +66,7 @@ my ($_stdin, $_help, $_edit,
>  	$_version, $_fetch_all, $_no_rebase,
>  	$_merge, $_strategy, $_dry_run, $_local,
>  	$_prefix, $_no_checkout, $_url, $_verbose,
> -	$_git_format, $_commit_url, $_tag);
> +	$_git_format, $_commit_url, $_tag, $_convert_timezones);

Not easy to tell (and apologies for that) but this new variable probably
belongs in the Git::SVN namespace.  I really need to find some time to
reorganize and split out the source to git-svn.

>  $Git::SVN::_follow_parent = 1;
>  my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
>                      'config-dir=s' => \$Git::SVN::Ra::config_dir,
> @@ -84,6 +84,7 @@ my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
>  		   \$Git::SVN::_repack_flags,
>  		'use-log-author' => \$Git::SVN::_use_log_author,
>  		'add-author-from' => \$Git::SVN::_add_author_from,
> +		'convert-timezones' => \$_convert_timezones,
>  		%remote_opts );
> 
>  my ($_trunk, $_tags, $_branches, $_stdlayout);
> @@ -2526,12 +2527,63 @@ sub get_untracked {
>  	\@out;
>  }
> 
> +# parse_svn_date(DATE)
> +# --------------------
> +# Given a date (in UTC) from Subversion, return a string in the format
> +# "<TZ Offset> <local date/time>" that Git will use.
> +#
> +# By default the parsed date will be in UTC for interoperating with
> +# Subversion, but if $_convert_timezones is true we'll convert it to
> +# the local timezone instead.
>  sub parse_svn_date {
>  	my $date = shift || return '+0000 1970-01-01 00:00:00';
>  	my ($Y,$m,$d,$H,$M,$S) = ($date =~ /^(\d{4})\-(\d\d)\-(\d\d)T
>  	                                    (\d\d)\:(\d\d)\:(\d\d).\d+Z$/x) or
>  	                                 croak "Unable to parse date: $date\n";
> -	"+0000 $Y-$m-$d $H:$M:$S";
> +	my $parsed_date;    # Set next.
> +
> +	if ($_convert_timezones) {
> +		# Translate the Subversion datetime to an epoch time.
> +		# We need to switch ourselves to $date's timezone,
> +		# UTC, for this.
> +		my $oldEnvTZ = $ENV{TZ};
> +		$ENV{TZ} = 'UTC';
> +
> +		my $epochUTC =
> +		    POSIX::strftime ('%s', $S, $M, $H, $d, $m - 1, $Y - 1900);
> +
> +		# Determine our local timezone (including DST) at the
> +		# time of $epochUTC.  $Git::SVN::Log::TZ stored the
> +		# value of TZ, if any, at the time we were run.
> +		if (defined $Git::SVN::Log::TZ) {
> +			$ENV{TZ} = $Git::SVN::Log::TZ;
> +		} else {
> +			delete $ENV{TZ};
> +		}
> +
> +		my $ourTZ =
> +		    POSIX::strftime ('%Z', $S, $M, $H, $d, $m - 1, $Y - 1900);
> +
> +		# This converts $epochUTC into our local timezone.
> +		my ($sec, $min, $hour, $mday, $mon, $year,
> +		    $wday, $yday, $isdst) = localtime ($epochUTC);
> +
> +		$parsed_date = sprintf ('%s %04d-%02d-%02d %02d:%02d:%02d',
> +					$ourTZ, $year + 1900, $mon + 1,
> +					$mday, $hour, $min, $sec);

There's probably a reason you didn't use strftime here, or is there?
The stock Perl time/date handling functions have always frightened me,
so I'll just trust the (+|-) (1|1900) things are correct :)

-- 
Eric Wong
