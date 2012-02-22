From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 7.2/8] diff --stat: add a test for output with COLUMNS=40
Date: Wed, 22 Feb 2012 12:51:45 +0100
Message-ID: <1329911507-10587-2-git-send-email-zbyszek@in.waw.pl>
References: <4F44D084.7030308@in.waw.pl>
 <1329911507-10587-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, pclouds@gmail.com,
	j.sixt@viscovery.net,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 22 12:52:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Ak3-0006Ga-So
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 12:52:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755443Ab2BVLwI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Feb 2012 06:52:08 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:55003 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752755Ab2BVLwH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 06:52:07 -0500
Received: from optyk25.fuw.edu.pl ([193.0.81.79] helo=ameba.fuw.edu.pl)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S0Aju-0007d7-5Y; Wed, 22 Feb 2012 12:52:06 +0100
X-Mailer: git-send-email 1.7.9.1.355.ge8a9f
In-Reply-To: <1329911507-10587-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191251>

In preparation for the introduction on the limit of the width of the
graph part, a new test with COLUMNS=3D40 is added to check that the
environment variable influences diff, show, log, but not format-patch.
A new test is added because limiting the graph part makes COLUMNS=3D200
stop influencing diff --stat behaviour, which isn't wide enough now.
The old test with COLUMNS=3D200 is retained to check for regressions.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 t/t4052-stat-output.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git t/t4052-stat-output.sh t/t4052-stat-output.sh
index c250744..84be8bd 100755
--- t/t4052-stat-output.sh
+++ t/t4052-stat-output.sh
@@ -99,6 +99,25 @@ respects expect200 show --stat
 respects expect200 log -1 --stat
 EOF
=20
+cat >expect40 <<'EOF'
+ abcd | 1000 ++++++++++++++++++++++++++
+EOF
+
+while read verb expect cmd args
+do
+	test_expect_success "$cmd $verb not enough COLUMNS (big change)" '
+		COLUMNS=3D40 git $cmd $args >output
+		grep " | " output >actual &&
+		test_cmp "$expect" actual
+	'
+done <<\EOF
+ignores expect80 format-patch -1 --stdout
+respects expect40 diff HEAD^ HEAD --stat
+respects expect40 show --stat
+respects expect40 log -1 --stat
+EOF
+
+
 cat >expect <<'EOF'
  abcd | 1000 ++++++++++++++++++++++++++
 EOF
--=20
1.7.9.1.355.ge8a9f
