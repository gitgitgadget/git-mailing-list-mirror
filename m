From: Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 1/2] submodule: implement `module_list` as a builtin helper
Date: Fri, 31 Jul 2015 16:09:06 -0700
Message-ID: <1438384147-3275-2-git-send-email-sbeller@google.com>
References: <1438384147-3275-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, Jens.Lehmann@web.de,
	hvoigt@hvoigt.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 01 01:09:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLJQv-0001WE-Gg
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 01:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108AbbGaXJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 19:09:41 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34677 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570AbbGaXJf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 19:09:35 -0400
Received: by pacan13 with SMTP id an13so48374907pac.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 16:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=enUzWn+fFNtK/0eDolu5aJH2eUWbBoMprxsLiDON/NA=;
        b=myJ1ZACME0IBlbyds9kRXXn4MsqtWVESOu0oe0bNJBQ8sh3ekTvceejyi3wdtT8JyL
         ETk0VIMOUimkR5zfYIzeC7s1uIJWdtulB4uYsHlGbM7AAz8Ga7U7zuXDiIvjEwKcQ/RF
         9m0V91bE23yoPSRdDziZBMKpAKNIhAVMfGUIG2GqQaGK6SD3fq0xqg1RJUzTeEX2flQB
         mHhLxaS6fMdVXf24kw64rplGfISO85Xzam2ml3YnW03WHvPhnV2DiVfnkj5tvHYZp63Y
         z9yCZ6quHQ5dUK8Dp3RURXPwsLUSKERF/dOamM/NAc0yosJ8wGM3gWg3Mx8IcOXgzvEU
         H/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=enUzWn+fFNtK/0eDolu5aJH2eUWbBoMprxsLiDON/NA=;
        b=gAYH2ANCUDB/TCMu86ZVzDt+NcWpPPgEpT9Ui6pqbzRC+sVS5XqH+CM6Lj07KPwN//
         tglv6D61KHo8XF0BGUcTfoOmehAMdh1qb4kysrXb+07f/3YJLJzvD9aZ2SGWF+UkHz+b
         vN1GakIXD9HZip5Cs3a6dhuIWCkT566oanKWeu1i9krv5w7rldyvim9ealhD41Xw3a8z
         xA4Gq6ttY1Z5zKuiIR2MI63LI6gptxHQzIEozPdX5QieuzkSxTORQYJ3SCyeJr5+Nsrd
         F2zK3HIqYZpNqSCivZ8xEe8u0VJH4OCTT9lT7hUOZM+OBXIbkBaI2Pg2+UsVBCeIbJET
         DdzA==
X-Gm-Message-State: ALoCoQmewvh65hBCi3xtoSYKgNwnmLeajTFZBzij7qHFeKadog5b7jiiuImtai6fYAipDz3Zb1BJ
X-Received: by 10.66.141.42 with SMTP id rl10mr11995938pab.25.1438384174830;
        Fri, 31 Jul 2015 16:09:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:e5af:ce62:986f:5269])
        by smtp.gmail.com with ESMTPSA id xf6sm11266pbc.70.2015.07.31.16.09.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 Jul 2015 16:09:34 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.5.gf4cd9ae.dirty
In-Reply-To: <1438384147-3275-1-git-send-email-sbeller@google.com>
In-Reply-To: <1438301956-1658-1-git-send-email-sbeller@google.com>
References: <1438301956-1658-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275090>

Most of the submodule operations work on a set of submodules.
Calculating and using this set is usually done via:

       module_list "$@" | {
           while read mode sha1 stage sm_path
           do
                # the actual operation
           done
       }

Currently the function `module_list` is implemented in the
git-submodule.sh as a shell script wrapping a perl script.
The rewrite is in C, such that it is faster and can later be
easily adapted when other functions are rewritten in C.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Makefile                    |  1 +
 builtin.h                   |  1 +
 builtin/submodule--helper.c | 99 +++++++++++++++++++++++++++++++++++++++++++++
 git.c                       |  1 +
 4 files changed, 102 insertions(+)
 create mode 100644 builtin/submodule--helper.c

diff --git a/Makefile b/Makefile
index 8c3c724..6fb7484 100644
--- a/Makefile
+++ b/Makefile
@@ -898,6 +898,7 @@ BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-ref.o
 BUILTIN_OBJS += builtin/stripspace.o
+BUILTIN_OBJS += builtin/submodule--helper.o
 BUILTIN_OBJS += builtin/symbolic-ref.o
 BUILTIN_OBJS += builtin/tag.o
 BUILTIN_OBJS += builtin/unpack-file.o
diff --git a/builtin.h b/builtin.h
index 9e04f97..7bf9597 100644
--- a/builtin.h
+++ b/builtin.h
@@ -118,6 +118,7 @@ extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_status(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
+extern int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_tag(int argc, const char **argv, const char *prefix);
 extern int cmd_tar_tree(int argc, const char **argv, const char *prefix);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
new file mode 100644
index 0000000..2e24fdc
--- /dev/null
+++ b/builtin/submodule--helper.c
@@ -0,0 +1,99 @@
+#include "builtin.h"
+#include "cache.h"
+#include "parse-options.h"
+#include "quote.h"
+#include "pathspec.h"
+#include "dir.h"
+
+static const char * const git_submodule_helper_usage[] = {
+	N_("git submodule--helper --module_list [<path>...]"),
+	NULL
+};
+
+int module_list(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	static struct pathspec pathspec;
+	const struct cache_entry **ce_entries = NULL;
+	int alloc = 0, used = 0;
+	char *ps_matched = NULL;
+	char *max_prefix;
+	int max_prefix_len;
+	struct string_list already_printed = STRING_LIST_INIT_NODUP;
+
+	parse_pathspec(&pathspec, 0,
+		       PATHSPEC_PREFER_FULL,
+		       prefix, argv);
+
+	/* Find common prefix for all pathspec's */
+	max_prefix = common_prefix(&pathspec);
+	max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
+
+	if (pathspec.nr)
+		ps_matched = xcalloc(1, pathspec.nr);
+
+	if (read_cache() < 0)
+		die("index file corrupt");
+
+	for (i = 0; i < active_nr; i++) {
+		const struct cache_entry *ce = active_cache[i];
+
+		if (!match_pathspec(&pathspec, ce->name, ce_namelen(ce),
+				    max_prefix_len, ps_matched,
+				    S_ISGITLINK(ce->ce_mode) | S_ISDIR(ce->ce_mode)))
+			continue;
+
+		if (S_ISGITLINK(ce->ce_mode)) {
+			ALLOC_GROW(ce_entries, used + 1, alloc);
+			ce_entries[used++] = ce;
+		}
+	}
+
+	if (ps_matched && report_path_error(ps_matched, &pathspec, prefix)) {
+		printf("#unmatched\n");
+		return 1;
+	}
+
+	for (i = 0; i < used; i++) {
+		const struct cache_entry *ce = ce_entries[i];
+
+		if (string_list_has_string(&already_printed, ce->name))
+			continue;
+
+		if (ce_stage(ce)) {
+			printf("%06o %s U\t", ce->ce_mode, sha1_to_hex(null_sha1));
+		} else {
+			printf("%06o %s %d\t", ce->ce_mode, sha1_to_hex(ce->sha1), ce_stage(ce));
+		}
+		write_name_quoted(ce->name, stdout, '\n');
+		string_list_insert(&already_printed, ce->name);
+	}
+	return 0;
+}
+
+int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
+{
+	enum {
+		MODE_UNSPECIFIED = 0,
+		MODE_MODULE_LIST,
+	} cmdmode = MODE_UNSPECIFIED;
+
+	struct option options[] = {
+		OPT_CMDMODE(0, "module_list", &cmdmode,
+			    N_("Get the submodule list"), MODE_MODULE_LIST),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_submodule_helper_usage, 0);
+
+	switch (cmdmode) {
+	case MODE_MODULE_LIST:
+		return module_list(argc, argv, prefix);
+		break;
+	case MODE_UNSPECIFIED:
+		usage_with_options(git_submodule_helper_usage, options);
+		break;
+	}
+	return 0;
+}
diff --git a/git.c b/git.c
index fe94066..721995e 100644
--- a/git.c
+++ b/git.c
@@ -468,6 +468,7 @@ static struct cmd_struct commands[] = {
 	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
+	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP },
 	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 	{ "tag", cmd_tag, RUN_SETUP },
 	{ "unpack-file", cmd_unpack_file, RUN_SETUP },
-- 
2.5.0.5.gf4cd9ae.dirty
