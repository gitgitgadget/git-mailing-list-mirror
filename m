From: Johannes Gilger <heipei@hackvalue.de>
Subject: [PATCH] Test for correct behaviour on %B(1) and %B(-1)
Date: Wed, 23 Sep 2009 15:12:44 +0200
Message-ID: <1253711564-17876-1-git-send-email-heipei@hackvalue.de>
References: <7vmy4mo85b.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Gilger <heipei@hackvalue.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 23 15:13:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqRfF-0003fZ-BT
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 15:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbZIWNNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 09:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbZIWNNf
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 09:13:35 -0400
Received: from avalon.gnuzifer.de ([78.46.211.2]:33586 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbZIWNNe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 09:13:34 -0400
Received: from u-6-181.vpn.rwth-aachen.de ([137.226.102.181]:37577 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <heipei@hackvalue.de>)
	id 1MqRew-0000DB-9I; Wed, 23 Sep 2009 15:13:26 +0200
X-Mailer: git-send-email 1.6.5.rc1.38.g1fbd3
In-Reply-To: <7vmy4mo85b.fsf@alter.siamese.dyndns.org>
X-Verified-Sender: yes
X-SA-Exim-Connect-IP: 137.226.102.181
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128981>

Small test for correct indentation of the new %B tag (and whether
negative values are ignored as an incorrect placeholder).

Signed-off-by: Johannes Gilger <heipei@hackvalue.de>
---
Hi Junio,

seeing as the %B-patch is in your pu you seem to be almost happy with it. It's 
marked NEEDSWORK: tests, so I thought I give that a try too. Probably best to 
be squashed with the other one.

Greetings,
Jojo

 t/t4202-log.sh |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 1e952ca..9b7825d 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -32,8 +32,9 @@ test_expect_success setup '
 	git commit -m fifth  &&
 
 	git rm a/two &&
+	echo -e "sixth\n\nlineone\nlinetwo" >sixth &&
 	test_tick &&
-	git commit -m sixth
+	git commit -F sixth
 
 '
 
@@ -63,8 +64,15 @@ test_expect_success 'format' '
 	test_cmp expect actual
 '
 
+printf "sixth\n\n lineone\n linetwo\n%%B(-1)\n" > expect
+test_expect_success 'format (subject %s, body %B(1), %B(-1))' '
+
+	git log --format="%s%n%n%B(1)%n%B(-1)" 394ef78..5821e35 > actual &&
+	test_cmp expect actual
+'
+
 cat > expect << EOF
-804a787 sixth
+5821e35 sixth
 394ef78 fifth
 5d31159 fourth
 2fbe8c0 third
@@ -150,22 +158,22 @@ test_expect_success 'git log --follow' '
 '
 
 cat > expect << EOF
-804a787 sixth
+5821e35 sixth
 394ef78 fifth
 5d31159 fourth
 EOF
 test_expect_success 'git log --no-walk <commits> sorts by commit time' '
-	git log --no-walk --oneline 5d31159 804a787 394ef78 > actual &&
+	git log --no-walk --oneline 5d31159 5821e35 394ef78 > actual &&
 	test_cmp expect actual
 '
 
 cat > expect << EOF
 5d31159 fourth
-804a787 sixth
+5821e35 sixth
 394ef78 fifth
 EOF
 test_expect_success 'git show <commits> leaves list of commits as given' '
-	git show --oneline -s 5d31159 804a787 394ef78 > actual &&
+	git show --oneline -s 5d31159 5821e35 394ef78 > actual &&
 	test_cmp expect actual
 '
 
-- 
1.6.5.rc1.38.g1fbd3
