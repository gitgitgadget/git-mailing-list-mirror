From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v5 3/6] submodule summary: ignore --for-status option
Date: Fri,  6 Sep 2013 19:43:06 +0200
Message-ID: <1378489389-25802-4-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq38phsvuc.fsf@anie.imag.frvpq38phsvuc.fsf@anie.imag.fr>
 <1378489389-25802-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 06 19:43:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI04G-00016q-Ri
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 19:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952Ab3IFRnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 13:43:31 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54070 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750924Ab3IFRn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 13:43:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r86HhMmA014277
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 6 Sep 2013 19:43:22 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VI044-0000bA-Dq; Fri, 06 Sep 2013 19:43:24 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VI044-0006jQ-4S; Fri, 06 Sep 2013 19:43:24 +0200
X-Mailer: git-send-email 1.8.4.5.g8688bea
In-Reply-To: <1378489389-25802-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 06 Sep 2013 19:43:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r86HhMmA014277
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1379094204.26362@GbX7WvdSaawHNCeBT6evrw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234071>

The --for-status option was an undocumented option used only by
wt-status.c, which inserted a header and commented out the output. We can
achieve the same result within wt-status.c, without polluting the
submodule command-line options.

This will make it easier to disable the comments from wt-status.c later.

The --for-status is kept so that another topic in flight
(bc/submodule-status-ignored) can continue relying on it, although it is
currently a no-op.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-submodule.sh             | 13 +------------
 t/t7401-submodule-summary.sh | 12 +++++-------
 wt-status.c                  | 27 ++++++++++++++++++++++++++-
 3 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2979197..c17bef1 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1149,18 +1149,7 @@ cmd_summary() {
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
index ac2434c..5a6d6d6 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -265,13 +265,11 @@ EOF
 test_expect_success '--for-status' "
 	git submodule summary --for-status HEAD^ >actual &&
 	test_i18ncmp actual - <<EOF
-# Submodule changes to be committed:
-#
-# * sm1 $head6...0000000:
-#
-# * sm2 0000000...$head7 (2):
-#   > Add foo9
-#
+* sm1 $head6...0000000:
+
+* sm2 0000000...$head7 (2):
+  > Add foo9
+
 EOF
 "
 
diff --git a/wt-status.c b/wt-status.c
index 958a53c..853813f 100644
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
@@ -685,9 +689,30 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
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
+	fputs(summary.buf, s->fp);
+	strbuf_release(&summary);
 }
 
 static void wt_status_print_other(struct wt_status *s,
-- 
1.8.4.5.g8688bea
