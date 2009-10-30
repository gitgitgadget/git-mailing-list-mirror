From: Mark Rada <marada@uwaterloo.ca>
Subject: Re: [RFC/PATCH v6 2/2] gitweb: Smarter snapshot names
Date: Fri, 30 Oct 2009 16:07:06 -0400
Message-ID: <4AEB476A.7030306@mailservices.uwaterloo.ca>
References: <1256854062-25496-1-git-send-email-jnareb@gmail.com> <1256854062-25496-2-git-send-email-jnareb@gmail.com> <1256854062-25496-3-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 21:07:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3xku-0007aj-Bf
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 21:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbZJ3UHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 16:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932627AbZJ3UHO
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 16:07:14 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:50687 "EHLO
	mailchk-m04.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932405AbZJ3UHN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Oct 2009 16:07:13 -0400
Received: from karakura.local (CPE000e0c6492b0-CM001692fb78dc.cpe.net.cable.rogers.com [99.236.79.58])
	(authenticated bits=0)
	by mailchk-m04.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id n9UK76Ap003409
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 30 Oct 2009 16:07:10 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.4pre) Gecko/20090915 Thunderbird/3.0b4
In-Reply-To: <1256854062-25496-3-git-send-email-jnareb@gmail.com>
X-UUID: ab90d47d-a5d7-4ca7-aae4-3bc78041bdea
X-Miltered: at mailchk-m04 with ID 4AEB476B.001 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.2 at mailchk-m04
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m04.uwaterloo.ca [129.97.128.141]); Fri, 30 Oct 2009 16:07:13 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131745>

Hmm, I guess I was taking too long? Fair enough.

I've had more to do this academic term than I thought.
Thank you for getting this done.


--
Mark Rada (ferrous26)
marada@uwaterloo.ca


On 09-10-29 6:07 PM, Jakub Narebski wrote:
> From: Mark Rada <marada@uwaterloo.ca>
> 
> Teach gitweb how to produce nicer snapshot names by only using the
> short hash id.  If clients make requests using a tree-ish that is not
> a partial or full SHA-1 hash, then the short hash will also be appended
> to whatever they asked for.  If clients request snapshot of a tag
> (which means that $hash ('h') parameter has 'refs/tags/' prefix),
> use only tag name.
> 
> This also includes tests cases for t9502-gitweb-standalone-parse-output.
> 
> Signed-off-by: Mark Rada <marada@uwaterloo.ca>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> This is currently an RFC because commit message does not describe
> changes completely.  Among others it doesn't describe current rules.
> Also tests could be better described.
> 
> Changes since v5 (by Mark Rada):
> - put common parts of git_get_full_hash and git_get_short_hash 
>   into git_get_hash, do not do double verification
> - separate finding snapshot name and prefix in snapshot_name()
>   subroutine, more smarts for snapshot name
> - improved tests (use 'tar' snapshot format, testing new smarts,
>   testing prefix)
> 
>  gitweb/gitweb.perl                        |   76 +++++++++++++++----
>  t/t9502-gitweb-standalone-parse-output.sh |  112 +++++++++++++++++++++++++++++
>  2 files changed, 172 insertions(+), 16 deletions(-)
>  create mode 100755 t/t9502-gitweb-standalone-parse-output.sh
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 8d4a2ae..d8dfd95 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1983,16 +1983,27 @@ sub quote_command {
>  
>  # get HEAD ref of given project as hash
>  sub git_get_head_hash {
> -	my $project = shift;
> +	return git_get_full_hash(shift, 'HEAD');
> +}
> +
> +sub git_get_full_hash {
> +	return git_get_hash(@_);
> +}
> +
> +sub git_get_short_hash {
> +	return git_get_hash(@_, '--short=7');
> +}
> +
> +sub git_get_hash {
> +	my ($project, $hash, @options) = @_;
>  	my $o_git_dir = $git_dir;
>  	my $retval = undef;
>  	$git_dir = "$projectroot/$project";
> -	if (open my $fd, "-|", git_cmd(), "rev-parse", "--verify", "HEAD") {
> -		my $head = <$fd>;
> +	if (open my $fd, '-|', git_cmd(), 'rev-parse',
> +	    '--verify', '-q', @options, $hash) {
> +		$retval = <$fd>;
> +		chomp $retval if defined $retval;
>  		close $fd;
> -		if (defined $head && $head =~ /^([0-9a-fA-F]{40})$/) {
> -			$retval = $1;
> -		}
>  	}
>  	if (defined $o_git_dir) {
>  		$git_dir = $o_git_dir;
> @@ -5179,6 +5190,43 @@ sub git_tree {
>  	git_footer_html();
>  }
>  
> +sub snapshot_name {
> +	my ($project, $hash) = @_;
> +
> +	# path/to/project.git  -> project
> +	# path/to/project/.git -> project
> +	my $name = to_utf8($project);
> +	$name =~ s,([^/])/*\.git$,$1,;
> +	$name = basename($name);
> +	# sanitize name
> +	$name =~ s/[[:cntrl:]]/?/g;
> +
> +	my $ver = $hash;
> +	if ($hash =~ /^[0-9a-fA-F]+$/) {
> +		# shorten SHA-1 hash
> +		my $full_hash = git_get_full_hash($project, $hash);
> +		if ($full_hash =~ /^$hash/ && length($hash) > 7) {
> +			$ver = git_get_short_hash($project, $hash);
> +		}
> +	} elsif ($hash =~ m!^refs/tags/(.*)$!) {
> +		# tags don't need shortened SHA-1 hash
> +		$ver = $1;
> +	} else {
> +		# branches and other need shortened SHA-1 hash
> +		if ($hash =~ m!^refs/(?:heads|remotes)/(.*)$!) {
> +			$ver = $1;
> +		}
> +		$ver .= '-' . git_get_short_hash($project, $hash);
> +	}
> +	# in case of hierarchical branch names
> +	$ver =~ s!/!.!g;
> +
> +	# name = project-version_string
> +	$name = "$name-$ver";
> +
> +	return wantarray ? ($name, $name) : $name;
> +}
> +
>  sub git_snapshot {
>  	my $format = $input_params{'snapshot_format'};
>  	if (!@snapshot_fmts) {
> @@ -5203,24 +5251,20 @@ sub git_snapshot {
>  		die_error(400, 'Object is not a tree-ish');
>  	}
>  
> -	my $name = $project;
> -	$name =~ s,([^/])/*\.git$,$1,;
> -	$name = basename($name);
> -	my $filename = to_utf8($name);
> -	$name =~ s/\047/\047\\\047\047/g;
> -	my $cmd;
> -	$filename .= "-$hash$known_snapshot_formats{$format}{'suffix'}";
> -	$cmd = quote_command(
> +	my ($name, $prefix) = snapshot_name($project, $hash);
> +	my $filename = "$name$known_snapshot_formats{$format}{'suffix'}";
> +	my $cmd = quote_command(
>  		git_cmd(), 'archive',
>  		"--format=$known_snapshot_formats{$format}{'format'}",
> -		"--prefix=$name/", $hash);
> +		"--prefix=$prefix/", $hash);
>  	if (exists $known_snapshot_formats{$format}{'compressor'}) {
>  		$cmd .= ' | ' . quote_command(@{$known_snapshot_formats{$format}{'compressor'}});
>  	}
>  
> +	$filename =~ s/(["\\])/\\$1/g;
>  	print $cgi->header(
>  		-type => $known_snapshot_formats{$format}{'type'},
> -		-content_disposition => 'inline; filename="' . "$filename" . '"',
> +		-content_disposition => 'inline; filename="' . $filename . '"',
>  		-status => '200 OK');
>  
>  	open my $fd, "-|", $cmd
> diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
> new file mode 100755
> index 0000000..fbf4e26
> --- /dev/null
> +++ b/t/t9502-gitweb-standalone-parse-output.sh
> @@ -0,0 +1,112 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2009 Mark Rada
> +#
> +
> +test_description='gitweb as standalone script (parsing script output).
> +
> +This test runs gitweb (git web interface) as a CGI script from the
> +commandline, and checks that it produces the correct output, either
> +in the HTTP header or the actual script output.'
> +
> +
> +. ./gitweb-lib.sh
> +
> +# ----------------------------------------------------------------------
> +# snapshot file name
> +
> +cat >>gitweb_config.perl <<\EOF
> +
> +$known_snapshot_formats{'tar'} = {
> +	'display' => 'tar',
> +	'type' => 'application/x-tar',
> +	'suffix' => '.tar',
> +	'format' => 'tar',
> +};
> +
> +$feature{'snapshot'}{'default'} = ['tar'];
> +EOF
> +
> +test_expect_success setup '
> +	test_commit first foo &&
> +	git branch xx/test &&
> +	FULL_ID=$(git rev-parse --verify HEAD) &&
> +	SHORT_ID=$(git rev-parse --verify --short=7 HEAD)
> +'
> +test_debug '
> +	echo "FULL_ID  = $FULL_ID"
> +	echo "SHORT_ID = $SHORT_ID"
> +'
> +
> +test_expect_success 'snapshots: give full hash' '
> +	gitweb_run "p=.git;a=snapshot;h=$FULL_ID;sf=tar" &&
> +	grep ".git-$SHORT_ID.tar" gitweb.headers
> +'
> +test_debug 'cat gitweb.headers'
> +test_debug 'cat gitweb.log'
> +
> +test_expect_success 'snapshots: give short hash' '
> +	gitweb_run "p=.git;a=snapshot;h=$SHORT_ID;sf=tar" &&
> +	grep ".git-$SHORT_ID.tar" gitweb.headers
> +'
> +test_debug 'cat gitweb.headers'
> +
> +test_expect_success 'snapshots: give almost full hash' '
> +	ID=$(git rev-parse --short=30 HEAD) &&
> +	gitweb_run "p=.git;a=snapshot;h=$ID;sf=tar" &&
> +	grep ".git-$SHORT_ID.tar" gitweb.headers
> +'
> +test_debug 'cat gitweb.headers'
> +
> +test_expect_success 'snapshots: give HEAD' '
> +	gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tar" &&
> +	grep ".git-HEAD-$SHORT_ID.tar" gitweb.headers
> +'
> +test_debug 'cat gitweb.headers'
> +
> +test_expect_success 'snapshots: give short branch name' '
> +	gitweb_run "p=.git;a=snapshot;h=master;sf=tar" &&
> +	ID=$(git rev-parse --verify --short=7 master) &&
> +	grep ".git-master-$ID.tar" gitweb.headers
> +'
> +test_debug 'cat gitweb.headers'
> +
> +test_expect_success 'snapshots: give short tag name' '
> +	gitweb_run "p=.git;a=snapshot;h=first;sf=tar" &&
> +	ID=$(git rev-parse --verify --short=7 first) &&
> +	grep ".git-first-$ID.tar" gitweb.headers
> +'
> +test_debug 'cat gitweb.headers'
> +
> +test_expect_success 'snapshots: give full branch name' '
> +	gitweb_run "p=.git;a=snapshot;h=refs/heads/master;sf=tar" &&
> +	ID=$(git rev-parse --verify --short=7 master) &&
> +	grep ".git-master-$ID.tar" gitweb.headers
> +'
> +test_debug 'cat gitweb.headers'
> +
> +test_expect_success 'snapshots: give full tag name' '
> +	gitweb_run "p=.git;a=snapshot;h=refs/tags/first;sf=tar" &&
> +	grep ".git-first.tar" gitweb.headers
> +'
> +test_debug 'cat gitweb.headers'
> +
> +test_expect_success 'snapshots: give hierarchical branch name' '
> +	gitweb_run "p=.git;a=snapshot;h=xx/test;sf=tar" &&
> +	grep -v "filename=.*/" gitweb.headers
> +'
> +test_debug 'cat gitweb.headers'
> +
> +cat >expected <<EOF
> +.git-HEAD-$SHORT_ID/
> +.git-HEAD-$SHORT_ID/foo
> +EOF
> +test_expect_success 'snapshots: check prefix' '
> +	gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tar" &&
> +	grep ".git-HEAD-$SHORT_ID.tar" gitweb.headers &&
> +	"$TAR" tf gitweb.body >actual &&
> +	test_cmp expected actual
> +'
> +test_debug 'cat gitweb.headers'
> +
> +test_done
