From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2] git-remote-mediawiki: allow push to set MediaWiki metadata
Date: Thu,  1 Sep 2011 18:54:56 +0200
Message-ID: <1314896096-17544-3-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq39ggomtu.fsf@bauges.imag.fr>
 <1314896096-17544-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 01 18:55:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzAY3-0005p5-8i
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 18:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755315Ab1IAQzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 12:55:22 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34333 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752674Ab1IAQzS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 12:55:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p81GsTKQ005098
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 1 Sep 2011 18:54:29 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1QzAXq-0003Ar-9a; Thu, 01 Sep 2011 18:55:14 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1QzAXq-0004Zs-8Q; Thu, 01 Sep 2011 18:55:14 +0200
X-Mailer: git-send-email 1.7.7.rc0.75.g56f27
In-Reply-To: <1314896096-17544-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 01 Sep 2011 18:54:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p81GsTKQ005098
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1315500870.55238@+mS1qxphC8MyXzO8fi70vQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180546>

Push can not set the commit note "mediawiki_revision:" and update the
remote reference. This avoids having to "git pull --rebase" after each
push, and is probably more natural. Make it the default, but let it be
configurable with mediawiki.dumbPush or remote.<remotename>.dumbPush.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki |   35 ++++++++++++++++++++++++++++++-
 1 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index d4d1198..0ba88de 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -84,6 +84,27 @@ my $shallow_import = run_git("config --get --bool remote.". $remotename .".shall
 chomp($shallow_import);
 $shallow_import = ($shallow_import eq "true");
 
+# Dumb push: don't update notes and mediawiki ref to reflect the last push.
+#
+# Configurable with mediawiki.dumbPush, or per-remote with
+# remote.<remotename>.dumbPush.
+#
+# This means the user will have to re-import the just-pushed
+# revisions. On the other hand, this means that the Git revisions
+# corresponding to MediaWiki revisions are all imported from the wiki,
+# regardless of whether they were initially created in Git or from the
+# web interface, hence all users will get the same history (i.e. if
+# the push from Git to MediaWiki loses some information, everybody
+# will get the history with information lost). If the import is
+# deterministic, this means everybody gets the same sha1 for each
+# MediaWiki revision.
+my $dumb_push = run_git("config --get --bool remote.$remotename.dumbPush");
+unless ($dumb_push) {
+	$dumb_push = run_git("config --get --bool mediawiki.dumbPush");
+}
+chomp($dumb_push);
+$dumb_push = ($dumb_push eq "true");
+
 my $wiki_name = $url;
 $wiki_name =~ s/[^\/]*:\/\///;
 
@@ -598,6 +619,9 @@ sub mw_push_file {
 	my $complete_file_name = shift;
 	# Commit message
 	my $summary = shift;
+	# MediaWiki revision number. Keep the previous one by default,
+	# in case there's no edit to perform.
+	my $newrevid = shift;
 
 	my $new_sha1 = $diff_info_split[3];
 	my $old_sha1 = $diff_info_split[2];
@@ -631,10 +655,12 @@ sub mw_push_file {
 				  }) || die 'Fatal: Error ' .
 				  $mediawiki->{error}->{code} .
 				  ' from mediwiki: ' . $mediawiki->{error}->{details};
+		$newrevid = $result->{edit}->{newrevid};
 		print STDERR "Pushed file : $new_sha1 - $title\n";
 	} else {
 		print STDERR "$complete_file_name not a mediawiki file (Not pushable on this version of git-remote-mediawiki).\n"
 	}
+	return $newrevid;
 }
 
 sub mw_push {
@@ -666,7 +692,7 @@ sub mw_push {
 	# Notify Git that the push is done
 	print STDOUT "\n";
 
-	if ($pushed) {
+	if ($pushed && $dumb_push) {
 		print STDERR "Just pushed some revisions to MediaWiki.\n";
 		print STDERR "The pushed revisions now have to be re-imported, and your current branch\n";
 		print STDERR "needs to be updated with these re-imported commits. You can do this with\n";
@@ -682,6 +708,7 @@ sub mw_push_revision {
 	my $last_local_revid = get_last_local_revision();
 	print STDERR ".\n"; # Finish sentence started by get_last_local_revision()
 	my $last_remote_revid = get_last_remote_revision();
+	my $mw_revision = $last_remote_revid;
 
 	# Get sha1 of commit pointed by local HEAD
 	my $HEAD_sha1 = run_git("rev-parse $local 2>/dev/null"); chomp($HEAD_sha1);
@@ -747,7 +774,11 @@ sub mw_push_revision {
 			# and we've split on \0.
 			my $info = shift(@diff_info_list);
 			my $file = shift(@diff_info_list);
-			mw_push_file($info, $file, $commit_msg);
+			$mw_revision = mw_push_file($info, $file, $commit_msg, $mw_revision);
+		}
+		unless ($dumb_push) {
+			run_git("notes --ref=$remotename/mediawiki add -m \"mediawiki_revision: $mw_revision\" $sha1_commit");
+			run_git("update-ref -m \"Git-MediaWiki push\" refs/mediawiki/$remotename/master $sha1_commit $sha1_child");
 		}
 	}
 
-- 
1.7.7.rc0.75.g56f27
