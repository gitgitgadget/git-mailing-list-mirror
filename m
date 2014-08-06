From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v8 4/8] change `git_config()` return value to void
Date: Wed,  6 Aug 2014 07:53:08 -0700
Message-ID: <1407336792-16962-5-git-send-email-tanayabh@gmail.com>
References: <1407336792-16962-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 06 17:01:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF2i7-0000BC-QL
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 17:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818AbaHFPA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 11:00:56 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:58683 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696AbaHFPAz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 11:00:55 -0400
Received: by mail-pd0-f170.google.com with SMTP id g10so3450415pdj.15
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 08:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KHgDjku2cGk64yAccRP8ANSZBW7qYrS2E6Cqzl/7P/4=;
        b=l/sQJI0EpPjodeb0lDLsZPBil2YWoHHnbiKVplBqSrkoERiwslHFFkWjr7Pvp9q0+B
         EMsQhb2kYPao8Yi+BfGse9ITaQR9DgnGgaroauFw2MB24Ie8L783g9U2X39RsP2236av
         7YWnOyvfXXNHEdPGHbnV1g7SaIR1DePyjn+lTLr0cMoSsFOLHKVYt7CzJGPWnhZZ6QRa
         wwBnX1mFRqPmoNDY2Si3Z/jD4QKcWRlSN7nDNmOoKc7Z9PaWGoGjVJLpoPMvVXbaydwt
         k4QZFgt/hxHTKZt8d5byzHTUKjn4f6MFS6vEtl/fQCch3QoH8Rj/i71co8mwCDRvPwD2
         v8HA==
X-Received: by 10.68.164.164 with SMTP id yr4mr11747046pbb.57.1407337255456;
        Wed, 06 Aug 2014 08:00:55 -0700 (PDT)
Received: from localhost.localdomain ([223.176.214.188])
        by mx.google.com with ESMTPSA id u2sm1547305pbs.42.2014.08.06.08.00.52
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 06 Aug 2014 08:00:54 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407336792-16962-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254860>

Currently `git_config()` returns an integer signifying an error code.
During rewrites of the function most of the code was shifted to
`git_config_with_options()`. `git_config_with_options()` normally
returns positive values if its `config_source` parameter is set as NULL,
as most errors are fatal, and non-fatal potential errors are guarded
by "if" statements that are entered only when no error is possible.

Still a negative value can be returned in case of race condition between
`access_or_die()` & `git_config_from_file()`. Also, all callers of
`git_config()` ignore the return value except for one case in branch.c.

Change `git_config()` return value to void and make it die if it receives
a negative value from `git_config_with_options()`.

Original-patch-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 branch.c |  5 +----
 cache.h  |  2 +-
 config.c | 16 ++++++++++++++--
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/branch.c b/branch.c
index 46e8aa8..735767d 100644
--- a/branch.c
+++ b/branch.c
@@ -161,10 +161,7 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
 	strbuf_addf(&name, "branch.%s.description", branch_name);
 	cb.config_name = name.buf;
 	cb.value = NULL;
-	if (git_config(read_branch_desc_cb, &cb) < 0) {
-		strbuf_release(&name);
-		return -1;
-	}
+	git_config(read_branch_desc_cb, &cb);
 	if (cb.value)
 		strbuf_addstr(buf, cb.value);
 	strbuf_release(&name);
diff --git a/cache.h b/cache.h
index 0b1bdfd..f11ce41 100644
--- a/cache.h
+++ b/cache.h
@@ -1294,7 +1294,7 @@ extern int git_config_from_buf(config_fn_t fn, const char *name,
 			       const char *buf, size_t len, void *data);
 extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
-extern int git_config(config_fn_t fn, void *);
+extern void git_config(config_fn_t fn, void *);
 extern int git_config_with_options(config_fn_t fn, void *,
 				   struct git_config_source *config_source,
 				   int respect_includes);
diff --git a/config.c b/config.c
index e4d745e..4cefa25 100644
--- a/config.c
+++ b/config.c
@@ -1230,9 +1230,21 @@ int git_config_with_options(config_fn_t fn, void *data,
 	return ret;
 }
 
-int git_config(config_fn_t fn, void *data)
+void git_config(config_fn_t fn, void *data)
 {
-	return git_config_with_options(fn, data, NULL, 1);
+	if (git_config_with_options(fn, data, NULL, 1) < 0)
+		/*
+		 * git_config_with_options() normally returns only
+		 * positive values, as most errors are fatal, and
+		 * non-fatal potential errors are guarded by "if"
+		 * statements that are entered only when no error is
+		 * possible.
+		 *
+		 * If we ever encounter a non-fatal error, it means
+		 * something went really wrong and we should stop
+		 * immediately.
+		 */
+		die(_("unknown error occured while reading the configuration files"));
 }
 
 static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)
-- 
1.9.0.GIT
