From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 3/4] reflog: fix overriding of command line options
Date: Fri,  1 Apr 2011 11:20:33 +0200
Message-ID: <d89cd4bda86934489f931858b8ecaf2e8525c7ad.1301649372.git.git@drmicha.warpmail.net>
References: <7vwrjfjdqr.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 11:24:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5aan-0001Hg-Kk
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 11:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755304Ab1DAJYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 05:24:16 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44094 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755226Ab1DAJYO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Apr 2011 05:24:14 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1B82F208C0;
	Fri,  1 Apr 2011 05:24:14 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 01 Apr 2011 05:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=WgUKYDrbg6guCo4PeMGc3p2ZeyE=; b=tqUae29kWqOJiavds2InsNe6kST9RCyA8cLGs5ck3C9mKjPZxEH3SDuJuMbhLL8m1XnAinqzI+IlQIkf7SFYaJ/a0o/5pi7XQe4+rvKmrQ2ge1sSMZQbRatqXYi26MZ6b26xU/vFB5J99s4q6QLpVrQ3gkUf3wH+5wVbqsXS0+g=
X-Sasl-enc: TrP9Y8u5FkFrzkiELpxc3dHdfi3rdbBIcZDUS0fQHXxf 1301649853
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 91EC5445813;
	Fri,  1 Apr 2011 05:24:13 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.2.668.gba03a4
In-Reply-To: <7vwrjfjdqr.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1301649372.git.git@drmicha.warpmail.net>
References: <cover.1301649372.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170570>

Currently, "git reflog" overrides some command line options such as
"--format".

Fix this by using the new 2-phase version of cmd_log_init().

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/log.c          |    9 ++-------
 t/t1411-reflog-show.sh |    2 +-
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index f585209..916019c 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -495,16 +495,11 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	rev.verbose_header = 1;
 	memset(&opt, 0, sizeof(opt));
 	opt.def = "HEAD";
-	cmd_log_init(argc, argv, prefix, &rev, &opt);
-
-	/*
-	 * This means that we override whatever commit format the user gave
-	 * on the cmd line.  Sad, but cmd_log_init() currently doesn't
-	 * allow us to set a different default.
-	 */
+	cmd_log_init_defaults(&rev);
 	rev.commit_format = CMIT_FMT_ONELINE;
 	rev.use_terminator = 1;
 	rev.always_show_header = 1;
+	cmd_log_init_finish(argc, argv, prefix, &rev, &opt);
 
 	return cmd_log_walk(&rev);
 }
diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
index 88dc6a7..caa687b 100755
--- a/t/t1411-reflog-show.sh
+++ b/t/t1411-reflog-show.sh
@@ -41,7 +41,7 @@ Author: A U Thor <author@example.com>
 
     one
 EOF
-test_expect_failure 'override reflog default format' '
+test_expect_success 'override reflog default format' '
 	git reflog --format=short -1 >actual &&
 	test_cmp expect actual
 '
-- 
1.7.4.2.668.gba03a4
