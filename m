From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 01/19] parse-options-cb: implement parse_opt_pass_strbuf()
Date: Wed,  3 Jun 2015 14:48:45 +0800
Message-ID: <1433314143-4478-2-git-send-email-pyokagan@gmail.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 08:49:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z02Ur-0004JQ-Fq
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 08:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbbFCGtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 02:49:49 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33628 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129AbbFCGts (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 02:49:48 -0400
Received: by padj3 with SMTP id j3so768349pad.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 23:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l0/+BhinUT9zHGgWsG17ZkY62myBNo6U6ZWD9SDR9ng=;
        b=kWpmoY0smOG8Dt9OT6gVwa+R5kZ7aa3ON2n/laeIRMn47IKOU8qu7G0cL4s4jbNkQz
         w4mOwDinTsq6c36mgigW+f4xf4VsizaIsX//a/0ksutkUq8N3wbFXemBnuR2d5L75xJd
         WdID5WhBIXx9BYsa6tYiHcTbCkO3TkZbblHdnGZY5PKtlNz1gR9hQBdPhdiwwxqlGcd/
         QEqKqliGwJip8YkwOHaoRswccuMSI4lcnxNlEFftHudKEZCOomtyLXCsPpg/3nNZwsw7
         RuWIWXvvgLquQzhXphj0UuBP6PQSJ+4AAcdBkmQsdwq7sWhbEOiuq5CjIyDBCdtpqMKR
         IUVA==
X-Received: by 10.70.101.2 with SMTP id fc2mr57598981pdb.77.1433314187700;
        Tue, 02 Jun 2015 23:49:47 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qt4sm19474130pbc.86.2015.06.02.23.49.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 23:49:46 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270638>

Certain git commands, such as git-pull, are simply wrappers around other
git commands like git-fetch, git-merge and git-rebase. As such, these
wrapper commands will typically need to "pass through" command-line
options of the commands they wrap.

Implement the parse_opt_pass_strbuf() parse-options callback, which will
reconstruct the command-line option into an strbuf, such that it can be
passed to another git command.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v2
    
    * Previously implemented as a static function in builtin/pull.c. It now
      uses an strbuf instead of returning newly-allocated strings, to make
      memory management easier.
    
    * We don't use defval anymore. Instead, we use long_name and short_name.

 parse-options-cb.c | 29 +++++++++++++++++++++++++++++
 parse-options.h    |  1 +
 2 files changed, 30 insertions(+)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index be8c413..5b1dbcf 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -134,3 +134,32 @@ int parse_opt_noop_cb(const struct option *opt, const char *arg, int unset)
 {
 	return 0;
 }
+
+/**
+ * For an option opt, recreates the command-line option in opt->value which
+ * must be an strbuf. This is useful when we need to pass the command-line
+ * option to another command.
+ */
+int parse_opt_pass_strbuf(const struct option *opt, const char *arg, int unset)
+{
+	struct strbuf *sb = opt->value;
+
+	strbuf_reset(sb);
+
+	if (opt->long_name) {
+		strbuf_addstr(sb, unset ? "--no-" : "--");
+		strbuf_addstr(sb, opt->long_name);
+		if (arg) {
+			strbuf_addch(sb, '=');
+			strbuf_addstr(sb, arg);
+		}
+	} else if (opt->short_name && !unset) {
+		strbuf_addch(sb, '-');
+		strbuf_addch(sb, opt->short_name);
+		if (arg)
+			strbuf_addstr(sb, arg);
+	} else
+		return -1;
+
+	return 0;
+}
diff --git a/parse-options.h b/parse-options.h
index c71e9da..1d21398 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -224,6 +224,7 @@ extern int parse_opt_with_commit(const struct option *, const char *, int);
 extern int parse_opt_tertiary(const struct option *, const char *, int);
 extern int parse_opt_string_list(const struct option *, const char *, int);
 extern int parse_opt_noop_cb(const struct option *, const char *, int);
+extern int parse_opt_pass_strbuf(const struct option *, const char *, int);
 
 #define OPT__VERBOSE(var, h)  OPT_COUNTUP('v', "verbose", (var), (h))
 #define OPT__QUIET(var, h)    OPT_COUNTUP('q', "quiet",   (var), (h))
-- 
2.1.4
