From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] config: Fix --unset for continuation lines
Date: Mon, 11 Feb 2008 01:23:03 +0100
Message-ID: <1202689383-9450-1-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 01:44:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOMmb-0000d9-LO
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 01:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756078AbYBKAnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 19:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754847AbYBKAnj
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 19:43:39 -0500
Received: from archimedes.lenk.info ([217.160.134.107]:58902 "EHLO
	archimedes.lenk.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755481AbYBKAni (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 19:43:38 -0500
X-Greylist: delayed 1236 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Feb 2008 19:43:37 EST
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtps 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1JOMRq-0003gU-Pk; Mon, 11 Feb 2008 01:23:02 +0100
Received: from p57b25f66.dip.t-dialin.net ([87.178.95.102] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1JOMRj-0001yT-Co; Mon, 11 Feb 2008 01:22:55 +0100
Received: from djpig by dirac.djpig.de with local (Exim 4.69)
	(envelope-from <frank@lichtenheld.de>)
	id 1JOMRr-0002Sq-P4; Mon, 11 Feb 2008 01:23:03 +0100
X-Mailer: git-send-email 1.5.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73444>

find_beginning_of_line didn't take into account that the
previous line might have ended with \ in which case it shouldn't
stop but continue its search.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 config.c               |    5 +++++
 t/t1300-repo-config.sh |   19 +++++++++++++++++++
 2 files changed, 24 insertions(+), 0 deletions(-)

 My usual "I can't code C" disclaimer applies

diff --git a/config.c b/config.c
index 498259e..1649aae 100644
--- a/config.c
+++ b/config.c
@@ -701,12 +701,17 @@ static ssize_t find_beginning_of_line(const char* contents, size_t size,
 	size_t equal_offset = size, bracket_offset = size;
 	ssize_t offset;
 
+contline:
 	for (offset = offset_-2; offset > 0
 			&& contents[offset] != '\n'; offset--)
 		switch (contents[offset]) {
 			case '=': equal_offset = offset; break;
 			case ']': bracket_offset = offset; break;
 		}
+	if (offset > 0 && contents[offset-1] == '\\') {
+		offset_ = offset;
+		goto contline;
+	}
 	if (bracket_offset < equal_offset) {
 		*found_bracket = 1;
 		offset = bracket_offset+1;
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 66aeb88..5f7c3a5 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -72,6 +72,25 @@ EOF
 test_expect_success 'non-match result' 'cmp .git/config expect'
 
 cat > .git/config << EOF
+[alpha]
+bar = foo
+[beta]
+baz = multiple \\
+lines
+EOF
+
+test_expect_success 'unset with cont. lines' \
+	'git config --unset beta.baz'
+
+cat > expect << EOF
+[alpha]
+bar = foo
+[beta]
+EOF
+
+test_expect_success 'unset with cont. lines is correct' 'cmp .git/config expect'
+
+cat > .git/config << EOF
 [beta] ; silly comment # another comment
 noIndent= sillyValue ; 'nother silly comment
 
-- 
1.5.4
