From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: Allow certain refs to be ignored
Date: Fri, 07 Oct 2011 16:23:13 -0700
Message-ID: <7vvcs0s7xa.fsf@alter.siamese.dyndns.org>
References: <CAN4ruPiSgY+LPdDgS021WQyoHMuNrJDzrqMuCt9G5qfZ=XtjoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Olson <mwolson@gnu.org>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Oct 08 01:23:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCJlC-0002rJ-Dl
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 01:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759378Ab1JGXXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 19:23:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54592 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754028Ab1JGXXR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 19:23:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6BFC6456;
	Fri,  7 Oct 2011 19:23:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sbTNGId6Hiy39EYZ+2mb8jKGMkc=; b=feMxgX
	yE6FVYZXVKl6NkRVyJmbY9I2FpKbyNCXrrwaGs2AhkJBJ6TrS+sKD3WZayIlL5bV
	erQlelpMYktPa/iTerE/VAsHEAMHjwthiLByBWcExbbEBtMiHqbsIRwTI6W464xk
	WrkjjBYSG6r8bSrAgd/qSTtx/TTSBOFbAeKUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RMI6iH+hdV9gMg6YLKbYGA//VEuQlOoP
	yRwOCPj09YbZ0UsNV97TBtdE1D81bzaDjcfCYry1Rxl7i4RLhcppA1tOOegsHSkL
	OZCiP3I7cEXQLiSMhFp6AIQEQzHJy/tf1E0GaaZ/Mfz2YvsRgfiQHP0hKQv7vHxQ
	P6vlLwufn+c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D61DC6455;
	Fri,  7 Oct 2011 19:23:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 00C7B6453; Fri,  7 Oct 2011
 19:23:14 -0400 (EDT)
In-Reply-To: <CAN4ruPiSgY+LPdDgS021WQyoHMuNrJDzrqMuCt9G5qfZ=XtjoQ@mail.gmail.com> (Michael
 Olson's message of "Thu, 6 Oct 2011 17:41:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 54DB785C-F13B-11E0-B3A7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183126>

Asking Eric to comment when he has time to do so.

I find these pattern matches that are not anchored on either side 
somewhat disturbing (e.g. --ignore-refs=master would ignore master2)
but ignore-paths codepath seems to follow the same pattern, so perhaps it
is in line with what git-svn users want. I dunno.

Michael Olson <mwolson@gnu.org> writes:

> Implement a new --ignore-refs option which specifies a regex of refs
> to ignore while importing svn history.
>
> This is a useful supplement to the --ignore-paths option, as that
> option only operates on the contents of branches and tags, not the
> branches and tags themselves.
>
> Signed-off-by: Michael Olson <mwolson@gnu.org>
> ---
> Re-sent by request of Piotr Krukowiecki.  This is against v1.7.4.1,
> and I've been using it stably for a while.
>
>  git-svn.perl |   38 +++++++++++++++++++++++++++++++++-----
>  1 files changed, 33 insertions(+), 5 deletions(-)
>
> diff --git a/git-svn.perl b/git-svn.perl
> index 177dd25..541fa2d 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -90,7 +90,8 @@ $_q ||= 0;
>  my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
>                      'config-dir=s' => \$Git::SVN::Ra::config_dir,
>                      'no-auth-cache' => \$Git::SVN::Prompt::_no_auth_cache,
> -                    'ignore-paths=s' => \$SVN::Git::Fetcher::_ignore_regex );
> +                    'ignore-paths=s' => \$SVN::Git::Fetcher::_ignore_regex,
> +                    'ignore-refs=s' => \$Git::SVN::Ra::_ignore_refs_regex );
>  my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
>  		'authors-file|A=s' => \$_authors,
>  		'authors-prog=s' => \$_authors_prog,
> @@ -380,9 +381,12 @@ sub do_git_init_db {
>  		command_noisy('config', "$pfx.$i", $icv{$i});
>  		$set = $i;
>  	}
> -	my $ignore_regex = \$SVN::Git::Fetcher::_ignore_regex;
> -	command_noisy('config', "$pfx.ignore-paths", $$ignore_regex)
> -		if defined $$ignore_regex;
> +	my $ignore_paths_regex = \$SVN::Git::Fetcher::_ignore_regex;
> +	command_noisy('config', "$pfx.ignore-paths", $$ignore_paths_regex)
> +		if defined $$ignore_paths_regex;
> +	my $ignore_refs_regex = \$Git::SVN::Ra::_ignore_refs_regex;
> +	command_noisy('config', "$pfx.ignore-refs", $$ignore_refs_regex)
> +		if defined $$ignore_refs_regex;
>  }
>
>  sub init_subdir {
> @@ -1831,6 +1835,8 @@ sub read_all_remotes {
>  			$r->{$1}->{svm} = {};
>  		} elsif (m!^(.+)\.url=\s*(.*)\s*$!) {
>  			$r->{$1}->{url} = $2;
> +		} elsif (m!^(.+)\.ignore-refs=\s*(.*)\s*$!) {
> +			$r->{$1}->{ignore_refs_regex} = $2;
>  		} elsif (m!^(.+)\.(branches|tags)=$svn_refspec$!) {
>  			my ($remote, $t, $local_ref, $remote_ref) =
>  			                                     ($1, $2, $3, $4);
> @@ -1867,6 +1873,16 @@ sub read_all_remotes {
>  		}
>  	} keys %$r;
>
> +	foreach my $remote (keys %$r) {
> +		foreach ( grep { defined $_ }
> +			  map { $r->{$remote}->{$_} } qw(branches tags) ) {
> +			foreach my $rs ( @$_ ) {
> +				$rs->{ignore_refs_regex} =
> +				    $r->{$remote}->{ignore_refs_regex};
> +			}
> +		}
> +	}
> +
>  	$r;
>  }
>
> @@ -4876,7 +4892,7 @@ sub apply_diff {
>  }
>
>  package Git::SVN::Ra;
> -use vars qw/@ISA $config_dir $_log_window_size/;
> +use vars qw/@ISA $config_dir $_ignore_refs_regex $_log_window_size/;
>  use strict;
>  use warnings;
>  my ($ra_invalid, $can_do_switch, %ignored_err, $RA);
> @@ -5334,6 +5350,17 @@ sub get_dir_globbed {
>  	@finalents;
>  }
>
> +# return value: 0 -- don't ignore, 1 -- ignore
> +sub is_ref_ignored {
> +	my ($g, $p) = @_;
> +	my $refname = $g->{ref}->full_path($p);
> +	return 1 if defined($g->{ignore_refs_regex}) &&
> +	            $refname =~ m!$g->{ignore_refs_regex}!;
> +	return 0 unless defined($_ignore_refs_regex);
> +	return 1 if $refname =~ m!$_ignore_refs_regex!o;
> +	return 0;
> +}
> +
>  sub match_globs {
>  	my ($self, $exists, $paths, $globs, $r) = @_;
>
> @@ -5370,6 +5397,7 @@ sub match_globs {
>  			next unless /$g->{path}->{regex}/;
>  			my $p = $1;
>  			my $pathname = $g->{path}->full_path($p);
> +			next if is_ref_ignored($g, $p);
>  			next if $exists->{$pathname};
>  			next if ($self->check_path($pathname, $r) !=
>  			         $SVN::Node::dir);
