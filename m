From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] send-email: Refuse to send cover-letter template subject
Date: Mon,  8 Jun 2009 23:34:12 +0200
Message-ID: <7fedc4b76fed03e4db6a2bb7453609c9cd02928a.1244496564.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 08 23:35:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDmUe-0007fk-U6
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 23:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757015AbZFHVeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 17:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756211AbZFHVeQ
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 17:34:16 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:24346 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756971AbZFHVeO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 17:34:14 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 8 Jun 2009 23:33:59 +0200
Received: from localhost.localdomain ([77.58.128.129]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 8 Jun 2009 23:33:59 +0200
X-Mailer: git-send-email 1.6.3.2.335.gc04d
X-OriginalArrivalTime: 08 Jun 2009 21:33:59.0399 (UTC) FILETIME=[D59BDF70:01C9E880]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121113>

Every so often, someone sends out an unedited cover-letter template.
Add a simple check to send-email that refuses to send if the subject
contains "*** SUBJECT HERE ***", with an option --force to override.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-send-email.perl   |   15 +++++++++++++++
 t/t9001-send-email.sh |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 3d6a982..293ee46 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -82,6 +82,7 @@
     --[no-]validate                * Perform patch sanity checks. Default on.
     --[no-]format-patch            * understand any non optional arguments as
                                      `git format-patch` ones.
+    --force                        * Send even if safety checks would prevent it.
 
 EOT
 	exit(1);
@@ -159,6 +160,7 @@
 my ($quiet, $dry_run) = (0, 0);
 my $format_patch;
 my $compose_filename;
+my $force = 0;
 
 # Handle interactive edition of files.
 my $multiedit;
@@ -268,6 +270,7 @@
 		    "thread!" => \$thread,
 		    "validate!" => \$validate,
 		    "format-patch!" => \$format_patch,
+		    "force" => \$force,
 	 );
 
 unless ($rc) {
@@ -638,6 +641,18 @@ sub get_patch_subject($) {
 	return undef;
 }
 
+
+if (!$force) {
+	for my $f (@files) {
+		if (get_patch_subject($f) =~ /\*\*\* SUBJECT HERE \*\*\*/) {
+			die "Refusing to send because the patch\n\t$f\n"
+				. "has the template subject '*** SUBJECT HERE ***'. "
+				. "Pass --force if you really want to send.\n";
+		}
+	}
+
+}
+
 my $prompting = 0;
 if (!defined $sender) {
 	$sender = $repoauthor || $repocommitter || '';
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index ce26ea4..af5e73e 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -621,4 +621,40 @@ test_expect_success 'in-reply-to but no threading' '
 	grep "In-Reply-To: <in-reply-id@example.com>"
 '
 
+# Note that the patches in this test are deliberately out of order; we
+# want to make sure it works even if the cover-letter is not in the
+# first mail.
+test_expect_success 'refusing to send cover letter template' '
+	clean_fake_sendmail &&
+	rm -fr outdir &&
+	git-format-patch --cover-letter -2 -o outdir &&
+	test_must_fail git send-email \
+	  --from="Example <nobody@example.com>" \
+	  --to=nobody@example.com \
+	  --smtp-server="$(pwd)/fake.sendmail" \
+	  outdir/0002-*.patch \
+	  outdir/0000-*.patch \
+	  outdir/0001-*.patch \
+          2>errors >out &&
+	grep "SUBJECT HERE" errors &&
+	test -z "$(ls msgtxt*)"
+'
+
+test_expect_success '--force sends cover letter template anyway' '
+	clean_fake_sendmail &&
+	rm -fr outdir &&
+	git-format-patch --cover-letter -2 -o outdir &&
+	git send-email \
+	  --force \
+	  --from="Example <nobody@example.com>" \
+	  --to=nobody@example.com \
+	  --smtp-server="$(pwd)/fake.sendmail" \
+	  outdir/0002-*.patch \
+	  outdir/0000-*.patch \
+	  outdir/0001-*.patch \
+          2>errors >out &&
+	! grep "SUBJECT HERE" errors &&
+	test -n "$(ls msgtxt*)"
+'
+
 test_done
-- 
1.6.3.2.335.gc04d
