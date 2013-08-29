From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v3 3/4] get rid of "git submodule summary --for-status"
Date: Thu, 29 Aug 2013 15:05:35 +0200
Message-ID: <1377781536-31955-4-git-send-email-Matthieu.Moy@imag.fr>
References: <1377781536-31955-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 29 15:09:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF1yd-0007UN-Gt
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 15:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785Ab3H2NJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 09:09:27 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59407 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752729Ab3H2NJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 09:09:26 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r7TD5kdS019325
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Aug 2013 15:05:47 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VF1v2-0008HB-Jy; Thu, 29 Aug 2013 15:05:48 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VF1v2-0008Kf-8L; Thu, 29 Aug 2013 15:05:48 +0200
X-Mailer: git-send-email 1.8.4.12.gf9d53a3.dirty
In-Reply-To: <1377781536-31955-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 29 Aug 2013 15:05:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7TD5kdS019325
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1378386349.5139@eNLXcQCiIhBQqNxZ817Ghg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233255>

The --for-status option was an undocumented option used only by
wt-status.c, which inserted a header and commented out the output. We can
achieve the same result within wt-status.c, without polluting the
submodule command-line options.

This will make it easier to disable the comments from wt-status.c later.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 git-submodule.sh             | 17 +----------------
 t/t7401-submodule-summary.sh | 13 -------------
 wt-status.c                  | 29 +++++++++++++++++++++++++++--
 3 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2979197..fccdec9 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -965,7 +965,6 @@ set_name_rev () {
 #
 cmd_summary() {
 	summary_limit=-1
-	for_status=
 	diff_cmd=diff-index
 
 	# parse $args after "submodule ... summary".
@@ -978,9 +977,6 @@ cmd_summary() {
 		--files)
 			files="$1"
 			;;
-		--for-status)
-			for_status="$1"
-			;;
 		-n|--summary-limit)
 			summary_limit="$2"
 			isnumber "$summary_limit" || usage
@@ -1149,18 +1145,7 @@ cmd_summary() {
 			echo
 		fi
 		echo
-	done |
-	if test -n "$for_status"; then
-		if [ -n "$files" ]; then
-			gettextln "Submodules changed but not updated:" | git stripspace -c
-		else
-			gettextln "Submodule changes to be committed:" | git stripspace -c
-		fi
-		printf "\n" | git stripspace -c
-		git stripspace -c
-	else
-		cat
-	fi
+	done
 }
 #
 # List all submodules, prefixed with:
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index ac2434c..b435d03 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -262,19 +262,6 @@ EOF
 	test_cmp expected actual
 "
 
-test_expect_success '--for-status' "
-	git submodule summary --for-status HEAD^ >actual &&
-	test_i18ncmp actual - <<EOF
-# Submodule changes to be committed:
-#
-# * sm1 $head6...0000000:
-#
-# * sm2 0000000...$head7 (2):
-#   > Add foo9
-#
-EOF
-"
-
 test_expect_success 'fail when using --files together with --cached' "
 	test_must_fail git submodule summary --files --cached
 "
diff --git a/wt-status.c b/wt-status.c
index 958a53c..d91661d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -665,6 +665,10 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
 	char index[PATH_MAX];
 	const char *env[] = { NULL, NULL };
 	struct argv_array argv = ARGV_ARRAY_INIT;
+	struct strbuf cmd_stdout = STRBUF_INIT;
+	struct strbuf summary = STRBUF_INIT;
+	char *summary_content;
+	size_t len;
 
 	sprintf(summary_limit, "%d", s->submodule_summary);
 	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", s->index_file);
@@ -673,7 +677,6 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
 	argv_array_push(&argv, "submodule");
 	argv_array_push(&argv, "summary");
 	argv_array_push(&argv, uncommitted ? "--files" : "--cached");
-	argv_array_push(&argv, "--for-status");
 	argv_array_push(&argv, "--summary-limit");
 	argv_array_push(&argv, summary_limit);
 	if (!uncommitted)
@@ -685,9 +688,31 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
 	sm_summary.git_cmd = 1;
 	sm_summary.no_stdin = 1;
 	fflush(s->fp);
-	sm_summary.out = dup(fileno(s->fp));    /* run_command closes it */
+	sm_summary.out = -1;
+
 	run_command(&sm_summary);
 	argv_array_clear(&argv);
+
+	len = strbuf_read(&cmd_stdout, sm_summary.out, 1024);
+
+	/* prepend header, only if there's an actual output */
+	if (len) {
+		if (uncommitted)
+			strbuf_addstr(&summary, _("Submodules changed but not updated:"));
+		else
+			strbuf_addstr(&summary, _("Submodule changes to be committed:"));
+		strbuf_addstr(&summary, "\n\n");
+	}
+	strbuf_addbuf(&summary, &cmd_stdout);
+	strbuf_release(&cmd_stdout);
+
+	summary_content = strbuf_detach(&summary, &len);
+	strbuf_add_commented_lines(&summary, summary_content, len);
+	free(summary_content);
+
+	summary_content = strbuf_detach(&summary, &len);
+	fprintf(s->fp, summary_content);
+	free(summary_content);
 }
 
 static void wt_status_print_other(struct wt_status *s,
-- 
1.8.4.12.gf9d53a3.dirty
