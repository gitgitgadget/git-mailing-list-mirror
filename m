From: Jeff King <peff@peff.net>
Subject: rewriting pathnames in history
Date: Tue, 21 Feb 2006 02:53:42 -0500
Message-ID: <20060221075342.GA13814@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Feb 21 08:53:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBSLF-0003Hn-1k
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 08:53:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWBUHxp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 02:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWBUHxp
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 02:53:45 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:29889 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S1751119AbWBUHxo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2006 02:53:44 -0500
Received: (qmail 63816 invoked from network); 21 Feb 2006 07:53:42 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 21 Feb 2006 07:53:42 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Feb 2006 02:53:42 -0500
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16522>

I recently ran into an interesting situation with git. I created a
repository that consisted of several directories (and files in them).
Later, after many commits, I realized I would prefer each directory have
its own git repository. That is, given a repo with the files:
  foo/bar
  baz/bleep
I wanted two repos, "foo" containing the file "bar" and "baz" containing
the file "bleep".

Obviously, one could simply make new repositories (one for each
directory), rename the files, and commit. However, I wanted to keep the
history for each new repo tidy, as well. So my solution was to replay
the history once for each new repo, omitting any revisions which had no
effect, and rewriting paths to move "dir/foo" to "foo".

The script I used is included at the end of this mail. I'm posting in
case anyone else finds it useful (comments are also welcome).

I also have a question regarding this task. I wanted to split the whole
history, so I wanted a "blank" commit to start adding my replay to (that
is, a commit with no files and no parent).  What's the best way using
git to get a blank commit? I ended up creating a new repo (with cogito,
which I regularly use), and then fetching it into the original repo and
switching to it as a branch. 

-Peff

--------------
#!/usr/bin/perl
# Rewrite history by replaying and modifying pathnames.
# Public domain.
#
# 1. Switch your HEAD to the head where the rewritten history will go.
# 2. Figure out which revs you want to replay (e.g., git-rev-list master)
# 3. Figure out which paths you want to include (e.g., '/^prefix/)
# 4. Figure out how you want to modify the path (e.g., 's!^prefix/!!')
# 5. Run the script:
#      git-rev-list master | perl rewrite.pl /^prefix/ 's!^prefix/!!'

my $USAGE = 'usage: rewrite.pl match rewrite';
my $match = shift or die "$USAGE, halting";
my $rewrite = shift or die "$USAGE, halting";

my @revs = ('HEAD', reverse(map { chomp; $_ } <>));
foreach my $i (1 .. $#revs) {
  my @files = difftree($revs[$i-1], $revs[$i]);
  @files = grep { match($match, $_) } @files
    or next;
  @files = map { rewrite($rewrite, $_) } @files;
  update_index(@files);
  commit($revs[$i]);
}

sub difftree {
  my ($x, $y) = @_;
  my @files;
  open(my $fh, "git-diff-tree -r $x $y|")
    or die "unable to open git-diff-tree: $!, halting";
  while(my $line = <$fh>) {
    chomp $line;
    $line =~ /^:\d+ (\d+) [0-9a-f]+ ([0-9a-f]+) .\t(.*)/
      or die "bad diff-tree output: $line, halting";
    push @files, [$1, $2, $3];
  }
  $? and die "git-diff-tree returned error: $!, halting";
  return @files;
}

sub match {
  my $m = shift;
  my $f = shift;
  local $_ = $f->[2];
  return eval $m;
}

sub rewrite {
  my $r = shift;
  my $f = shift;
  local $_ = $f->[2];
  eval $r;
  $@ and die $@;
  $f->[2] = $_;
  return $f;
}

sub update_index {
  open(my $fh, '|git-update-index --index-info')
    or die "unable to open git-update-index, halting";
  foreach my $f (@_) {
    print $fh "$f->[0] $f->[1]\t$f->[2]\n";
  }
  close($fh);
  $? and die "git-update-index reported failure, halting";
}

sub commit {
  my $r = shift;
  system("git-commit -C $r")
    and die "git-commit reported failure, halting";
}
