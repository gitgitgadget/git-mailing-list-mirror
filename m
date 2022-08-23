Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A29C28D13
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 01:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbiHWBBt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 21:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238679AbiHWBBm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 21:01:42 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7805723C
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 18:01:27 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 98FD85A1AC;
        Tue, 23 Aug 2022 01:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1661216486;
        bh=+QOBTIU7olqIGY9mLwPTFulyaF5ylPr0UXthfFkc62A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=TsCUNU5BLMkxkdZcF2+VKwS7TRFwSj6uNZn0W/pzTyZHww0SsZAfa2DiV6R4pPRRU
         gmXhOH335NVHB4ypO+yAo9JzA4fW/WfRb3rYazHBIVDWOtqw000wDFELaeUey4vKCy
         0x2YNO2WZhxGeP21j6IyAJQ9RKzqruxbzR8YXRYor9nx18P2Ily86QMrgGU5ZdiaHS
         LXxs83EF8XEY2QGqcK5yyiY21lgbGF8FmfCNs/CRSlLrtUiDoCK1be3Dt9YO91CkCm
         yP52x4Qi4Ov14JVGUI0ezvIRBxSebqhAedGs2hJlTcuSCTT2Wxto+hRWIrYHMp/p6+
         Qg15rIWfUMM8Qu4dwsvnIh/oX/XGFh9gGvB30YdXbHzlf0/yuMcWYdFiwYTe3SjLLZ
         FFMBNMvMi4EDB9yv/6anDbXcxuBAv6EqoOgJ30q4ylSRSmNIRO2zO1/Xqm3SrWXFjD
         A5Drm+U5me2/ccpaIvxpQfwDWda9ba28azX5alpK47pglq+R75t
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Renato Botelho <garga@FreeBSD.org>,
        Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH] gc: use temporary file for editing crontab
Date:   Tue, 23 Aug 2022 01:01:20 +0000
Message-Id: <20220823010120.25388-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a
In-Reply-To: <1dd29f43-1a8e-eb69-3320-7f5140a0e18e@github.com>
References: <1dd29f43-1a8e-eb69-3320-7f5140a0e18e@github.com>
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

Reported-by: Renato Botelho <garga@FreeBSD.org>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
My apologies for the delay on this.  I forgot when I'd send a patch that
I had a wedding out of town.

 builtin/gc.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index eeff2b760e..168dbdb5d9 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -2065,6 +2065,7 @@ static int crontab_update_schedule(int run_maintenance, int fd)
 	struct child_process crontab_edit = CHILD_PROCESS_INIT;
 	FILE *cron_list, *cron_in;
 	struct strbuf line = STRBUF_INIT;
+	struct tempfile *tmpedit;
 
 	get_schedule_cmd(&cmd, NULL);
 	strvec_split(&crontab_list.args, cmd);
@@ -2079,6 +2080,15 @@ static int crontab_update_schedule(int run_maintenance, int fd)
 	/* Ignore exit code, as an empty crontab will return error. */
 	finish_command(&crontab_list);
 
+	tmpedit = mks_tempfile_t(".git_cron_edit_tmpXXXXXX");
+	if (!tmpedit)
+		return error(_("failed to create crontab temporary file"));
+	cron_in = fdopen_tempfile(tmpedit, "w");
+	if (!cron_in) {
+		result = error(_("failed to open temporary file"));
+		goto out;
+	}
+
 	/*
 	 * Read from the .lock file, filtering out the old
 	 * schedule while appending the new schedule.
@@ -2086,19 +2096,6 @@ static int crontab_update_schedule(int run_maintenance, int fd)
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
@@ -2132,14 +2129,22 @@ static int crontab_update_schedule(int run_maintenance, int fd)
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
+	close_tempfile_gently(tmpedit);
 	return result;
 }
 
