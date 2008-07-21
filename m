From: Olivier Marin <dkr+ml.git@free.fr>
Subject: [PATCH] parse-options: fix segmentation fault when a required value
 is missing
Date: Mon, 21 Jul 2008 20:30:36 +0200
Message-ID: <4884D5CC.2070007@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Jul 21 20:32:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL0Av-00084S-Mi
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 20:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919AbYGUSaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 14:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752964AbYGUSaj
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 14:30:39 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:40002 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751754AbYGUSai (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 14:30:38 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id CCF6B12B713;
	Mon, 21 Jul 2008 20:30:36 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 7213E12B6DF;
	Mon, 21 Jul 2008 20:30:36 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89382>

From: Olivier Marin <dkr@freesurf.fr>

p->argc represent the number of arguments that have not been parsed yet,
_including_ the one we are currently parsing. If it is not greater than
one then there is no more argument.

Signed-off-by: Olivier Marin <dkr@freesurf.fr>
---
 I hope this is the right fix.

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
-       } else if (p->argc) {
+       } else if (p->argc > 1) {
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
+       test-parse-options -s;
+       test $? = 129 &&
+       test-parse-options --string;
+       test $? = 129
+'
+
 cat > expect << EOF
 boolean: 1
 integer: 13
-- 
1.6.0.rc0.1.g75f42
