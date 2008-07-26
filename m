From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: teach dcommit about svn auto-props
Date: Fri, 25 Jul 2008 22:45:47 -0700
Message-ID: <20080726054547.GA20494@untitled>
References: <20080725060037.GB14756@untitled> <4889F215.9020804@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 07:47:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMccN-0004fr-So
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 07:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbYGZFpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 01:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbYGZFpu
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 01:45:50 -0400
Received: from hand.yhbt.net ([66.150.188.102]:36079 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038AbYGZFpt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 01:45:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id CFCFA2DC095;
	Fri, 25 Jul 2008 22:45:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4889F215.9020804@kitware.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90182>

Brad King <brad.king@kitware.com> wrote:
> 
> Subversion repositories often require files to have properties such as
> svn:mime-type and svn:eol-style set when they are added.  Users
> typically set these properties automatically using the SVN auto-props
> feature with 'svn add'.  This commit teaches dcommit to look at the user
> SVN configuration and apply matching auto-props entries for files added
> by a diff as it is applied to the SVN remote.
> 
> Signed-off-by: Brad King <brad.king@kitware.com>

Thanks Brad,

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
> Eric Wong wrote:
> > I like this patch.
> 
> Thanks.
> 
> > Can we get an automated test of this functionality?
> 
> This patch adds a test.  I also fixed the property name/value parsing
> to remove leading and trailing whitespace.
> 
> > We can (and probably should) set $HOME for the test and ignore the
> > existing ~/.subversion/config of the user.
> 
> I used the --config-dir option.
> 
> > Also, some minor nitpicks on whitespace/formatting inline below.
> 
> Addressed.  I missed the wrong indentation before because my second patch
> removed it.
> 
> > I haven't had the chance to look at this.   Can anybody else shed more
> > light on that bug?  It's really strange that the tests won't run because
> > of it.  Are you unable to run some git-svn tests or all of them?
> 
> Just that one fails.  All others (including the one in the patch below) pass.

Exactly which test fails for you?  Perhaps it's some setting in your
~/.subversion/config that's causing it to fail.  Maybe we should set
$HOME and use a clean ~/.subversion/config for git-svn tests regardless
if that turns out to be the case...

> Thanks for reviewing,
> -Brad
> 
>  git-svn.perl                          |   52 ++++++++++++++++++++
>  t/t9124-git-svn-dcommit-auto-props.sh |   84 +++++++++++++++++++++++++++++++++
>  2 files changed, 136 insertions(+), 0 deletions(-)
>  create mode 100755 t/t9124-git-svn-dcommit-auto-props.sh
> 

> diff --git a/git-svn.perl b/git-svn.perl
> index 2e0e552..0a8e907 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -3340,6 +3340,7 @@ sub new {
>  	$self->{rm} = { };
>  	$self->{path_prefix} = length $self->{svn_path} ?
>  	                       "$self->{svn_path}/" : '';
> +	$self->{config} = $opts->{config};
>  	return $self;
>  }
>  
> @@ -3528,6 +3529,56 @@ sub ensure_path {
>  	return $bat->{$c};
>  }
>  
> +# Subroutine to convert a globbing pattern to a regular expression.
> +# From perl cookbook.
> +sub glob2pat {
> +	my $globstr = shift;
> +	my %patmap = ('*' => '.*', '?' => '.', '[' => '[', ']' => ']');
> +	$globstr =~ s{(.)} { $patmap{$1} || "\Q$1" }ge;
> +	return '^' . $globstr . '$';
> +}
> +
> +sub check_autoprop {
> +	my ($self, $pattern, $properties, $file, $fbat) = @_;
> +	# Convert the globbing pattern to a regular expression.
> +	my $regex = glob2pat($pattern);
> +	# Check if the pattern matches the file name.
> +	if($file =~ m/($regex)/) {
> +		# Parse the list of properties to set.
> +		my @props = split(/;/, $properties);
> +		foreach my $prop (@props) {
> +			# Parse 'name=value' syntax and set the property.
> +			if ($prop =~ /([^=]+)=(.*)/) {
> +				my ($n,$v) = ($1,$2);
> +				$n =~ s/^\s+//; $n =~ s/\s+$//;
> +				$v =~ s/^\s+//; $v =~ s/\s+$//;
> +				$self->change_file_prop($fbat, $n, $v);
> +			}
> +		}
> +	}
> +}
> +
> +sub apply_autoprops {
> +	my ($self, $file, $fbat) = @_;
> +	my $conf_t = ${$self->{config}}{'config'};
> +	no warnings 'once';
> +	# Check [miscellany]/enable-auto-props in svn configuration.
> +	if (SVN::_Core::svn_config_get_bool(
> +		$conf_t,
> +		$SVN::_Core::SVN_CONFIG_SECTION_MISCELLANY,
> +		$SVN::_Core::SVN_CONFIG_OPTION_ENABLE_AUTO_PROPS,
> +		0)) {
> +		# Auto-props are enabled.  Enumerate them to look for matches.
> +		my $callback = sub {
> +			$self->check_autoprop($_[0], $_[1], $file, $fbat);
> +		};
> +		SVN::_Core::svn_config_enumerate(
> +			$conf_t,
> +			$SVN::_Core::SVN_CONFIG_SECTION_AUTO_PROPS,
> +			$callback);
> +	}
> +}
> +
>  sub A {
>  	my ($self, $m) = @_;
>  	my ($dir, $file) = split_path($m->{file_b});
> @@ -3535,6 +3586,7 @@ sub A {
>  	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
>  					undef, -1);
>  	print "\tA\t$m->{file_b}\n" unless $::_q;
> +	$self->apply_autoprops($file, $fbat);
>  	$self->chg_file($fbat, $m);
>  	$self->close_file($fbat,undef,$self->{pool});
>  }
> diff --git a/t/t9124-git-svn-dcommit-auto-props.sh b/t/t9124-git-svn-dcommit-auto-props.sh
> new file mode 100755
> index 0000000..beefbcc
> --- /dev/null
> +++ b/t/t9124-git-svn-dcommit-auto-props.sh
> @@ -0,0 +1,84 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2008 Brad King
> +
> +test_description='git-svn dcommit honors auto-props'
> +
> +. ./lib-git-svn.sh
> +
> +generate_auto_props() {
> +cat << EOF
> +[miscellany]
> +enable-auto-props=$1
> +[auto-props]
> +*.sh  = svn:mime-type=application/x-shellscript; svn:eol-style=LF
> +*.txt = svn:mime-type=text/plain; svn:eol-style = native
> +EOF
> +}
> +
> +test_expect_success 'initialize git-svn' '
> +	mkdir import &&
> +	cd import &&
> +	echo foo > foo &&
> +	svn import -m "import for git-svn" . "$svnrepo" >/dev/null &&
> +	cd .. &&
> +	rm -rf import &&
> +	git-svn init "$svnrepo"
> +	git-svn fetch'
> +
> +test_expect_success 'enable auto-props config' '
> +	cd "$gittestrepo" &&
> +	mkdir user &&
> +	generate_auto_props yes > user/config
> +	'
> +
> +test_expect_success 'add files matching auto-props' '
> +	cd "$gittestrepo" &&
> +	echo "#!/bin/sh" > exec1.sh &&
> +	chmod +x exec1.sh &&
> +	echo "hello" > hello.txt &&
> +	echo bar > bar &&
> +	git add exec1.sh hello.txt bar &&
> +	git commit -m "files for enabled auto-props" &&
> +	git svn dcommit --config-dir=user
> +	'
> +
> +test_expect_success 'disable auto-props config' '
> +	cd "$gittestrepo" &&
> +	generate_auto_props no > user/config
> +	'
> +
> +test_expect_success 'add files matching disabled auto-props' '
> +	cd "$gittestrepo" &&
> +	echo "#!/bin/sh" > exec2.sh &&
> +	chmod +x exec2.sh &&
> +	echo "world" > world.txt &&
> +	echo zot > zot &&
> +	git add exec2.sh world.txt zot &&
> +	git commit -m "files for disabled auto-props" &&
> +	git svn dcommit --config-dir=user
> +	'
> +
> +test_expect_success 'check resulting svn repository' '
> +	mkdir work &&
> +	cd work &&
> +	svn co "$svnrepo" &&
> +	cd svnrepo &&
> +
> +	# Check properties from first commit.
> +	test "x$(svn propget svn:executable exec1.sh)" = "x*" &&
> +	test "x$(svn propget svn:mime-type exec1.sh)" = \
> +	     "xapplication/x-shellscript" &&
> +	test "x$(svn propget svn:mime-type hello.txt)" = "xtext/plain" &&
> +	test "x$(svn propget svn:eol-style hello.txt)" = "xnative" &&
> +	test "x$(svn propget svn:mime-type bar)" = "x" &&
> +
> +	# Check properties from second commit.
> +	test "x$(svn propget svn:executable exec2.sh)" = "x*" &&
> +	test "x$(svn propget svn:mime-type exec2.sh)" = "x" &&
> +	test "x$(svn propget svn:mime-type world.txt)" = "x" &&
> +	test "x$(svn propget svn:eol-style world.txt)" = "x" &&
> +	test "x$(svn propget svn:mime-type zot)" = "x"
> +	'
> +
> +test_done

-- 
Eric Wong
