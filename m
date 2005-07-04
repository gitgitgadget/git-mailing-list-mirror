From: Junio C Hamano <junkio@cox.net>
Subject: Re: Last mile for 1.0 again
Date: Mon, 04 Jul 2005 16:06:55 -0700
Message-ID: <7vmzp2gohc.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0507041801040.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 01:08:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dpa39-0007rB-TF
	for gcvg-git@gmane.org; Tue, 05 Jul 2005 01:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVGDXIO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 19:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVGDXIO
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 19:08:14 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:53176 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261730AbVGDXG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2005 19:06:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050704230655.HUUS12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 4 Jul 2005 19:06:55 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0507041801040.30848-100000@iabervon.org> (Daniel Barkalow's message of "Mon, 4 Jul 2005 18:41:19 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:

DB> Junio: what's missing from annotate/blame?

Which one are you talking about?

What I use to generate http://members.cox.net/junkio/Summary.txt
is an implementation of an algorithm I consider "complete" in
that it does rename/copy and complete rewrite correctly.  What
is missing from the implementation is efficiency.

------------
#!/usr/bin/perl -w

use strict;

package main;
$::debug = 0;

sub read_blob {
    my $sha1 = shift;
    my $fh = undef;
    my $result;
    local ($/) = undef;
    open $fh, '-|', 'git-cat-file', 'blob', $sha1
	or die "cannot read blob $sha1";
    $result = join('', <$fh>);
    close $fh
	or die "failure while closing pipe to git-cat-file";
    return $result;
}

sub read_diff_raw {
    my ($parent, $filename) = @_;
    my $fh = undef;
    local ($/) = "\0";
    my @result = (); 
    my ($meta, $status, $sha1_1, $sha1_2, $file1, $file2);

    print STDERR "* diff-cache --cached $parent $filename\n" if $::debug;
    my $has_changes = 0;
    open $fh, '-|', 'git-diff-cache', '--cached', '-z', $parent, $filename
	or die "cannot read git-diff-cache $parent $filename";
    while (defined ($meta = <$fh>)) {
	$has_changes = 1;
    }
    close $fh
	or die "failure while closing pipe to git-diff-cache";
    if (!$has_changes) {
	return ();
    }

    $fh = undef;
    print STDERR "* diff-cache -B -C --find-copies-harder --cached $parent\n" if $::debug;
    open($fh, '-|', 'git-diff-cache', '-B', '-C', '--find-copies-harder',
	 '--cached', '-z', $parent)
	or die "cannot read git-diff-cache with $parent";
    while (defined ($meta = <$fh>)) {
	chomp($meta);
	(undef, undef, $sha1_1, $sha1_2, $status) = split(/ /, $meta);
	$file1 = <$fh>;
	chomp($file1);
	if ($status =~ /^[CR]/) {
	    $file2 = <$fh>;
	    chomp($file2);
	} elsif ($status =~ /^D/) {
	    next;
	} else {
	    $file2 = $file1;
	}
	if ($file2 eq $filename) {
	    push @result, [$status, $sha1_1, $sha1_2, $file1, $file2];
	}
    }
    close $fh
	or die "failure while closing pipe to git-diff-cache";
    return @result;
}

sub write_temp_blob {
    my ($sha1, $temp) = @_;
    my $fh = undef;
    my $blob = read_blob($sha1);
    open $fh, '>', $temp
	or die "cannot open temporary file $temp";
    print $fh $blob;
    close($fh);
}

package Git::Patch;
sub new {
    my ($class, $sha1_1, $sha1_2) = @_;
    my $self = bless [], $class;
    my $fh = undef;
    ::write_temp_blob($sha1_1, "/tmp/blame-$$-1");
    ::write_temp_blob($sha1_2, "/tmp/blame-$$-2");
    open $fh, '-|', 'diff', '-u0', "/tmp/blame-$$-1", "/tmp/blame-$$-2"
	or die "cannot read diff";
    while (<$fh>) {
	if (/^\@\@ -(\d+)(?:,(\d+))? \+(\d+)(?:,(\d+))? \@\@/) {
	    push @$self, [$1, (defined $2 ? $2 : 1),
			  $3, (defined $4 ? $4 : 1)];
	}
    }
    close $fh;
    unlink "/tmp/blame-$$-1", "/tmp/blame-$$-2";
    return $self;
}

sub find_parent_line {
    my ($self, $commit_lineno) = @_;
    my $ofs = 0;
    for (@$self) {
	my ($line_1, $len_1, $line_2, $len_2) = @$_;
	if ($commit_lineno < $line_2) {
	    return $commit_lineno - $ofs;
	}
	if ($line_2 <= $commit_lineno && $commit_lineno < $line_2 + $len_2) {
	    return -1; # changed by commit.
	}
	$ofs += ($len_1 - $len_2);
    }
    return $commit_lineno + $ofs;
}

package Git::Commit;

my %author_name_canon = 
('Linus Torvalds <torvalds@ppc970.osdl.org.(none)>' =>
 'Linus Torvalds <torvalds@ppc970.osdl.org>');

sub canon_author_name {
    my ($name) = @_;
    if (exists $author_name_canon{$name}) {
	return $author_name_canon{$name};
    }
    return $name;
}

sub new {
    my $class = shift;
    my $self = bless {
	PARENT => [],
	TREE => undef,
	AUTHOR => undef,
	COMMITTER => undef,
    }, $class;
    my $commit_sha1 = shift;
    $self->{SHA1} = $commit_sha1;
    my $fh = undef;
    open $fh, '-|', 'git-cat-file', 'commit', $commit_sha1
	or die "cannot read commit object $commit_sha1";
    while (<$fh>) {
	chomp;
	if (/^tree ([0-9a-f]{40})$/) { $self->{TREE} = $1; }
	elsif (/^parent ([0-9a-f]{40})$/) { push @{$self->{PARENT}}, $1; }
	elsif (/^author ([^>]+>)/) {
	    $self->{AUTHOR} = canon_author_name($1);
	}
	elsif (/^committer ([^>]+>)/) {
	    $self->{COMMITTER} = canon_author_name($1);
	}
    }
    close $fh
	or die "failure while closing pipe to git-cat-file";
    return $self;
}

sub find_file {
    my ($commit, $path) = @_;
    my $result = undef;
    my $fh = undef;
    local ($/) = "\0";
    open $fh, '-|', 'git-ls-tree', '-z', '-r', '-d', $commit->{TREE}, $path
	or die "cannot read git-ls-tree $commit->{TREE}";
    while (<$fh>) {
	chomp;
	if (/^[0-7]{6} blob ([0-9a-f]{40})	(.*)$/) {
	    if ($2 ne $path) {
		die "$2 ne $path???";
	    }
	    $result = $1;
	    last;
	}
    }
    close $fh
	or die "failure while closing pipe to git-ls-tree";
    return $result;
}

package Git::Blame;
sub new {
    my $class = shift;
    my $self = bless {
	LINE => [],
	UNKNOWN => undef,
	WORK => [],
    }, $class;
    my $commit = shift;
    my $filename = shift;
    my $sha1 = $commit->find_file($filename);
    my $blob = ::read_blob($sha1);
    my @blob = (split(/\n/, $blob));
    for (my $i = 0; $i < @blob; $i++) {
	$self->{LINE}[$i] = +{
	    COMMIT => $commit,
	    FOUND => undef,
	    FILENAME => $filename,
	    LINENO => ($i + 1),
	};
    }
    $self->{UNKNOWN} = scalar @blob;
    push @{$self->{WORK}}, [$commit, $filename];
    return $self;
}

sub read_blame_cache {
    my $self = shift;
    my $filename = shift;
    my $fh = undef;
    my $pi = $self->{'PATHINFO'} = {};
    open $fh, '<', $filename;
    while (<$fh>) {
	chomp;
	my ($commit, $parent, $path) = split(/\t/, $_);
	$pi->{$path}{$commit}{$parent} = 1;
    }
    close $fh;
}

sub print {
    my $self = shift;
    my $line_termination = shift;
    for (my $i = 0; $i < @{$self->{LINE}}; $i++) {
	my $l = $self->{LINE}[$i];
	print ($l->{FOUND} ? ':' : '?');;
	print "$l->{COMMIT}->{SHA1}	";
	print "$l->{COMMIT}->{AUTHOR}	";
	print "$l->{COMMIT}->{COMMITTER}	";
	print "$l->{LINENO}	$l->{FILENAME}";
	print $line_termination;
    }
}

sub take_responsibility {
    my ($self, $commit) = @_;
    for (my $i = 0; $i < @{$self->{LINE}}; $i++) {
	my $l = $self->{LINE}[$i];
	if (! $l->{FOUND} && ($l->{COMMIT}->{SHA1} eq $commit->{SHA1})) {
	    $l->{FOUND} = 1;
	    $self->{UNKNOWN}--;
	}
    }
}

sub blame_parent {
    my ($self, $commit, $parent, $filename) = @_;
    my @diff = ::read_diff_raw($parent->{SHA1}, $filename);
    my $filename_in_parent;
    my $passed_blame_to_parent = undef;
    if (@diff == 0) {
	# We have not touched anything.  Blame parent for everything
	# that we are suspected for.
	for (my $i = 0; $i < @{$self->{LINE}}; $i++) {
	    my $l = $self->{LINE}[$i];
	    if (! $l->{FOUND} && ($l->{COMMIT}->{SHA1} eq $commit->{SHA1})) {
		$l->{COMMIT} = $parent;
		$passed_blame_to_parent = 1;
	    }
	}
	$filename_in_parent = $filename;
    }
    elsif (@diff != 1) {
	# This should not happen.
	for (@diff) {
	    print "** @$_\n";
	}
	die "Oops";
    }
    else {
	my ($status, $sha1_1, $sha1_2, $file1, $file2) = @{$diff[0]};
	print STDERR "** $status $file1 $file2\n" if $::debug;
	if ($status =~ /N/ || $status =~ /M[0-9][0-9]/) {
	    # Either some of other parents created it, or we did.
	    # At this point the only thing we know is that this
	    # parent is not responsible for it.
	    ;
	}
	else {
	    my $patch = Git::Patch->new($sha1_1, $sha1_2);
	    $filename_in_parent = $file1;
	    for (my $i = 0; $i < @{$self->{LINE}}; $i++) {
		my $l = $self->{LINE}[$i];
		if (! $l->{FOUND} && $l->{COMMIT}->{SHA1} eq $commit->{SHA1}) {
		    # We are suspected to have introduced this line.
		    # Does it exist in the parent?
		    my $lineno = $l->{LINENO};
		    my $parent_line = $patch->find_parent_line($lineno);
		    if ($parent_line < 0) {
			# No, we may be the guilty ones, or some other
			# parent might be.  We do not assign blame to
			# ourselves here yet.
			;
		    }
		    else {
			# This line is coming from the parent, so pass
			# blame to it.
			$l->{COMMIT} = $parent;
			$l->{FILENAME} = $file1;
			$l->{LINENO} = $parent_line;
			$passed_blame_to_parent = 1;
		    }
		}
	    }
	}
    }
    if ($passed_blame_to_parent && $self->{UNKNOWN}) {
	unshift @{$self->{WORK}},
	[$parent, $filename_in_parent];
    }
}

sub assign {
    my ($self, $commit, $filename) = @_;
    # We do read-tree of the current commit and diff-cache
    # with each parents, instead of running diff-tree.  This
    # is because diff-tree does not look for copies hard enough.

    if (exists $self->{'PATHINFO'} && exists $self->{'PATHINFO'}{$filename} &&
	!exists $self->{'PATHINFO'}{$filename}{$commit->{SHA1}} &&
	@{$commit->{PARENT}} == 1) {
	# This commit did not touch the path at all, and
	# has only one parent.  It is all that parent's fault.

	my $parent = Git::Commit->new($commit->{PARENT}[0]);
	my $passed_blame_to_parent = 0;
	for (my $i = 0; $i < @{$self->{LINE}}; $i++) {
	    my $l = $self->{LINE}[$i];
	    if (! $l->{FOUND} &&
		($l->{COMMIT}->{SHA1} eq $commit->{SHA1})) {
		$l->{COMMIT} = $parent;
		$passed_blame_to_parent = 1;
	    }
	}
	if ($passed_blame_to_parent && $self->{UNKNOWN}) {
	    unshift @{$self->{WORK}},
	    [$parent, $filename];
	}
	return;
    }

    print STDERR "* read-tree  $commit->{SHA1}\n" if $::debug;
    system('git-read-tree', '-m', $commit->{SHA1});
    for my $parent (@{$commit->{PARENT}}) {
	$self->blame_parent($commit, Git::Commit->new($parent), $filename);
    }
    $self->take_responsibility($commit);
}

sub assign_blame {
    my ($self) = @_;
    while ($self->{UNKNOWN} && @{$self->{WORK}}) {
	my $wk = shift @{$self->{WORK}};
	my ($commit, $filename) = @$wk;
	$self->assign($commit, $filename);
    }
}



################################################################
package main;
my $usage = "blame [-z] <commit> filename";
my $line_termination = "\n";

$::ENV{GIT_INDEX_FILE} = "/tmp/blame-$$-index";
unlink($::ENV{GIT_INDEX_FILE});

if ($ARGV[0] eq '-z') {
    $line_termination = "\0";
    shift;
}

if (@ARGV != 2) {
    die $usage;
}

my $head_commit = Git::Commit->new($ARGV[0]);
my $filename = $ARGV[1];
my $blame = Git::Blame->new($head_commit, $filename);
if (-f ".blame-cache") {
    $blame->read_blame_cache(".blame-cache");
}

$blame->assign_blame();
$blame->print($line_termination);

unlink($::ENV{GIT_INDEX_FILE});

__END__

How does this work, and what do we do about merges?

The algorithm considers that the first parent is our main line of
development and treats it somewhat special than other parents.  So we
pass on the blame to the first parent if a line has not changed from
it.  For lines that have changed from the first parent, we must have
either inherited that change from some other parent, or it could have
been merge conflict resolution edit we did on our own.

The following picture illustrates how we pass on and assign blames.

In the sample, the original O was forked into A and B and then merged
into M.  Line 1, 2, and 4 did not change.  Line 3 and 5 are changed in
A, and Line 5 and 6 are changed in B.  M made its own decision to
resolve merge conflicts at Line 5 to something different from A and B:

                A: 1 2 T 4 T 6
               /               \ 
O: 1 2 3 4 5 6                  M: 1 2 T 4 M S
               \               / 
                B: 1 2 3 4 S S

In the following picture, each line is annotated with a blame letter.
A lowercase blame (e.g. "a" for "1") means that commit or its ancestor
is the guilty party but we do not know which particular ancestor is
responsible for the change yet.  An uppercase blame means that we know
that commit is the guilty party.

First we look at M (the HEAD) and initialize Git::Blame->{LINE} like
this:

             M: 1 2 T 4 M S
                m m m m m m

That is, we know all lines are results of modification made by some
ancestor of M, so we assign lowercase 'm' to all of them.

Then we examine our first parent A.  Throughout the algorithm, we are
always only interested in the lines we are the suspect, but this being
the initial round, we are the suspect for all of them.  We notice that
1 2 T 4 are the same as the parent A, so we pass the blame for these
four lines to A.  M and S are different from A, so we leave them as
they are (note that we do not immediately take the blame for them):

             M: 1 2 T 4 M S
                a a a a m m

Next we go on to examine parent B.  Again, we are only interested in
the lines we are still the suspect (i.e. M and S).  We notice S is
something we inherited from B, so we pass the blame on to it, like
this:

             M: 1 2 T 4 M S
                a a a a m b

Once we exhausted the parents, we look at the results and take
responsibility for the remaining ones that we are still the suspect:

             M: 1 2 T 4 M S
                a a a a M b

We are done with M.  And we know commits A and B need to be examined
further, so we do them recursively.  When we look at A, we again only
look at the lines that A is the suspect:

             A: 1 2 T 4 T 6
                a a a a M b

Among 1 2 T 4, comparing against its parent O, we notice 1 2 4 are
the same so pass the blame for those lines to O:

             A: 1 2 T 4 T 6
                o o a o M b

A is a non-merge commit; we have already exhausted the parents and
take responsibility for the remaining ones that A is the suspect:

             A: 1 2 T 4 T 6
                o o A o M b

We go on like this and the final result would become:

             O: 1 2 3 4 5 6
                O O A O M B
