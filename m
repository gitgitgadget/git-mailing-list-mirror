From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] submodule: use argv_array instead of hand-building arrays
Date: Sat, 01 Sep 2012 17:27:06 +0200
Message-ID: <5042294A.7020507@web.de>
References: <20120901112251.GA11445@sigill.intra.peff.net> <20120901112735.GB19163@sigill.intra.peff.net> <50421CF8.60703@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Dan Johnson <computerdruid@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <ossi@kde.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 01 17:27:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7pbu-0003jY-CQ
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 17:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755536Ab2IAP12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 11:27:28 -0400
Received: from mout.web.de ([212.227.17.12]:52902 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755535Ab2IAP1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 11:27:16 -0400
Received: from [192.168.178.41] ([91.3.157.191]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0Maamb-1SslYR3Zij-00JyKD; Sat, 01 Sep 2012 17:27:08
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120824 Thunderbird/15.0
In-Reply-To: <50421CF8.60703@web.de>
X-Provags-ID: V02:K0:QbK2cC23H3nUZAjQuTyPqbuIKczWEZts2SrH9DymxyL
 6MrfWJod13HiYtvK67yImuUfBW7T0B60lJfynpvNIfKz54tztQ
 bTxxcaL5F7YQs5aHAH7W9bMr459fIbCVFhznOkoB8Ra9itQy2j
 52YN0Axr67mfoLcQ76pGwTFdT3R9O5V89lPoIwrgwNe1qbH+rn
 DWa4UfCg+O6RfaHjMnOVQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204634>

fetch_populated_submodules() allocates the full argv array it uses to
recurse into the submodules from the number of given options plus the six
argv values it is going to add. It then initializes it with those values
which won't change during the iteration and copies the given options into
it. Inside the loop the two argv values different for each submodule get
replaced with those currently valid.

However, this technique is brittle and error-prone (as the comment to
explain the magic number 6 indicates), so let's replace it with an
argv_array. Instead of replacing the argv values, push them to the
argv_array just before the run_command() call (including the option
separating them) and pop them from the argv_array right after that.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---


Am 01.09.2012 16:34, schrieb Jens Lehmann:
> Am 01.09.2012 13:27, schrieb Jeff King:
>> It may be that fetch_populated_submodules would also benefit from
>> conversion (here I just pass in the argc and argv separately), but I
>> didn't look.
> 
> Yes, it does some similar brittle stuff and should be changed to use
> the argv-array too. I'll look into that.

Maybe something like this on top of your two patches?

I thought about adding an argv_array_cat() function to replace the
for() loop copying the option values into the argv-array built inside
fetch_populated_submodules(), but I suspect saving one line from the
code is not worth it. Yet I didn't check if others would benefit from
such a function too.


 builtin/fetch.c |  2 +-
 submodule.c     | 31 ++++++++++++++++---------------
 submodule.h     |  3 ++-
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b6a8be0..aaba61e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1012,7 +1012,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		struct argv_array options = ARGV_ARRAY_INIT;

 		add_options_to_argv(&options);
-		result = fetch_populated_submodules(options.argc, options.argv,
+		result = fetch_populated_submodules(&options,
 						    submodule_prefix,
 						    recurse_submodules,
 						    verbosity < 0);
diff --git a/submodule.c b/submodule.c
index 19dc6a6..51d48c2 100644
--- a/submodule.c
+++ b/submodule.c
@@ -588,13 +588,13 @@ static void calculate_changed_submodule_paths(void)
 	initialized_fetch_ref_tips = 0;
 }

-int fetch_populated_submodules(int num_options, const char **options,
+int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
 			       int quiet)
 {
-	int i, result = 0, argc = 0, default_argc;
+	int i, result = 0;
 	struct child_process cp;
-	const char **argv;
+	struct argv_array argv = ARGV_ARRAY_INIT;
 	struct string_list_item *name_for_path;
 	const char *work_tree = get_git_work_tree();
 	if (!work_tree)
@@ -604,17 +604,13 @@ int fetch_populated_submodules(int num_options, const char **options,
 		if (read_cache() < 0)
 			die("index file corrupt");

-	/* 6: "fetch" (options) --recurse-submodules-default default "--submodule-prefix" prefix NULL */
-	argv = xcalloc(num_options + 6, sizeof(const char *));
-	argv[argc++] = "fetch";
-	for (i = 0; i < num_options; i++)
-		argv[argc++] = options[i];
-	argv[argc++] = "--recurse-submodules-default";
-	default_argc = argc++;
-	argv[argc++] = "--submodule-prefix";
+	argv_array_push(&argv, "fetch");
+	for (i = 0; i < options->argc; i++)
+		argv_array_push(&argv, options->argv[i]);
+	argv_array_push(&argv, "--recurse-submodules-default");
+	/* default value, "--submodule-prefix" and its value are added later */

 	memset(&cp, 0, sizeof(cp));
-	cp.argv = argv;
 	cp.env = local_repo_env;
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
@@ -674,16 +670,21 @@ int fetch_populated_submodules(int num_options, const char **options,
 			if (!quiet)
 				printf("Fetching submodule %s%s\n", prefix, ce->name);
 			cp.dir = submodule_path.buf;
-			argv[default_argc] = default_argv;
-			argv[argc] = submodule_prefix.buf;
+			argv_array_push(&argv, default_argv);
+			argv_array_push(&argv, "--submodule-prefix");
+			argv_array_push(&argv, submodule_prefix.buf);
+			cp.argv = argv.argv;
 			if (run_command(&cp))
 				result = 1;
+			argv_array_pop(&argv);
+			argv_array_pop(&argv);
+			argv_array_pop(&argv);
 		}
 		strbuf_release(&submodule_path);
 		strbuf_release(&submodule_git_dir);
 		strbuf_release(&submodule_prefix);
 	}
-	free(argv);
+	argv_array_clear(&argv);
 out:
 	string_list_clear(&changed_submodule_paths, 1);
 	return result;
diff --git a/submodule.h b/submodule.h
index e105b0e..594b50d 100644
--- a/submodule.h
+++ b/submodule.h
@@ -2,6 +2,7 @@
 #define SUBMODULE_H

 struct diff_options;
+struct argv_array;

 enum {
 	RECURSE_SUBMODULES_ON_DEMAND = -1,
@@ -23,7 +24,7 @@ void show_submodule_summary(FILE *f, const char *path,
 		const char *del, const char *add, const char *reset);
 void set_config_fetch_recurse_submodules(int value);
 void check_for_new_submodule_commits(unsigned char new_sha1[20]);
-int fetch_populated_submodules(int num_options, const char **options,
+int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
 			       int quiet);
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
-- 
1.7.12.149.g47e61ec
