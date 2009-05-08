From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v2] git-svn: add --authors-prog option
Date: Fri, 08 May 2009 09:43:30 +0200
Message-ID: <4A03E2A2.4050303@drmicha.warpmail.net>
References: <1241745069-2663-1-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 08 09:43:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2KkD-0002i5-Ab
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 09:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757219AbZEHHnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 03:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754911AbZEHHnl
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 03:43:41 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:41204 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754032AbZEHHnj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 May 2009 03:43:39 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id EA17334156D;
	Fri,  8 May 2009 03:43:39 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 08 May 2009 03:43:39 -0400
X-Sasl-enc: hiz5rPUK7PxEuv44sQUxEgEELGbyOxrEjeEPBpWY2JUm 1241768619
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6712F12D8F;
	Fri,  8 May 2009 03:43:38 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090506 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <1241745069-2663-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118575>

Mark Lodato venit, vidit, dixit 08.05.2009 03:11:
> Add a new option, --authors-prog, to git-svn that allows a more flexible
> alternative (or supplement) to --authors-file.  This allows more
> advanced username operations than the authors file will allow.  For
> example, one may look up Subversion users via LDAP, or may generate the
> name and email address from the Subversion username.
> 
> Notes:
> 
> * If both --authors-name and --authors-prog are given, the former is
>   tried first, falling back to the later.
> 
> * The program is called once per unique SVN username and the result is
>   cached.
> 
> * The command-line argument must be the path to a program, not a generic
>   shell command line.  The absolute path to this program is taken at
>   startup since the git-svn script changes directory during operation.
> 
> * The option is not enabled for `git log'.
> 
> Signed-off-by: Mark Lodato <lodatom@gmail.com>
> ---
> 
> This is my second attempt at a patch.  I received no feedback from the
> first attempt, so I suppose I made a mistake.  I cleaned up my commit
> message, added a Signed-off-by, CC'd the appropriate maintainers, and
> put the additional message (this paragraph) in the correct location.
> The contents of the patch have not changed.  Sorry for the resend; I'm
> still learning.

Thanks for willing to learn and rewriting according to the list's
requirements!

> 
>  Documentation/git-svn.txt       |    8 ++++
>  git-svn.perl                    |   30 +++++++++++++++--
>  t/t9138-git-svn-authors-prog.sh |   69 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 104 insertions(+), 3 deletions(-)
>  create mode 100755 t/t9138-git-svn-authors-prog.sh
> 
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index 1c40894..78582ad 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -398,6 +398,14 @@ after the authors-file is modified should continue operation.
>  
>  config key: svn.authorsfile
>  
> +--authors-prog=<filename>::
> +
> +If this option is specified, for each SVN committer name that does not
> +exist in the authors file, the given file is executed with the commiter

s/commiter/committer/

Also, "If..., the given... for each..." may be easier to read.

> +name as the first argument.  The program is expected to return a single
> +line of the form "Name <email>", which will be logically inserted into the

"be treated as if included in the..."

> +authors file.
> +

Maybe we want a config key also, just like for the authors file.

The feature itself looks useful for large user databases. For smaller
ones one could just as well update the authors file before each fetch by
dumping the whole db in there (or even conditionally on git svn fetch
erroring out due to encountering an unknown name).

>  -q::
>  --quiet::
>  	Make 'git-svn' less verbose. Specify a second time to make it
> diff --git a/git-svn.perl b/git-svn.perl
> index ef1d30d..f9c9567 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -5,7 +5,7 @@ use warnings;
>  use strict;
>  use vars qw/	$AUTHOR $VERSION
>  		$sha1 $sha1_short $_revision $_repository
> -		$_q $_authors %users/;
> +		$_q $_authors $_authors_prog %users/;
>  $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
>  $VERSION = '@@GIT_VERSION@@';
>  
> @@ -39,6 +39,7 @@ use Digest::MD5;
>  use IO::File qw//;
>  use File::Basename qw/dirname basename/;
>  use File::Path qw/mkpath/;
> +use File::Spec;
>  use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev/;
>  use IPC::Open3;
>  use Git;
> @@ -76,6 +77,7 @@ my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
>                      'ignore-paths=s' => \$SVN::Git::Fetcher::_ignore_regex );
>  my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
>  		'authors-file|A=s' => \$_authors,
> +		'authors-prog=s' => \$_authors_prog,
>  		'repack:i' => \$Git::SVN::_repack,
>  		'noMetadata' => \$Git::SVN::_no_metadata,
>  		'useSvmProps' => \$Git::SVN::_use_svm_props,
> @@ -263,6 +265,7 @@ usage(0) if $_help;
>  version() if $_version;
>  usage(1) unless defined $cmd;
>  load_authors() if $_authors;
> +$_authors_prog = "'" . File::Spec->rel2abs($_authors_prog) . "'";
>  
>  unless ($cmd =~ /^(?:clone|init|multi-init|commit-diff)$/) {
>  	Git::SVN::Migration::migration_check();
> @@ -2663,12 +2666,33 @@ sub other_gs {
>  	$gs
>  }
>  
> +sub call_authors_prog {
> +	my ($orig_author) = @_;
> +	my $author = `$::_authors_prog $orig_author`;
> +	if ($? != 0) {
> +		die "$::_authors_prog failed with exit code $?\n"
> +	}
> +	if ($author =~ /^\s*(.+?)\s*<(.*)>\s*$/) {
> +		my ($name, $email) = ($1, $2);
> +		$email = undef if length $2 == 0;
> +		return [$name, $email];
> +	} else {
> +		die "Author: $orig_author: $::_authors_prog returned "
> +			. "invalid author format: $author\n";
> +	}
> +}
> +
>  sub check_author {
>  	my ($author) = @_;
>  	if (!defined $author || length $author == 0) {
>  		$author = '(no author)';
> -	} elsif (defined $::_authors && ! defined $::users{$author}) {
> -		die "Author: $author not defined in $::_authors file\n";
> +	}
> +	if (!defined $::users{$author}) {
> +		if (defined $::_authors_prog) {
> +			$::users{$author} = call_authors_prog($author);
> +		} elsif (defined $::_authors) {
> +			die "Author: $author not defined in $::_authors file\n";
> +		}
>  	}
>  	$author;
>  }
> diff --git a/t/t9138-git-svn-authors-prog.sh b/t/t9138-git-svn-authors-prog.sh
> new file mode 100755
> index 0000000..a4b00f2
> --- /dev/null
> +++ b/t/t9138-git-svn-authors-prog.sh
> @@ -0,0 +1,69 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2009 Eric Wong, Mark Lodato
> +#
> +
> +test_description='git svn authors prog tests'
> +
> +. ./lib-git-svn.sh
> +
> +cat > svn-authors-prog <<'EOF'
> +#!/usr/bin/perl
> +$_ = shift;
> +if (s/-sub$//)  {
> +	print "$_ <$_\@sub.example.com>\n";
> +}
> +else {
> +	print "$_ <$_\@example.com>\n";
> +}
> +EOF
> +chmod +x svn-authors-prog
> +
> +cat > svn-authors <<'EOF'
> +ff = FFFFFFF FFFFFFF <fFf@other.example.com>
> +EOF
> +
> +test_expect_success 'setup svnrepo' '
> +	for i in aa bb cc-sub dd-sub ee-foo ff
> +	do
> +		svn mkdir -m $i --username $i "$svnrepo"/$i
> +	done
> +	'
> +
> +test_expect_success 'import authors with prog and file' '
> +	git svn clone --authors-prog=./svn-authors-prog \
> +	    --authors-file=svn-authors "$svnrepo" x
> +	'
> +
> +test_expect_success 'imported 6 revisions successfully' '
> +	(
> +		cd x
> +		test "`git rev-list refs/remotes/git-svn | wc -l`" -eq 6
> +	)
> +	'
> +
> +test_expect_success 'authors-prog ran correctly' '
> +	(
> +		cd x
> +		git rev-list -1 --pretty=raw refs/remotes/git-svn~1 | \
> +		  grep "^author ee-foo <ee-foo@example\.com> " &&
> +		git rev-list -1 --pretty=raw refs/remotes/git-svn~2 | \
> +		  grep "^author dd <dd@sub\.example\.com> " &&
> +		git rev-list -1 --pretty=raw refs/remotes/git-svn~3 | \
> +		  grep "^author cc <cc@sub\.example\.com> " &&
> +		git rev-list -1 --pretty=raw refs/remotes/git-svn~4 | \
> +		  grep "^author bb <bb@example\.com> " &&
> +		git rev-list -1 --pretty=raw refs/remotes/git-svn~5 | \
> +		  grep "^author aa <aa@example\.com> "
> +	)
> +	'
> +
> +test_expect_success 'authors-file overrode authors-prog' '
> +	(
> +		cd x
> +		git rev-list -1 --pretty=raw refs/remotes/git-svn | \
> +		  grep "^author FFFFFFF FFFFFFF <fFf@other\.example\.com> "
> +	)
> +	'
> +
> +test_done
