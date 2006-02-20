From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 4/9] git-svn: remove any need for the XML::Simple dependency
Date: Mon, 20 Feb 2006 10:57:28 -0800
Message-ID: <11404618483821-git-send-email-normalperson@yhbt.net>
References: <1140461846433-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: junkio@cox.net, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 19:58:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBGEO-0001UO-7x
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 19:57:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbWBTS5d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 13:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbWBTS5d
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 13:57:33 -0500
Received: from hand.yhbt.net ([66.150.188.102]:57275 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932626AbWBTS52 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Feb 2006 13:57:28 -0500
Received: from untitled (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 3C5A82DC09D;
	Mon, 20 Feb 2006 10:57:28 -0800 (PST)
In-Reply-To: <1140461846433-git-send-email-normalperson@yhbt.net>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16495>

XML::Simple was originally required back when I made svn-arch-mirror
because I needed to explictly track renames with Arch.  Then I carried
it over to git-svn because I was afraid somebody could commit an svn
log message that could throw off a non-XML log parser.  Then I noticed
the <n> lines column in the header.  So, no more XML :)

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn |   84 ++++++++++++++++++++---------------------------
 1 files changed, 35 insertions(+), 49 deletions(-)

9b380ed2f8f1b18f95d12b86cb760f95e6e0cefe
diff --git a/contrib/git-svn/git-svn b/contrib/git-svn/git-svn
index 5f23d6b..4391bc3 100755
--- a/contrib/git-svn/git-svn
+++ b/contrib/git-svn/git-svn
@@ -21,7 +21,7 @@ $ENV{LC_ALL} = 'C';
 
 # If SVN:: library support is added, please make the dependencies
 # optional and preserve the capability to use the command-line client.
-# See what I do with XML::Simple to make the dependency optional.
+# use eval { require SVN::... } to make it lazy load
 use Carp qw/croak/;
 use IO::File qw//;
 use File::Basename qw/dirname basename/;
@@ -177,8 +177,7 @@ sub fetch {
 	push @log_args, "-r$_revision";
 	push @log_args, '--stop-on-copy' unless $_no_stop_copy;
 
-	eval { require XML::Simple or croak $! };
-	my $svn_log = $@ ? svn_log_raw(@log_args) : svn_log_xml(@log_args);
+	my $svn_log = svn_log_raw(@log_args);
 	@$svn_log = sort { $a->{revision} <=> $b->{revision} } @$svn_log;
 
 	my $base = shift @$svn_log or croak "No base revision!\n";
@@ -476,49 +475,6 @@ sub svn_commit_tree {
 	return fetch("$rev_committed=$commit")->{revision};
 }
 
-sub svn_log_xml {
-	my (@log_args) = @_;
-	my $log_fh = IO::File->new_tmpfile or croak $!;
-
-	my $pid = fork;
-	defined $pid or croak $!;
-
-	if ($pid == 0) {
-		open STDOUT, '>&', $log_fh or croak $!;
-		exec (qw(svn log --xml), @log_args) or croak $!
-	}
-
-	waitpid $pid, 0;
-	croak $? if $?;
-
-	seek $log_fh, 0, 0;
-	my @svn_log;
-	my $log = XML::Simple::XMLin( $log_fh,
-				ForceArray => ['path','revision','logentry'],
-				KeepRoot => 0,
-				KeyAttr => {	logentry => '+revision',
-						paths => '+path' },
-			)->{logentry};
-	foreach my $r (sort {$a <=> $b} keys %$log) {
-		my $log_msg = $log->{$r};
-		my ($Y,$m,$d,$H,$M,$S) = ($log_msg->{date} =~
-					/(\d{4})\-(\d\d)\-(\d\d)T
-					 (\d\d)\:(\d\d)\:(\d\d)\.\d+Z$/x)
-					 or croak "Failed to parse date: ",
-						 $log->{$r}->{date};
-		$log_msg->{date} = "+0000 $Y-$m-$d $H:$M:$S";
-
-		# XML::Simple can't handle <msg></msg> as a string:
-		if (ref $log_msg->{msg} eq 'HASH') {
-			$log_msg->{msg} = "\n";
-		} else {
-			$log_msg->{msg} .= "\n";
-		}
-		push @svn_log, $log->{$r};
-	}
-	return \@svn_log;
-}
-
 sub svn_log_raw {
 	my (@log_args) = @_;
 	my $pid = open my $log_fh,'-|';
@@ -529,21 +485,42 @@ sub svn_log_raw {
 	}
 
 	my @svn_log;
-	my $state;
+	my $state = 'sep';
 	while (<$log_fh>) {
 		chomp;
 		if (/^\-{72}$/) {
+			if ($state eq 'msg') {
+				if ($svn_log[$#svn_log]->{lines}) {
+					$svn_log[$#svn_log]->{msg} .= $_."\n";
+					unless(--$svn_log[$#svn_log]->{lines}) {
+						$state = 'sep';
+					}
+				} else {
+					croak "Log parse error at: $_\n",
+						$svn_log[$#svn_log]->{revision},
+						"\n";
+				}
+				next;
+			}
+			if ($state ne 'sep') {
+				croak "Log parse error at: $_\n",
+					"state: $state\n",
+					$svn_log[$#svn_log]->{revision},
+					"\n";
+			}
 			$state = 'rev';
 
 			# if we have an empty log message, put something there:
 			if (@svn_log) {
 				$svn_log[$#svn_log]->{msg} ||= "\n";
+				delete $svn_log[$#svn_log]->{lines};
 			}
 			next;
 		}
 		if ($state eq 'rev' && s/^r(\d+)\s*\|\s*//) {
 			my $rev = $1;
-			my ($author, $date) = split(/\s*\|\s*/, $_, 2);
+			my ($author, $date, $lines) = split(/\s*\|\s*/, $_, 3);
+			($lines) = ($lines =~ /(\d+)/);
 			my ($Y,$m,$d,$H,$M,$S,$tz) = ($date =~
 					/(\d{4})\-(\d\d)\-(\d\d)\s
 					 (\d\d)\:(\d\d)\:(\d\d)\s([\-\+]\d+)/x)
@@ -551,6 +528,7 @@ sub svn_log_raw {
 			my %log_msg = (	revision => $rev,
 					date => "$tz $Y-$m-$d $H:$M:$S",
 					author => $author,
+					lines => $lines,
 					msg => '' );
 			push @svn_log, \%log_msg;
 			$state = 'msg_start';
@@ -560,7 +538,15 @@ sub svn_log_raw {
 		if ($state eq 'msg_start' && /^$/) {
 			$state = 'msg';
 		} elsif ($state eq 'msg') {
-			$svn_log[$#svn_log]->{msg} .= $_."\n";
+			if ($svn_log[$#svn_log]->{lines}) {
+				$svn_log[$#svn_log]->{msg} .= $_."\n";
+				unless (--$svn_log[$#svn_log]->{lines}) {
+					$state = 'sep';
+				}
+			} else {
+				croak "Log parse error at: $_\n",
+					$svn_log[$#svn_log]->{revision},"\n";
+			}
 		}
 	}
 	close $log_fh or croak $?;
-- 
1.2.0.gdee6
