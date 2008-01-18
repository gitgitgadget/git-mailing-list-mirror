From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] send-email: add no-validate option
Date: Fri, 18 Jan 2008 09:20:10 -0500
Message-ID: <20080118142010.GC19783@coredump.intra.peff.net>
References: <20080118141638.GA14928@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Piatyszek <ediap@users.sourceforge.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 15:20:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFs5M-0001ck-QW
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 15:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759227AbYAROUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 09:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758982AbYAROUO
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 09:20:14 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1453 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758643AbYAROUM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 09:20:12 -0500
Received: (qmail 18517 invoked by uid 111); 18 Jan 2008 14:20:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 18 Jan 2008 09:20:11 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Jan 2008 09:20:10 -0500
Content-Disposition: inline
In-Reply-To: <20080118141638.GA14928@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71022>

Since we are now sanity-checking the contents of patches and
refusing to send ones with long lines, this knob provides a
way for the user to override the new behavior (if, e.g., he
knows his SMTP path will handle it).

Signed-off-by: Jeff King <peff@peff.net>
---
 git-send-email.perl   |   12 +++++++++---
 t/t9001-send-email.sh |   10 ++++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 144d7d4..39e0222 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -100,6 +100,8 @@ Options:
 
    --envelope-sender	Specify the envelope sender used to send the emails.
 
+   --no-validate	Don't perform any sanity checks on patches.
+
 EOT
 	exit(1);
 }
@@ -177,6 +179,7 @@ my ($quiet, $dry_run) = (0, 0);
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_cc, $cc_cmd);
 my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_authpass, $smtp_ssl);
 my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
+my ($no_validate);
 
 my %config_bool_settings = (
     "thread" => [\$thread, 1],
@@ -222,6 +225,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "dry-run" => \$dry_run,
 		    "envelope-sender=s" => \$envelope_sender,
 		    "thread!" => \$thread,
+		    "no-validate" => \$no_validate,
 	 );
 
 unless ($rc) {
@@ -332,9 +336,11 @@ for my $f (@ARGV) {
 	}
 }
 
-foreach my $f (@files) {
-	my $error = validate_patch($f);
-	$error and die "fatal: $f: $error\nwarning: no patches were sent\n";
+if (!$no_validate) {
+	foreach my $f (@files) {
+		my $error = validate_patch($f);
+		$error and die "fatal: $f: $error\nwarning: no patches were sent\n";
+	}
 }
 
 if (@files) {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 1c41810..4f6822f 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -98,4 +98,14 @@ test_expect_success 'no patch was sent' '
 	! test -e commandline
 '
 
+test_expect_success 'allow long lines with --no-validate' '
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--no-validate \
+		$patches longline.patch \
+		2>errors
+'
+
 test_done
-- 
1.5.4.rc3.1128.g1826-dirty
