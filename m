From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC PATCH] config: Introduce functions to write non-standard file
Date: Tue, 19 Jul 2011 03:07:12 +0530
Message-ID: <1311025032-835-1-git-send-email-artagnon@gmail.com>
References: <20110713190724.GA31965@sigill.intra.peff.net>
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 18 23:38:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QivVu-0005mF-01
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 23:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297Ab1GRVhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 17:37:52 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:41552 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103Ab1GRVhw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 17:37:52 -0400
Received: by pvg12 with SMTP id 12so3346327pvg.19
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 14:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=C0mj7tSs7HwqU//gPaQaxmANteuanDFXWjM7b80JPfU=;
        b=ZYsCYf507dJoG87iilSMGXgjb+Ymu4U3Xlvm29GWJwD4w6jsKZQMdmQ1YeE38RGoJn
         23igQMQWAcyNOvEMW81bnGzebZhtTOFkfKDerVu3nUMA8wKt8SyTfdxvhuASnzOvXsxd
         wC9dVBE6Ew80u558taWs49L2Q1xKgSusK9X4s=
Received: by 10.142.4.24 with SMTP id 24mr2567731wfd.143.1311025071421;
        Mon, 18 Jul 2011 14:37:51 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id r12sm3824640wfe.13.2011.07.18.14.37.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jul 2011 14:37:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <20110713190724.GA31965@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177412>

Introduce two new functions corresponding to "git_config_set" and
"git_config_set_multivar" to write a non-standard configuration file.
Expose thse new functions in cache.h for other git programs to use.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Although this patch is ready for inclusion as far as I'm concerned,
 I'm marking it an RFC because I will post it along with the latest
 iteration of the Sequencer -- there's some usage examples in that
 series that can justify the creation of two new functions.

 It may be classified as a workaround -- the more we encourage patches
 like this, the more cruft config.c will accumulate, and the harder
 it'll become to refactor completely.

 cache.h  |    2 ++
 config.c |   29 ++++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index bc9e5eb..833ee75 100644
--- a/cache.h
+++ b/cache.h
@@ -1056,9 +1056,11 @@ extern int git_config_bool(const char *, const char *);
 extern int git_config_maybe_bool(const char *, const char *);
 extern int git_config_string(const char **, const char *, const char *);
 extern int git_config_pathname(const char **, const char *, const char *);
+extern int git_config_set_in_file(const char *, const char *, const char *);
 extern int git_config_set(const char *, const char *);
 extern int git_config_parse_key(const char *, char **, int *);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
+extern int git_config_set_multivar_in_file(const char *, const char *, const char *, int, const char *);
 extern int git_config_rename_section(const char *, const char *);
 extern const char *git_etc_gitconfig(void);
 extern int check_repository_format_version(const char *var, const char *value, void *cb);
diff --git a/config.c b/config.c
index 1fc063b..3d9da6b 100644
--- a/config.c
+++ b/config.c
@@ -1092,9 +1092,22 @@ contline:
 	return offset;
 }
 
+int git_config_set_in_file(const char *key, const char *value,
+			const char *filename)
+{
+	const char *saved;
+	int ret;
+
+	saved = config_exclusive_filename;
+	config_exclusive_filename = filename;
+	ret = git_config_set_multivar(key, value, NULL, 0);
+	config_exclusive_filename = saved;
+	return ret;
+}
+
 int git_config_set(const char *key, const char *value)
 {
-	return git_config_set_multivar(key, value, NULL, 0);
+	return git_config_set_in_file(key, value, config_exclusive_filename);
 }
 
 /*
@@ -1387,6 +1400,20 @@ write_err_out:
 
 }
 
+int git_config_set_multivar_in_file(const char *key, const char *value,
+				const char *value_regex, int multi_replace,
+				const char *filename)
+{
+	const char *saved;
+	int ret;
+
+	saved = config_exclusive_filename;
+	config_exclusive_filename = filename;
+	ret = git_config_set_multivar(key, value, value_regex, multi_replace);
+	config_exclusive_filename = saved;
+	return ret;
+}
+
 static int section_name_match (const char *buf, const char *name)
 {
 	int i = 0, j = 0, dot = 0;
-- 
1.7.4.rc1.7.g2cf08.dirty
