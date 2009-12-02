From: Alex Vandiver <alex@chmrr.net>
Subject: [PATCH 3/5] git-svn: Strip SVK headers, optionally parsing author information
Date: Wed,  2 Dec 2009 14:07:52 -0500
Message-ID: <1259780874-14706-4-git-send-email-alex@chmrr.net>
References: <1259780874-14706-1-git-send-email-alex@chmrr.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 20:38:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFv1v-0007t6-RJ
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 20:38:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755581AbZLBThj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 14:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752866AbZLBThi
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 14:37:38 -0500
Received: from chmrr.net ([209.67.253.66]:56888 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755571AbZLBThf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 14:37:35 -0500
Received: from 75-147-59-54-newengland.hfc.comcastbusiness.net ([75.147.59.54] helo=localhost.localdomain)
	by utwig.chmrr.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <alex@chmrr.net>)
	id 1NFuYm-0004Rd-Oa
	for git@vger.kernel.org; Wed, 02 Dec 2009 14:08:24 -0500
X-Mailer: git-send-email 1.6.6.rc0.327.g032bc
In-Reply-To: <1259780874-14706-1-git-send-email-alex@chmrr.net>
X-Authenticated-User: chmrr
X-Authenticator: plain
X-Sender-Verify: SUCCEEDED (sender exists & accepts mail)
X-Exim-Version: 4.69 (build at 07-Feb-2009 20:08:51)
X-Date: 2009-12-02 14:08:24
X-Connected-IP: 75.147.59.54:47077
X-Message-Linecount: 152
X-Body-Linecount: 143
X-Message-Size: 5371
X-Body-Size: 4948
X-Received-Count: 1
X-Recipient-Count: 1
X-Local-Recipient-Count: 1
X-Local-Recipient-Defer-Count: 0
X-Local-Recipient-Fail-Count: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134384>

SVK adds additional headers (often nested arbitrarily) detailing
information on the local commit.  When possible, strip these headers
so that the first line of git's commit message is actually descriptive
of the commit.

Additionally, these headers contain information about the original
author's username, and their local commit time.  If the
--use-log-author flag is set, use this information to set the
information on the git commit.  Note that the username thus extracted
may be a _local_ username, and thus may require additional, somewhat
unexpected, entries in the authors file.

Signed-off-by: Alex Vandiver <alex@chmrr.net>
---
 git-svn.perl |   98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 5337326..0731425 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3110,7 +3110,8 @@ sub make_log_entry {
 	close $un or croak $!;
 
 	$log_entry{date} = parse_svn_date($log_entry{date});
-	$log_entry{log} .= "\n";
+	parse_svk_log(\%log_entry) if $log_entry{log} =~ svk_header_regex( lenient => 1 );
+
 	my $author = $log_entry{author} = check_author($log_entry{author});
 	my ($name, $email) = defined $::users{$author} ? @{$::users{$author}}
 						       : ($author, undef);
@@ -3118,7 +3119,15 @@ sub make_log_entry {
 	my ($commit_name, $commit_email) = ($name, $email);
 	if ($_use_log_author) {
 		my $name_field;
-		if ($log_entry{log} =~ /From:\s+(.*\S)\s*\n/i) {
+		if ($log_entry{log_author}) {
+			$log_entry{commit_date} = $log_entry{date};
+			$log_entry{date} = $log_entry{log_author_date};
+			$log_entry{log_author} = check_author($log_entry{log_author});
+			my ($log_author_name, $log_author_email)
+			    = defined $::users{$log_entry{log_author}} ? @{$::users{$log_entry{log_author}}}
+			        : ($log_entry{log_author}, undef);
+			$name_field = "$log_author_name <$log_author_email>";
+		} elsif ($log_entry{log} =~ /From:\s+(.*\S)\s*\n/i) {
 			$name_field = $1;
 		} elsif ($log_entry{log} =~ /Signed-off-by:\s+(.*\S)\s*\n/i) {
 			$name_field = $1;
@@ -3182,6 +3191,91 @@ sub make_log_entry {
 	\%log_entry;
 }
 
+sub svk_header_regex {
+	my %args = ( lenient => 0, orig => 0, @_ );
+	my $orig = $args{orig} ? qr/ \(orig r\d+\)/ : "";
+	my $atstart = "";
+	if ($args{lenient}) {
+		$atstart = qr/\s*/;
+		$orig = qr/(?: \(orig r\d+\))?/;
+	}
+	return qr/^${atstart}r\d+\@\S+$orig:\s*(\S+)\s*\|\s*(.*?)\s*([+-]\d+)$/m;
+}
+
+sub parse_svk_log {
+	my $log_entry = shift;
+	my $log = $log_entry->{log};
+
+	# Strip off blank lines at the start and end
+	$log =~ s/^(\s*?\n)+//;
+	$log =~ s/\s*$//;
+
+	# If each line starts with a space, this might be an
+	# unmodified SVK log format.  As a side effect, this also
+	# trims the leading space off of the lines.
+	my $lines = $log =~ s/^//mg;
+	my $spaced = $log =~ s/^ //mg;
+	return unless $lines == $spaced;
+
+	my $regex = svk_header_regex( orig => 1 );
+	if ($log =~ /\A$regex/) {
+		# This is either a merge commit, or a base-less merge
+		# (replay from a different repository) The \A assures
+		# that this is an _unedited_ merge commit with no
+		# hand-supplied log message.
+		if (@{$log_entry->{merged_branches} || []}) {
+			# This is a merge with no description; provide
+			# one.
+			$log_entry->{log} = "Merge from @{$log_entry->{merged_branches}}\n\n$log";
+		} else {
+			my $commits = 0;
+			$commits++ while $log =~ /$regex/g;
+			if ($commits == 1) {
+				# This is a baseless merge of one
+				# commit; strip off the original
+				# commit info
+				$log_entry->{log_author} = $1;
+				$log_entry->{log_author_date} = "$3 $2";
+				$log =~ s/\A$regex\n*//;
+				$log_entry->{log} = $log;
+				parse_svk_log($log_entry);
+			} else {
+				# A lump baseless merge?  Remove all
+				# of the SVK headers on this level,
+				# and add a summary.  Trailing
+				# newlines on the svk header lines are
+				# left unmolested, so they become
+				# blank lines.
+				$log =~ s/$regex//g;
+				$log_entry->{log} = "Lump commit\n$log";
+			}
+		}
+	} else {
+		# Look for svk header lines without the (orig r12345),
+		# which were local commits.
+		$regex = svk_header_regex();
+		my $commits = 0;
+		$commits++ while $log =~ /$regex/g;
+		if ($commits == 0) {
+			# No more svk-like commits; don't change anything.
+		} elsif ($commits == 1) {
+			# Only one top-level commit-like object; strip
+			# it off, recurse down.
+			$log_entry->{log_author} = $1;
+			$log_entry->{log_author_date} = "$3 $2";
+			$log =~ s/$regex\n*//;
+			$log_entry->{log} = $log;
+			parse_svk_log($log_entry);
+		} else {
+			# This is a lump push of local commits.	 Strip
+			# off all of the svk headers in this level,
+			# and call it quits.
+			$log =~ s/$regex//g;
+			$log_entry->{log} = $log;
+		}
+	}
+}
+
 sub fetch {
 	my ($self, $min_rev, $max_rev, @parents) = @_;
 	my ($last_rev, $last_commit) = $self->last_rev_commit;
-- 
1.6.6.rc0.327.g032bc
