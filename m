From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH v7 08/11] diff --stat: add a test for output with COLUMNS=40
Date: Fri, 24 Feb 2012 21:32:15 +0100
Message-ID: <1330115538-1576-8-git-send-email-zbyszek@in.waw.pl>
References: <4F47F394.5070007@in.waw.pl>
 <1330115538-1576-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, pclouds@gmail.com,
	j.sixt@viscovery.net,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 24 21:36:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S11sZ-0002Iw-FQ
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 21:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757188Ab2BXUgb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Feb 2012 15:36:31 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:55120 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755665Ab2BXUga (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 15:36:30 -0500
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S11sT-00042s-Ka; Fri, 24 Feb 2012 21:36:29 +0100
X-Mailer: git-send-email 1.7.9.2.332.g05f13
In-Reply-To: <1330115538-1576-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191468>

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

diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index c250744..84be8bd 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
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
1.7.9.2.332.g05f13
