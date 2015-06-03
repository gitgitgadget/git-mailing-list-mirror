From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 02/19] parse-options-cb: implement parse_opt_pass_argv_array()
Date: Wed,  3 Jun 2015 14:48:46 +0800
Message-ID: <1433314143-4478-3-git-send-email-pyokagan@gmail.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 08:50:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z02Uv-0004ND-V3
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 08:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248AbbFCGtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 02:49:53 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:34868 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236AbbFCGtv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 02:49:51 -0400
Received: by pdbnf5 with SMTP id nf5so735814pdb.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 23:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BxkAT4azgOUTp4ZU+ycIwwzsyaKAwodXyW4PWjXgwgs=;
        b=utZC08anvXnjVuYBBzdjM22a5avA3suxmTsnV4hmK8JvpZYt+Y4QDQNiOf/jU+RwOH
         rL9KJhOU9dP9MDFZTVNDgC7olpnaKCSIQTeGEPx56luDkY02xUYwlv5pUHbz/dMCVv/r
         PuJCz5ZUd+iTta2zpWLFsNzWjRohiLsaG7HMziX1zpeD9lr6yZT/rRjiQ+1lRWFB6Z8M
         Hy0GDU4OYd6Ylqna4V/Xf6Fo3j+FmtT2R5cI7/j8QLXQV7KRuAaWFfDNoOv/9omWJpYX
         ziHYmEXMs4y4VuOBPCNE6n1t5pulSMup0jkrVMLqZoexEbW682rTDsuTsV0ESGXW6Ksx
         WELQ==
X-Received: by 10.66.155.197 with SMTP id vy5mr57672934pab.104.1433314190712;
        Tue, 02 Jun 2015 23:49:50 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qt4sm19474130pbc.86.2015.06.02.23.49.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 23:49:49 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270641>

Certain git commands, such as git-pull, are simply wrappers around other
git commands like git-fetch, git-merge and git-rebase. As such, these
wrapper commands will typically need to "pass through" command-line
options of the commands they wrap.

Implement the parse_opt_pass_argv_array() parse-options callback, which
will reconstruct all the provided command-line options into an
argv_array, such that it can be passed to another git command. This is
useful for passing command-line options that can be specified multiple
times.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v2
    
    * This function is a requirement for the rewrite of git-am to handle
      passing git-apply's options to git-apply. Since it would be
      implemented anyway I thought it would be good if git-pull could take
      advantage of it as well to handle --strategy and --strategy-option.

 parse-options-cb.c | 32 ++++++++++++++++++++++++++++++++
 parse-options.h    |  1 +
 2 files changed, 33 insertions(+)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index 5b1dbcf..7330506 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -4,6 +4,7 @@
 #include "commit.h"
 #include "color.h"
 #include "string-list.h"
+#include "argv-array.h"
 
 /*----- some often used options -----*/
 
@@ -163,3 +164,34 @@ int parse_opt_pass_strbuf(const struct option *opt, const char *arg, int unset)
 
 	return 0;
 }
+
+/**
+ * For an option opt, recreate the command-line option, appending it to
+ * opt->value which must be a argv_array. This is useful when we need to pass
+ * the command-line option, which can be specified multiple times, to another
+ * command.
+ */
+int parse_opt_pass_argv_array(const struct option *opt, const char *arg, int unset)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct argv_array *opt_value = opt->value;
+
+	if (opt->long_name) {
+		strbuf_addstr(&sb, unset ? "--no-" : "--");
+		strbuf_addstr(&sb, opt->long_name);
+		if (arg) {
+			strbuf_addch(&sb, '=');
+			strbuf_addstr(&sb, arg);
+		}
+	} else if (opt->short_name && !unset) {
+		strbuf_addch(&sb, '-');
+		strbuf_addch(&sb, opt->short_name);
+		if (arg)
+			strbuf_addstr(&sb, arg);
+	} else
+		return -1;
+
+	argv_array_push(opt_value, sb.buf);
+	strbuf_release(&sb);
+	return 0;
+}
diff --git a/parse-options.h b/parse-options.h
index 1d21398..b663f87 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -225,6 +225,7 @@ extern int parse_opt_tertiary(const struct option *, const char *, int);
 extern int parse_opt_string_list(const struct option *, const char *, int);
 extern int parse_opt_noop_cb(const struct option *, const char *, int);
 extern int parse_opt_pass_strbuf(const struct option *, const char *, int);
+extern int parse_opt_pass_argv_array(const struct option *, const char *, int);
 
 #define OPT__VERBOSE(var, h)  OPT_COUNTUP('v', "verbose", (var), (h))
 #define OPT__QUIET(var, h)    OPT_COUNTUP('q', "quiet",   (var), (h))
-- 
2.1.4
