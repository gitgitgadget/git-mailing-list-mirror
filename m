From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] contrib/git-svn: stabilize memory usage for big fetches
Date: Sat, 25 Mar 2006 18:52:31 -0800
Message-ID: <11433415513822-git-send-email-normalperson@yhbt.net>
References: <20060325082521.GA17473@hand.yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: git <git@vger.kernel.org>, Jan-Benedict Glaw <jbglaw@lug-owl.de>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Mar 26 04:53:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNLNF-0000aL-Sk
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 04:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWCZCw7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 21:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWCZCw7
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 21:52:59 -0500
Received: from hand.yhbt.net ([66.150.188.102]:13455 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751358AbWCZCw6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 21:52:58 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 7643B2DC033;
	Sat, 25 Mar 2006 18:52:58 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email
In-Reply-To: <20060325082521.GA17473@hand.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18022>

We should be safely able to import histories with thousands
of revisions without hogging up lots of memory.

With this, we lose the ability to autocorrect mistakes when
people specify revisions in reverse, but it's probably no longer
a problem since we only have one method of log parsing nowadays.

I've added an extra check to ensure that revision numbers do
increment.

Also, increment the version number to 0.11.0.  I really should
just call it 1.0 soon...

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.perl |  109 ++++++++++++++++++++++++------------------
 1 files changed, 63 insertions(+), 46 deletions(-)

c76df6617116a7d330a3110230bc3b01eaf9c66d
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index f3fc3ec..3e5733e 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -8,7 +8,7 @@ use vars qw/	$AUTHOR $VERSION
 		$GIT_SVN_INDEX $GIT_SVN
 		$GIT_DIR $REV_DIR/;
 $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
-$VERSION = '0.10.0';
+$VERSION = '0.11.0';
 $GIT_DIR = $ENV{GIT_DIR} || "$ENV{PWD}/.git";
 # make sure the svn binary gives consistent output between locales and TZs:
 $ENV{TZ} = 'UTC';
@@ -217,9 +217,8 @@ sub fetch {
 	push @log_args, '--stop-on-copy' unless $_no_stop_copy;
 
 	my $svn_log = svn_log_raw(@log_args);
-	@$svn_log = sort { $a->{revision} <=> $b->{revision} } @$svn_log;
 
-	my $base = shift @$svn_log or croak "No base revision!\n";
+	my $base = next_log_entry($svn_log) or croak "No base revision!\n";
 	my $last_commit = undef;
 	unless (-d $SVN_WC) {
 		svn_cmd_checkout($SVN_URL,$base->{revision},$SVN_WC);
@@ -234,18 +233,22 @@ sub fetch {
 	}
 	my @svn_up = qw(svn up);
 	push @svn_up, '--ignore-externals' unless $_no_ignore_ext;
-	my $last_rev = $base->{revision};
-	foreach my $log_msg (@$svn_log) {
-		assert_svn_wc_clean($last_rev, $last_commit);
-		$last_rev = $log_msg->{revision};
-		sys(@svn_up,"-r$last_rev");
+	my $last = $base;
+	while (my $log_msg = next_log_entry($svn_log)) {
+		assert_svn_wc_clean($last->{revision}, $last_commit);
+		if ($last->{revision} >= $log_msg->{revision}) {
+			croak "Out of order: last >= current: ",
+				"$last->{revision} >= $log_msg->{revision}\n";
+		}
+		sys(@svn_up,"-r$log_msg->{revision}");
 		$last_commit = git_commit($log_msg, $last_commit, @parents);
+		$last = $log_msg;
 	}
-	assert_svn_wc_clean($last_rev, $last_commit);
+	assert_svn_wc_clean($last->{revision}, $last_commit);
 	unless (-e "$GIT_DIR/refs/heads/master") {
 		sys(qw(git-update-ref refs/heads/master),$last_commit);
 	}
-	return pop @$svn_log;
+	return $last;
 }
 
 sub commit {
@@ -708,49 +711,61 @@ sub svn_commit_tree {
 	return fetch("$rev_committed=$commit")->{revision};
 }
 
+# read the entire log into a temporary file (which is removed ASAP)
+# and store the file handle + parser state
 sub svn_log_raw {
 	my (@log_args) = @_;
-	my $pid = open my $log_fh,'-|';
+	my $log_fh = IO::File->new_tmpfile or croak $!;
+	my $pid = fork;
 	defined $pid or croak $!;
-
-	if ($pid == 0) {
+	if (!$pid) {
+		open STDOUT, '>&', $log_fh or croak $!;
 		exec (qw(svn log), @log_args) or croak $!
 	}
+	waitpid $pid, 0;
+	croak if $?;
+	seek $log_fh, 0, 0 or croak $!;
+	return { state => 'sep', fh => $log_fh };
+}
+
+sub next_log_entry {
+	my $log = shift; # retval of svn_log_raw()
+	my $ret = undef;
+	my $fh = $log->{fh};
 
-	my @svn_log;
-	my $state = 'sep';
-	while (<$log_fh>) {
+	while (<$fh>) {
 		chomp;
 		if (/^\-{72}$/) {
-			if ($state eq 'msg') {
-				if ($svn_log[$#svn_log]->{lines}) {
-					$svn_log[$#svn_log]->{msg} .= $_."\n";
-					unless(--$svn_log[$#svn_log]->{lines}) {
-						$state = 'sep';
+			if ($log->{state} eq 'msg') {
+				if ($ret->{lines}) {
+					$ret->{msg} .= $_."\n";
+					unless(--$ret->{lines}) {
+						$log->{state} = 'sep';
 					}
 				} else {
 					croak "Log parse error at: $_\n",
-						$svn_log[$#svn_log]->{revision},
+						$ret->{revision},
 						"\n";
 				}
 				next;
 			}
-			if ($state ne 'sep') {
+			if ($log->{state} ne 'sep') {
 				croak "Log parse error at: $_\n",
-					"state: $state\n",
-					$svn_log[$#svn_log]->{revision},
+					"state: $log->{state}\n",
+					$ret->{revision},
 					"\n";
 			}
-			$state = 'rev';
+			$log->{state} = 'rev';
 
 			# if we have an empty log message, put something there:
-			if (@svn_log) {
-				$svn_log[$#svn_log]->{msg} ||= "\n";
-				delete $svn_log[$#svn_log]->{lines};
+			if ($ret) {
+				$ret->{msg} ||= "\n";
+				delete $ret->{lines};
+				return $ret;
 			}
 			next;
 		}
-		if ($state eq 'rev' && s/^r(\d+)\s*\|\s*//) {
+		if ($log->{state} eq 'rev' && s/^r(\d+)\s*\|\s*//) {
 			my $rev = $1;
 			my ($author, $date, $lines) = split(/\s*\|\s*/, $_, 3);
 			($lines) = ($lines =~ /(\d+)/);
@@ -758,36 +773,34 @@ sub svn_log_raw {
 					/(\d{4})\-(\d\d)\-(\d\d)\s
 					 (\d\d)\:(\d\d)\:(\d\d)\s([\-\+]\d+)/x)
 					 or croak "Failed to parse date: $date\n";
-			my %log_msg = (	revision => $rev,
+			$ret = {	revision => $rev,
 					date => "$tz $Y-$m-$d $H:$M:$S",
 					author => $author,
 					lines => $lines,
-					msg => '' );
+					msg => '' };
 			if (defined $_authors && ! defined $users{$author}) {
 				die "Author: $author not defined in ",
 						"$_authors file\n";
 			}
-			push @svn_log, \%log_msg;
-			$state = 'msg_start';
+			$log->{state} = 'msg_start';
 			next;
 		}
 		# skip the first blank line of the message:
-		if ($state eq 'msg_start' && /^$/) {
-			$state = 'msg';
-		} elsif ($state eq 'msg') {
-			if ($svn_log[$#svn_log]->{lines}) {
-				$svn_log[$#svn_log]->{msg} .= $_."\n";
-				unless (--$svn_log[$#svn_log]->{lines}) {
-					$state = 'sep';
+		if ($log->{state} eq 'msg_start' && /^$/) {
+			$log->{state} = 'msg';
+		} elsif ($log->{state} eq 'msg') {
+			if ($ret->{lines}) {
+				$ret->{msg} .= $_."\n";
+				unless (--$ret->{lines}) {
+					$log->{state} = 'sep';
 				}
 			} else {
 				croak "Log parse error at: $_\n",
-					$svn_log[$#svn_log]->{revision},"\n";
+					$ret->{revision},"\n";
 			}
 		}
 	}
-	close $log_fh or croak $?;
-	return \@svn_log;
+	return $ret;
 }
 
 sub svn_info {
@@ -1114,9 +1127,13 @@ __END__
 
 Data structures:
 
-@svn_log = array of log_msg hashes
+$svn_log hashref (as returned by svn_log_raw)
+{
+	fh => file handle of the log file,
+	state => state of the log file parser (sep/msg/rev/msg_start...)
+}
 
-$log_msg hash
+$log_msg hashref as returned by next_log_entry($svn_log)
 {
 	msg => 'whitespace-formatted log entry
 ',						# trailing newline is preserved
-- 
1.2.4.gb622a
