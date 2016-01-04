From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH v2] git-send-email: do not double-escape quotes from mutt
Date: Mon, 4 Jan 2016 20:53:30 +0000
Message-ID: <20160104205330.GA6658@dcvr.yhbt.net>
References: <20151227020810.1450-1-normalperson@yhbt.net>
 <vpqsi2dxlht.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 21:53:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGC8F-0004gd-T6
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 21:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274AbcADUxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 15:53:31 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:57822 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752356AbcADUxa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 15:53:30 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AB2620208;
	Mon,  4 Jan 2016 20:53:30 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <vpqsi2dxlht.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283323>

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
  Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
  > I think you meant "remove the escaping" or simply "unescape", not
  > "remove them", which I'd understand as "remove the quotes".
  > 
  > Other than that, the patch looks good to me, including your proposed
  > fixup:

  Thanks, updated the comment and squashed my fixup

  > I wouldn't worry too much about corner-cases, but perhaps some people do
  > use escaped quotes inside escaped quotes. I'd say they get what they
  > deserve ;-).

  Agreed :)

 git-send-email.perl   |  9 +++++++--
 t/t9001-send-email.sh | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 6caa5b5..d356901 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -524,8 +524,13 @@ my %parse_alias = (
 		if (/^\s*alias\s+(?:-group\s+\S+\s+)*(\S+)\s+(.*)$/) {
 			my ($alias, $addr) = ($1, $2);
 			$addr =~ s/#.*$//; # mutt allows # comments
-			 # commas delimit multiple addresses
-			$aliases{$alias} = [ split_addrs($addr) ];
+			# commas delimit multiple addresses
+			my @addr = split_addrs($addr);
+
+			# quotes may be escaped in the file,
+			# unescape them so we do not double-escape them later.
+			s/\\"/"/g foreach @addr;
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
