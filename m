From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 7/7] git grep: honor textconv by default
Date: Tue, 23 Apr 2013 14:11:59 +0200
Message-ID: <043047afd2915dd8f3a68cf164dc516d4c0bb5c2.1366718624.git.git@drmicha.warpmail.net>
References: <517298D4.3030802@drmicha.warpmail.net>
Cc: Matthieu.Moy@grenoble-inp.fr, jeremy.rosen@openwide.fr,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 23 14:12:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUc58-0002Sj-RO
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 14:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755915Ab3DWMMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 08:12:13 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59657 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755836Ab3DWMMG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Apr 2013 08:12:06 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 097082098D;
	Tue, 23 Apr 2013 08:12:06 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 23 Apr 2013 08:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=cv
	3ECRxlCaGSAYxC6jt2KtqwjUQ=; b=pyRv075vAZs9Ke7nwsNR5Km3NDQ61cApXk
	oVQJo+4FnM3YVmf6Jt1h/69Rj7czso5hqktno8vJ8VwkHJe2V14mRlnQX5qASzwq
	wyX61Y5BM7kk0AIueUv1jUizdgWZk2EKbgeyxPl3mqvel7UI/23umXIimw1tjATZ
	p8VarCd7A=
X-Sasl-enc: itIDqgmiGXUCqcY5BYmZI0d9ZLCR5HqAoeS3O6ZjQLw+ 1366719124
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 161C82001BB;
	Tue, 23 Apr 2013 08:12:03 -0400 (EDT)
X-Mailer: git-send-email 1.8.2.1.799.g1ac2534
In-Reply-To: <517298D4.3030802@drmicha.warpmail.net>
In-Reply-To: <cover.1366718624.git.git@drmicha.warpmail.net>
References: <cover.1366718624.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222153>

Currently, "git grep" does not honor textconv settings by default.
Make it honor them by default just like "git log --grep" does.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-grep.txt | 2 +-
 grep.c                     | 2 ++
 t/t7008-grep-binary.sh     | 4 ++--
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index a5c5a27..f54ac0c 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -82,10 +82,10 @@ OPTIONS
 
 --textconv::
 	Honor textconv filter settings.
+	This is the default.
 
 --no-textconv::
 	Do not honor textconv filter settings.
-	This is the default.
 
 -i::
 --ignore-case::
diff --git a/grep.c b/grep.c
index c668034..161d3f0 100644
--- a/grep.c
+++ b/grep.c
@@ -31,6 +31,7 @@ void init_grep_defaults(void)
 	opt->max_depth = -1;
 	opt->pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED;
 	opt->extended_regexp_option = 0;
+	opt->allow_textconv = 1;
 	strcpy(opt->color_context, "");
 	strcpy(opt->color_filename, "");
 	strcpy(opt->color_function, "");
@@ -134,6 +135,7 @@ void grep_init(struct grep_opt *opt, const char *prefix)
 	opt->pathname = def->pathname;
 	opt->regflags = def->regflags;
 	opt->relative = def->relative;
+	opt->allow_textconv = def->allow_textconv;
 
 	strcpy(opt->color_context, def->color_context);
 	strcpy(opt->color_filename, def->color_filename);
diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index 10b2c8b..2fc9d9c 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -156,7 +156,7 @@ test_expect_success 'setup textconv filters' '
 	git config diff.foo.textconv "\"$(pwd)\""/nul_to_q_textconv
 '
 
-test_expect_failure 'grep does not honor textconv' '
+test_expect_success 'grep does honor textconv' '
 	echo "a:binaryQfile" >expect &&
 	git grep Qfile >actual &&
 	test_cmp expect actual
@@ -172,7 +172,7 @@ test_expect_success 'grep --no-textconv does not honor textconv' '
 	test_must_fail git grep --no-textconv Qfile
 '
 
-test_expect_failure 'grep blob does not honor textconv' '
+test_expect_success 'grep blob does honor textconv' '
 	echo "HEAD:a:binaryQfile" >expect &&
 	git grep Qfile HEAD:a >actual &&
 	test_cmp expect actual
-- 
1.8.2.1.799.g1ac2534
