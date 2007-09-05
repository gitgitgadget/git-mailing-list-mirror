From: Jeff King <peff@peff.net>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 5 Sep 2007 19:56:53 -0400
Message-ID: <20070905235653.GB25001@coredump.intra.peff.net>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org> <20070905074206.GA31750@artemis.corp> <46DE6DBC.30704@midwinter.com> <7vbqchjx9f.fsf@gitster.siamese.dyndns.org> <46a038f90709050227u777ed7b9w23dc3bab13c7b09b@mail.gmail.com> <vpqzm01v4li.fsf@bauges.imag.fr> <D32A7C27-EAF5-4156-BE0E-99FE3D948AE8@wgaf.org> <vpq1wddkohr.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Sep 06 01:57:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT4k3-0003tq-TE
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 01:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbXIEX47 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 19:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbXIEX47
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 19:56:59 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1328 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932163AbXIEX46 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 19:56:58 -0400
Received: (qmail 11967 invoked by uid 111); 5 Sep 2007 23:56:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 05 Sep 2007 19:56:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Sep 2007 19:56:53 -0400
Content-Disposition: inline
In-Reply-To: <vpq1wddkohr.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57779>

On Wed, Sep 05, 2007 at 07:31:44PM +0200, Matthieu Moy wrote:

> I have ~/teaching/some-course/.git (well, almost) and ~/etc/.git which
> are two unrelated projects, and to "git gc" both of them, I need
> either a script, or two manual invocations.
>
> (yes, I'm really talking about something trivial)

I tend to have a lot of small projects, so I have on the order of 80 git
repositories on each machine I use, most of which have a 'mothership'
origin on a central, backed-up machine.

When I sit down to work, I want to see which repositories
have changes that need to be pulled. And when I get up to leave, I want
to see which repositories have changes that need to be pushed. Not to
mention files that need committed, loose objects that need packed, etc.

So I wrote the 'git-stale' script, included below. It's not especially
user-friendly, but you might find it useful, as it solves the exact
problem you are talking about (and much more).

It reads 'repository specifications' from ~/.gitstale, one per line,
which are either of the form:

  /path/to/repo

which specifies a repo to check, or:

  r:/path/to/many/repos

which specifies a hierarchy in which to recursively find repos.

My .gitstale looks something like this:

  /home/peff/compile/git
  /home/peff/compile/tig
  r:/home/peff/work

and I get output something like this (edited for brevity):

Checking (1/77) /home/peff/compile/git...
Checking (2/77) /home/peff/compile/tig...
[...]
Checking (77/77) /home/peff/work/foo...
MERGE:next /home/peff/compile/git
COMMIT: /home/peff/work/foo
PACK: /home/peff/work/foo
PUSH:master /home/peff/work/bar

which translates to:
  - the git repo has commits in 'origin/next' that are not in 'next'
    (and you might want to merge them in)
  - there are uncommitted files in 'foo'
  - 'foo' needs packing
  - in the 'bar' repo there are commits in master that are not in origin
    (and you might want to push)

Hopefully it will be useful to you, though I think it is probably too
specific to my workflow to be part of git.

-Peff

-- >8 --
#!/usr/bin/perl

use strict;
use Getopt::Long;

my $CONFIG_FILE = "$ENV{HOME}/.gitstale";

my $nofetch = $ENV{GITSTALE_NOFETCH};
Getopt::Long::Configure(qw(bundling));
GetOptions('nofetch|n!' => \$nofetch) or exit 100;

my @projects = process_spec(@ARGV ? @ARGV : cat($CONFIG_FILE));

my $n = 1;
my $total = @projects;
my %errors;
foreach my $p (@projects) {
  print "Checking ($n/$total) $p...\n";
  $errors{$p} = [check_git($p)];
  $n++;
}

my $errcount;
foreach my $p (@projects) {
  foreach my $e (@{$errors{$p}}) {
    print "$e: $p\n";
  }
}

exit $errcount ? 1 : 0;

sub cat {
  my $fn = shift;
  open(my $fh, '<', $fn)
    or die "unable to open $fn: $!\n";
  return map { chomp; length($_) ? $_ : () } <$fh>;
}

sub process_spec {
  my @dirs;
  my @roots;
  my @exclude;

  foreach (@_) {
    if(/^r:(.*)/) { push @roots, $1 }
    elsif(/^d:(.*)/) { push @dirs, $1 }
    elsif(/^-(.*)/) { push @exclude, qr#(^|/)$1($|/)# }
    else { push @dirs, $_ }
  }

  use File::Find;
  find({
      no_chdir => 1,
      preprocess => sub { sort @_ },
      wanted => sub {
        return unless -d $_ && $_ =~ m#/.git$#;
        foreach my $e (@exclude) { return if $_ =~ $e }
        my $d = $_;
        $d =~ s#/\.git$##;
        push @dirs, $d;
      }
    }, @roots) if @roots;
  return @dirs;
}

sub count_zero {
  open(my $fh, '-|', @_) or die "unable to fork: $!\n";
  my $line = <$fh>;
  return length($line) == 0;
}

sub check_git {
  my $d = shift;

  chdir($d) or return 'CHDIR';

  my @r;
  count_zero(qw(
        git-ls-files -m -o -d --exclude-per-directory=.gitignore
        --directory --no-empty-directory
  )) or push @r, 'COMMIT';

  if(has_origin()) {
    push @r, 'FETCH' if !$nofetch && system('git-fetch');

    foreach my $p (branch_pairs()) {
      count_zero('git-rev-list', "$p->[0]..$p->[1]")
        or push @r, "MERGE:$p->[0]";
      count_zero('git-rev-list', "$p->[1]..$p->[0]")
        or push @r, "PUSH:$p->[0]";
    }
  }
  else {
    push @r, 'ORIGIN';
  }

  push @r, 'PACK' if unpacked_objects() > 1000;

  return @r;
}

sub unpacked_objects {
  my $objects = `git-count-objects`;
  $objects =~ /^(\d+)/;
  return $1;
}

sub branch_pairs {
  my %config;
  foreach my $line (`git-repo-config --get-regexp 'branch..*..*'`) {
    $line =~ m#^branch\.([^.]+)\.([^ ]+) (?:refs/heads/)?(.*)#
      or die "confusing git-repo-config output: $line\n";
    $config{$1}{$2} = $3;
  }

  return [qw(master origin)] if -e '.git/refs/heads/origin';

  return
    (-e '.git/refs/heads/origin' ? [qw(master origin)] : ()),
    map {
      $config{$_}{remote} && $config{$_}{merge} ?
        [$_, $config{$_}{remote} . '/' . $config{$_}{merge}] :
        ()
    } sort keys(%config);
}

sub has_origin {
  return
    -e '.git/branches/origin' ||
    -e '.git/remotes/origin' ||
    !count_zero(qw(git-repo-config --get remote.origin.url));
}
__END__
