From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 01/19] parse-options-cb: implement parse_opt_passthru()
Date: Thu, 18 Jun 2015 18:53:54 +0800
Message-ID: <1434624852-6869-2-git-send-email-pyokagan@gmail.com>
References: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 12:54:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5XT8-0001H1-UM
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 12:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870AbbFRKyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 06:54:45 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35353 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463AbbFRKyo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 06:54:44 -0400
Received: by pdbci14 with SMTP id ci14so5691290pdb.2
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 03:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=30fAMWaAlR/77pyrgCT2uZZPCBOgSLnAIO6714QuRGo=;
        b=tbiIMNS+KEJmmS/RQNjHhwB6VnuucPWJ4vBGEY43Pc9TQf8LcS/q9zPzXxx57NlGPU
         dTU0Cqw4S6klCR/D29rD9Ky1qfNqSAqXAV5UH3RIo2E1S1/oY0ztaL6i98bH2Y0CE45h
         sHbm2lLz0qFc+QPc/XYX45uEkvQmaSsqsJvDz3YdgNQurnbGuXLGndQcpBk1H8d4OqW0
         jFMM88FO+X8H65WSJ81lGyKGsRc8Q5Lz0Ox779EzjjhMgJgkt4vIOKrTxaforn4kWnU/
         BMQ49SMcZn/Yz7MwZyiNcYfCQDO31DJ2eBsJvD+6mUbGnAgD7AvMCQ1g3UTtSNWWSWU2
         6JvA==
X-Received: by 10.66.62.163 with SMTP id z3mr19926237par.12.1434624883684;
        Thu, 18 Jun 2015 03:54:43 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id eu5sm7735063pac.37.2015.06.18.03.54.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 03:54:41 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271944>

Certain git commands, such as git-pull, are simply wrappers around other
git commands like git-fetch, git-merge and git-rebase. As such, these
wrapper commands will typically need to "pass through" command-line
options of the commands they wrap.

Implement the parse_opt_passthru() parse-options callback, which will
reconstruct the command-line option into an char* string, such that it
can be passed to another git command.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 Documentation/technical/api-parse-options.txt |  7 ++++
 parse-options-cb.c                            | 49 +++++++++++++++++++++++++++
 parse-options.h                               |  3 ++
 3 files changed, 59 insertions(+)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 1f2db31..85d10ab 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -212,6 +212,13 @@ There are some macros to easily define options:
 	Use it to hide deprecated options that are still to be recognized
 	and ignored silently.
 
+`OPT_PASSTHRU(short, long, &char_var, arg_str, description, flags)`::
+	Introduce an option that will be reconstructed into a char* string,
+	which must be initialized to NULL. This is useful when you need to
+	pass the command-line option to another command. Any previous value
+	will be overwritten, so this should only be used for options where
+	the last one specified on the command line wins.
+
 
 The last element of the array must be `OPT_END()`.
 
diff --git a/parse-options-cb.c b/parse-options-cb.c
index be8c413..68bc593 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -134,3 +134,52 @@ int parse_opt_noop_cb(const struct option *opt, const char *arg, int unset)
 {
 	return 0;
 }
+
+/**
+ * Recreates the command-line option in the strbuf.
+ */
+static int recreate_opt(struct strbuf *sb, const struct option *opt,
+		const char *arg, int unset)
+{
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
+
+/**
+ * For an option opt, recreates the command-line option in opt->value which
+ * must be an char* initialized to NULL. This is useful when we need to pass
+ * the command-line option to another command. Since any previous value will be
+ * overwritten, this callback should only be used for options where the last
+ * one wins.
+ */
+int parse_opt_passthru(const struct option *opt, const char *arg, int unset)
+{
+	static struct strbuf sb = STRBUF_INIT;
+	char **opt_value = opt->value;
+
+	if (recreate_opt(&sb, opt, arg, unset) < 0)
+		return -1;
+
+	if (*opt_value)
+		free(*opt_value);
+
+	*opt_value = strbuf_detach(&sb, NULL);
+
+	return 0;
+}
diff --git a/parse-options.h b/parse-options.h
index c71e9da..5b0f886 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -224,6 +224,7 @@ extern int parse_opt_with_commit(const struct option *, const char *, int);
 extern int parse_opt_tertiary(const struct option *, const char *, int);
 extern int parse_opt_string_list(const struct option *, const char *, int);
 extern int parse_opt_noop_cb(const struct option *, const char *, int);
+extern int parse_opt_passthru(const struct option *, const char *, int);
 
 #define OPT__VERBOSE(var, h)  OPT_COUNTUP('v', "verbose", (var), (h))
 #define OPT__QUIET(var, h)    OPT_COUNTUP('q', "quiet",   (var), (h))
@@ -242,5 +243,7 @@ extern int parse_opt_noop_cb(const struct option *, const char *, int);
 	OPT_COLOR_FLAG(0, "color", (var), (h))
 #define OPT_COLUMN(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), N_("style"), (h), PARSE_OPT_OPTARG, parseopt_column_callback }
+#define OPT_PASSTHRU(s, l, v, a, h, f) \
+	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), (f), parse_opt_passthru }
 
 #endif
-- 
2.1.4
