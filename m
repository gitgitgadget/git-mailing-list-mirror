From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/3] submodule: display summary header in bold
Date: Thu,  1 Nov 2012 16:13:50 +0530
Message-ID: <1351766630-4837-4-git-send-email-artagnon@gmail.com>
References: <1351766630-4837-1-git-send-email-artagnon@gmail.com>
Cc: Jens Lehmann <Jens.Lehmann@web.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 11:44:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTsGE-00072O-Tw
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 11:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107Ab2KAKoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 06:44:11 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61418 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756249Ab2KAKoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 06:44:09 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1650246pbb.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 03:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0FksthzVOfrfc0MYih95eAEI2V2mFx6lBKsjEXnHi3g=;
        b=d6u22xxr8OpPSER3x6+wmHjRAwvG5BlFeT1wSMRwP8rw040iblxEi0IVQljSWB3eUk
         n7L34f0PIi4xyYe6zSFN2mWeK06pZ4FDtcnHJJ3Ef4BQxgFF3zP4tnhmadGttYlNXUGL
         1CdIRYrbfRIHaAesED9tf+Fh0p/rOpDcDGPGf06qvkbQjL5sQmrrP2nKn4/ut+PLZQ7Q
         rxMl5oO2KvHEB72472saB4k7UsVJ2NtgdFxJACLOrd82jprosxBLbNsewzWN5nZ0/joM
         ZIFd8NBvPNf0SHkAfZy2FLglM8/SeApm72DTOF2oVk6v4XfP0n8oob9iZ7beVjXylEFX
         VzGg==
Received: by 10.66.85.227 with SMTP id k3mr109799066paz.79.1351766649479;
        Thu, 01 Nov 2012 03:44:09 -0700 (PDT)
Received: from localhost.localdomain ([49.206.137.123])
        by mx.google.com with ESMTPS id vw4sm3855414pbc.26.2012.11.01.03.44.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2012 03:44:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <1351766630-4837-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208872>

Currently, 'git diff --submodule' displays output with a bold diff
header for non-submodules.  So this part is in bold:

    diff --git a/file1 b/file1
    index 30b2f6c..2638038 100644
    --- a/file1
    +++ b/file1

For submodules, the header looks like this:

    Submodule submodule1 012b072..248d0fd:

Unfortunately, it's easy to miss in the output because it's not bold.
Change this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 diff.c      |    2 +-
 submodule.c |    8 ++++----
 submodule.h |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 835eb26..115f384 100644
--- a/diff.c
+++ b/diff.c
@@ -2244,7 +2244,7 @@ static void builtin_diff(const char *name_a,
 		const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
 		show_submodule_summary(o->file, one ? one->path : two->path,
 				one->sha1, two->sha1, two->dirty_submodule,
-				del, add, reset);
+				set, del, add, reset);
 		return;
 	}
 
diff --git a/submodule.c b/submodule.c
index e3e0b45..c10182e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -258,7 +258,7 @@ int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
 
 void show_submodule_summary(FILE *f, const char *path,
 		unsigned char one[20], unsigned char two[20],
-		unsigned dirty_submodule,
+		unsigned dirty_submodule, const char *set,
 		const char *del, const char *add, const char *reset)
 {
 	struct rev_info rev;
@@ -292,15 +292,15 @@ void show_submodule_summary(FILE *f, const char *path,
 		return;
 	}
 
-	strbuf_addf(&sb, "Submodule %s %s..", path,
+	strbuf_addf(&sb, "%sSubmodule %s %s..", set, path,
 			find_unique_abbrev(one, DEFAULT_ABBREV));
 	if (!fast_backward && !fast_forward)
 		strbuf_addch(&sb, '.');
 	strbuf_addf(&sb, "%s", find_unique_abbrev(two, DEFAULT_ABBREV));
 	if (message)
-		strbuf_addf(&sb, " %s\n", message);
+		strbuf_addf(&sb, " %s%s\n", message, reset);
 	else
-		strbuf_addf(&sb, "%s:\n", fast_backward ? " (rewind)" : "");
+		strbuf_addf(&sb, "%s:%s\n", fast_backward ? " (rewind)" : "", reset);
 	fwrite(sb.buf, sb.len, 1, f);
 
 	if (!message) {
diff --git a/submodule.h b/submodule.h
index f2e8271..997fd06 100644
--- a/submodule.h
+++ b/submodule.h
@@ -20,7 +20,7 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
 int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
 void show_submodule_summary(FILE *f, const char *path,
 		unsigned char one[20], unsigned char two[20],
-		unsigned dirty_submodule,
+		unsigned dirty_submodule, const char *set,
 		const char *del, const char *add, const char *reset);
 void set_config_fetch_recurse_submodules(int value);
 void check_for_new_submodule_commits(unsigned char new_sha1[20]);
-- 
1.7.8.1.362.g5d6df.dirty
