From: Olivier Marin <dkr+ml.git@free.fr>
Subject: [PATCH v2] parse-options: fix segmentation fault when a required value is missing
Date: Tue, 22 Jul 2008 12:11:33 +0200
Message-ID: <1216721493-17836-1-git-send-email-dkr+ml.git@free.fr>
References: <20080721190709.GD2718@artemis.madism.org>
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Jul 22 12:12:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLErC-0007NZ-FX
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 12:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbYGVKLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 06:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbYGVKLf
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 06:11:35 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:47791 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751753AbYGVKLe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 06:11:34 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 7006E12B6D4;
	Tue, 22 Jul 2008 12:11:33 +0200 (CEST)
Received: from localhost.localdomain (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 0D2C012B6C6;
	Tue, 22 Jul 2008 12:11:33 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.136.g55999
In-Reply-To: <20080721190709.GD2718@artemis.madism.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89480>

From: Olivier Marin <dkr@freesurf.fr>

p->argc represent the number of arguments that have not been parsed yet,
_including_ the one we are currently parsing. If it is not greater than
one then there is no more argument.

Signed-off-by: Olivier Marin <dkr@freesurf.fr>
Acked-by: Pierre Habouzit <madcoder@debian.org>
---

 The same, not whitespace damaged! Sorry for the noise.

 parse-options.c          |    2 +-
 t/t0040-parse-options.sh |    7 +++++++
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 987b015..71a7acf 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -22,7 +22,7 @@ static int get_arg(struct parse_opt_ctx_t *p, const struct option *opt,
 		p->opt = NULL;
 	} else if (p->argc == 1 && (opt->flags & PARSE_OPT_LASTARG_DEFAULT)) {
 		*arg = (const char *)opt->defval;
-	} else if (p->argc) {
+	} else if (p->argc > 1) {
 		p->argc--;
 		*arg = *++p->argv;
 	} else
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 6309aed..03dbe00 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -78,6 +78,13 @@ test_expect_success 'long options' '
 	test_cmp expect output
 '
 
+test_expect_success 'missing required value' '
+	test-parse-options -s;
+	test $? = 129 &&
+	test-parse-options --string;
+	test $? = 129
+'
+
 cat > expect << EOF
 boolean: 1
 integer: 13
-- 
1.6.0.rc0.136.g55999
