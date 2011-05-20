From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 maint] git-svn: Fix git svn log --show-commit
Date: Fri, 20 May 2011 13:16:34 +0200
Message-ID: <3dd919897d4a5eca34f421457cc8da461574ee78.1305890184.git.git@drmicha.warpmail.net>
References: <87y622doa7.fsf@norang.ca>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Bernt Hansen <bernt@norang.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 13:16:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNNhD-0000UG-Pp
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 13:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935420Ab1ETLQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 07:16:38 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:39279 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935149Ab1ETLQh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2011 07:16:37 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7D1B420658;
	Fri, 20 May 2011 07:16:36 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 20 May 2011 07:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=N7iAV3it+z7RaOLer255pSKzSaM=; b=Sm3/6lKhJcX8jfBx7ULWklAf5tp8CyX04qL7C+oDPEP64WPn1Sh2dD9B5fnX7GUDxXE8yCR6bytdUgTKNixzskL7UXkkPRedQFZaGaYfuydtbfqtfkR/aGnGDKZ66tdoL9KJPUp1xEa0ozK+/tuhby3GR/bnBlOPvw/z+kvuwxg=
X-Sasl-enc: G2IRN+MZs/z0Pl6QBNtSni2OEJkjEDGcHHcbtYBelO2n 1305890196
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F202E409096;
	Fri, 20 May 2011 07:16:35 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.558.gc8bec
In-Reply-To: <87y622doa7.fsf@norang.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174055>

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

v2 uses the grouped regexp again. I've learned to count to 2 meanwhile.
---
 git-svn.perl           |    2 +-
 t/t9116-git-svn-log.sh |   15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index a5857c1..0cee0e9 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -5735,7 +5735,7 @@ sub cmd_show_log {
 	my $esc_color = qr/(?:\033\[(?:(?:\d+;)*\d*)?m)*/;
 	while (<$log>) {
 		if (/^${esc_color}commit (- )?($::sha1_short)/o) {
-			my $cmt = $1;
+			my $cmt = $2;
 			if ($c && cmt_showable($c) && $c->{r} != $r_last) {
 				$r_last = $c->{r};
 				process_commit($c, $r_min, $r_max, \@k) or
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
