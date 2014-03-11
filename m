From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 2/2] grep: support -h (no header) with --count
Date: Tue, 11 Mar 2014 22:15:49 +0100
Message-ID: <531F7D05.5010207@web.de>
References: <531F7B2E.20209@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 11 22:16:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNU2i-0001yb-2Y
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 22:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755561AbaCKVQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 17:16:51 -0400
Received: from mout.web.de ([212.227.17.12]:59623 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755558AbaCKVQv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 17:16:51 -0400
Received: from [192.168.178.27] ([79.250.161.106]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LlniO-1Wwor648Qq-00ZKxm; Tue, 11 Mar 2014 22:16:37
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <531F7B2E.20209@web.de>
X-Provags-ID: V03:K0:EBQU6An/h4bRYie54g3MeAD313ApfXJuuXgMvHfrc7Rq5LiouJr
 k1k8Uk/1kzxxzOPb7bKTr8vI56HftXsMJkjuM6HeS8fk/uCCv3MYuS7EZxDI0dCBjrfsa2Y
 qgHlp4bTJTYRwWGqdBOWkoaUx3LCVmjk4uzrkmuTFCW2GpqbzQ1xDukIUPOiCA0M/bFERhz
 /M3ks9aPED98ZacccCOJw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243900>

Suppress printing the header (filename) with -h even if in -c/--count
mode.  GNU grep and OpenBSD's grep do the same.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 grep.c          |  7 +++++--
 t/t7810-grep.sh | 12 ++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index c668034..94f7290 100644
--- a/grep.c
+++ b/grep.c
@@ -1562,8 +1562,11 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 	 */
 	if (opt->count && count) {
 		char buf[32];
-		output_color(opt, gs->name, strlen(gs->name), opt->color_filename);
-		output_sep(opt, ':');
+		if (opt->pathname) {
+			output_color(opt, gs->name, strlen(gs->name),
+				     opt->color_filename);
+			output_sep(opt, ':');
+		}
 		snprintf(buf, sizeof(buf), "%u\n", count);
 		opt->output(opt, buf, strlen(buf));
 		return 1;
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 46aaebc..63b3039 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -328,6 +328,18 @@ do
 			grep "a+b*c" $H ab >actual &&
 		test_cmp expected actual
 	'
+
+	test_expect_success "grep --count $L" '
+		echo ${HC}ab:3 >expected &&
+		git grep --count -e b $H -- ab >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep --count -h $L" '
+		echo 3 >expected &&
+		git grep --count -h -e b $H -- ab >actual &&
+		test_cmp expected actual
+	'
 done
 
 cat >expected <<EOF
-- 
1.9.0
