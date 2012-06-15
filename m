From: Alexander Strasser <eclipse7@gmx.net>
Subject: [PATCH v2] diff: Only count lines in show_shortstats
Date: Fri, 15 Jun 2012 21:02:48 +0200
Message-ID: <20120615190248.GA28377@akuma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	mj@ucw.cz, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 15 21:03:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfbnX-0006SA-DD
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 21:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757338Ab2FOTDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 15:03:03 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:34124 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751361Ab2FOTDB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 15:03:01 -0400
Received: (qmail invoked by alias); 15 Jun 2012 19:02:57 -0000
Received: from p5DC36C83.dip.t-dialin.net (EHLO gmx.net) [93.195.108.131]
  by mail.gmx.net (mp070) with SMTP; 15 Jun 2012 21:02:57 +0200
X-Authenticated: #8251126
X-Provags-ID: V01U2FsdGVkX18krHFp9MAksCZjnG6et/fUANizdbn1sP2RBxOGc3
	h2izTv28Nd4gJF
Received: by gmx.net (sSMTP sendmail emulation); Fri, 15 Jun 2012 21:02:48 +0200
Mail-Followup-To: git@vger.kernel.org,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	mj@ucw.cz, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200081>

Do not mix byte and line counts. Binary files have byte counts;
skip them when accumulating line insertions/deletions.

The regression was introduced in e18872b.

Signed-off-by: Alexander Strasser <eclipse7@gmx.net>
---

 Zbigniew, Junio:
   I hope I did submit the patch correctly this time.

   This is a reroll with the following differences to v1:

   * I changed the additional test for t4012 to adhere to modern
     style on request by Zbigniew. I had the impression this might
     be in conflict with Junio's comment
     "Style fixes should be done later after dust from more important
      changes (e.g. a bugfix) settles."
     But maybe that was directed at modernizing the remaining of
     parts of that test file.
   * I deleted the 2-space indent in the commit message paragraphs
   * I omitted the parenthesis in the subject message

   The above points are the reason I resent this for discussion to
 the list.

   I apologize for the long delay, some misunderstandings on my side
 made me think the initial submission was considered for inclusion.

 diff.c                 | 2 +-
 t/t4012-diff-binary.sh | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

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
index 8b4e80d..7d03c1d 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -36,6 +36,12 @@ test_expect_success '"apply --stat" output for binary file change' '
 	test_i18ncmp expected current
 '
 
+test_expect_success 'diff --shortstat output for binary file change' '
+	echo " 4 files changed, 2 insertions(+), 2 deletions(-)" >expected &&
+	git diff --shortstat >current &&
+	test_i18ncmp expected current
+'
+
 test_expect_success 'apply --numstat notices binary file change' '
 	git diff >diff &&
 	git apply --numstat <diff >current &&
-- 
1.7.10.2.552.gaa3bb87
