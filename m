From: Rafal Klys <rafalklys@wp.pl>
Subject: [PATCH v2] trailer: load config to handle core.commentChar
Date: Thu, 28 Apr 2016 22:00:58 +0200
Message-ID: <1461873658-11394-1-git-send-email-rafalklys@wp.pl>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Rafal Klys <rafalklys@wp.pl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 22:04:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avsB3-0006L9-JP
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 22:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752967AbcD1UEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 16:04:42 -0400
Received: from mx4.wp.pl ([212.77.101.12]:25759 "EHLO mx4.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752414AbcD1UEl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 16:04:41 -0400
Received: (wp-smtpd smtp.wp.pl 17492 invoked from network); 28 Apr 2016 22:04:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1461873878; bh=2KmZ4zT9pjGcvzwNJqmrQRr7M+/tfUUYGvSt2C03yQM=;
          h=From:To:Cc:Subject;
          b=M74qaGgtu7kQXTb3FZiKPw/Q68Z3sBveagYUckuK6MtzItDPax6qiIBDOKqCaJftb
           d9/BkUlp6KbRJfyg/HbTlw3oXprkJx5IzWww8nVmPKKTtHfnoSUtD+dZt7fyxPwr2P
           g1+hHcKZh4tpaD+BC2IIjASasa1p1+I8q7lhR/58=
Received: from staticline-31-183-163-223.toya.net.pl (HELO localhost.localdomain) (rafalklys@wp.pl@[31.183.163.223])
          (envelope-sender <rafalklys@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-SHA encrypted SMTP
          for <git@vger.kernel.org>; 28 Apr 2016 22:04:37 +0200
X-Mailer: git-send-email 2.8.1.69.g6de72cc
X-WP-DKIM-Status: good (id: wp.pl)                                      
X-WP-MailID: 56c6680194724e4802665b90053efd3a
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO 0000000 [QVOk]                               
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292947>

Fall throught git_default_config when reading config to update the
comment_line_char from default '#' to possible different value set in
core.commentChar.

Signed-off-by: Rafal Klys <rafalklys@wp.pl>
---

Added fallthru instead of reading config third time.

Added test, updated commit message.

I even tried to change that to only one pass, but looks like it would require a
bit more coding, so maybe next time.

Thanks for feedback, I'm impressed that contributing to Git is so easy for
newbies (never sent a patch via email before!) and that the response is so
quick.

 t/t7513-interpret-trailers.sh | 30 ++++++++++++++++++++++++++++++
 trailer.c                     |  3 ++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index aee785c..e6f9d8e 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -267,6 +267,36 @@ test_expect_success 'with message that has comments' '
 	test_cmp expected actual
 '
 
+test_expect_success 'with message that has comments using non-default core.commentChar' '
+	git config core.commentChar x &&
+	test_when_finished "git config --unset core.commentChar" &&
+	cat basic_message >message_with_comments &&
+	sed -e "s/ Z\$/ /" >>message_with_comments <<-\EOF &&
+		x comment
+
+		x other comment
+		Cc: Z
+		x yet another comment
+		Reviewed-by: Johan
+		Reviewed-by: Z
+		x last comment
+
+	EOF
+	cat basic_patch >>message_with_comments &&
+	cat basic_message >expected &&
+	cat >>expected <<-\EOF &&
+		x comment
+
+		Reviewed-by: Johan
+		Cc: Peff
+		x last comment
+
+	EOF
+	cat basic_patch >>expected &&
+	git interpret-trailers --trim-empty --trailer "Cc: Peff" message_with_comments >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'with message that has an old style conflict block' '
 	cat basic_message >message_with_comments &&
 	sed -e "s/ Z\$/ /" >>message_with_comments <<-\EOF &&
diff --git a/trailer.c b/trailer.c
index 8e48a5c..2ec0883 100644
--- a/trailer.c
+++ b/trailer.c
@@ -483,7 +483,8 @@ static int git_trailer_default_config(const char *conf_key, const char *value, v
 	const char *trailer_item, *variable_name;
 
 	if (!skip_prefix(conf_key, "trailer.", &trailer_item))
-		return 0;
+		/* for core.commentChar */
+		return git_default_config(conf_key, value, cb);
 
 	variable_name = strrchr(trailer_item, '.');
 	if (!variable_name) {
-- 
2.8.1.69.g6de72cc
