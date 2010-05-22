From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 4/8] grep: --name-only over binary
Date: Sat, 22 May 2010 23:30:48 +0200
Message-ID: <4BF84D08.4080808@lsrfire.ath.cx>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org> <4BF84B9E.7060009@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 22 23:31:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFwHl-0002W9-5Y
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 23:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758770Ab0EVVbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 17:31:04 -0400
Received: from india601.server4you.de ([85.25.151.105]:51049 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758612Ab0EVVbD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 17:31:03 -0400
Received: from [10.0.1.100] (p57B7F4C3.dip.t-dialin.net [87.183.244.195])
	by india601.server4you.de (Postfix) with ESMTPSA id 5EE512F8069;
	Sat, 22 May 2010 23:31:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BF84B9E.7060009@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147546>

As with the option -c/--count, git grep with the option -l/--name-only
should work the same with binary files as with text files because
there is no danger of messing up the terminal with control characters
from the contents of matching files.  GNU grep does the same.

Move the check for ->name_only before the one for binary_match_only,
thus making the latter irrelevant for git grep -l.

Reported-by: Dmitry Potapov <dpotapov@gmail.com>
Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 grep.c                 |    8 ++++----
 t/t7008-grep-binary.sh |    6 ++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/grep.c b/grep.c
index 35c18b7..22639cd 100644
--- a/grep.c
+++ b/grep.c
@@ -873,6 +873,10 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 			count++;
 			if (opt->status_only)
 				return 1;
+			if (opt->name_only) {
+				show_name(opt, name);
+				return 1;
+			}
 			if (opt->count)
 				goto next_line;
 			if (binary_match_only) {
@@ -882,10 +886,6 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 				opt->output(opt, " matches\n", 9);
 				return 1;
 			}
-			if (opt->name_only) {
-				show_name(opt, name);
-				return 1;
-			}
 			/* Hit at this line.  If we haven't shown the
 			 * pre-context lines, we would need to show them.
 			 */
diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index 91970ea..4a12d97 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -33,6 +33,12 @@ test_expect_success 'git grep -c ina a' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git grep -l ina a' '
+	echo a >expect &&
+	git grep -l ina a >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git grep -L bar a' '
 	echo a >expect &&
 	git grep -L bar a >actual &&
-- 
1.7.1
