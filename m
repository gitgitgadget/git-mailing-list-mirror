From: Eric Wong <normalperson@yhbt.net>
Subject: [RFC] git-send-email: do not double-escape quotes from mutt
Date: Sun, 27 Dec 2015 02:08:10 +0000
Message-ID: <20151227020810.1450-1-normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 27 03:08:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aD0lA-0003gm-L4
	for gcvg-git-2@plane.gmane.org; Sun, 27 Dec 2015 03:08:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754394AbbL0CIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Dec 2015 21:08:31 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:51530 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754366AbbL0CIa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2015 21:08:30 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 715331F724;
	Sun, 27 Dec 2015 02:08:29 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283009>

mutt saves aliases with escaped quotes in the form of:

	alias dot \"Dot U. Sir\" <somebody@example.org>

When we pass through our sanitize_address routine,
we end up with double-escaping:

	 To: "\\\"Dot U. Sir\\\" <somebody@example.org>

Remove the escaping in mutt only for now, as I am not sure
if other mailers can do this or if this is better fixed in
sanitize_address.

Cc: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Cc-ing Remi and Matthieu since they might know better
 about fixing this in sanitize_address instead or if it's
 better being a one-off for mutt.

 git-send-email.perl   | 10 ++++++++--
 t/t9001-send-email.sh | 15 +++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index c2abdaa..2d3f51e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -524,8 +524,14 @@ my %parse_alias = (
 		if (/^\s*alias\s+(?:-group\s+\S+\s+)*(\S+)\s+(.*)$/) {
 			my ($alias, $addr) = ($1, $2);
 			$addr =~ s/#.*$//; # mutt allows # comments
-			 # commas delimit multiple addresses
-			$aliases{$alias} = [ split_addrs($addr) ];
+			# commas delimit multiple addresses
+			my @addr = split_addrs($addr);
+
+			# quotes may be escaped in the file,
+			# remove them if paired so we do not
+			# double-escape them later.
+			s/^\\"(.*)\\"/"$1"/g foreach @addr;
+			$aliases{$alias} = \@addr
 		}}},
 	mailrc => sub { my $fh = shift; while (<$fh>) {
 		if (/^alias\s+(\S+)\s+(.*)$/) {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 3c49536..834d91a 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1527,6 +1527,21 @@ test_expect_success $PREREQ 'cccover adds Cc to all mail' '
 	test_cover_addresses "Cc"
 '
 
+test_expect_success $PREREQ 'escaped quotes in sendemail.aliasfiletype=mutt' '
+	clean_fake_sendmail &&
+	echo "alias sbd \\\"Dot U. Sir\\\" <somebody@example.org>" >.mutt &&
+	git config --replace-all sendemail.aliasesfile "$(pwd)/.mutt" &&
+	git config sendemail.aliasfiletype mutt &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=sbd \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		outdir/0001-*.patch \
+		2>errors >out &&
+	grep "^!somebody@example\.org!$" commandline1 &&
+	grep -F "To: \"Dot U. Sir\" <somebody@example.org>" out
+'
+
 test_expect_success $PREREQ 'sendemail.aliasfiletype=mailrc' '
 	clean_fake_sendmail &&
 	echo "alias sbd  somebody@example.org" >.mailrc &&
-- 
EW
