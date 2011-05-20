From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH maint] git-svn: Fix git svn log --show-commit
Date: Fri, 20 May 2011 09:49:12 +0200
Message-ID: <a9a8802cb8efa509991f7430ed7591d0b3946e88.1305877679.git.git@drmicha.warpmail.net>
References: <87y622doa7.fsf@norang.ca>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Bernt Hansen <bernt@norang.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 09:49:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNKSX-0007Qu-9Z
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 09:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932733Ab1ETHtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 03:49:16 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:50810 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932135Ab1ETHtP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2011 03:49:15 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C9EAE20CE3;
	Fri, 20 May 2011 03:49:14 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 20 May 2011 03:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=uI8ZV/srFRwBXRHJihUcQhCRRr0=; b=VUyXItNQrfs0Zn1ezeidKrCb+VTQRaZ3KlHzZ3PZvoY4WtXXoLKO8Fbp2ex1gJBZ0dlxXL5ZeGYlbzK/z4iGSO24orObyUSc0BC0+wG2nHl6VxTSNq/badMBLuT8zb5gIp6nep0OSYybLAHOk0UI6BIJNFfXQosYpIgJTPbcwXo=
X-Sasl-enc: +iATg9aR9pXAbqsAdFNwBaQLUeMhg/z1ELhx53ngGVCR 1305877754
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 41FFA4486F2;
	Fri, 20 May 2011 03:49:14 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.558.gc8bec
In-Reply-To: <87y622doa7.fsf@norang.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174048>

git svn log --show-commit had no tests and, consequently, no attention
by the author of

b1b4755 (git-log: put space after commit mark, 2011-03-10)

who kept git svn log working only without --show-commit.

Introduce a test and fix it.

Reported-by: Bernt Hansen <bernt@norang.ca>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
git svn scares me. It exits with 0 even with these problems!
Consequently, the tests in t9116 completely ignore the return codes
because of the pipes.

Patch directly on top of b1b4755. Thanks for the report!

The fix replaces a group "(- )?" by "-? ?" which works in this
case (though not being equivalent). It's easier than dealing
with the problem the grouping introduced.
---
 git-svn.perl           |    2 +-
 t/t9116-git-svn-log.sh |   15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index a5857c1..b1eef85 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -5734,7 +5734,7 @@ sub cmd_show_log {
 	my (@k, $c, $d, $stat);
 	my $esc_color = qr/(?:\033\[(?:(?:\d+;)*\d*)?m)*/;
 	while (<$log>) {
-		if (/^${esc_color}commit (- )?($::sha1_short)/o) {
+		if (/^${esc_color}commit -? ?($::sha1_short)/o) {
 			my $cmt = $1;
 			if ($c && cmt_showable($c) && $c->{r} != $r_last) {
 				$r_last = $c->{r};
diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
index 5d477e4..cf4c052 100755
--- a/t/t9116-git-svn-log.sh
+++ b/t/t9116-git-svn-log.sh
@@ -60,6 +60,21 @@ test_expect_success 'test ascending revision range' "
 	git svn log -r 1:4 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r1-r2-r4 -
 	"
 
+test_expect_success 'test ascending revision range with --show-commit' "
+	git reset --hard trunk &&
+	git svn log --show-commit -r 1:4 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r1-r2-r4 -
+	"
+
+test_expect_success 'test ascending revision range with --show-commit (sha1)' "
+	git svn find-rev r1 >expected-range-r1-r2-r4-sha1 &&
+	git svn find-rev r2 >>expected-range-r1-r2-r4-sha1 &&
+	git svn find-rev r4 >>expected-range-r1-r2-r4-sha1 &&
+	git reset --hard trunk &&
+	git svn log --show-commit -r 1:4 | grep '^r[0-9]' | cut -d'|' -f2 >out &&
+	git rev-parse \$(cat out) >actual &&
+	test_cmp expected-range-r1-r2-r4-sha1 actual
+	"
+
 printf 'r4 \nr2 \nr1 \n' > expected-range-r4-r2-r1
 
 test_expect_success 'test descending revision range' "
-- 
1.7.5.1.558.gc8bec
