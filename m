From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/5] diff: acknowledge --submodule=short command-line option
Date: Tue,  2 Oct 2012 22:21:08 +0530
Message-ID: <1349196670-2844-4-git-send-email-artagnon@gmail.com>
References: <1349196670-2844-1-git-send-email-artagnon@gmail.com>
Cc: Jens Lehmann <Jens.Lehmann@web.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 18:52:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ5hf-0007bu-Tb
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 18:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233Ab2JBQvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 12:51:50 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61183 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730Ab2JBQvi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 12:51:38 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so8944010pbb.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 09:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Z1X9xm9AwpoF86OYJdi8hEBJuaS/OBjZ1sOdIPW1Y5A=;
        b=NpXGkcLh41LnHQrD/QsATpBEB2mP3Je0tQPwj0pZ/uGx5xjSwzXpfzgHbIFhGHw2qU
         6i0i+3WUNy8yczao41lplfMNc3GbJeRj2WWuPx3zCoAYXSXUR+k1u8P7w9knBhJduhMq
         6057CkyKxz1Jq6g/TNMYyPtEj3H4U6ApCOVQDu5SACbr6y+lBR+q2NvDnnMRaV7bKcmT
         1qZ48r6NBmqB1btFcIRuOiT0DDfDfoHbc0lhlwYG/Tj/4//gyHaZBxzudvRbuK1Yb/yw
         VBHlGkRUOj98/im+QQ+JUx+y+rkvdvVwhsLZQBnPiitxKfYrge//B2ScfeL1KnKxi6ib
         p8Lg==
Received: by 10.66.74.196 with SMTP id w4mr45468626pav.32.1349196697803;
        Tue, 02 Oct 2012 09:51:37 -0700 (PDT)
Received: from localhost.localdomain ([49.206.137.123])
        by mx.google.com with ESMTPS id qd9sm1151524pbb.31.2012.10.02.09.51.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Oct 2012 09:51:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <1349196670-2844-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206815>

Currently, the diff code does not differentiate between an explicit
'--submodule=short' being passed, and no submodule option being passed
on the command line.  Making this differentiation will be important
when the command-line option can be used to override a
"diff.submoduleFormat" configuration variable introduced in the next
patch.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 diff.c |    4 +++-
 diff.h |   17 +++++++++--------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index 35d3f07..8ea40f9 100644
--- a/diff.c
+++ b/diff.c
@@ -3647,7 +3647,9 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	} else if (!strcmp(arg, "--submodule"))
 		DIFF_OPT_SET(options, SUBMODULE_LOG);
 	else if (!prefixcmp(arg, "--submodule=")) {
-		if (!strcmp(arg + 12, "log"))
+		if (!strcmp(arg + 12, "short"))
+			DIFF_OPT_SET(options, SUBMODULE_SHORT);
+		else if (!strcmp(arg + 12, "log"))
 			DIFF_OPT_SET(options, SUBMODULE_LOG);
 	}
 
diff --git a/diff.h b/diff.h
index a658f85..4115b49 100644
--- a/diff.h
+++ b/diff.h
@@ -77,14 +77,15 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_DIRSTAT_BY_FILE     (1 << 20)
 #define DIFF_OPT_ALLOW_TEXTCONV      (1 << 21)
 #define DIFF_OPT_DIFF_FROM_CONTENTS  (1 << 22)
-#define DIFF_OPT_SUBMODULE_LOG       (1 << 23)
-#define DIFF_OPT_DIRTY_SUBMODULES    (1 << 24)
-#define DIFF_OPT_IGNORE_UNTRACKED_IN_SUBMODULES (1 << 25)
-#define DIFF_OPT_IGNORE_DIRTY_SUBMODULES (1 << 26)
-#define DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG (1 << 27)
-#define DIFF_OPT_DIRSTAT_BY_LINE     (1 << 28)
-#define DIFF_OPT_FUNCCONTEXT         (1 << 29)
-#define DIFF_OPT_PICKAXE_IGNORE_CASE (1 << 30)
+#define DIFF_OPT_SUBMODULE_SHORT     (1 << 23)
+#define DIFF_OPT_SUBMODULE_LOG       (1 << 24)
+#define DIFF_OPT_DIRTY_SUBMODULES    (1 << 25)
+#define DIFF_OPT_IGNORE_UNTRACKED_IN_SUBMODULES (1 << 26)
+#define DIFF_OPT_IGNORE_DIRTY_SUBMODULES (1 << 27)
+#define DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG (1 << 28)
+#define DIFF_OPT_DIRSTAT_BY_LINE     (1 << 29)
+#define DIFF_OPT_FUNCCONTEXT         (1 << 30)
+#define DIFF_OPT_PICKAXE_IGNORE_CASE (1 << 31)
 
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
-- 
1.7.8.1.362.g5d6df.dirty
