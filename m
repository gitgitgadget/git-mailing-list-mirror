From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/5] Add a generic tree traversal to fetch SVN properties.
Date: Tue, 16 Oct 2007 00:43:10 -0700
Message-ID: <20071016074310.GA32254@soma>
References: <1192462506-3783-1-git-send-email-tsuna@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Tue Oct 16 09:43:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihh5J-0006Lm-4G
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 09:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760194AbXJPHnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 03:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759809AbXJPHnN
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 03:43:13 -0400
Received: from hand.yhbt.net ([66.150.188.102]:46377 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759126AbXJPHnM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 03:43:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 6E9777DC0FE;
	Tue, 16 Oct 2007 00:43:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1192462506-3783-1-git-send-email-tsuna@lrde.epita.fr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61104>

Benoit Sigoure <tsuna@lrde.epita.fr> wrote:
> 	* git-svn.perl (&traverse_ignore): Remove.
> 	(&prop_walk): New.
> 	(&cmd_show_ignore): Use prop_walk.
> 
> Signed-off-by: Benoit Sigoure <tsuna@lrde.epita.fr>

Although I myself have never needed this functionality, this series
looks pretty good in general.

Thanks.

One comment below about property selection (whitelist vs blacklist).


It would be possible to get identical information out of unhandled.log,
but older repositories may not have complete information...  Maybe some
local option would be good for people with complete unhandled.log files;
but it could be really incomplete/insufficient.


I'm not sure about 5/5, it's purely a style issue, however I don't
really feel strongly about a trailing "\n" either way...  Nevertheless,
it is definitely not part of this series and should be treated
independently.


Coding style

Other than that, I prefer to keep braces on the same line as foreach,
if, else statements.  I generally follow the git and Linux coding
style for C in my Perl code.

One exception that I make for Perl (but not C) is that I keep the "{"
for subs on the same line (since subs can be nested and anonymous ones
passed as arguments and such); unlike their C counterparts[1]

[1] - well, nesting functions is allowed in C99 or GNU C, I can't
      remember which or both...

> ---
>  git-svn.perl |   66 ++++++++++++++++++++++++++++++++++++++++-----------------
>  1 files changed, 46 insertions(+), 20 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 777e436..abc83ec 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -488,7 +488,15 @@ sub cmd_show_ignore {
>  	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
>  	$gs ||= Git::SVN->new;
>  	my $r = (defined $_revision ? $_revision : $gs->ra->get_latest_revnum);
> -	$gs->traverse_ignore(\*STDOUT, $gs->{path}, $r);
> +	$gs->prop_walk($gs->{path}, $r, sub {
> +		my ($gs, $path, $props) = @_;
> +		print STDOUT "\n# $path\n";
> +		my $s = $props->{'svn:ignore'} or return;
> +		$s =~ s/[\r\n]+/\n/g;
> +		chomp $s;
> +		$s =~ s#^#$path#gm;
> +		print STDOUT "$s\n";
> +	});
>  }
>  
>  sub cmd_multi_init {
> @@ -1480,28 +1488,46 @@ sub rel_path {
>  	$url;
>  }
>  
> -sub traverse_ignore {
> -	my ($self, $fh, $path, $r) = @_;
> -	$path =~ s#^/+##g;
> -	my $ra = $self->ra;
> -	my ($dirent, undef, $props) = $ra->get_dir($path, $r);
> +# prop_walk(PATH, REV, SUB)
> +# -------------------------
> +# Recursively traverse PATH at revision REV and invoke SUB for each
> +# directory that contains a SVN property.  SUB will be invoked as
> +# follows:  &SUB(gs, path, props);  where `gs' is this instance of
> +# Git::SVN, `path' the path to the directory where the properties
> +# `props' were found.  The `path' will be relative to point of checkout,
> +# that is, if url://repo/trunk is the current Git branch, and that
> +# directory contains a sub-directory `d', SUB will be invoked with `/d/'
> +# as `path' (note the trailing `/').
> +sub prop_walk {
> +	my ($self, $path, $rev, $sub) = @_;
> +
> +	my ($dirent, undef, $props) = $self->ra->get_dir($path, $rev);
> +	$path =~ s#^/*#/#g;
>  	my $p = $path;
> -	$p =~ s#^\Q$self->{path}\E(/|$)##;
> -	print $fh length $p ? "\n# $p\n" : "\n# /\n";
> -	if (my $s = $props->{'svn:ignore'}) {
> -		$s =~ s/[\r\n]+/\n/g;
> -		chomp $s;
> -		if (length $p == 0) {
> -			$s =~ s#\n#\n/$p#g;
> -			print $fh "/$s\n";
> -		} else {
> -			$s =~ s#\n#\n/$p/#g;
> -			print $fh "/$p/$s\n";
> -		}
> -	}
> +	# Strip the irrelevant part of the path.
> +	$p =~ s#^/+\Q$self->{path}\E(/|$)#/#;
> +	# Ensure the path is terminated by a `/'.
> +	$p =~ s#/*$#/#;
> +
> +	# The properties contain all the internal SVN stuff nobody
> +	# (usually) cares about.

How about having a blacklist (for the author, date, log, uuid?) instead
of a whitelist?  I can't remember all of them that should be blacklisted,
 but maybe it's just author, date and log)..

> +	my $interesting_props = 0;
> +	foreach(keys %{$props})
> +	{
> +		# If it doesn't start with `svn:', it must be a
> +		# user-defined property.
> +		++$interesting_props and next if $_ !~ /^svn:/;
> +		# FIXME: Fragile, if SVN adds new public properties,
> +		# this needs to be updated.
> +		++$interesting_props if /^svn:(?:ignore|keywords|executable
> +		                                 |eol-style|mime-type
> +						 |externals|needs-lock)$/x;
> +	}
> +	&$sub($self, $p, $props) if $interesting_props;
> +
>  	foreach (sort keys %$dirent) {
>  		next if $dirent->{$_}->{kind} != $SVN::Node::dir;
> -		$self->traverse_ignore($fh, "$path/$_", $r);
> +		$self->prop_walk($path . '/' . $_, $rev, $sub);
>  	}
>  }

-- 
Eric Wong
