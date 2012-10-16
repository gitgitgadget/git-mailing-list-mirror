From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/4] test-lib: allow variable export from lazy prereq tests
Date: Tue, 16 Oct 2012 13:39:45 +0200
Message-ID: <ca07c5a1cf836826fc0ee53daf3e7f3dfe111ece.1350387132.git.git@drmicha.warpmail.net>
References: <k5gq60$q8c$1@ger.gmane.org>
Cc: Joachim Schmitz <jojo@schmitz-digital.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 13:40:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO5VD-0003yi-N5
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 13:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754559Ab2JPLjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 07:39:53 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59377 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754542Ab2JPLjw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2012 07:39:52 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5702620993;
	Tue, 16 Oct 2012 07:39:52 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Tue, 16 Oct 2012 07:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=mk
	NCBzlKXKjX6CJMzR/wfyt3sqE=; b=q2xAvM/AWJm0K2O4Wx2Ybekyi0zgh4vadV
	ah3KQcHWK5Q2u9fbMExOHMvctclJxDd5avPBfafbtOtqw4tDEqdeXke0oeYtWTj+
	mAIPIeJfQlt6KEcUm3P8p1X/CYpV80iRowd5xPGrZxalZXzhFPYneBOOW+RpkVrv
	PGFT51UB0=
X-Sasl-enc: JfENtXrTyjG7T1EdAjWoycf+A2ZwPBDtvGTLri1qCJ8l 1350387591
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id E9FE24827C7;
	Tue, 16 Oct 2012 07:39:51 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc2.304.g9f3ac5c
In-Reply-To: <k5gq60$q8c$1@ger.gmane.org>
In-Reply-To: <cover.1350387132.git.git@drmicha.warpmail.net>
References: <cover.1350387132.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207816>

Currently, lazy prereq tests are run in a subshell which communicates
only the exit code to the outer world.

Run it as a subcommand so that variables can be exported to the test
environment.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
I don't think this has any adverse side effects, but I'm begging for
another set of eyeballs to have a look. (Test suite passes, of course.)

 t/test-lib-functions.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 8889ba5..e587902 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -246,13 +246,15 @@ test_lazy_prereq () {
 test_run_lazy_prereq_ () {
 	script='
 mkdir -p "$TRASH_DIRECTORY/prereq-test-dir" &&
-(
+{
 	cd "$TRASH_DIRECTORY/prereq-test-dir" &&'"$2"'
-)'
+}'
 	say >&3 "checking prerequisite: $1"
 	say >&3 "$script"
+	orig_pwd="$(pwd)"
 	test_eval_ "$script"
 	eval_ret=$?
+	cd "$orig_pwd"
 	rm -rf "$TRASH_DIRECTORY/prereq-test-dir"
 	if test "$eval_ret" = 0; then
 		say >&3 "prerequisite $1 ok"
-- 
1.8.0.rc2.304.g9f3ac5c
