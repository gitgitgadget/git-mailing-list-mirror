From: Pang Yan Han <pangyanhan@gmail.com>
Subject: [PATCH/RFC 2/2] format-patch: produce non colorized patches when ui.color=always
Date: Mon, 12 Sep 2011 23:56:56 +0800
Message-ID: <1315843016-10959-3-git-send-email-pangyanhan@gmail.com>
References: <1315843016-10959-1-git-send-email-pangyanhan@gmail.com>
Cc: gitster@pobox.com, peff@peff.net, martin.von.zweigbergk@gmail.com,
	sdaoden@googlemail.com, ib@wupperonline.de,
	Pang Yan Han <pangyanhan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 17:59:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R38uw-0003jd-JA
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 17:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758288Ab1ILP70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 11:59:26 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53961 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758077Ab1ILP7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 11:59:25 -0400
Received: by mail-vw0-f46.google.com with SMTP id 1so113778vws.19
        for <git@vger.kernel.org>; Mon, 12 Sep 2011 08:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=kTUL1GwCLGzR4XmfnlPUxV1zfGsOwqwKzYVs8NXclDQ=;
        b=fBc3MHw6IvqmIx6uQ+oK5N8lxvTHjhPtyo96kv99K6H54sEDkoe2QZpQffu0Adg44V
         ec3YCnk4/dcHv/8Zv2LD7KWRJfd6T1IhKFj6f/odogbAZL0YyRAeFhZPSdBRQPVfH0U5
         01ztzF3S4SdAVTRuT1om0GkqGr6zUXUM41GNU=
Received: by 10.52.117.100 with SMTP id kd4mr86514vdb.465.1315843164942;
        Mon, 12 Sep 2011 08:59:24 -0700 (PDT)
Received: from localhost (bb219-74-111-93.singnet.com.sg [219.74.111.93])
        by mx.google.com with ESMTPS id ch2sm10500091vdc.19.2011.09.12.08.59.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Sep 2011 08:59:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc0.190.gee9b6
In-Reply-To: <1315843016-10959-1-git-send-email-pangyanhan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181220>

commit c9bfb953 (want_color: automatically fallback to color.ui) introduced
a regression where format-patch produces colorized patches when color.ui is
set to "always".

Teach format-patch to disable colorized output by introducing the color_disable
function in color.c

Signed-off-by: Pang Yan Han <pangyanhan@gmail.com>
---
 builtin/log.c                 |    1 +
 color.c                       |    5 +++++
 color.h                       |    1 +
 t/t4051-format-patch-color.sh |    2 +-
 4 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index d760ee0..f62520d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1090,6 +1090,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	extra_to.strdup_strings = 1;
 	extra_cc.strdup_strings = 1;
 	git_config(git_format_config, NULL);
+	color_disable();
 	init_revisions(&rev, prefix);
 	rev.commit_format = CMIT_FMT_EMAIL;
 	rev.verbose_header = 1;
diff --git a/color.c b/color.c
index e8e2681..48e7208 100644
--- a/color.c
+++ b/color.c
@@ -207,6 +207,11 @@ int want_color(int var)
 	return var;
 }
 
+void color_disable(void)
+{
+	git_use_color_default = 0;
+}
+
 int git_color_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "color.ui")) {
diff --git a/color.h b/color.h
index 9a8495b..ff4e6e5 100644
--- a/color.h
+++ b/color.h
@@ -77,6 +77,7 @@ int git_color_default_config(const char *var, const char *value, void *cb);
 
 int git_config_colorbool(const char *var, const char *value);
 int want_color(int var);
+void color_disable(void);
 void color_parse(const char *value, const char *var, char *dst);
 void color_parse_mem(const char *value, int len, const char *var, char *dst);
 __attribute__((format (printf, 3, 4)))
diff --git a/t/t4051-format-patch-color.sh b/t/t4051-format-patch-color.sh
index db30840..44dba16 100755
--- a/t/t4051-format-patch-color.sh
+++ b/t/t4051-format-patch-color.sh
@@ -13,7 +13,7 @@ test_expect_success setup '
 	git commit -m "commit2"
 '
 
-test_expect_failure 'format patch with ui.color=always generates non colorized patch' '
+test_expect_success 'format patch with ui.color=always generates non colorized patch' '
 	git config color.ui always &&
 	git format-patch -1 &&
 	mv 0001-commit2.patch actual &&
-- 
1.7.7.rc0.190.g816e
