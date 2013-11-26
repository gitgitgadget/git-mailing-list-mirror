From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Add an option for adding more branch refs
Date: Tue, 26 Nov 2013 13:48:10 -0800
Message-ID: <xmqqr4a2vnqd.fsf@gitster.dls.corp.google.com>
References: <1385462243-7898-1-git-send-email-krzesimir@endocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Krzesimir Nowak <krzesimir@endocode.com>
X-From: git-owner@vger.kernel.org Tue Nov 26 22:48:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlQUd-0003wM-Ev
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 22:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757833Ab3KZVsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Nov 2013 16:48:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62868 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754569Ab3KZVsW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Nov 2013 16:48:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FADF56947;
	Tue, 26 Nov 2013 16:48:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3hHKMjOjTufEJq/EDKkFtfRpGpI=; b=KgeeD+
	El7hlNGL1n9JPgkhEaBi8aUKuG792hocgaLpj0rwMsbeW++CnIDPWlxgFsg3NMPw
	Mb++xfz0bUnPt++VOaYOZ8Yfg6T45rlgdjgNVDh9Lp6+YOGM24V0RgErLeLMT92N
	PcM9fYJUqlgbl84x//Yfps/j97EYJbpadXB3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j0Ge64DfkOIHlSRwAJRXIHMbOTXpFiIh
	9gewBm9tm5Qg8gL5FzVlunfMwxyqX+mCS0OsZKgDrO6LhuIEKjz3s0imTH68QAsa
	yqyOMez0cJlpQC/1Y/f+j6oiFxyh3Cd/WxUpg+1rwg7cIDMHk1EZabnm8/AUlD0m
	g5hFEyONKEA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CB2756946;
	Tue, 26 Nov 2013 16:48:21 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5211B56945;
	Tue, 26 Nov 2013 16:48:20 -0500 (EST)
In-Reply-To: <1385462243-7898-1-git-send-email-krzesimir@endocode.com>
	(Krzesimir Nowak's message of "Tue, 26 Nov 2013 11:37:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7730720C-56E4-11E3-BB31-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238395>

Krzesimir Nowak <krzesimir@endocode.com> writes:

> Overriding an @additional_branch_refs configuration variable with
> value ('wip') will make gitweb to show branches that appear in
> refs/heads and refs/wip (refs/heads is hardcoded). Might be useful for
> gerrit setups where user branches are not stored under refs/heads/.
>
> Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
> ---
>  gitweb/gitweb.perl | 99 ++++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 74 insertions(+), 25 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 68c77f6..9bfd38b 100755
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
> @@ -122,6 +123,10 @@ our $logo_label = "git homepage";
>  # source of projects list
>  our $projects_list = "++GITWEB_LIST++";
>  
> +# list of additional "directories" under "refs/" we want to display as
> +# branches
> +our @additional_branch_refs = ();
> +
>  # the width (in characters) of the projects list "Description" column
>  our $projects_list_description_width = 25;
>  
> @@ -626,14 +631,29 @@ sub feature_avatar {
>  	return @val ? @val : @_;
>  }
>  
> +sub get_branch_refs {
> +    return ('heads', @additional_branch_refs);
> +}
> +
>  # checking HEAD file with -e is fragile if the repository was
>  # initialized long time ago (i.e. symlink HEAD) and was pack-ref'ed
>  # and then pruned.
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
> +		for my $ref (get_branch_refs()) {
> +			return 1 if $rl =~ /^refs\/$ref\//;
> +		}
> +	}
> +	return 0;

The change to this function is wrong. A non-detached HEAD that
points at anything other than refs/heads/ should be considered a
repository corruption and should not be encouraged.

> @@ -2515,6 +2535,7 @@ sub format_snapshot_links {
>  sub get_feed_info {
>  	my $format = shift || 'Atom';
>  	my %res = (action => lc($format));
> +	my $matched_ref = 0;
>  
>  	# feed links are possible only for project views
>  	return unless (defined $project);
> @@ -2522,12 +2543,17 @@ sub get_feed_info {
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
> +	# branches refs uses 'refs/' + $get_branch_refs()[x] + '/' prefix
> +	# (fullname) to differentiate from tag links; this also makes
> +	# possible to detect branch links
> +	for my $ref (get_branch_refs()) {
> +		if ((defined $hash_base && $hash_base =~ m!^refs/$ref/(.*)$!) ||
> +		    (defined $hash      && $hash      =~ m!^refs/$ref/(.*)$!)) {
> +			$branch = $1;
> +			$matched_ref = $ref;
> +			last;
> +		}
>  	}
>  	# find log type for feed description (title)
>  	my $type = 'log';
> @@ -2540,7 +2566,7 @@ sub get_feed_info {
>  	}
>  
>  	$res{-title} = $type;
> -	$res{'hash'} = (defined $branch ? "refs/heads/$branch" : undef);
> +	$res{'hash'} = (defined $branch ? "refs/$matched_ref/$branch" : undef);
>  	$res{'file_name'} = $file_name;

OK.

> @@ -3184,24 +3210,43 @@ sub git_get_project_owner {
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
>  	}
> +
> +	return undef;
> +}
> +
> +sub git_get_last_activity {
> +	my ($path) = @_;
> +	my @ages = ();
> +
> +	$git_dir = "$projectroot/$path";
> +	for my $ref (get_branch_refs()) {
> +		my $age = git_get_last_activity_age('refs/' . $_);
> +
> +		push @ages, $age if defined $age;
> +	}
> +	if (@ages) {
> +		my $min_age = min(@ages);
> +
> +		return ($min_age, age_string($min_age));
> +	}
> +
>  	return (undef, undef);
>  }

The original runs

	for-each-ref --count=1 refs/heads

and picks the latest one, so shouldn't it be the matter of running

	for-each-ref --count=1 refs/heads refs/extra

i.e. something like

@@ -3193,7 +3193,7 @@ sub git_get_last_activity {
 	     '--format=%(committer)',
 	     '--sort=-committerdate',
 	     '--count=1',
-	     'refs/heads') or return;
+	     map { "refs/$_" } get_branch_refs()) or return;
 	my $most_recent = <$fd>;
 	close $fd or return;
 	if (defined $most_recent &&

to grab the latest among the refs you care about?

> @@ -3223,7 +3268,7 @@ sub git_get_remotes_list {
>  		next if $wanted and not $remote eq $wanted;
>  		my ($url, $key) = ($1, $2);
>  
> -		$remotes{$remote} ||= { 'heads' => () };
> +		$remotes{$remote} ||= { map { $_ => () } get_branch_refs() };
>  		$remotes{$remote}{$key} = $url;
>  	}
>  	close $fd or return;
> @@ -3237,9 +3282,11 @@ sub fill_remote_heads {
>  	my @heads = map { "remotes/$_" } keys %$remotes;
>  	my @remoteheads = git_get_heads_list(undef, @heads);
>  	foreach my $remote (keys %$remotes) {
> -		$remotes->{$remote}{'heads'} = [ grep {
> -			$_->{'name'} =~ s!^$remote/!!
> -			} @remoteheads ];
> +		foreach my $ref (get_branch_refs()) {
> +			$remotes->{$remote}{$ref} = [ grep {
> +				$_->{'name'} =~ s!^$remote/!!
> +				} @remoteheads ];
> +		}
>  	}
>  }

Hmmm, why?  Aren't these additional ones about the local
"branch-like" refs?  What makes us think that these names are also
shared with the names from remote hierarchies?

> @@ -3644,7 +3691,7 @@ sub parse_from_to_diffinfo {
>  
>  sub git_get_heads_list {
>  	my ($limit, @classes) = @_;
> -	@classes = ('heads') unless @classes;
> +	@classes = get_branch_refs() unless @classes;
>  	my @patterns = map { "refs/$_" } @classes;
>  	my @headslist;
>  
> @@ -3662,7 +3709,8 @@ sub git_get_heads_list {
>  		my ($committer, $epoch, $tz) =
>  			($committerinfo =~ /^(.*) ([0-9]+) (.*)$/);
>  		$ref_item{'fullname'}  = $name;
> -		$name =~ s!^refs/(?:head|remote)s/!!;
> +		my $strip_refs = join '|', get_branch_refs();
> +		$name =~ s!^refs/(?:$strip_refs|remotes)/!!;
>  
>  		$ref_item{'name'}  = $name;
>  		$ref_item{'id'}    = $hash;
> @@ -4286,7 +4334,7 @@ sub git_print_page_nav {
>  # available if the feature is enabled
>  sub format_ref_views {
>  	my ($current) = @_;
> -	my @ref_views = qw{tags heads};
> +	my @ref_views = ('tags', get_branch_refs());
>  	push @ref_views, 'remotes' if gitweb_check_feature('remote_heads');
>  	return join " | ", map {
>  		$_ eq $current ? $_ :
> @@ -7179,7 +7227,8 @@ sub snapshot_name {
>  		$ver = $1;
>  	} else {
>  		# branches and other need shortened SHA-1 hash
> -		if ($hash =~ m!^refs/(?:heads|remotes)/(.*)$!) {
> +		my $strip_refs = join '|', get_branch_refs();
> +		if ($hash =~ m!^refs/(?:$strip_refs|remotes)/(.*)$!) {
>  			$ver = $1;
>  		}
>  		$ver .= '-' . git_get_short_hash($project, $hash);

As the elements of @additional_branch_refs are expected by code
added by this patch to never have any special metacharacters in
them, it probably is a good idea to sanity check it to catch
misconfigurations and typos before doing anything else.

Other than that, looks good to me.

Thanks.
