From: Max Kirillov <max@max630.net>
Subject: [PATCH 1/2] git-show: fix 'git show -s' to not add extra terminator
 after merge commit
Date: Tue, 13 May 2014 01:42:34 +0300
Message-ID: <20140512224234.GA32316@wheezy.local>
References: <20140512223517.GA32205@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 13 00:42:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wjyvj-0002p0-N9
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 00:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbaELWmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 18:42:40 -0400
Received: from p3plsmtpa09-09.prod.phx3.secureserver.net ([173.201.193.238]:53089
	"EHLO p3plsmtpa09-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751100AbaELWmj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 May 2014 18:42:39 -0400
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 May 2014 18:42:39 EDT
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa09-09.prod.phx3.secureserver.net with 
	id 1AiY1o00P3gsSd601Aiexk; Mon, 12 May 2014 15:42:39 -0700
Content-Disposition: inline
In-Reply-To: <20140512223517.GA32205@wheezy.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248737>

When git show -s is called for merge commit it prints extra newline
after any merge commit and the next one. This looks especially ugly for
--oneline and other single-line formats. Looks very much like a bug.

The code in question exists since commit 3969cf7db1. Probably the
correct condition should be in fact
"opt->output_format & DIFF_FORMAT_DIFFSTAT".

Test t7007-show.sh is also modified to cover this case.
---
 combine-diff.c  | 3 ++-
 t/t7007-show.sh | 8 ++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 3b92c448..ff6ceaf 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1331,7 +1331,8 @@ void diff_tree_combined(const unsigned char *sha1,
 		if (show_log_first && i == 0) {
 			show_log(rev);
 
-			if (rev->verbose_header && opt->output_format)
+			if (rev->verbose_header && opt->output_format &&
+			    opt->output_format != DIFF_FORMAT_NO_OUTPUT)
 				printf("%s%c", diff_line_prefix(opt),
 				       opt->line_termination);
 		}
diff --git a/t/t7007-show.sh b/t/t7007-show.sh
index e41fa00..de22812 100755
--- a/t/t7007-show.sh
+++ b/t/t7007-show.sh
@@ -25,6 +25,7 @@ test_expect_success 'set up a bit of history' '
 	git checkout -b side HEAD^^ &&
 	test_commit side2 &&
 	test_commit side3
+	test_merge merge main3
 '
 
 test_expect_success 'showing two commits' '
@@ -109,8 +110,11 @@ test_expect_success 'showing range' '
 '
 
 test_expect_success '-s suppresses diff' '
-	echo main3 >expect &&
-	git show -s --format=%s main3 >actual &&
+	cat >expect <<-\EOF &&
+	merge
+	main3
+	EOF
+	git show -s --format=%s merge main3 >actual &&
 	test_cmp expect actual
 '
 
-- 
1.8.5.2.421.g4cdf8d0
