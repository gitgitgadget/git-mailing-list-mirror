From: Sam Vilain <sam@vilain.net>
Subject: Re: Retroactively change email signature? [resend]
Date: Thu, 03 Jan 2008 18:52:55 +1300
Message-ID: <477C7837.9000303@vilain.net>
References: <9b3e2dc20801021237v4d5d236fn3d2643502b9bb78f@mail.gmail.com> <alpine.LFD.1.00.0801021316080.3010@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 14:02:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAmCC-0002Oo-QE
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 14:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbYADNCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 08:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751791AbYADNCF
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 08:02:05 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:49378 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752991AbYADNCB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 08:02:01 -0500
X-Greylist: delayed 1577 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Jan 2008 08:02:00 EST
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 8379321D146; Sat,  5 Jan 2008 01:35:40 +1300 (NZDT)
Received: from longdrop.musashi.utsl.gen.nz (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	by mail.utsl.gen.nz (Postfix) with ESMTP id D0FFE21D01F;
	Sat,  5 Jan 2008 01:35:36 +1300 (NZDT)
Received: from samv by longdrop.musashi.utsl.gen.nz with local (Exim 3.36 #1 (Debian))
	id 1JAllw-0000oc-00; Sat, 05 Jan 2008 01:35:36 +1300
FCC: imap://sam@localhost/INBOX/Sent
X-Identity-Key: id4
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; uuencode=0
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <alpine.LFD.1.00.0801021316080.3010@woody.linux-foundation.org>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,
	DATE_IN_PAST_24_48 autolearn=failed version=3.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69576>

Linus Torvalds wrote:
> (I don't think git-filter-branch even exposes any easy way to remap the 
> "revert commit xyz" messages in the message format. It's not technically 
> hard to use a --msg-filter for it, but it seems a big bother).

Assuming, of course, that the commit you refer to in a message like that
is in your history.  If it's referring to another commit in a different
branch, which may be being re-written, you've got two problems:

1. rewriting the commit

2. making sure that git-filter-branch processes the two commits in the
right order.

The first is easily fixable; the second requires a hook in
git-filter-branch to customize the tournament.

Subject: [PATCH] git-filter-branch: allow a custom tournament for rewrite ordering

The topological sort by git rev-list may be inconvenient for history
modification where commit IDs are used in comments to refer to other
changes.  So, allow for a program that can take a list of commits, and
return that list in the order that the rewriter must follow.  Borrow
"Tournament" term from Graph Theory.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 Documentation/git-filter-branch.txt         |   18 ++++
 contrib/filter-branch/msg-links.perl        |   50 +++++++++
 contrib/filter-branch/tournament-links.perl |  148 +++++++++++++++++++++++++++
 git-filter-branch.sh                        |   11 ++
 t/t7003-filter-branch.sh                    |   21 ++++
 5 files changed, 248 insertions(+), 0 deletions(-)
 create mode 100755 contrib/filter-branch/msg-links.perl
 create mode 100755 contrib/filter-branch/tournament-links.perl

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 895d750..ed3a839 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -118,6 +118,24 @@ convenience functions, too.  For example, calling 'skip_commit "$@"'
 will leave out the current commit (but not its changes! If you want
 that, use gitlink:git-rebase[1] instead).
 
+--tournament <command>::
+	This command is responsible for re-ordering the commit history
+	after it is retrieved from the input list.  It is passed on
+	standard input the deduced list based upon a regular
+	topological search, and the command is expected to print to
+	standard output a list in the same form.
++
+Again, this can't be used to re-order patches like
+gitlink:git-rebase[1] does, as the tree IDs of the original positions
+will remain untouched, so the differences between revisions will be
+scrambled.
++
+However, it is required when you need to refer to a commit by ID in a
+commit message, where the commit you are referring to is on an
+unrelated branch.  See the contributed filters in the Git distribution
+for an example script that can let you preserve such referential
+integrity during a rewrite.
+
 --tag-name-filter <command>::
 	This is the filter for rewriting tag names. When passed,
 	it will be called for every tag ref that points to a rewritten
diff --git a/contrib/filter-branch/msg-links.perl b/contrib/filter-branch/msg-links.perl
new file mode 100755
index 0000000..1ff780c
--- /dev/null
+++ b/contrib/filter-branch/msg-links.perl
@@ -0,0 +1,50 @@
+#!/usr/bin/perl -nl
+#
+#   msg-links.perl
+#
+# This is the companion script to tournament-links.perl, it is
+# configured in the same way.  If you want this script, you will
+# probably also want the other one.
+#
+# What it does is rewrites all commit IDs of at least 12 digits long
+# to the post-rewritten version.  Note that this works only for
+# commits seen by the current git-filter-branch run!  If you need to
+# correct "dead" links from a previous run, then supply the rewrite
+# file.
+#
+# You don't need the tournament filter if all of the commits IDs you
+# are changing to are "ancient" history, or if you are rewriting
+# history that is a straight line.
+
+no strict;
+no warnings;
+
+use constant REV_MIN_LENGTH => $ENV{MSG_LINK_MIN} || 12;
+
+BEGIN {
+	$mlr = "$ENV{GITDIR}/msg-link-rewrite";
+	if ( -e $mlr ) {
+		open FH, "<", $mlr or die $!;
+		local($/);
+		%remap = m{([0-9a-f]{40})}g while <FH>;
+	}
+	( -d "../map" ) or die "can't see the git-filter-branch map dir";
+}
+
+my $old = $_;
+s{([0-9a-f]{${\(REV_MIN_LENGTH)},40})}{substr(($remap{$1}?do {
+	print STDERR " Remapped: $1 => $remap{$1} (rule)\n";
+	$remap{$1}; }
+		   : $1), 0, length($1))}eg;
+
+s{([0-9a-f]{${\(REV_MIN_LENGTH)},40})}{substr((-e "../map/$1" ? do {
+	$x = `cat ../map/$1`; chomp($x);
+		print STDERR " Remapped: $1 => $x (ripple)\n";
+	$x}
+: $1),0,length($1))}eg;
+
+if ( $old ne $_ ) {
+	print STDERR "*** filtered: pre: \n$old\n post:\n$_\n";
+}
+
+print;
diff --git a/contrib/filter-branch/tournament-links.perl b/contrib/filter-branch/tournament-links.perl
new file mode 100755
index 0000000..479a28f
--- /dev/null
+++ b/contrib/filter-branch/tournament-links.perl
@@ -0,0 +1,148 @@
+#!/usr/bin/perl
+#
+#  tournament-links.perl: a tournament that allows simple re-ordering.
+#
+#  This provides the requirement of getting the commits in the right
+#  order if there are any (full length) commitids in the commit
+#  messages.  It also provides for some remapping along the way (if,
+#  say, a referenced commit ID was wrong).  To do that, put it in a
+#  file in GIT_DIR called "msg-link-rewrite".
+#
+#  The format of msg-link-rewrite is very simple - any full-length
+#  SHA1s that are seen in the file are put into a single hash.  So,
+#  every other item is a key, starting with the first.  Everything
+#  else in the file is ignored.  This is combined with the remapping
+#  that the current git-filter-branch run has performed.
+#
+#  This script is only called once, at the beginning of the run, and
+#  can be relatively expensive on this basis.  This one is practically
+#  guaranteed to feed quicksort it's worst nightmare every time.
+#
+#  Example:
+#    $ cat > .git/msg-link-rewrite <<EOF
+#        Rewrite the commit ID 123456789012 to
+#              '92712632981923'
+#    EOF
+#    $ path=$ENV{HOME}/src/git/contrib/filter-branch
+#    $ git-filter-branch --tournament $path/tournament.perl \
+#         --msg-filter $path/msg-links.perl
+#
+
+no strict;
+no warnings;
+# use sort '_mergesort'; # Perl 5.10+ - use a mergesort instead
+
+use constant WATCH_BATTLE => $ENV{WATCH_BATTLE};
+use constant TOURNAMENT_RESULTS => $ENV{TOURNAMENT_RESULTS};
+use constant REV_MIN_LENGTH => $ENV{MSG_LINK_MIN} || 12;
+
+BEGIN {
+	$mlr = "$ENV{GITDIR}/msg-link-rewrite";
+	if ( -e $mlr ) {
+		open FH, "<", $mlr or die $!;
+		local($/);
+		%remap = m{([0-9a-f]{${\(REV_MIN_LENGTH)},40})}g while <FH>;
+	}
+	( -d "../map" ) or die "can't see the git-filter-branch map dir";
+}
+
+@commits = <>;
+%refers;
+
+# shorten a commit ID to something human-readable for display to
+# STDERR only
+sub n{
+	my $commitid = shift;
+	substr($commitid, 0, 12);
+}
+
+print STDERR "tournament: read ".@commits." commit IDs\n"
+	if TOURNAMENT_RESULTS;
+
+for my $line ( @commits ) {
+	chomp($line);
+	my ($commit, @parents) = split " ", $line;
+	my @refers_commitids;
+	open COMMIT, "-|", qw(git cat-file commit), $commit;
+	while ( <COMMIT> ) {
+		push @refers_commitids, $1 if m{^parent (.*)$};
+		last if m{^\s*$};
+	}
+
+	my $msg = join "", <COMMIT>;
+
+	my @refers_commitids = map {
+		my ($match) = $remap{$_} ? ($remap{$_})
+			: map { $remap{$_} } grep m{^$_}, keys %remap;
+		if ( $match ) {
+			print STDERR "msg-link in ".n($commit).": "
+				.n($_)." treated as ".n($match)."\n"
+					if WATCH_BATTLE;
+			$match;
+		}
+		elsif ( do { $match = `git rev-parse $_`; !$? } ) {
+			chomp($match);
+			print STDERR "msg-link seen in ".n($commit)
+				." to ".n($match)."\n"
+					if WATCH_BATTLE;
+			$match;
+		}
+		else {
+			print STDERR "dead msg-link seen in ".n($commit)
+				." to ".n($_)."\n";
+			$_;
+		}
+	} ($msg =~ m{([0-9a-f]{${\(REV_MIN_LENGTH)},40})}g);
+
+	warn("$commit is not an extant revision\n"), next if $?;
+
+	$refers{$commit} = { map { $_ => 1 } @refers_commitids, @parents };
+}
+print STDERR "tournament: read ".@commits." commits\n"
+	if TOURNAMENT_RESULTS;
+
+my $O;
+
+# returns 1 if source refers to target, or target is a parent of
+# anything referred to by source.
+my $refers = sub {
+	my $source = shift;
+	my $target = shift;
+	my @todo = keys %{ $refers{$source}||{} };
+	my %seen = map { $_ => 1 } @todo;
+	while ( my $commit = shift @todo ) {
+		$O++;
+		do {
+			print STDERR n($source)." refers to ".n($target)."\n"
+				if WATCH_BATTLE;
+			return 1;
+		} if $commit eq $target;
+		push @todo, grep { $O++; !$seen{$_}++ }
+			keys %{ $refers{$commit} || {} };
+	}
+	print STDERR n($source)." does not refer to ".n($target)."\n"
+		if WATCH_BATTLE;
+	return 0;
+};
+
+# It's tournament time!
+print "$_\n" for sort {
+	(my $_a = $a) =~ s{ .*}{};
+	(my $_b = $b) =~ s{ .*}{};
+	my $cmp_val = 0;
+	if ( $refers->($_a, $_b) ) {
+		++$cmp_val;
+	}
+	elsif ( $refers->($_b, $_a) ) {
+		--$cmp_val;
+	}
+	print STDERR n($a)." ".
+		(($cmp_val == 0 ? "EQUIVALENT TO" :
+		  $cmp_val == -1 ? "COMES BEFORE" :
+		  $cmp_val == 1 ? "COMES AFTER" : "TSNH")
+		 ." ".n($b)."\n")
+			if WATCH_BATTLE;
+	$cmp_val;
+} @commits;
+
+print STDERR "tournament-links.perl: O(".@commits.") = ".$O."\n";
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index ae29f47..6c099ea 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -110,6 +110,7 @@ filter_msg=cat
 filter_commit='git commit-tree "$@"'
 filter_tag_name=
 filter_subdir=
+tournament=
 orig_namespace=refs/original/
 force=
 while :
@@ -166,6 +167,9 @@ do
 	--subdirectory-filter)
 		filter_subdir="$OPTARG"
 		;;
+	--tournament)
+		tournament="$OPTARG"
+		;;
 	--original)
 		orig_namespace=$(expr "$OPTARG/" : '\(.*[^/]\)/*$')/
 		;;
@@ -254,6 +258,13 @@ commits=$(wc -l <../revs | tr -d " ")
 
 test $commits -eq 0 && die "Found nothing to rewrite"
 
+if [ -n "$tournament" ]
+then
+	cat ../revs | (eval "$tournament") > ../revs.sorted
+	mv ../revs ../revs.pre-sorted
+	mv ../revs.sorted ../revs
+fi
+
 # Rewrite the commits
 
 i=0
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 5f60b22..8d5679d 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -165,4 +165,25 @@ test_expect_success '"map" works in commit filter' '
 	git rev-parse --verify master
 '
 
+test_expect_success "Specifying a custom tournament" '
+        git checkout -b custom-tournament &&
+	echo "Hello">&2
+        echo j > j &&
+	git add j &&
+	echo "There">&2
+        git commit -m j j &&
+        echo z > z &&
+	git add z &&
+	echo "Dude">&2
+        git commit -m z &&
+        echo x > x &&
+	git add x &&
+	echo "Dude">&2
+        git commit -m x &&
+        git-filter-branch -f --parent-filter cat --tournament "cat > foo; fp=\$(head -1 foo | awk \"{print \\\$2}\"); ( head -2 foo | tac; tail -1 foo ) | awk \"{print \\\$1}\" | while read x y; do echo \$x \$fp; fp=\$x; done"  master..HEAD &&
+	order=$(git-log --pretty=format:"%s" master...custom-tournament | xargs) &&
+	echo "order is <$order>" &&
+	test "$order" = "x j z"
+'
+
 test_done
-- 
1.5.3.5
