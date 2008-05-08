From: Jeff King <peff@peff.net>
Subject: Re: detecting rename->commit->modify->commit
Date: Thu, 8 May 2008 14:17:24 -0400
Message-ID: <20080508181723.GA30449@sigill.intra.peff.net>
References: <4819CF50.2020509@tikalk.com> <4819D98E.1040004@tikalk.com> <32541b130805010827r22169651s37c707071f3448f2@mail.gmail.com> <20080501153457.GB11469@sigill.intra.peff.net> <D0968007-2A38-44DB-B26F-3D273F20D428@midwinter.com> <20080501231427.GD21731@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Ittay Dror <ittayd@tikalk.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu May 08 20:18:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuAh2-0003KY-Kr
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 20:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626AbYEHSRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 14:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbYEHSRX
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 14:17:23 -0400
Received: from peff.net ([208.65.91.99]:1905 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752481AbYEHSRW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 14:17:22 -0400
Received: (qmail 12310 invoked by uid 111); 8 May 2008 18:17:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 08 May 2008 14:17:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 May 2008 14:17:24 -0400
Content-Disposition: inline
In-Reply-To: <20080501231427.GD21731@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81547>

On Thu, May 01, 2008 at 07:14:27PM -0400, Jeff King wrote:

>   1. write a proof-of-concept that shows directory renaming after the
>     fact (e.g., take a conflicted merge, scan the diff for directory
>     renames, and then fix up the files). That way it is available, but
>     doesn't impact git at all.

Here's a toy script that finds directory renames. I'm sure there are a
ton of corner cases it doesn't handle (like directory renames inside of
directory renames). My test case was the very trivial:

  mkdir repo && cd repo && git init

  mkdir subdir
  for i in 1 2 3; do
    echo content $i >subdir/file$i
  done
  git add subdir
  git commit -m initial

  git mv subdir new
  git commit -m move

  git checkout -b other HEAD^
  echo content 4 >subdir/file4
  git add subdir
  git commit -m new

  git merge --no-commit master
  perl ../find-dir-rename.pl
  git commit

At which point you should see the merged commit with new/file4.

Script is below.

-- >8 --
#!/usr/bin/perl
#
# Find renamed directories, and move any files in the "old"
# directory into the "new".
#
# usage:
#   git merge --no-commit <whatever>
#   find-dir-rename
#   git commit

use strict;

foreach my $r (renamed_dirs()) {
  move_dir_contents($r->{from}, $r->{to});
}
exit 0;

sub renamed_dirs {
  my $base = `git merge-base HEAD MERGE_HEAD`;
  chomp $base;
  return grep {
    $_->{score} == 1
  } (renamed_dirs_between($base, 'HEAD'),
     renamed_dirs_between($base, 'MERGE_HEAD'));
}

sub renamed_dirs_between {
  my ($base, $commit) = @_;

  my %sources;
  foreach my $pair (renamed_files($base, $commit)) {
    my $d1 = dir_of($pair->[0]);
    my $d2 = dir_of($pair->[1]);
    next unless defined($d1) && defined($d2);

    $sources{$d1}->{total}++;
    $sources{$d1}->{dests}->{$d2}++;
  }

  return map {
    my $from = $_;
    map {
      {
        from => $from,
        to => $_,
        score => $sources{$from}->{dests}->{$_} / $sources{$from}->{total},
      }
    } keys(%{$sources{$from}->{dests}});
  } removed_directories($base, $commit);
}

sub dir_of {
  local $_ = shift;
  s{/[^/]+$}{} or return undef;
  return $_;
}

sub renamed_files {
  my ($from, $to) = @_;
  open(my $fh, '-|', qw(git diff-tree -r -M), $from, $to)
    or die "unable to open diff-tree: $!";
  return map {
    chomp;
    m/ R\d+\t([^\t]+)\t(.*)/ ? [$1 => $2] : ()
  } <$fh>;
}

sub removed_directories {
  my ($base, $commit) = @_;
  my %new_dirs = map { $_ => 1 } directories($commit);
  return grep { !exists $new_dirs{$_} } directories($base);
}

sub directories {
  my $commit = shift;
  return uniq(
    map {
      s{/[^/]+$}{} ? $_ : ()
    } files($commit)
  );
}

sub files {
  my $commit = shift;
  open(my $fh, '-|', qw(git ls-tree -r), $commit)
    or die "unable to open ls-tree: $!";
  return map {
    chomp;
    s/^[^\t]*\t//;
    $_
  } <$fh>;
}

sub uniq {
  my %seen;
  return grep { !$seen{$_}++ } @_;
}

sub move_dir_contents {
  my ($from, $to) = @_;

  my @files = glob("$from/*");
  return unless @files;

  system(qw(git mv), @files, "$to/")
    and die "unable to move $from/* to $to";
  rmdir($from); # ignore error since there may be untracked files
}
