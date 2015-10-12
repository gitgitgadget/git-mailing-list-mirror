From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] Add fetch.recurseSubmoduleParallelism config option
Date: Mon, 12 Oct 2015 15:52:30 -0700
Message-ID: <1444690350-6486-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, hvoigt@hvoigt.net, jens.lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Oct 13 00:53:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zlly7-00066O-Vt
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 00:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606AbbJLWw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 18:52:59 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33086 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbbJLWw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 18:52:58 -0400
Received: by pabrc13 with SMTP id rc13so592754pab.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 15:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4sYobNyYNmG/5Bxaop69dXy5hMFl1zzUwSE+LGfwdXE=;
        b=C07EA07P0kJLY/TdPF7hhOk2y0iCn7sQcM/TPUk7UBKWpK4k4TCXVh3Pi1Sx//En08
         cGigpf/CPaE1qsSbc+mKGPV30GxRr6UOykM4rCtHYwwrCqBUo4ZevLDoVVEHpt+Kpey7
         O5uRKYX4IsRanaNyKXGQye+fYc7KkHP6EIZ52Mu+QWHJ6B91MJ3GJ7xZDXap8bSSB6K8
         bBgC1aF5omOvRIe5RufrBKqsUbJniqXph+B+vfplJQBEBB0QRUz7W9T45g68IjiEfF4k
         00lmaBD5EEieYTMJpaQnlUIiVrL1QLHdjGLAbQGNHkswa2FBPmK9+90NqXXjIBuHQBoP
         KN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4sYobNyYNmG/5Bxaop69dXy5hMFl1zzUwSE+LGfwdXE=;
        b=JzjfY0QZNSp+sRZUM0cVdvZjwtu1zHxWnHA0KBSu4RUEqf1MuIevSGzQBJEyg6Jth8
         Tken/A0iNlLLER3Q0ei1/RigxgTaV9w76/vtjZBk646iFXyRkRZ9o39G3TK+6yO2H49p
         sJDsBAgxnznHojHOiF+tE0eyjNnbXrqHSLm3uFBGSLFkU4FHpH2tslqdoHxoDu1IhwIR
         8faZ3uohQgYpPUtng0nSbn6fJgO708QOzzaIf+W+MPORcHTR+19+f+tgB5Jj/jnuWVtw
         gJYKYRYe74Pvsp2c5DxQr0sovXBVllj9nSzlwvRMYy1NQf3anoOe3DAByOdsyW6yS8Vv
         EPyw==
X-Gm-Message-State: ALoCoQktRFR5iJAytbBTlEDbNK51gLQZI8ZLgjkkAwlKW4gsrxXYkYD0dTgRwd3Ua8k9oIGWR0ry
X-Received: by 10.69.1.5 with SMTP id bc5mr36643489pbd.151.1444690377536;
        Mon, 12 Oct 2015 15:52:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:5950:8bdc:8939:e460])
        by smtp.gmail.com with ESMTPSA id ux7sm20419746pac.10.2015.10.12.15.52.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 12 Oct 2015 15:52:56 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.267.g8d6e698.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279470>

This allows to configure fetching in parallel without having the annoying
command line option.

This moved the responsibility to determine how many parallel processes
to start from builtin/fetch to submodule.c as we need a way to communicate
"The user did not specify the number of parallel processes in the command
line options" in the builtin fetch. The submodule code takes care of
the precedence (CLI > config > default)

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt |  6 ++++++
 builtin/fetch.c          |  2 +-
 submodule.c              | 14 ++++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)
 
 I just monkey tested the code and it worked once! The problem with testing
 this parallelizing option is that the expected behavior doesn't change
 except for being faster. And I don't want to add timing tests to the test
 suite because they are unreliable.
 
 Any idea how to test this properly?
 
 This applies on top of sb/submodule-parallel-fetch
 
 Thanks,
 Stefan
 

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 315f271..1172db0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1140,6 +1140,12 @@ fetch.recurseSubmodules::
 	when its superproject retrieves a commit that updates the submodule's
 	reference.
 
+fetch.recurseSubmoduleParallelism
+	This is used to determine how many submodules can be fetched in
+	parallel. Specifying a positive integer allows up to that number
+	of submodules being fetched in parallel. Specifying 0 the number
+	of cpus will be taken as the maximum number.
+
 fetch.fsckObjects::
 	If it is set to true, git-fetch-pack will check all fetched
 	objects. It will abort in the case of a malformed object or a
diff --git a/builtin/fetch.c b/builtin/fetch.c
index f28eac6..b1399dc 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -37,7 +37,7 @@ static int prune = -1; /* unspecified */
 static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity;
 static int progress = -1, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int tags = TAGS_DEFAULT, unshallow, update_shallow;
-static int max_children = 1;
+static int max_children = -1;
 static const char *depth;
 static const char *upload_pack;
 static struct strbuf default_rla = STRBUF_INIT;
diff --git a/submodule.c b/submodule.c
index c21b265..c85d3ef 100644
--- a/submodule.c
+++ b/submodule.c
@@ -15,6 +15,7 @@
 #include "thread-utils.h"
 
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
+static int config_fetch_parallel_submodules = -1;
 static struct string_list changed_submodule_paths;
 static int initialized_fetch_ref_tips;
 static struct sha1_array ref_tips_before_fetch;
@@ -179,6 +180,14 @@ int submodule_config(const char *var, const char *value, void *cb)
 	else if (!strcmp(var, "fetch.recursesubmodules")) {
 		config_fetch_recurse_submodules = parse_fetch_recurse_submodules_arg(var, value);
 		return 0;
+	} else if (!strcmp(var, "fetch.recursesubmoduleparallelism")) {
+		char *end;
+		int ret;
+		config_fetch_parallel_submodules = strtol(value, &end, 0);
+		ret = (*end == '\0');
+		if (!ret)
+			warning("value for fetch.recurseSubmoduleParallelism not recognized");
+		return ret;
 	}
 	return 0;
 }
@@ -759,6 +768,11 @@ int fetch_populated_submodules(const struct argv_array *options,
 	argv_array_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
+	if (max_parallel_jobs < 0)
+		max_parallel_jobs = config_fetch_parallel_submodules;
+	if (max_parallel_jobs < 0)
+		max_parallel_jobs = 1;
+
 	calculate_changed_submodule_paths();
 	run_processes_parallel(max_parallel_jobs,
 			       get_next_submodule,
-- 
2.5.0.267.g8d6e698.dirty
