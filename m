Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E04ECAAD5
	for <git@archiver.kernel.org>; Sun, 28 Aug 2022 21:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiH1Vlx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Aug 2022 17:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiH1Vlw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2022 17:41:52 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2FF13FA1
        for <git@vger.kernel.org>; Sun, 28 Aug 2022 14:41:50 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 6BA645A26C;
        Sun, 28 Aug 2022 21:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1661722909;
        bh=/P9bcJObTotj/qSX4jbFZrcs1DF94NMEfzYz6ewu6og=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=qdyJ8ez7pD3TIVLweJ3l3MptTdE3C1+bk6LTHZ5EuoR0y1Qnq850JlPfvOYd/cbs9
         aSV4+PgbcrqiiPe4RNDfwWhS+pjHhDFqYscL13dfQagk/v0hMCD4MFR6AmmiqQ9abQ
         vCY6TpnHL9b3fcQ7oU6ySXxrXzo0f54vWWT5nHoNozGdMhMCSMMReV+DIVpqpikfNK
         sTCda4zjcRCxFRkqOCgdR16u6cST5xwNHUNsyI8shX2tjnEoOt0+Nzh/2sa+g+USpV
         8XW4CzamCNfsnCqBH/uK/SVaMEkTb1cZfCH3mfKUIP9ASUP4Mi6r7y2IgTJvrqZAXw
         vUw2KcWQS74pYJycD8Vw7saMmhMxgG6zimG3gMOdgGao94XAN3d+iecBOcrDlEV57g
         4h7eezk5hrPyhP3/rXSO3qd7S1ku+f98OVEPJnG5alUZYnFDET2jPA/wrNnX6FYH7j
         0Ted1DWTmtN2eLgwwx1gd9zWYj2SfGHFGdgrQlB9aVEMApmH22z
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Renato Botelho <garga@FreeBSD.org>
Subject: [PATCH v2] gc: use temporary file for editing crontab
Date:   Sun, 28 Aug 2022 21:41:43 +0000
Message-Id: <20220828214143.754759-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a
In-Reply-To: <20220823010120.25388-1-sandals@crustytoothpaste.net>
References: <20220823010120.25388-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While cron is specified by POSIX, there are a wide variety of
implementations in use.  On FreeBSD, the cron implementation requires a
file name argument: if the user wants to edit standard input, they must
specify "-".  However, this notation is not specified by POSIX, allowing
the possibility that making such a change may break other, less common
implementations.

Since POSIX tells us that cron must accept a file name argument, let's
solve this problem by specifying a temporary file instead.  This will
ensure that we work with the vast majority of implementations.

Note that because delete_tempfile closes the file for us, we should not
call fclose here on the handle, since doing so will introduce a double
free.

Reported-by: Renato Botelho <garga@FreeBSD.org>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
Changes from v1:

* Use `goto out;` in additional places.
* Fix broken test.
* Use `delete_tempfile`.
* Improve commit message to mention `fclose` rationale.

 builtin/gc.c            | 39 +++++++++++++++++++++++----------------
 t/helper/test-crontab.c |  4 ++--
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index eeff2b760e..0d9e6dabef 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -2065,6 +2065,7 @@ static int crontab_update_schedule(int run_maintenance, int fd)
 	struct child_process crontab_edit = CHILD_PROCESS_INIT;
 	FILE *cron_list, *cron_in;
 	struct strbuf line = STRBUF_INIT;
+	struct tempfile *tmpedit = NULL;
 
 	get_schedule_cmd(&cmd, NULL);
 	strvec_split(&crontab_list.args, cmd);
@@ -2079,6 +2080,17 @@ static int crontab_update_schedule(int run_maintenance, int fd)
 	/* Ignore exit code, as an empty crontab will return error. */
 	finish_command(&crontab_list);
 
+	tmpedit = mks_tempfile_t(".git_cron_edit_tmpXXXXXX");
+	if (!tmpedit) {
+		result = error(_("failed to create crontab temporary file"));
+		goto out;
+	}
+	cron_in = fdopen_tempfile(tmpedit, "w");
+	if (!cron_in) {
+		result = error(_("failed to open temporary file"));
+		goto out;
+	}
+
 	/*
 	 * Read from the .lock file, filtering out the old
 	 * schedule while appending the new schedule.
@@ -2086,19 +2098,6 @@ static int crontab_update_schedule(int run_maintenance, int fd)
 	cron_list = fdopen(fd, "r");
 	rewind(cron_list);
 
-	strvec_split(&crontab_edit.args, cmd);
-	crontab_edit.in = -1;
-	crontab_edit.git_cmd = 0;
-
-	if (start_command(&crontab_edit))
-		return error(_("failed to run 'crontab'; your system might not support 'cron'"));
-
-	cron_in = fdopen(crontab_edit.in, "w");
-	if (!cron_in) {
-		result = error(_("failed to open stdin of 'crontab'"));
-		goto done_editing;
-	}
-
 	while (!strbuf_getline_lf(&line, cron_list)) {
 		if (!in_old_region && !strcmp(line.buf, BEGIN_LINE))
 			in_old_region = 1;
@@ -2132,14 +2131,22 @@ static int crontab_update_schedule(int run_maintenance, int fd)
 	}
 
 	fflush(cron_in);
-	fclose(cron_in);
-	close(crontab_edit.in);
 
-done_editing:
+	strvec_split(&crontab_edit.args, cmd);
+	strvec_push(&crontab_edit.args, get_tempfile_path(tmpedit));
+	crontab_edit.git_cmd = 0;
+
+	if (start_command(&crontab_edit)) {
+		result = error(_("failed to run 'crontab'; your system might not support 'cron'"));
+		goto out;
+	}
+
 	if (finish_command(&crontab_edit))
 		result = error(_("'crontab' died"));
 	else
 		fclose(cron_list);
+out:
+	delete_tempfile(&tmpedit);
 	return result;
 }
 
diff --git a/t/helper/test-crontab.c b/t/helper/test-crontab.c
index e7c0137a47..2942543046 100644
--- a/t/helper/test-crontab.c
+++ b/t/helper/test-crontab.c
@@ -17,8 +17,8 @@ int cmd__crontab(int argc, const char **argv)
 		if (!from)
 			return 0;
 		to = stdout;
-	} else if (argc == 2) {
-		from = stdin;
+	} else if (argc == 3) {
+		from = fopen(argv[2], "r");
 		to = fopen(argv[1], "w");
 	} else
 		return error("unknown arguments");
