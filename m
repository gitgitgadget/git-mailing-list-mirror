From: Alexander Strasser <eclipse7@gmx.net>
Subject: [PATCH] diff: Only count lines in show_shortstats()
Date: Wed, 30 May 2012 23:58:43 +0200
Message-ID: <20120530215843.GA29737@akuma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 30 23:58:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZqus-0000EQ-Gu
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 23:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756255Ab2E3V6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 17:58:50 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:54972 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754264Ab2E3V6u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 17:58:50 -0400
Received: (qmail invoked by alias); 30 May 2012 21:58:47 -0000
Received: from p5DC37DB2.dip.t-dialin.net (EHLO gmx.net) [93.195.125.178]
  by mail.gmx.net (mp033) with SMTP; 30 May 2012 23:58:47 +0200
X-Authenticated: #8251126
X-Provags-ID: V01U2FsdGVkX19ZcfEqIpRZqSBathG6Z7T3d/jYlEYhDJ2QBTk+X4
	gTkDdH/94M6aNj
Received: by gmx.net (sSMTP sendmail emulation); Wed, 30 May 2012 23:58:43 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198842>

  Do not mix byte and line counts. Binary files have byte counts;
skip them when accumulating line insertions/deletions.

  The regression was introduced in e18872b.

Signed-off-by: Alexander Strasser <eclipse7@gmx.net>
---

  I hope this does retain the original intent of e18872b while
not messing up the insertions/deletions output by --shortstat.

  Output of --stat was never affected AFAICT.

 diff.c                 | 2 +-
 t/t4012-diff-binary.sh | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 77edd50..1a594df 100644
--- a/diff.c
+++ b/diff.c
@@ -1700,7 +1700,7 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
 			continue;
 		if (!data->files[i]->is_renamed && (added + deleted == 0)) {
 			total_files--;
-		} else {
+		} else if (!data->files[i]->is_binary) { /* don't count bytes */
 			adds += added;
 			dels += deleted;
 		}
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 8b4e80d..1a994f0 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -36,6 +36,14 @@ test_expect_success '"apply --stat" output for binary file change' '
 	test_i18ncmp expected current
 '
 
+cat > expected <<\EOF
+ 4 files changed, 2 insertions(+), 2 deletions(-)
+EOF
+test_expect_success 'diff with --shortstat' '
+	git diff --shortstat >current &&
+	test_cmp expected current
+'
+
 test_expect_success 'apply --numstat notices binary file change' '
 	git diff >diff &&
 	git apply --numstat <diff >current &&
-- 
1.7.10.2.552.gaa3bb87
