From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] wt-status: use argv_array for environment
Date: Sun, 29 Jun 2014 22:47:00 +0200
Message-ID: <53B07B44.9000406@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 29 22:47:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1M0V-0007fQ-64
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jun 2014 22:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539AbaF2UrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2014 16:47:23 -0400
Received: from mout.web.de ([212.227.17.11]:54514 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169AbaF2UrG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2014 16:47:06 -0400
Received: from [192.168.178.27] ([79.250.179.75]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MRl5x-1XCW0U2nmL-00SyL1; Sun, 29 Jun 2014 22:47:03
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Provags-ID: V03:K0:uqRsIxie6QPXmsZFY6pc593dj2Dw98TKZvftnxkJUwP2hf7DV+R
 BFsFQk3e0E4LJIpnUwD9v+4pJR0vHM4jBN6A4lr66yyfKxodEE5Ue8TpB0t65tWaHsEf734
 Gu4W46HnYwwANadQMEol5oULTJnRwsjrDiGwQKbL7sUCr1BQi/BaQhpKFrrQJwPzkHD68Be
 W7ibeY4vyVgqBafb52Wng==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252648>

Instead of using a PATH_MAX buffer, use argv_array for constructing the
environment for git submodule summary.  This simplifies the code a bit
and removes the arbitrary length limit.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 wt-status.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 318a191..2c0bff8 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -735,8 +735,7 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
 {
 	struct child_process sm_summary;
 	char summary_limit[64];
-	char index[PATH_MAX];
-	const char *env[] = { NULL, NULL };
+	struct argv_array env = ARGV_ARRAY_INIT;
 	struct argv_array argv = ARGV_ARRAY_INIT;
 	struct strbuf cmd_stdout = STRBUF_INIT;
 	struct strbuf summary = STRBUF_INIT;
@@ -744,9 +743,8 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
 	size_t len;
 
 	sprintf(summary_limit, "%d", s->submodule_summary);
-	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", s->index_file);
+	argv_array_pushf(&env, "GIT_INDEX_FILE=%s", s->index_file);
 
-	env[0] = index;
 	argv_array_push(&argv, "submodule");
 	argv_array_push(&argv, "summary");
 	argv_array_push(&argv, uncommitted ? "--files" : "--cached");
@@ -758,13 +756,14 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
 
 	memset(&sm_summary, 0, sizeof(sm_summary));
 	sm_summary.argv = argv.argv;
-	sm_summary.env = env;
+	sm_summary.env = env.argv;
 	sm_summary.git_cmd = 1;
 	sm_summary.no_stdin = 1;
 	fflush(s->fp);
 	sm_summary.out = -1;
 
 	run_command(&sm_summary);
+	argv_array_clear(&env);
 	argv_array_clear(&argv);
 
 	len = strbuf_read(&cmd_stdout, sm_summary.out, 1024);
-- 
2.0.0
