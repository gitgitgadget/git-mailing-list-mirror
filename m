From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 02/19] parse-options-cb: implement parse_opt_passthru_argv()
Date: Thu, 18 Jun 2015 18:53:55 +0800
Message-ID: <1434624852-6869-3-git-send-email-pyokagan@gmail.com>
References: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 12:55:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5XT9-0001H1-RF
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 12:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889AbbFRKys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 06:54:48 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34975 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180AbbFRKyr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 06:54:47 -0400
Received: by pacyx8 with SMTP id yx8so59030577pac.2
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 03:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JgaofCyzE/pS7rWwDJ86qLwXQQAPfn2dr2PzLRSopCM=;
        b=mhxy1qYuoJEoIRPuqthavgO/osLBtIXABgZDjXnMaoJMQIe5230YvJTsataHEdmMc1
         gTXTG5izvTFlEQlB/JDGMgSvPCFlTXW9znCpprhKDdkEq5i+AIiVrfIb5qJhAtSMtMKv
         72nOxW4+dMz6Y/mJH3wleB1zDD00okGIx4Knl5J5hm5AmPl7h68wcjKrITaasn6FD/Nk
         Ti+AEm52F9oUNLmxo8wETd5mLvEWZdFRCW1p+nP/mNeQgfphHJPJX5lAjVyMKZGz3X0R
         jCOaji5i0oPlak6f86a7FbojbBQ+IeX7HJW87cduDha3KG0OG016lJVwUgwHho9tjBKB
         Lqtg==
X-Received: by 10.66.164.161 with SMTP id yr1mr19879538pab.63.1434624886936;
        Thu, 18 Jun 2015 03:54:46 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id eu5sm7735063pac.37.2015.06.18.03.54.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 03:54:45 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271945>

Certain git commands, such as git-pull, are simply wrappers around other
git commands like git-fetch, git-merge and git-rebase. As such, these
wrapper commands will typically need to "pass through" command-line
options of the commands they wrap.

Implement the parse_opt_passthru_argv() parse-options callback, which
will reconstruct all the provided command-line options into an
argv_array, such that it can be passed to another git command. This is
useful for passing command-line options that can be specified multiple
times.

Helped-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 Documentation/technical/api-parse-options.txt |  6 ++++++
 parse-options-cb.c                            | 20 ++++++++++++++++++++
 parse-options.h                               |  3 +++
 3 files changed, 29 insertions(+)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 85d10ab..0b0ab01 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -219,6 +219,12 @@ There are some macros to easily define options:
 	will be overwritten, so this should only be used for options where
 	the last one specified on the command line wins.
 
+`OPT_PASSTHRU_ARGV(short, long, &argv_array_var, arg_str, description, flags)`::
+	Introduce an option where all instances of it on the command-line will
+	be reconstructed into an argv_array. This is useful when you need to
+	pass the command-line option, which can be specified multiple times,
+	to another command.
+
 
 The last element of the array must be `OPT_END()`.
 
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 68bc593..5ab6ed6 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -4,6 +4,7 @@
 #include "commit.h"
 #include "color.h"
 #include "string-list.h"
+#include "argv-array.h"
 
 /*----- some often used options -----*/
 
@@ -183,3 +184,22 @@ int parse_opt_passthru(const struct option *opt, const char *arg, int unset)
 
 	return 0;
 }
+
+/**
+ * For an option opt, recreate the command-line option, appending it to
+ * opt->value which must be a argv_array. This is useful when we need to pass
+ * the command-line option, which can be specified multiple times, to another
+ * command.
+ */
+int parse_opt_passthru_argv(const struct option *opt, const char *arg, int unset)
+{
+	static struct strbuf sb = STRBUF_INIT;
+	struct argv_array *opt_value = opt->value;
+
+	if (recreate_opt(&sb, opt, arg, unset) < 0)
+		return -1;
+
+	argv_array_push(opt_value, sb.buf);
+
+	return 0;
+}
diff --git a/parse-options.h b/parse-options.h
index 5b0f886..aba06688 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -225,6 +225,7 @@ extern int parse_opt_tertiary(const struct option *, const char *, int);
 extern int parse_opt_string_list(const struct option *, const char *, int);
 extern int parse_opt_noop_cb(const struct option *, const char *, int);
 extern int parse_opt_passthru(const struct option *, const char *, int);
+extern int parse_opt_passthru_argv(const struct option *, const char *, int);
 
 #define OPT__VERBOSE(var, h)  OPT_COUNTUP('v', "verbose", (var), (h))
 #define OPT__QUIET(var, h)    OPT_COUNTUP('q', "quiet",   (var), (h))
@@ -245,5 +246,7 @@ extern int parse_opt_passthru(const struct option *, const char *, int);
 	{ OPTION_CALLBACK, (s), (l), (v), N_("style"), (h), PARSE_OPT_OPTARG, parseopt_column_callback }
 #define OPT_PASSTHRU(s, l, v, a, h, f) \
 	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), (f), parse_opt_passthru }
+#define OPT_PASSTHRU_ARGV(s, l, v, a, h, f) \
+	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), (f), parse_opt_passthru_argv }
 
 #endif
-- 
2.1.4
