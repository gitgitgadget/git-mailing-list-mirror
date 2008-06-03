From: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
Subject: [PATCH] Avoid errors from git-rev-parse in gitweb blame (take 2)
Date: Tue,  3 Jun 2008 14:58:10 +0200
Message-ID: <1212497890-4101-1-git-send-email-rgarciasuarez@gmail.com>
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 14:59:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3W6Z-000857-U4
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 14:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913AbYFCM55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 08:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752959AbYFCM55
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 08:57:57 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:51915 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752263AbYFCM54 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 08:57:56 -0400
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 503885FE53;
	Tue,  3 Jun 2008 14:57:55 +0200 (CEST)
Received: from localhost.localdomain (inv75-3-82-241-119-67.fbx.proxad.net [82.241.119.67])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 375C65FE3F;
	Tue,  3 Jun 2008 14:57:55 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83650>

git-rev-parse will abort with an error message on stderr when passed a
non-existent revision spec, such as "deadbeef^" where deadbeef has no
parent. Using the --revs-only parameter makes this error go away, while
retaining functionality, keeping the web server error log nice and clean.

Moreover, when there is no parent commit, direct the blame at the first
commit featuring the file, that is itself. This unbreaks the link on the
line number when the corresponding line had never been modified.

Finally, to avoid forking git-rev-parse too many times, cache its
results in a new hash %parent_commits.

Signed-off-by: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
---
 gitweb/gitweb.perl |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 55fb100..828cf45 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4189,6 +4189,7 @@ sub git_blame2 {
 <tr><th>Commit</th><th>Line</th><th>Data</th></tr>
 HTML
 	my %metainfo = ();
+	my %parent_commits = ();
 	while (1) {
 		$_ = <$fd>;
 		last unless defined $_;
@@ -4226,11 +4227,16 @@ HTML
 			              esc_html($rev));
 			print "</td>\n";
 		}
-		open (my $dd, "-|", git_cmd(), "rev-parse", "$full_rev^")
-			or die_error(undef, "Open git-rev-parse failed");
-		my $parent_commit = <$dd>;
-		close $dd;
-		chomp($parent_commit);
+		if (!exists $parent_commits{$full_rev}) {
+		    # --revs-only avoids an error message if $full_rev has no parent
+		    open (my $dd, "-|", git_cmd(), "rev-parse", '--revs-only', "$full_rev^")
+			    or die_error(undef, "Open git-rev-parse failed");
+		    # set the $parent_commit to $full_rev if it has no parent
+		    $parent_commits{$full_rev} = <$dd> || $full_rev;
+		    chomp($parent_commits{$full_rev});
+		    close $dd;
+		}
+		my $parent_commit = $parent_commits{$full_rev};
 		my $blamed = href(action => 'blame',
 		                  file_name => $meta->{'filename'},
 		                  hash_base => $parent_commit);
-- 
1.5.6.rc1
