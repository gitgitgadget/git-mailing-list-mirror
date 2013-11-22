From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Make showing branches configurable
Date: Fri, 22 Nov 2013 09:34:41 -0800
Message-ID: <xmqqhab41gsu.fsf@gitster.dls.corp.google.com>
References: <1385125848-8243-1-git-send-email-krzesimir@endocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Krzesimir Nowak <krzesimir@endocode.com>
X-From: git-owner@vger.kernel.org Fri Nov 22 18:34:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjud7-0003U7-GU
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 18:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755431Ab3KVRex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 12:34:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64658 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752565Ab3KVRew (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 12:34:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECFFE540A6;
	Fri, 22 Nov 2013 12:34:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MdGIR4lEhnQy+/3SVgvc+a8bJ6U=; b=GxJku3
	RFV1gTCxvoG2Ct064YeqFifNoH2fHlOdTtVtXNoCI+SGppfznLXC2HDxRFSyx8WY
	NLJsqc4bamloOH6OSmXMx/979ozBBW4LjjrmOZ4q3HT1AhvA+dFdGxe1lvcb2Zbb
	M6GECKPoYb/YbRrtWeqt6y8GiUbA6MIFroNEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mTYAfDTk7yRRauM3o+0junNUdtq3O/5Q
	DDa7jAs8zWM8FCm01qK82sJiBMgEppTgEGsEm24Z2alWL+risGUGzZ+04W13Ly/i
	70CxT3uRocxLI9MwufuftP2Ns3BaJm+zeZjd9D4ENK53opor1722tBeC+isnQCOK
	jw/qB+dVKhs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA211540A4;
	Fri, 22 Nov 2013 12:34:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB708540A2;
	Fri, 22 Nov 2013 12:34:45 -0500 (EST)
In-Reply-To: <1385125848-8243-1-git-send-email-krzesimir@endocode.com>
	(Krzesimir Nowak's message of "Fri, 22 Nov 2013 14:10:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6110B05E-539C-11E3-A7B5-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238201>

Krzesimir Nowak <krzesimir@endocode.com> writes:

> Running 'make GITWEB_WANTED_REFS="heads wip" gitweb.cgi' will create a
> gitweb CGI script showing branches that appear in refs/heads/ and in
> refs/wip/. Might be useful for gerrit setups where user branches are
> not stored under refs/heads/.
>
> Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
> ---
>
> Notes:
>     I'm actually not sure if all those changes are really necessary as I
>     was mostly targeting it for Gerrit use. Especially I mean the changes
>     in git_get_remotes_list, fill_remote_heads and print_page_nav. I tried
>     to make it as general as it gets, so there's nothing Gerrit specific.

Thanks.

Two knee-jerk reactions after a quick scan.

 - You include "heads" for normal builds by hardcoded
   "GITWEB_WANTED_REFS = heads" but include "tags" unconditionally
   by having @ref_views = ("tags", @wanted_refs) in the code.  Why?

 - Does this have be a compile-time decision?  It looks like this is
   something that can and should be made controllable with the
   normal gitweb configuration mechanism.


>  gitweb/Makefile    |  4 ++-
>  gitweb/gitweb.perl | 94 +++++++++++++++++++++++++++++++++++++++---------------
>  2 files changed, 72 insertions(+), 26 deletions(-)
>
> diff --git a/gitweb/Makefile b/gitweb/Makefile
> index cd194d0..361dce9 100644
> --- a/gitweb/Makefile
> +++ b/gitweb/Makefile
> @@ -38,6 +38,7 @@ GITWEB_SITE_HTML_HEAD_STRING =
>  GITWEB_SITE_HEADER =
>  GITWEB_SITE_FOOTER =
>  HIGHLIGHT_BIN = highlight
> +GITWEB_WANTED_REFS = heads
>  
>  # include user config
>  -include ../config.mak.autogen
> @@ -148,7 +149,8 @@ GITWEB_REPLACE = \
>  	-e 's|++GITWEB_SITE_HTML_HEAD_STRING++|$(GITWEB_SITE_HTML_HEAD_STRING)|g' \
>  	-e 's|++GITWEB_SITE_HEADER++|$(GITWEB_SITE_HEADER)|g' \
>  	-e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g' \
> -	-e 's|++HIGHLIGHT_BIN++|$(HIGHLIGHT_BIN)|g'
> +	-e 's|++HIGHLIGHT_BIN++|$(HIGHLIGHT_BIN)|g' \
> +	-e 's|++GITWEB_WANTED_REFS++|$(GITWEB_WANTED_REFS)|g'
>  
>  GITWEB-BUILD-OPTIONS: FORCE
>  	@rm -f $@+
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 68c77f6..8bc9e9a 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -17,6 +17,7 @@ use Encode;
>  use Fcntl ':mode';
>  use File::Find qw();
>  use File::Basename qw(basename);
> +use List::Util qw(min);
>  use Time::HiRes qw(gettimeofday tv_interval);
>  binmode STDOUT, ':utf8';
>  
> @@ -122,6 +123,9 @@ our $logo_label = "git homepage";
>  # source of projects list
>  our $projects_list = "++GITWEB_LIST++";
>  
> +# list of "directories" under "refs/" we want to display as branches
> +our @wanted_refs = qw{++GITWEB_WANTED_REFS++};
> +
>  # the width (in characters) of the projects list "Description" column
>  our $projects_list_description_width = 25;
>  
> @@ -632,8 +636,19 @@ sub feature_avatar {
>  sub check_head_link {
>  	my ($dir) = @_;
>  	my $headfile = "$dir/HEAD";
> -	return ((-e $headfile) ||
> -		(-l $headfile && readlink($headfile) =~ /^refs\/heads\//));
> +
> +	if (-e $headfile) {
> +		return 1;
> +	}
> +	if (-l $headfile) {
> +		my $rl = readlink($headfile);
> +
> +		for my $ref (@wanted_refs) {
> +			return 1 if $rl =~ /^refs\/$ref\//;
> +		}
> +	}
> +
> +	return 0;
>  }
>  
>  sub check_export_ok {
> @@ -2515,6 +2530,7 @@ sub format_snapshot_links {
>  sub get_feed_info {
>  	my $format = shift || 'Atom';
>  	my %res = (action => lc($format));
> +	my $matched_ref = 0;
>  
>  	# feed links are possible only for project views
>  	return unless (defined $project);
> @@ -2522,12 +2538,17 @@ sub get_feed_info {
>  	# or don't have specific feed yet (so they should use generic)
>  	return if (!$action || $action =~ /^(?:tags|heads|forks|tag|search)$/x);
>  
> -	my $branch;
> -	# branches refs uses 'refs/heads/' prefix (fullname) to differentiate
> -	# from tag links; this also makes possible to detect branch links
> -	if ((defined $hash_base && $hash_base =~ m!^refs/heads/(.*)$!) ||
> -	    (defined $hash      && $hash      =~ m!^refs/heads/(.*)$!)) {
> -		$branch = $1;
> +	my $branch = undef;
> +	# branches refs uses 'refs/' + $wanted_refs[x] + '/' prefix
> +	# (fullname) to differentiate from tag links; this also makes
> +	# possible to detect branch links
> +	for my $ref (@wanted_refs) {
> +		if ((defined $hash_base && $hash_base =~ m!^refs/$ref/(.*)$!) ||
> +		    (defined $hash      && $hash      =~ m!^refs/$ref/(.*)$!)) {
> +			$branch = $1;
> +			$matched_ref = $ref;
> +			last;
> +		}
>  	}
>  	# find log type for feed description (title)
>  	my $type = 'log';
> @@ -2540,7 +2561,7 @@ sub get_feed_info {
>  	}
>  
>  	$res{-title} = $type;
> -	$res{'hash'} = (defined $branch ? "refs/heads/$branch" : undef);
> +	$res{'hash'} = (defined $branch ? "refs/$matched_ref/$branch" : undef);
>  	$res{'file_name'} = $file_name;
>  
>  	return %res;
> @@ -3184,24 +3205,43 @@ sub git_get_project_owner {
>  	return $owner;
>  }
>  
> -sub git_get_last_activity {
> -	my ($path) = @_;
> -	my $fd;
> +sub git_get_last_activity_age {
> +	my ($refs) = @_;
> +	my $fd = -1;
>  
> -	$git_dir = "$projectroot/$path";
>  	open($fd, "-|", git_cmd(), 'for-each-ref',
>  	     '--format=%(committer)',
>  	     '--sort=-committerdate',
>  	     '--count=1',
> -	     'refs/heads') or return;
> +	     $refs) or return undef;
> +
>  	my $most_recent = <$fd>;
> -	close $fd or return;
> +	close $fd or return undef;
>  	if (defined $most_recent &&
>  	    $most_recent =~ / (\d+) [-+][01]\d\d\d$/) {
>  		my $timestamp = $1;
> -		my $age = time - $timestamp;
> -		return ($age, age_string($age));
> +		return time - $timestamp;
> +	}
> +
> +	return undef;
> +}
> +
> +sub git_get_last_activity {
> +	my ($path) = @_;
> +	my @ages = ();
> +
> +	$git_dir = "$projectroot/$path";
> +	for my $ref (@wanted_refs) {
> +		my $age = git_get_last_activity_age('refs/' . $_);
> +
> +		push @ages, $age if defined $age;
>  	}
> +	if (@ages) {
> +		my $min_age = min(@ages);
> +
> +		return ($min_age, age_string($min_age));
> +	}
> +
>  	return (undef, undef);
>  }
>  
> @@ -3223,7 +3263,7 @@ sub git_get_remotes_list {
>  		next if $wanted and not $remote eq $wanted;
>  		my ($url, $key) = ($1, $2);
>  
> -		$remotes{$remote} ||= { 'heads' => () };
> +		$remotes{$remote} ||= { map { $_ => () } @wanted_refs };
>  		$remotes{$remote}{$key} = $url;
>  	}
>  	close $fd or return;
> @@ -3237,9 +3277,11 @@ sub fill_remote_heads {
>  	my @heads = map { "remotes/$_" } keys %$remotes;
>  	my @remoteheads = git_get_heads_list(undef, @heads);
>  	foreach my $remote (keys %$remotes) {
> -		$remotes->{$remote}{'heads'} = [ grep {
> -			$_->{'name'} =~ s!^$remote/!!
> -			} @remoteheads ];
> +		foreach my $ref (@wanted_refs) {
> +			$remotes->{$remote}{$ref} = [ grep {
> +				$_->{'name'} =~ s!^$remote/!!
> +				} @remoteheads ];
> +		}
>  	}
>  }
>  
> @@ -3644,7 +3686,7 @@ sub parse_from_to_diffinfo {
>  
>  sub git_get_heads_list {
>  	my ($limit, @classes) = @_;
> -	@classes = ('heads') unless @classes;
> +	@classes = @wanted_refs unless @classes;
>  	my @patterns = map { "refs/$_" } @classes;
>  	my @headslist;
>  
> @@ -3662,7 +3704,8 @@ sub git_get_heads_list {
>  		my ($committer, $epoch, $tz) =
>  			($committerinfo =~ /^(.*) ([0-9]+) (.*)$/);
>  		$ref_item{'fullname'}  = $name;
> -		$name =~ s!^refs/(?:head|remote)s/!!;
> +		my $strip_refs = join '|', @wanted_refs;
> +		$name =~ s!^refs/(?:$strip_refs|remotes)/!!;
>  
>  		$ref_item{'name'}  = $name;
>  		$ref_item{'id'}    = $hash;
> @@ -4286,7 +4329,7 @@ sub git_print_page_nav {
>  # available if the feature is enabled
>  sub format_ref_views {
>  	my ($current) = @_;
> -	my @ref_views = qw{tags heads};
> +	my @ref_views = ("tags", @wanted_refs);
>  	push @ref_views, 'remotes' if gitweb_check_feature('remote_heads');
>  	return join " | ", map {
>  		$_ eq $current ? $_ :
> @@ -7179,7 +7222,8 @@ sub snapshot_name {
>  		$ver = $1;
>  	} else {
>  		# branches and other need shortened SHA-1 hash
> -		if ($hash =~ m!^refs/(?:heads|remotes)/(.*)$!) {
> +		my $strip_refs = join '|', @wanted_refs;
> +		if ($hash =~ m!^refs/(?:$strip_refs|remotes)/(.*)$!) {
>  			$ver = $1;
>  		}
>  		$ver .= '-' . git_get_short_hash($project, $hash);
