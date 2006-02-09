From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Allow using --cc when showing a merge.
Date: Wed, 08 Feb 2006 16:02:13 -0800
Message-ID: <7vhd79mmbe.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602081532360.2458@g5.osdl.org>
	<7vu0b9mmij.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 01:02:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6zGM-0001qx-PG
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 01:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422675AbWBIACQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 19:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422676AbWBIACP
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 19:02:15 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:38344 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1422675AbWBIACP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 19:02:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060209000040.HTFO20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Feb 2006 19:00:40 -0500
To: Kay Sievers <kay.sievers@suse.de>
In-Reply-To: <7vu0b9mmij.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 08 Feb 2006 15:57:56 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15769>


Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * This does not do the colorized diff, but just to show ideas
   where to put the link to ask for the combined diff.

 gitweb.cgi |   60 +++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 47 insertions(+), 13 deletions(-)

1f19febaefbf90dc04a6b37d79ba3a9337decaff
diff --git a/gitweb.cgi b/gitweb.cgi
index c1bb624..d2659ea 100755
--- a/gitweb.cgi
+++ b/gitweb.cgi
@@ -191,6 +191,9 @@ if (!defined $action || $action eq "summ
 } elsif ($action eq "commitdiff_plain") {
 	git_commitdiff_plain();
 	exit;
+} elsif ($action eq "combinediff") {
+	git_combinediff();
+	exit;
 } elsif ($action eq "history") {
 	git_history();
 	exit;
@@ -1762,7 +1765,15 @@ sub git_commit {
 	      "</tr>\n";
 	print "<tr><td>committer</td><td>" . esc_html($co{'committer'}) . "</td></tr>\n";
 	print "<tr><td></td><td> $cd{'rfc2822'}" . sprintf(" (%02d:%02d %s)", $cd{'hour_local'}, $cd{'minute_local'}, $cd{'tz_local'}) . "</td></tr>\n";
-	print "<tr><td>commit</td><td style=\"font-family:monospace\">$co{'id'}</td></tr>\n";
+	print "<tr><td>commit</td><td style=\"font-family:monospace\">$co{'id'}</td>";
+	if (1 < @{$co{'parents'}}) {
+		print '<td class="link">';
+		print $cgi->a({-href => "$my_uri?" .
+				   esc_param("p=$project;a=combinediff;".
+					     "h=$hash")}, "combinediff");
+		print '</td>';
+	}
+	print "</tr>\n";
 	print "<tr>" .
 	      "<td>tree</td>" .
 	      "<td style=\"font-family:monospace\">" .
@@ -2044,6 +2055,38 @@ sub git_commitdiff {
 	git_footer_html();
 }
 
+sub git_combinediff {
+	mkdir($git_temp, 0700);
+	my $fd;
+	my $refs = read_info_ref("tags");
+	open $fd, "-|", "$gitbin/git-describe $hash";
+	my ($tagname) = <$fd>;
+	chomp($tagname);
+	close $fd;
+	print $cgi->header(-type => "text/plain", -charset => 'utf-8', '-content-disposition' => "inline; filename=\"git-$hash.patch\"");
+	my %co = git_read_commit($hash);
+	my %ad = date_str($co{'author_epoch'}, $co{'author_tz'});
+	my $comment = $co{'comment'};
+	print "From: $co{'author'}\n" .
+	      "Date: $ad{'rfc2822'} ($ad{'tz_local'})\n".
+	      "Subject: $co{'title'}\n";
+	if (defined $tagname) {
+	      print "X-Git-Tag: $tagname\n";
+	}
+	print "\n";
+
+	foreach my $line (@$comment) {;
+		print "$line\n";
+	}
+	print "---\n\n";
+
+	open $fd, "-|", "$gitbin/git-diff-tree --cc $hash";
+	while (<$fd>) {
+		print $_;
+	}
+	close $fd;
+}
+
 sub git_commitdiff_plain {
 	mkdir($git_temp, 0700);
 	open my $fd, "-|", "$gitbin/git-diff-tree -r $hash_parent $hash" or die_error(undef, "Open failed.");
@@ -2051,20 +2094,11 @@ sub git_commitdiff_plain {
 	close $fd or die_error(undef, "Reading diff-tree failed.");
 
 	# try to figure out the next tag after this commit
-	my $tagname;
 	my $refs = read_info_ref("tags");
-	open $fd, "-|", "$gitbin/git-rev-list HEAD";
-	chomp (my (@commits) = <$fd>);
+	open $fd, "-|", "$gitbin/git-describe $hash";
+	my ($tagname) = <$fd>;
+	chomp($tagname);
 	close $fd;
-	foreach my $commit (@commits) {
-		if (defined $refs->{$commit}) {
-			$tagname = $refs->{$commit}
-		}
-		if ($commit eq $hash) {
-			last;
-		}
-	}
-
 	print $cgi->header(-type => "text/plain", -charset => 'utf-8', '-content-disposition' => "inline; filename=\"git-$hash.patch\"");
 	my %co = git_read_commit($hash);
 	my %ad = date_str($co{'author_epoch'}, $co{'author_tz'});
-- 
1.1.6.gbb042
