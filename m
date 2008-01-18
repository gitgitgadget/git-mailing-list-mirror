From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] send-email: validate patches before sending anything
Date: Fri, 18 Jan 2008 09:19:48 -0500
Message-ID: <20080118141948.GB19783@coredump.intra.peff.net>
References: <20080118141638.GA14928@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Piatyszek <ediap@users.sourceforge.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 15:20:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFs53-0001Vi-GH
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 15:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758792AbYAROTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 09:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758962AbYAROTv
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 09:19:51 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1447 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758455AbYAROTu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 09:19:50 -0500
Received: (qmail 18484 invoked by uid 111); 18 Jan 2008 14:19:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 18 Jan 2008 09:19:49 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Jan 2008 09:19:48 -0500
Content-Disposition: inline
In-Reply-To: <20080118141638.GA14928@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71020>

We try to catch errors early so that we don't end up sending
half of a broken patch series. Right now the only validation
is checking that line-lengths are under the SMTP-mandated
limit of 998.

The validation parsing is very crude (it just checks each
line length without understanding the mailbox format) but
should work fine for this simple check.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-send-email.perl   |   17 +++++++++++++++++
 t/t9001-send-email.sh |   20 ++++++++++++++++++++
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 7a86977..144d7d4 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -332,6 +332,11 @@ for my $f (@ARGV) {
 	}
 }
 
+foreach my $f (@files) {
+	my $error = validate_patch($f);
+	$error and die "fatal: $f: $error\nwarning: no patches were sent\n";
+}
+
 if (@files) {
 	unless ($quiet) {
 		print $_,"\n" for (@files);
@@ -837,3 +842,15 @@ sub unique_email_list(@) {
 	}
 	return @emails;
 }
+
+sub validate_patch {
+	my $fn = shift;
+	open(my $fh, '<', $fn)
+		or die "unable to open $fn: $!\n";
+	while (my $line = <$fh>) {
+		if (length($line) > 998) {
+			return "patch contains line longer than 998 characters";
+		}
+	}
+	return undef;
+}
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 659f9c7..1c41810 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -78,4 +78,24 @@ test_expect_success 'Show all headers' '
 	diff -u expected-show-all-headers actual-show-all-headers
 '
 
+z8=zzzzzzzz
+z64=$z8$z8$z8$z8$z8$z8$z8$z8
+z512=$z64$z64$z64$z64$z64$z64$z64$z64
+test_expect_success 'reject long lines' '
+	rm -f commandline &&
+	cp $patches longline.patch &&
+	echo $z512$z512 >>longline.patch &&
+	! git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		$patches longline.patch \
+		2>errors &&
+	grep longline.patch errors
+'
+
+test_expect_success 'no patch was sent' '
+	! test -e commandline
+'
+
 test_done
-- 
1.5.4.rc3.1128.g1826-dirty
