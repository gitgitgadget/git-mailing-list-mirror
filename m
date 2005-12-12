From: Artem Khodush <greenkaa@gmail.com>
Subject: [PATCH] add git-nntp-post: post git commit diffs as news messages
Date: Mon, 12 Dec 2005 22:39:11 +0300
Message-ID: <40b2b7d90512121139q5508f961y3bdbf5fff2cebc1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Dec 12 20:39:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EltW5-0000Xo-4G
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 20:39:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbVLLTjQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 14:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbVLLTjQ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 14:39:16 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:40529 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932175AbVLLTjP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2005 14:39:15 -0500
Received: by nproxy.gmail.com with SMTP id l35so520969nfa
        for <git@vger.kernel.org>; Mon, 12 Dec 2005 11:39:13 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=O6UDm6/RUzbu5gRGzM81eoRcRtvy/Nko2EBo83IBsF1+6sJEPsI9A7/20QPXYDFiwJCxbhE4jnEiXKXh/Rj6VP/PxNEyuExvctgNyZb48goDX9z9ihcSwpFsAZKEkgkDp5VcHcb1gSdOMgZrba3OAc+1+s4xWxTM24X31GN4jmQ=
Received: by 10.48.1.17 with SMTP id 17mr910890nfa;
        Mon, 12 Dec 2005 11:39:11 -0800 (PST)
Received: by 10.48.216.3 with HTTP; Mon, 12 Dec 2005 11:39:11 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13535>

This is a script that exports git repository to a nntp server,
as prompted in http://marc.theaimsgroup.com/?l=git&m=113385203614980&w=2
Tested with INN on localhost with a copy of git repository
(newsgroups must be created beforehand, and inn.conf artcutoff:
and expire.ctl /remember/: parameters better set to never).

I'm not sure if I got this one right, though:

> A merge commit would probably become a multipart with usually 2
> attachments (but N attachments for a N-way octopus), showing
> diff from each branch.

Currently for merges, it posts diff with parent[0] as first attachment,
and diff between parent[i] and git-merge-base parent[i] parent[0]
as each next attachment.


Signed-off-by: Artem Khodush <greenkaa@gmail.com>

---

 Makefile           |    2
 git-nntp-post.perl |  450 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 451 insertions(+), 1 deletions(-)
 create mode 100755 git-nntp-post.perl

bde2562197562d21fb0f66e83e51864c9f648c6a
diff --git a/Makefile b/Makefile
index a851f56..b9ed12c 100644
--- a/Makefile
+++ b/Makefile
@@ -80,7 +80,7 @@ SCRIPT_SH = \

 SCRIPT_PERL = \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
-	git-rename.perl git-shortlog.perl
+	git-rename.perl git-shortlog.perl git-nntp-post.perl

 SCRIPT_PYTHON = \
 	git-merge-recursive.py
diff --git a/git-nntp-post.perl b/git-nntp-post.perl
new file mode 100755
index 0000000..13d0293
--- /dev/null
+++ b/git-nntp-post.perl
@@ -0,0 +1,450 @@
+#!/usr/bin/perl -w
+#
+# Copyright (C) 2005 Artem Khodush <greenkaa@gmail.com>
+#
+# This program contains parts from gitweb.cgi,
+# (C) 2005, Kay Sievers <kay.sievers@vrfy.org>
+# (C) 2005, Christian Gierke <ch@gierke.de>
+
+# This program is licensed under the GPL v2, or a later version
+
+use warnings;
+use strict;
+use Net::NNTP;
+use HTTP::Date;
+use MIME::Lite;
+#use MIME::Entity; # interchangeable with the above, but slower
+
+BEGIN {
+	if( $^V ge v5.8.0 ) {
+		require Encode; import Encode;
+	}else {
+		no strict "refs";
+		*{"Encode::encode"}=sub { my ($a,$s,$b)=@_; return $s; };
+	}
+}
+
+# Read commits, starting from heads given on the command line,
+# (or all repository heads), and post each commit diff
+# to a newsgroup, starting with earliest commit.
+# Commits from different branches go to different newsgroups,
+# named after the head names.
+# The order of heads on the command line is important:
+# when branching point is encountered, the branch specified
+# earlier is considered to be the trunk, continuing into the past.
+
+# For commits with more than one parent, multipart message
+# is posted with first part containing diff with parent[0], and each
+# other part containing diff between parent[i] and
+# git-merge-base parent[i] parent[0] (thus showing summary change
+# followed by what was merged from each branch)
+
+# Subset of the git-rev-list options (--max-age, --min-age and
+# commits starting with ^) is accepted to limit the number of
+# commits posted.
+# Exactly one (the latest) commit may be posted with --one option.
+
+# By default, it posts to localhost nntp port (119), this may
+# be changed by --nntp-host and --nntp-port.
+
+# The newsgroup names are formed by taking the GIT_DIR
+# without the trailing .git, replacing / with ., and appending
+# the head name. This can be overriden with --newsgroup-prefix.
+
+# Each posted message gets an id of the form
+# <commit.SHA1@kernel.org>, and the nntp server is relied upon
+# to reject duplicate posts, and to keep the posting order intact.
+# Hence, with ordinary news servers, each commit
+# can appear only in the newsgroups it was originally posted
+# (currently only one), unless someone care to implement
+# logic for rewriting posts, or a special nntp server.
+
+sub usage() {
+	print STDERR <<EOT;
+$0 [OPTIONS] [<head> ...] [^<commit> ...]
+--nntp-host <host>
+--nntp-port <port>
+--newsgroup-prefix <prefix>
+--max-age <epoch>
+--min-age <epoch>
+--one
+--print-newsgroup-names
+--print-messages
+EOT
+	exit(1);
+}
+
+my $GIT_DIR = `git rev-parse --git-dir`;
+chop $GIT_DIR;
+exit 1 if $?; # rev-parse would have given "not a git dir" message.
+chomp($GIT_DIR);
+
+my $DOMAIN_ID="kernel.org"; # sufficiently unique string for Path and
Message-Id headers
+
+my $NNTP_HOST="localhost";
+my $NNTP_PORT="119";
+my $NEWSGROUP_PREFIX;
+my $MAX_AGE;
+my $MIN_AGE;
+my $ONLY_ONE;
+my %HEADS;
+my @STOP_COMMITS;
+my $PRINT_NEWSGROUP_NAMES;
+my $PRINT_MESSAGES;
+
+my $HEAD_COUNT=0;
+
+while( my $arg=shift ) {
+	if( $arg eq "-h" || $arg eq "--nntp-host" ) {
+		$NNTP_HOST=shift or usage();
+	}elsif( $arg=~/^--nntp-host=(.+)$/ ) {
+		$NNTP_HOST=$1;
+	}elsif( $arg eq "-p" || $arg eq "--nntp-port" ) {
+		$NNTP_PORT=shift or usage();
+	}elsif( $arg=~/^--nntp-port=(.+)$/ ) {
+		$NNTP_PORT=$1;
+	}elsif( $arg eq "-n" || $arg eq "--newsgroup-prefix" ) {
+		$NEWSGROUP_PREFIX=shift or usage();
+	}elsif( $arg=~/^--newsgroup-prefix=(.+)$/ ) {
+		$NEWSGROUP_PREFIX=$1;
+	}elsif( $arg eq "-a" || $arg eq "--max-age" ) {
+		$MAX_AGE=shift or usage();
+	}elsif( $arg=~/^--max-age=(.+)$/ ) {
+		$MAX_AGE=$1;
+	}elsif( $arg eq "-i" || $arg eq "--min-age" ) {
+		$MIN_AGE=shift or usage();
+	}elsif( $arg=~/^--min-age=(.+)$/ ) {
+		$MIN_AGE=$1;
+	}elsif( $arg eq "-1" || $arg eq "--one" ) {
+		$ONLY_ONE=1;
+	}elsif( $arg eq "--print-newsgroup-names" ) {
+		$PRINT_NEWSGROUP_NAMES=1;
+	}elsif( $arg eq "--print-messages" ) {
+		$PRINT_MESSAGES=1;
+	}elsif( $arg=~/^\^/ ) {
+		push @STOP_COMMITS, $arg;
+	}else {
+		if( "HEAD" eq $arg ) {
+			(undef,$arg)=split( " ", `git-name-rev HEAD` );
+		}
+		$HEADS{$arg}->{order}=++$HEAD_COUNT;
+	}
+}
+
+&verify_heads;
+&read_commits;
+&propagate_branches;
+&post_commits;
+exit( 0 );
+
+sub verify_heads()
+{
+	my $repo=$GIT_DIR;
+	my $read_all_heads= 0==$HEAD_COUNT;
+	open my $fd, "-|", "git-peek-remote $repo" or die "$0: error running
git-peek-remote: $!";
+	while( my $line=<$fd> ) {
+		my ($id,$name)=split ' ', $line;
+		my $is_head=0;
+		if( "HEAD" eq $name ) {
+			$is_head=1;
+			(undef,$name)=split( " ", `git-name-rev HEAD` );
+		}
+		if( $name=~s/^refs\/heads\/// || $is_head ) {
+			# if there were heads given on the command line, take only those.
+			# otherwise, with --one, take only HEAD, without --one, take all heads.
+			if( exists( $HEADS{$name} ) || ($read_all_heads && ($is_head ||
!$ONLY_ONE)) ) {
+				$HEADS{$name}->{id}=$id;
+			}
+		}
+	}
+	close $fd or die "$0: git_get_type: unable to close fd: $!";
+	if( $read_all_heads ) {
+		#sort them
+		my $n=0;
+		for my $name (sort keys %HEADS) {
+			$HEADS{$name}->{order}=++$n;
+		}
+		# make master the first
+		$HEADS{"master"}->{order}=0 if exists $HEADS{"master"};
+	}
+	if( $ONLY_ONE && scalar( keys %HEADS )!=1 ) {
+		die "$0: --one requires exactly one head, but " . scalar( keys
%HEADS ) . " were given\n";
+	}
+	if( $PRINT_NEWSGROUP_NAMES ) { # just print them
+		for my $head (keys %HEADS) {
+			print &make_newsgroup_name( $head ) . "\n";
+		}
+		exit( 0 );
+	}
+}
+
+my %COMMITS;
+
+sub read_commits
+{
+	my $args="";
+	$args.=" --max-age $MAX_AGE" if $MAX_AGE;
+	$args.=" " . join( " ", keys %HEADS );
+	$args.=" " . join( " ", @STOP_COMMITS );
+	$args.=" --max-count=1" if $ONLY_ONE;
+	$/ = "\0";
+	open my $fd, "-|", "git-rev-list --header --parents $args" or die
"$0: error running git-rev-list: $!";
+	while( my $commit_line=<$fd> ) {
+		$commit_line =~ s/\r$//;
+		my @commit_lines = split '\n', $commit_line;
+		pop @commit_lines;
+		my %co;
+
+		my $header = shift @commit_lines;
+		if (!($header =~ m/^[0-9a-fA-F]{40}/)) {
+			next;
+		}
+		($co{'id'}, my @parents) = split ' ', $header;
+		$co{'parents'} = \@parents;
+		while (my $line = shift @commit_lines) {
+			last if $line eq "\n";
+			if ($line =~ m/^author (.*) ([0-9]+) (.*)$/) {
+				$co{'author'} = $1;
+				$co{'author_epoch'} = $2;
+				$co{'author_tz'} = $3;
+			}elsif ($line =~ m/^committer (.*) ([0-9]+) (.*)$/) {
+				$co{'committer'} = $1;
+				$co{'committer_epoch'} = $2;
+				$co{'committer_tz'} = $3;
+			}
+		}
+		$co{'title'}="";
+		$co{'title_short'}="";
+		foreach my $title (@commit_lines) {
+			if ($title ne "") {
+				$title=~s/^\s+//;
+				$co{'title'} = chop_str($title, 80, 5);
+				# remove leading stuff of merges to make the interesting part visible
+				if (length($title) > 50) {
+					$title =~ s/^Automatic //;
+					$title =~ s/^merge (of|with) /Merge ... /i;
+					if (length($title) > 50) {
+						$title =~ s/(http|rsync):\/\///;
+					}
+					if (length($title) > 50) {
+						$title =~ s/(master|www|rsync)\.//;
+					}
+					if (length($title) > 50) {
+						$title =~ s/kernel.org:?//;
+					}
+					if (length($title) > 50) {
+						$title =~ s/\/pub\/scm//;
+					}
+				}
+				$co{'title_short'} = chop_str($title, 50, 5);
+				last;
+			}
+		}
+		# remove added spaces
+		foreach my $line (@commit_lines) {
+			$line =~ s/^    //;
+		}
+		$co{'comment'} = \@commit_lines;
+		$COMMITS{$co{'id'}}=\%co;
+	}
+	close $fd or die "$0: git_read_commit: unable to close fd: $!";
+	$/ = "\n";
+}
+
+sub propagate_branches
+{
+	for my $head (sort { $HEADS{$a}->{order} - $HEADS{$b}->{order} }
keys %HEADS) {
+		my $child_id=undef;
+		my $id=$HEADS{$head}->{id};
+		while( $id && exists $COMMITS{$id} && !exists $COMMITS{$id}->{branch} ) {
+			my $co=$COMMITS{$id};
+			$co->{branch}=$head;
+			$co->{child}=$child_id;
+			$HEADS{$head}->{start_id}=$id;
+			$child_id=$id;
+			$id=$co->{parents}->[0];
+		}
+	}
+}
+
+sub make_message_id
+{
+	my $id=shift;
+	return "<commit.$id\@$DOMAIN_ID>",
+}
+
+sub make_commit_body
+{
+	my ($id,$other_id,$from_branch)=@_;
+	my $body="";
+	my ($author, $author_epoch, $committer, $committer_epoch);
+	my $comment="";
+	if( exists $COMMITS{$id} ) { # if we have it already, spare git-cat-file
+		my $co=$COMMITS{$id};
+		($author, $author_epoch, $committer,
$committer_epoch)=($co->{author}, $co->{author_epoch},
$co->{committer}, $co->{committer_epoch});
+		$comment=join( "\n", @{$co->{comment}} );
+	}else {
+		open my $fd0, "-|", "git-cat-file commit $id" or die "$0: error
running git-cat-file: $!";
+		my $header=1;
+		while( <$fd0> ) {
+			if( !$header ) {
+				$comment.=$_;
+			}elsif( m/^\s+$/ ) {
+				$header=0;
+			}elsif( m/^author (.*) ([0-9]+) (.*)$/ ) {
+				$author=$1;
+				$author_epoch=$2;
+			}elsif( m/^committer (.*) ([0-9]+) (.*)$/ ) {
+				$committer=$1;
+				$committer_epoch=$2;
+			}
+		}
+		close $fd0;
+	}
+	if( $from_branch ) {
+		my $merge_base=`git-merge-base $id $other_id`;
+		chop $merge_base;
+		$body.="merged from $id\n\n---\n";
+		$other_id=$merge_base if $merge_base;
+	}else {
+		my ($author_name,$author_email)=split( " ", $author );
+		my ($committer_name,$committer_email)=split( " ", $committer );
+		$body.="committer $committer " . time2str( $committer_epoch ) .
"\n" unless $author_name eq $committer_name;
+		$body.=$comment;
+		$body.="\n---\n\n";
+	}
+	if( $other_id ) {
+		open my $fd1, "-|", "git-diff-tree -p $other_id $id | git-apply
--stat --summary" or die "$0: error running git-diff-tree: $!";
+		while( <$fd1> ) {
+			$body.=$_;
+		}
+		close $fd1;
+		$body.="\n";
+		open my $fd2, "-|", "git-diff-tree -p $other_id $id" or die "$0:
error running git-diff-tree again: $!";
+		while( <$fd2> ) {
+			$body.=$_;
+		}
+		close $fd2;
+	}
+	return $body;
+}
+
+sub make_commit_message
+{
+	my ($newsgroup,$co)=@_;
+	my $n_parents=scalar( @{$co->{parents}} );
+	my $parents=join( " ", map( make_message_id( $_ ),  @{$co->{parents}} ) );
+	my $from=$co->{author};
+	$from=$co->{committer} unless $from;
+	$from="unknown author" unless $from;
+	my $subject=$co->{title_short};
+	$subject="undescribed patch" unless $subject;
+	my $msg=MIME::Lite->new(
+		From=>join( " ", map( Encode::encode( "MIME-Q", $_ ), split( " ",
$from ) ) ),
+		Subject=>join( " ", map( Encode::encode( "MIME-Q", $_ ), split( "
", $subject ) ) ),
+		Date=>time2str( $co->{author_epoch} ),
+		"Message-Id"=>make_message_id( $co->{id} ),
+		($n_parents>0 ? (References=>$parents) : ()),
+
+		($n_parents>1 ? (Type=>"multipart/mixed")
+			:(
+			Type=>"text/plain; charset=utf8",
+			Encoding=>"quoted-printable",
+			Data=>make_commit_body( $co->{id}, $co->{parents}->[0], 0 )
+			)
+		)
+	);
+	$msg->add( Path=>$DOMAIN_ID );
+	$msg->add( Newsgroups=>$newsgroup );
+	if( $n_parents>1 ) {
+		$msg->attach(
+			Type=>"text/plain; charset=utf8",
+			Encoding=>"quoted-printable",
+			Data=>make_commit_body( $co->{id}, $co->{parents}->[0], 0 )
+		);
+		for my $n (1..$n_parents-1) {
+			$msg->attach(
+				Type=>"text/plain; charset=utf8",
+				Encoding=>"quoted-printable",
+				Data=>make_commit_body( $co->{parents}->[$n], $co->{parents}->[0], 1 )
+			);
+		}
+	}
+	return $msg;
+}
+
+sub post_commit
+{
+	my ($nntp,$newsgroup,$co)=@_;
+	if( $PRINT_MESSAGES ) { # just print them
+		print make_commit_message( $newsgroup, $co )->as_string();
+		print "\0";
+	}else {
+		if( !$nntp->ihave( make_message_id( $co->{id} ) ) ) {
+			my $reason=$nntp->message();
+			unless( $reason=~m/got it/i || $reason=~m/duplicate/i ) {
+				print STDERR "unexpected responce in attempt to post $co->{id}: $reason"
+			}
+		}else {
+			$nntp->datasend( make_commit_message(  $newsgroup, $co )->as_string() );
+			if( !$nntp->dataend() ) {
+				print STDERR "error posting $co->{id}: " . $nntp->message() . "\n";
+			}
+		}
+	}
+}
+
+sub make_newsgroup_name
+{
+	my $nhead=shift;
+	$nhead=~s/\/+$//;
+	$nhead=~s/^\/+//;
+	$nhead=~s/\./-/g;
+	$nhead=~s/\//\./g;
+	my $nprefix=$NEWSGROUP_PREFIX;
+	if( !defined( $nprefix ) ) {
+		$nprefix=$GIT_DIR;
+		$nprefix=~s/\/\.git\/?\s*$//;
+		$nprefix=~s/\/+$//;
+		$nprefix=~s/^\/+//;
+		$nprefix=~s/\./-/g;
+		$nprefix=~s/\//\./g;
+	}
+	return "$nprefix.$nhead";
+}
+
+sub post_commits
+{
+	my $nntp;
+	unless( $PRINT_MESSAGES ) {
+		$nntp=Net::NNTP->new( $NNTP_HOST, Port=>$NNTP_PORT,  Reader=>0 );
+		die "unable to connect to nntp host ${NNTP_HOST}:${NNTP_PORT}" unless $nntp;
+	}
+	while( my ($head,$h)=each %HEADS ) {
+		my $id=$h->{start_id};
+		my $newsgroup_name=make_newsgroup_name( $head );
+		while( $id ) {
+			my $co=$COMMITS{$id};
+			$id=$co->{child};
+			next if defined( $MIN_AGE ) && $co->{committer_epoch} > $MIN_AGE;
+			post_commit( $nntp, $newsgroup_name, $co );
+		}
+	}
+}
+
+sub chop_str {
+	my $str = shift;
+	my $len = shift;
+	my $add_len = shift || 10;
+
+	# allow only $len chars, but don't cut a word if it would fit in $add_len
+	# if it doesn't fit, cut it if it's still longer than the dots we would add
+	$str =~ m/^(.{0,$len}[^ \/\-_:\.@]{0,$add_len})(.*)/;
+	my $body = $1;
+	my $tail = $2;
+	if (length($tail) > 4) {
+		$tail = " ...";
+	}
+	return "$body$tail";
+}
+
--
0.99.9.GIT
