From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] send-email: test compose functionality
Date: Mon, 21 Jan 2008 22:29:05 -0500
Message-ID: <20080122032905.GD24758@coredump.intra.peff.net>
References: <m2y7aj9glo.fsf@userprimary.net> <1200945466-21154-1-git-send-email-hendeby@isy.liu.se> <1200945466-21154-2-git-send-email-hendeby@isy.liu.se> <20080122031932.GA24758@coredump.intra.peff.net> <20080122032353.GB24758@coredump.intra.peff.net> <20080122032544.GC24758@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gustaf Hendeby <hendeby@isy.liu.se>,
	Seth Falcon <seth@userprimary.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 04:29:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH9pU-0006Jr-O3
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 04:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508AbYAVD3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 22:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753755AbYAVD3J
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 22:29:09 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3797 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752490AbYAVD3I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 22:29:08 -0500
Received: (qmail 30606 invoked by uid 111); 22 Jan 2008 03:29:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 21 Jan 2008 22:29:06 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Jan 2008 22:29:05 -0500
Content-Disposition: inline
In-Reply-To: <20080122032544.GC24758@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71411>

This is just a basic sanity check that --compose works at
all. Unfortunately, we have to add a --no-confirm-send
option to git-send-email to make this work, since it
otherwise unconditionally tries to talk to the terminal.

Signed-off-by: Jeff King <peff@peff.net>
---
Note that the change to git-send-email depends textually on Gustaf's
fix (actually, on my suggested version). I am not happy with adding the
--no-confirm-send option, but there just isn't any way to avoid the
readline call with the existing code short of providing a dummy perl
module in the test harness.

 git-send-email.perl   |   16 ++++++++++------
 t/t9001-send-email.sh |   27 +++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index df1c833..f265a82 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -180,6 +180,7 @@ my ($thread, $chain_reply_to, $suppress_from, $signed_off_cc, $cc_cmd);
 my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_authpass, $smtp_ssl);
 my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
 my ($no_validate);
+my ($no_confirm_send);
 
 my %config_bool_settings = (
     "thread" => [\$thread, 1],
@@ -226,6 +227,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "envelope-sender=s" => \$envelope_sender,
 		    "thread!" => \$thread,
 		    "no-validate" => \$no_validate,
+		    "no-confirm-send" => \$no_confirm_send,
 	 );
 
 unless ($rc) {
@@ -453,13 +455,15 @@ EOT
 	close(C);
 	close(C2);
 
-	do {
-		$_ = $term->readline("Send this email? (y|n) ");
-	} while (!defined $_);
+	if (!$no_confirm_send) {
+		do {
+			$_ = $term->readline("Send this email? (y|n) ");
+		} while (!defined $_);
 
-	if (uc substr($_,0,1) ne 'Y') {
-		cleanup_compose_files();
-		exit(0);
+		if (uc substr($_,0,1) ne 'Y') {
+			cleanup_compose_files();
+			exit(0);
+		}
 	}
 
 	unshift @files, "$compose_filename.final";
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index dd0c395..b1e9de5 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -114,4 +114,31 @@ test_expect_success 'allow long lines with --no-validate' '
 		2>errors
 '
 
+test_expect_success 'setup fake editor' '
+	(echo "#!/bin/sh" &&
+	 echo "echo fake edit >>\$1"
+	) >fake-editor &&
+	chmod +x fake-editor
+'
+
+test_expect_success '--compose works' '
+	clean_fake_sendmail &&
+	GIT_EDITOR=$(pwd)/fake-editor \
+	git send-email \
+		--compose --subject foo --no-confirm-send \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		$patches \
+		2>errors
+'
+
+test_expect_success 'first message is compose text' '
+	grep "^fake edit" msgtxt1
+'
+
+test_expect_success 'second message is patch' '
+	grep "Subject:.*Second" msgtxt2
+'
+
 test_done
-- 
1.5.4.rc3.1130.gd9718-dirty
