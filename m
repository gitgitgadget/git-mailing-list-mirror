From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/3] git-remote-mediawiki: set 'basetimestamp' to let the wiki handle conflicts
Date: Tue, 27 Sep 2011 19:54:59 +0200
Message-ID: <1317146100-22938-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1317146100-22938-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 27 19:55:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8bsH-00054a-A7
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 19:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159Ab1I0RzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 13:55:17 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55088 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751595Ab1I0RzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 13:55:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p8RHqv8e003352
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 27 Sep 2011 19:52:57 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1R8bs3-0008V7-DH; Tue, 27 Sep 2011 19:55:07 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1R8bs3-0005yh-Bp; Tue, 27 Sep 2011 19:55:07 +0200
X-Mailer: git-send-email 1.7.7.rc0.75.g56f27
In-Reply-To: <1317146100-22938-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 27 Sep 2011 19:52:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p8RHqv8e003352
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1317750781.1018@od/IyfH8Dp8F6WArq1gf/Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182257>

We already have a check that no new revisions are on the wiki at the
beginning of the push, but this didn't handle concurrent accesses to the
wiki.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki |   43 +++++++++++++++++++++++++++----
 1 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index 768b42d..9bb58ab 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -287,6 +287,9 @@ sub get_last_local_revision {
 	return $lastrevision_number;
 }
 
+# Remember the timestamp corresponding to a revision id.
+my %basetimestamps;
+
 sub get_last_remote_revision {
 	mw_connect_maybe();
 
@@ -300,7 +303,7 @@ sub get_last_remote_revision {
 		my $query = {
 			action => 'query',
 			prop => 'revisions',
-			rvprop => 'ids',
+			rvprop => 'ids|timestamp',
 			pageids => $id,
 		};
 
@@ -308,6 +311,8 @@ sub get_last_remote_revision {
 
 		my $lastrev = pop(@{$result->{query}->{pages}->{$id}->{revisions}});
 
+		$basetimestamps{$lastrev->{revid}} = $lastrev->{timestamp};
+
 		$max_rev_num = ($lastrev->{revid} > $max_rev_num ? $lastrev->{revid} : $max_rev_num);
 	}
 
@@ -649,18 +654,32 @@ sub mw_push_file {
 			action => 'edit',
 			summary => $summary,
 			title => $title,
+			basetimestamp => $basetimestamps{$newrevid},
 			text => mediawiki_clean($file_content, $page_created),
 				  }, {
 					  skip_encoding => 1 # Helps with names with accentuated characters
-				  }) || die 'Fatal: Error ' .
-				  $mediawiki->{error}->{code} .
-				  ' from mediwiki: ' . $mediawiki->{error}->{details};
+				  });
+		if (!$result) {
+			if ($mediawiki->{error}->{code} == 3) {
+				# edit conflicts, considered as non-fast-forward
+				print STDERR 'Warning: Error ' .
+				    $mediawiki->{error}->{code} .
+				    ' from mediwiki: ' . $mediawiki->{error}->{details} .
+				    ".\n";
+				return ($newrevid, "non-fast-forward");
+			} else {
+				# Other errors. Shouldn't happen => just die()
+				die 'Fatal: Error ' .
+				    $mediawiki->{error}->{code} .
+				    ' from mediwiki: ' . $mediawiki->{error}->{details};
+			}
+		}
 		$newrevid = $result->{edit}->{newrevid};
 		print STDERR "Pushed file: $new_sha1 - $title\n";
 	} else {
 		print STDERR "$complete_file_name not a mediawiki file (Not pushable on this version of git-remote-mediawiki).\n"
 	}
-	return $newrevid;
+	return ($newrevid, "ok");
 }
 
 sub mw_push {
@@ -767,13 +786,25 @@ sub mw_push_revision {
 		chomp($commit_msg);
 		# Push every blob
 		while (@diff_info_list) {
+			my $status;
 			# git diff-tree -z gives an output like
 			# <metadata>\0<filename1>\0
 			# <metadata>\0<filename2>\0
 			# and we've split on \0.
 			my $info = shift(@diff_info_list);
 			my $file = shift(@diff_info_list);
-			$mw_revision = mw_push_file($info, $file, $commit_msg, $mw_revision);
+			($mw_revision, $status) = mw_push_file($info, $file, $commit_msg, $mw_revision);
+			if ($status eq "non-fast-forward") {
+				# we may already have sent part of the
+				# commit to MediaWiki, but it's too
+				# late to cancel it. Stop the push in
+				# the middle, but still give an
+				# accurate error message.
+				return error_non_fast_forward($remote);
+			}
+			if ($status ne "ok") {
+				die("Unknown error from mw_push_file()");
+			}
 		}
 		unless ($dumb_push) {
 			run_git("notes --ref=$remotename/mediawiki add -m \"mediawiki_revision: $mw_revision\" $sha1_commit");
-- 
1.7.7.rc0.75.g56f27
