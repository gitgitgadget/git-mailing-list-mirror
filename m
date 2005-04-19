From: David Greaves <david@dgreaves.com>
Subject: Re: [PATCH] Add help details to git help command. (This time with
 Perl)
Date: Tue, 19 Apr 2005 20:04:16 +0100
Message-ID: <42655630.80207@dgreaves.com>
References: <200504172242.26326.elenstev@mesatop.com> <20050418102412.GJ1461@pasky.ji.cz> <42654153.8080307@mesatop.com> <20050419175051.GK12757@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050206040606040908050407"
Cc: Steven Cole <elenstev@mesatop.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 21:02:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNxyi-0002BX-GT
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 21:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVDSTFs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 15:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVDSTFs
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 15:05:48 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:15061 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261451AbVDSTEW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 15:04:22 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 96B2FE6D8A; Tue, 19 Apr 2005 20:02:40 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 26131-08; Tue, 19 Apr 2005 20:02:40 +0100 (BST)
Received: from oak.dgreaves.com (modem-3049.baboon.dialup.pol.co.uk [81.78.27.233])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 68EADE6D3C; Tue, 19 Apr 2005 20:02:38 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DNy1A-0007GG-Qz; Tue, 19 Apr 2005 20:04:16 +0100
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050419175051.GK12757@pasky.ji.cz>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------050206040606040908050407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Petr Baudis wrote:
> Dear diary, on Tue, Apr 19, 2005 at 07:35:15PM CEST, I got a letter
> where Steven Cole <elenstev@mesatop.com> told me that...
> 

I've been working on git.pl and getting help working nicely

things to try:
git.pl help
git.pl add
git.pl add --help
git.pl add --man
git.pl help add

The main objectives:
* get a reasonable perl code base in git.pl
* provide some way to document WTF is going on :)
* keep the docs near the developer
* allow variations in verbosity
* modularise
* don't use modules outside the base perl set
* allow a gentle migration (so start by calling the .sh's)

I don't like the pod2usage calling convention but I use them for now.

I don't love the 'require gitadd.pl' but it's a gradual start...

Cogito.pm seems to be a good place for the library stuff.

git.pl
passes everything to scripts except gitadd.pl
works when called from somewhere other than the git dir
I don't feel 100% about the fixup ports

gitadd.pl


I thought I'd ask for comments before I spent too much time on this...

David

-- 

--------------050206040606040908050407
Content-Type: application/x-perl;
 name="Cogito.pm"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Cogito.pm"

package Cogito;
# Copyright (c) David Greaves, 2005

use Exporter qw(import);
use Pod::Usage;

our @EXPORT=qw(error help ignore);  # subs exported by default


# Standard mechanism to raise an error.
sub error {
	print STDERR "git: ".join("\n",@_)."\n";
}

# Utility that extracts the perlpod from the caller's file
sub help
  {
    my (undef,$srcfilename) = caller;
    pod2usage(@_, -input=>$srcfilename);
  }

sub ignore
  {
    return 0;
  }
1;

--------------050206040606040908050407
Content-Type: application/x-perl;
 name="gitadd.pl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gitadd.pl"

#!/usr/bin/perl -w
#
# Add new file to a GIT repository.
# Copyright (c) Petr Baudis, 2005
# Copyright (c) David Greaves, 2005
#

# FIXME: Those files are omitted from show-diff output!

use IO::File;   # leads to less perlish syntax and is standard in perl dists
use Pod::Usage;
use Cogito;

my $processed_stdin;
my $queue;
my $count = 0;
my $recurse;

sub add
# takes a list of filenames, - is opened and treated as a standard list
  {
    help(-verbose=>0, -exitval=>1) unless $_[0]; # exit if no args
    help(-verbose=>1, -exitval=>0) if $_[0] eq "--help";
    help(-verbose=>2, -exitval=>0) if $_[0] eq "--man";

    if ($_[0] eq '-r') { # Recurse?
      $recurse = 1;
      shift;
    }

    $queue = IO::File->new(">> $repo/add-queue") || die "Couldn't open add-queue $!";
    _add_files(@_);
    $queue->close;
    error("Added $count files for commital") if $verbose;
  }

sub _add_files
  {
    foreach $filename (@_) {
      if ($filename eq "-" && !$processed_stdin) {
	$processed_stdin=1; # avoid trying to process it twice if someone does "git add foo - bar -"
	while (<STDIN>) {
	  chomp;
	  _add_files($_);
	}
      } elsif (ignore($filename)) {
	next;
      } elsif (-d $filename && $recurse) {
	# FIX recurse into directory...
	# _add_files(glob "$filename/*"); # git ignores .files FIX: Check this?
      } else {
	error("adding non-existent file $filename") unless -f $filename;
	$queue->print($filename);
	$count++;
      }
    }
  }

1;
__END__

=head1 git add

add - Add new file or files to a GIT repository.

=head1 SYNOPSIS

add - Add new file or files to a GIT repository.

Usage: git add [-r] (-|FILE)...";

=head1 OPTIONS

	[-r]  recurse on any directories listed in FILE...
              not implemented yet but I want to see the help :)

=head1 DESCRIPTION

Takes a list of file names at the command line, and schedules them for
addition to the GIT repository at the next commit.


=cut

--------------050206040606040908050407
Content-Type: application/x-perl;
 name="git.pl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git.pl"

#!/usr/bin/perl -w
# The GIT scripted toolkit - in perl
# Copyright (c) Petr Baudis, 2005
# Copyright (c) David Greaves, 2005
#
# This is the central command for the GIT toolkit, providing a humanly
# usable SCM-like interface to GIT.
#
# This command mostly only multiplexes to the individual script based
# on the first argument.

# generalised usage:
# git [options] command [command options] [command args]

use Pod::Usage;        # Lets see if we can have a consistent form of
                       # documenting what we do that can also be
                       # extracted automatically
use English;           # Reduce obfuscation (nb performance hit on
                       # regexps may be an issue one day)

use File::Basename;

use lib ("".dirname($0));  # For now add the git executable dir to lib

use Cogito;


# This quietly tries to handle any changes to the repository format
perform_fixups();

# Set up standard initialisation variables
our $repo = ".git";
our $verbose = 1 ; # set using prefs??

execute_commands();

exit;

sub execute_commands
  {
    # FIX: Process any intermediate args (eg --verbose?)
    my $cmd = shift @ARGV;

    help(-msg=>"git: missing command", -exitval=>1, -verbose=>1)
      if !$cmd;

  COMMAND: for ($cmd) {
      /^add$/ && do {
	require "gitadd.pl";
	add(@ARGV);
	last COMMAND;
      };

      /^(addremote|apply|cancel|commit|diff|export|fork|
         init|log|ls|lsobj|lsremote|merge|pull|status|
         tag|track|version)$/x && do {
	system("git$1.sh ".join(' ',@ARGV));
	last COMMAND;
      };

      /^help$/ && do {
	$cmd = shift @ARGV;
	if ($cmd) { # is this git help <command>
	  error("help $cmd - not supported until all commands take --help");
	  exit(1);
	  unshift @ARGV,"--help";
	  unshift @ARGV,$cmd;
	  execute_commands(@ARGV);
	} else {
	  pod2usage(-verbose=>1, -exitval=>0);
	}
	last COMMAND;
      };

      pod2usage(-msg=>"unknown command: $cmd", -exitval=>1, -verbose=>2);
    }
  }


sub perform_fixups
  {
    ### XXX: Compatibility hack.
    # Introduced at 2005-04-12, to be removed few days later.
    if (-d '.dircache'&& ! -e '.git') {
      system("mv .dircache .git");
    }

    # Introduced at 2005-04-13:
    if (-d '.git' && ! -d '.git/heads') {
      system("mkdir .git/heads");
      for $h (glob '.git/HEAD.*') {
	if ( $h ne "local") {
	  my (undef, undef, $i) = split("\.",$h);
	  system ("mv $h .git/heads/$i");
	}
      }
    }
    # Introduced at 2005-04-16:
    if ( -d '.git' &&  ! -e '.git/heads/master') {
      system("mv .git/HEAD .git/heads/master");
      system("ln -s heads/master .git/HEAD");
    }
  }

__END__

=head1 git

The GIT scripted toolkit  $(gitversion.sh)

=head1 SYNOPSIS

Usage: git COMMAND [ARG]...

=head1 OPTIONS

Available commands:

	add		FILE...
	addremote	RNAME RSYNC_URL
	apply				< patch on stdin
	cancel
	ci, commit	[FILE]...	< log message on stdin
	diff		[-p] [-r FROM_ID[:TO_ID]] [FILE]...
	export		DESTDIR [TREE_ID]
	fork		BNAME BRANCH_DIR [COMMIT_ID]
	help
	init		RSYNC_URL
	log
	ls		[TREE_ID]
	lsobj		[OBJTYPE]
	lsremote
	merge		[-c] [-b BASE_ID] FROM_ID
	pull		[RNAME]
	rm		FILE...
	seek		[COMMIT_ID]
	status
	tag		TNAME [COMMIT_ID]
	track		[RNAME]
	version


Note that these expressions can be used interchangably as "ID"s:
	empty string (current HEAD)
	remote name (as registered with git addremote)
	tag name (as registered with git tag)
	shortcut hash (shorted unambiguous hash lead)
	commit object hash (as returned by commit-id)
	tree object hash (accepted only by some commands)

=head1 DESCRIPTION

Takes a list of file names at the command line, and schedules them for
addition to the GIT repository at the next commit.


=cut

--------------050206040606040908050407--
