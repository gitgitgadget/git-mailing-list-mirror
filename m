From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Support for git-svn propset
Date: Mon, 1 Dec 2014 09:49:11 +0000
Message-ID: <20141201094911.GA13931@dcvr.yhbt.net>
References: <20141201062420.GF99906@elvis.mu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Michael G. Schwern" <schwern@pobox.com>,
	David Fraser <davidf@sjsoft.com>
To: Alfred Perlstein <alfred@freebsd.org>
X-From: git-owner@vger.kernel.org Mon Dec 01 10:49:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvNbZ-00088M-1V
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 10:49:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbaLAJtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 04:49:13 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:51066 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752039AbaLAJtM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 04:49:12 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 83FB51FAC7;
	Mon,  1 Dec 2014 09:49:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20141201062420.GF99906@elvis.mu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260477>

Alfred Perlstein <alfred@freebsd.org> wrote:
> This change allows git-svn to support setting subversion properties.
> 
> Very useful for manually setting properties when committing to a
> subversion repo that *requires* properties to be set without requiring
> moving your changeset to separate subversion checkout in order to
> set props.

Thanks Alfred, that's a good reason for supporting this feature
(something I wasn't convinced of with the original).

> This change is initially from David Fraser <davidf () sjsoft ! com>
> Appearing here: http://marc.info/?l=git&m=125259772625008&w=2

I've added David to the Cc: (but I never heard back from him regarding
comments from his original patch).

Alfred: I had some comments on David's original patch here that
were never addressed:
  http://mid.gmane.org/20090923085812.GA20673@dcvr.yhbt.net

I suspect my concerns about .gitattributes in the source tree from
2009 are less relevant now in 2014 as git-svn seems more socially
acceptable in SVN-using projects.

Some of my other concerns about mimicking existing Perl style still
apply, and we have a Perl section in Documenting/CodingGuidelines
nowadays.

> They are now forward ported to most recent git along with fixes to
> deal with files in subdirectories.
> 
>         Developer's Certificate of Origin 1.1

<snip> no need for the whole DCO in the commit message.
just the S-o-b:

> Signed-off-by: Alfred Perlstein <alfred@freebsd.org>

Since this was originally written by David, his sign-off from the
original email should be here (Cc: for bigger changes)

> ---
>  git-svn.perl           | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  perl/Git/SVN/Editor.pm | 47 +++++++++++++++++++++++++++++++++++++++++++++++

We need a test case written for this new feature.

Most folks (including myself) who were ever involved with git-svn
rarely use it anymore, and this will likely be rarely-used.

>  2 files changed, 96 insertions(+), 1 deletion(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index b6e2186..91423a8 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -115,7 +115,7 @@ my ($_stdin, $_help, $_edit,
>  	$_before, $_after,
>  	$_merge, $_strategy, $_preserve_merges, $_dry_run, $_parents, $_local,
>  	$_prefix, $_no_checkout, $_url, $_verbose,
> -	$_commit_url, $_tag, $_merge_info, $_interactive);
> +	$_commit_url, $_tag, $_merge_info, $_interactive, $_set_svn_props);
>  
>  # This is a refactoring artifact so Git::SVN can get at this git-svn switch.
>  sub opt_prefix { return $_prefix || '' }
> @@ -193,6 +193,7 @@ my %cmd = (
>  			  'dry-run|n' => \$_dry_run,
>  			  'fetch-all|all' => \$_fetch_all,
>  			  'commit-url=s' => \$_commit_url,
> +			  'set-svn-props=s' => \$_set_svn_props,
>  			  'revision|r=i' => \$_revision,
>  			  'no-rebase' => \$_no_rebase,
>  			  'mergeinfo=s' => \$_merge_info,
> @@ -228,6 +229,9 @@ my %cmd = (
>          'propget' => [ \&cmd_propget,
>  		       'Print the value of a property on a file or directory',
>  		       { 'revision|r=i' => \$_revision } ],
> +        'propset' => [ \&cmd_propset,
> +		       'Set the value of a property on a file or directory - will be set on commit',
> +		       {} ],
>          'proplist' => [ \&cmd_proplist,
>  		       'List all properties of a file or directory',
>  		       { 'revision|r=i' => \$_revision } ],
> @@ -1376,6 +1380,50 @@ sub cmd_propget {
>  	print $props->{$prop} . "\n";
>  }
>  
> +# cmd_propset (PROPNAME, PROPVAL, PATH)
> +# ------------------------
> +# Adjust the SVN property PROPNAME to PROPVAL for PATH.
> +sub cmd_propset {
> +	my ($propname, $propval, $path) = @_;
> +	$path = '.' if not defined $path;
> +	$path = $cmd_dir_prefix . $path;
> +	usage(1) if not defined $propname;
> +	usage(1) if not defined $propval;
> +	my $file = basename($path);
> +	my $dn = dirname($path);
> +	# diff has check_attr locally, so just call direct
> +	#my $current_properties = check_attr( "svn-properties", $path );

I prefer leaving out dead code entirely instead of leaving it commented out.

> +	my $current_properties = Git::SVN::Editor::check_attr( "svn-properties", $path );
> +	my $new_properties = "";

Since some lines are too long, local variables can be shortened
to cur_props, new_props without being any less descriptive.

> +	if ($current_properties eq "unset" || $current_properties eq "" || $current_properties eq "set") {
> +		$new_properties = "$propname=$propval";
> +	} else {
> +		# TODO: handle combining properties better
> +		my @props = split(/;/, $current_properties);
> +		my $replaced_prop = 0;
> +		foreach my $prop (@props) {
> +			# Parse 'name=value' syntax and set the property.
> +			if ($prop =~ /([^=]+)=(.*)/) {
> +				my ($n,$v) = ($1,$2);
> +				if ($n eq $propname)
> +				{
> +					$v = $propval;
> +					$replaced_prop = 1;
> +				}
> +				if ($new_properties eq "") { $new_properties="$n=$v"; }
> +				else { $new_properties="$new_properties;$n=$v"; }
> +			}
> +		}
> +		if ($replaced_prop eq 0) {

Generally, == is favored for numeric comparisons
(but this is boolean)

> +			$new_properties = "$new_properties;$propname=$propval";
> +		}
> +	}
> +	my $attrfile = "$dn/.gitattributes";
> +	open my $attrfh, '>>', $attrfile or die "Can't open $attrfile: $!\n";
> +	# TODO: don't simply append here if $file already has svn-properties
> +	print $attrfh "$file svn-properties=$new_properties\n";

Would be good to have an explicit close and error checking on it in case
of FS errors

> +}
> +
>  # cmd_proplist (PATH)
>  # -------------------
>  # Print the list of SVN properties for PATH.
> diff --git a/perl/Git/SVN/Editor.pm b/perl/Git/SVN/Editor.pm
> index 34e8af9..5158c03 100644
> --- a/perl/Git/SVN/Editor.pm
> +++ b/perl/Git/SVN/Editor.pm
> @@ -288,6 +288,49 @@ sub apply_autoprops {
>  	}
>  }
>  
> +sub check_attr
> +{
> +    my ($attr,$path) = @_;
> +    if ( open my $fh, '-|', "git", "check-attr", $attr, "--", $path )

Use Git.pm (command_output_pipe) for running git commands portably.
(And formatting for this sub alone is really off).

> +    {
> +	my $val = <$fh>;
> +	close $fh;
> +	$val =~ s/^[^:]*:\s*[^:]*:\s*(.*)\s*$/$1/;
> +	return $val;
> +    }
> +    else
> +    {
> +	return undef;
> +    }
> +}
> +
> +sub apply_manualprops {
> +	my ($self, $file, $fbat) = @_;
> +	my $pending_properties = check_attr( "svn-properties", $file );
> +	if ($pending_properties eq "") { return; }
> +	# Parse the list of properties to set.
> +	my @props = split(/;/, $pending_properties);
> +	# TODO: get existing properties to compare to - this fails for add so currently not done
> +	# my $existing_props = ::get_svnprops($file);
> +	my $existing_props = {};
> +	# TODO: caching svn properties or storing them in .gitattributes would make that faster
> +	foreach my $prop (@props) {
> +		# Parse 'name=value' syntax and set the property.
> +		if ($prop =~ /([^=]+)=(.*)/) {
> +			my ($n,$v) = ($1,$2);
> +			for ($n, $v) {
> +				s/^\s+//; s/\s+$//;
> +			}

I'd probably rewrite the following hunk:

> +			# FIXME: clearly I don't know perl and couldn't work out how to evaluate this better
> +			if (defined $existing_props->{$n} && $existing_props->{$n} eq $v) {
> +				my $needed = 0;
> +			} else {
> +				$self->change_file_prop($fbat, $n, $v);
> +			}

as:

			my $existing = $existing_props->{$n};
			if (!defined($existing) || $existing ne $v) {
				$self->change_file_prop($fbat, $n, $v);
			}

No need for setting $needed = 0 from what I can tell.

Rest of the patch looks fine.

Thank you again for bringing this up and I look forward to a reroll
of this with my comments addressed (maybe wait a few days for others
to comment, holidays and all).
