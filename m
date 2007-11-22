From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/3 v3] git-svn: extract reusable code into utility functions
Date: Wed, 21 Nov 2007 17:19:46 -0800
Message-ID: <20071122011946.GA30134@soma>
References: <1195675039-26746-1-git-send-email-ddkilzer@kilzer.net> <1195675039-26746-2-git-send-email-ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Thu Nov 22 02:20:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv0jf-0006e2-7z
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 02:20:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbXKVBTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 20:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751970AbXKVBTt
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 20:19:49 -0500
Received: from hand.yhbt.net ([66.150.188.102]:37023 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbXKVBTs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 20:19:48 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 6D03C7DC0FE;
	Wed, 21 Nov 2007 17:19:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1195675039-26746-2-git-send-email-ddkilzer@kilzer.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65728>

"David D. Kilzer" <ddkilzer@kilzer.net> wrote:
> Extacted canonicalize_path() in the main package.
> 
> Created new Git::SVN::Util package with an md5sum() function.  A
> new package was created so that Digest::MD5 did not have to be
> loaded in the main package.  Replaced code in the SVN::Git::Editor
> and SVN::Git::Fetcher packages with calls to md5sum().
> 
> Extracted the format_svn_date(), parse_git_date() and
> set_local_timezone() functions within the Git::SVN::Log package.
> 
> Signed-off-by: David D. Kilzer <ddkilzer@kilzer.net>

Thanks, this patch is independently useful.

Acked-by: Eric Wong <normalperson@yhbt.net>


I'm having a problem with [2/3] currently:

$file_type not being detected correctly when running "git svn info"
on the top-level directory with no arguments.  It's opening the
directory and trying to md5 it here:

		} else {
			open FILE, "<", $path or die $!;
			$checksum = Git::SVN::Util::md5sum(\*FILE);
			close FILE or die $!;
		}

> ---
>  git-svn.perl |   96 ++++++++++++++++++++++++++++++++++++++-------------------
>  1 files changed, 64 insertions(+), 32 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 5b1deea..98c980f 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -48,7 +48,8 @@ BEGIN {
>  	foreach (qw/command command_oneline command_noisy command_output_pipe
>  	            command_input_pipe command_close_pipe/) {
>  		for my $package ( qw(SVN::Git::Editor SVN::Git::Fetcher
> -			Git::SVN::Migration Git::SVN::Log Git::SVN),
> +			Git::SVN::Migration Git::SVN::Log Git::SVN
> +			Git::SVN::Util),
>  			__PACKAGE__) {
>  			*{"${package}::$_"} = \&{"Git::$_"};
>  		}
> @@ -583,6 +584,17 @@ sub cmd_create_ignore {
>  	});
>  }
>  
> +sub canonicalize_path {
> +	my ($path) = @_;
> +	# File::Spec->canonpath doesn't collapse x/../y into y (for a
> +	# good reason), so let's do this manually.
> +	$path =~ s#/+#/#g;
> +	$path =~ s#/\.(?:/|$)#/#g;
> +	$path =~ s#/[^/]+/\.\.##g;
> +	$path =~ s#/$##g;
> +	return $path;
> +}
> +
>  # get_svnprops(PATH)
>  # ------------------
>  # Helper for cmd_propget and cmd_proplist below.
> @@ -600,12 +612,7 @@ sub get_svnprops {
>  
>  	# canonicalize the path (otherwise libsvn will abort or fail to
>  	# find the file)
> -	# File::Spec->canonpath doesn't collapse x/../y into y (for a
> -	# good reason), so let's do this manually.
> -	$path =~ s#/+#/#g;
> -	$path =~ s#/\.(?:/|$)#/#g;
> -	$path =~ s#/[^/]+/\.\.##g;
> -	$path =~ s#/$##g;
> +	$path = canonicalize_path($path);
>  
>  	my $r = (defined $_revision ? $_revision : $gs->ra->get_latest_revnum);
>  	my $props;
> @@ -1043,6 +1050,27 @@ sub linearize_history {
>  	(\@linear_refs, \%parents);
>  }
>  
> +package Git::SVN::Util;
> +use strict;
> +use warnings;
> +use Digest::MD5;
> +
> +sub md5sum {
> +	my $arg = shift;
> +	my $ref = ref $arg;
> +	my $md5 = Digest::MD5->new();
> +        if ($ref eq 'GLOB' || $ref eq 'IO::File') {
> +		$md5->addfile($arg) or croak $!;
> +	} elsif ($ref eq 'SCALAR') {
> +		$md5->add($$arg) or croak $!;
> +	} elsif (!$ref) {
> +		$md5->add($arg) or croak $!;
> +	} else {
> +		::fatal "Can't provide MD5 hash for unknown ref type: '", $ref, "'";
> +	}
> +	return $md5->hexdigest();
> +}
> +
>  package Git::SVN;
>  use strict;
>  use warnings;
> @@ -2610,7 +2638,6 @@ use strict;
>  use warnings;
>  use Carp qw/croak/;
>  use IO::File qw//;
> -use Digest::MD5;
>  
>  # file baton members: path, mode_a, mode_b, pool, fh, blob, base
>  sub new {
> @@ -2762,9 +2789,7 @@ sub apply_textdelta {
>  
>  		if (defined $exp) {
>  			seek $base, 0, 0 or croak $!;
> -			my $md5 = Digest::MD5->new;
> -			$md5->addfile($base);
> -			my $got = $md5->hexdigest;
> +			my $got = Git::SVN::Util::md5sum($base);
>  			die "Checksum mismatch: $fb->{path} $fb->{blob}\n",
>  			    "expected: $exp\n",
>  			    "     got: $got\n" if ($got ne $exp);
> @@ -2783,9 +2808,7 @@ sub close_file {
>  	if (my $fh = $fb->{fh}) {
>  		if (defined $exp) {
>  			seek($fh, 0, 0) or croak $!;
> -			my $md5 = Digest::MD5->new;
> -			$md5->addfile($fh);
> -			my $got = $md5->hexdigest;
> +			my $got = Git::SVN::Util::md5sum($fh);
>  			if ($got ne $exp) {
>  				die "Checksum mismatch: $path\n",
>  				    "expected: $exp\n    got: $got\n";
> @@ -2837,7 +2860,6 @@ use strict;
>  use warnings;
>  use Carp qw/croak/;
>  use IO::File;
> -use Digest::MD5;
>  
>  sub new {
>  	my ($class, $opts) = @_;
> @@ -3141,11 +3163,9 @@ sub chg_file {
>  	$fh->flush == 0 or croak $!;
>  	seek $fh, 0, 0 or croak $!;
>  
> -	my $md5 = Digest::MD5->new;
> -	$md5->addfile($fh) or croak $!;
> +	my $exp = Git::SVN::Util::md5sum($fh);
>  	seek $fh, 0, 0 or croak $!;
>  
> -	my $exp = $md5->hexdigest;
>  	my $pool = SVN::Pool->new;
>  	my $atd = $self->apply_textdelta($fbat, undef, $pool);
>  	my $got = SVN::TxDelta::send_stream($fh, @$atd, $pool);
> @@ -3859,6 +3879,29 @@ sub run_pager {
>  	exec $pager or ::fatal "Can't run pager: $! ($pager)";
>  }
>  
> +sub format_svn_date {
> +	return strftime("%Y-%m-%d %H:%M:%S %z (%a, %d %b %Y)", localtime(shift));
> +}
> +
> +sub parse_git_date {
> +	my ($t, $tz) = @_;
> +	# Date::Parse isn't in the standard Perl distro :(
> +	if ($tz =~ s/^\+//) {
> +		$t += tz_to_s_offset($tz);
> +	} elsif ($tz =~ s/^\-//) {
> +		$t -= tz_to_s_offset($tz);
> +	}
> +	return $t;
> +}
> +
> +sub set_local_timezone {
> +	if (defined $TZ) {
> +		$ENV{TZ} = $TZ;
> +	} else {
> +		delete $ENV{TZ};
> +	}
> +}
> +
>  sub tz_to_s_offset {
>  	my ($tz) = @_;
>  	$tz =~ s/(\d\d)$//;
> @@ -3879,13 +3922,7 @@ sub get_author_info {
>  	$dest->{t} = $t;
>  	$dest->{tz} = $tz;
>  	$dest->{a} = $au;
> -	# Date::Parse isn't in the standard Perl distro :(
> -	if ($tz =~ s/^\+//) {
> -		$t += tz_to_s_offset($tz);
> -	} elsif ($tz =~ s/^\-//) {
> -		$t -= tz_to_s_offset($tz);
> -	}
> -	$dest->{t_utc} = $t;
> +	$dest->{t_utc} = parse_git_date($t, $tz);
>  }
>  
>  sub process_commit {
> @@ -3939,8 +3976,7 @@ sub show_commit_normal {
>  	my ($c) = @_;
>  	print commit_log_separator, "r$c->{r} | ";
>  	print "$c->{c} | " if $show_commit;
> -	print "$c->{a} | ", strftime("%Y-%m-%d %H:%M:%S %z (%a, %d %b %Y)",
> -				 localtime($c->{t_utc})), ' | ';
> +	print "$c->{a} | ", format_svn_date($c->{t_utc}), ' | ';
>  	my $nr_line = 0;
>  
>  	if (my $l = $c->{l}) {
> @@ -3980,11 +4016,7 @@ sub cmd_show_log {
>  	my (@args) = @_;
>  	my ($r_min, $r_max);
>  	my $r_last = -1; # prevent dupes
> -	if (defined $TZ) {
> -		$ENV{TZ} = $TZ;
> -	} else {
> -		delete $ENV{TZ};
> -	}
> +	set_local_timezone();
>  	if (defined $::_revision) {
>  		if ($::_revision =~ /^(\d+):(\d+)$/) {
>  			($r_min, $r_max) = ($1, $2);

-- 
Eric Wong
