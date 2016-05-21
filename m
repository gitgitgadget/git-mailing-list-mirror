From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule operations: tighten pathspec errors
Date: Fri, 20 May 2016 18:21:29 -0700
Message-ID: <1463793689-19496-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat May 21 03:22:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3vcV-0005sn-Uu
	for gcvg-git-2@plane.gmane.org; Sat, 21 May 2016 03:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbcEUBVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 21:21:34 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35735 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbcEUBVd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 21:21:33 -0400
Received: by mail-pf0-f171.google.com with SMTP id b66so25333854pfb.2
        for <git@vger.kernel.org>; Fri, 20 May 2016 18:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=E0LxCkNIESxAvYclGEhutmBBzq9hSxf6EewuJ5hBYy4=;
        b=F0mG8lqJhNGR4Lwv9vOv6Fd5H4SEL56exgSioNVLwMTZJJBNyrdWYNdYBCBa4kj07M
         EGMQWyNjN4D9xNloRJ8C4r5MCpJUTXDTS03SpNph52POog6onZHUruOpV81ABZO3SXUZ
         D20gQW/Eg7tqUJHd9Mm2Ol6N28i4zl6bs6lHc6oJWQAgwqYPsZCogkacd0aTanxYCDEq
         0BK35KnjEnkCgutbI8A0PnUO4Tht2D/OJreD91wQ+LisQvr4cA3LALggZ66P4jNMG1Se
         I1Yi+JsD25z4rPJOVyG6S0Mk0TqoaRDlcObuEeSgYYGLf3muKgM9jLMJN6iS+MWZdQaS
         +ggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E0LxCkNIESxAvYclGEhutmBBzq9hSxf6EewuJ5hBYy4=;
        b=MA4wdM1RWocy6Dn67/y9muoZ7Gzwp6R9Lz4ObV4zQrgyeauZsxsx9fa6HGb94Gq4aI
         x48rWi8IR9q4Ckqdmfzz5Gb4uQJiL1NtHPhdJDwiYKtmvxWHTr0oNmVt3Dl1z/9K+7/5
         L/Am9BAXgTzqfYsZ1vWU2K0a8nxSVDhbwofylth+n2I2jM+lV5gdnuDeH+LOcfxXipsE
         4wWXSmJ8DbbFqPvPVRi679oRFtvRipCU77ufEIA1IvCP2I+DuckEIAaXWeX1pRR18nxm
         fMFFwSxcrgUnhkdW3nP5xBJMaZfVMT2NhX7wnHpz0XSQ0RjeN5Nc5H2Iu4c34gw8SflK
         Lwuw==
X-Gm-Message-State: ALyK8tJuoPcAhPLxW07t/IPlOJyzakAnhYNVPAXvGanPOJo6L1rQu5an2HiTaQUZ+1X8fSP9
X-Received: by 10.98.36.19 with SMTP id r19mr643360pfj.86.1463793692488;
        Fri, 20 May 2016 18:21:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:104:6ffe:257d:9a11])
        by smtp.gmail.com with ESMTPSA id n66sm29857002pfb.17.2016.05.20.18.21.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 20 May 2016 18:21:31 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.2.gaa9b48a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295224>

when the pathspec did not match any path, error out.
Add the `--error-unmatch` switch to use the old behavior.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

This was taken from the Left Over Bits:
   git submodule $cmd $pathspec may want to error out when the $pathspec does
   not match any submodules. There must be an --unmatch-ok option to override
   this safety, though. Cf. $gmane/289535
   
It's a first initial version with no tests (and probably conflicting with
some topics in flight), but I was curious how involved this issue actually is,
so I took a stab at implementing it.

I was debating if inside git-submodules.sh we want to pass around a variable
or instead export an environment variable GIT_SUBMODULE_UNMATCH, such that we
do not give it as an argument to the submodule--helper builtin.

(This version is developed on top of the sb/submodule-deinit-all)
   
 Documentation/git-submodule.txt | 15 ++++++++++-----
 builtin/submodule--helper.c     | 19 +++++++++++--------
 git-submodule.sh                | 41 ++++++++++++++++++++++++++++++-----------
 3 files changed, 51 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index ad85183..ceacc02 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -11,16 +11,16 @@ SYNOPSIS
 [verse]
 'git submodule' [--quiet] add [-b <branch>] [-f|--force] [--name <name>]
 	      [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]
-'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
-'git submodule' [--quiet] init [--] [<path>...]
-'git submodule' [--quiet] deinit [-f|--force] (--all|[--] <path>...)
-'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
+'git submodule' [--quiet] status [--error-unmatch] [--cached] [--recursive] [--] [<path>...]
+'git submodule' [--quiet] init [--error-unmatch] [--] [<path>...]
+'git submodule' [--quiet] deinit [--error-unmatch] [-f|--force] (--all|[--] <path>...)
+'git submodule' [--quiet] update [--error-unmatch] [--init] [--remote] [-N|--no-fetch]
 	      [-f|--force] [--rebase|--merge] [--reference <repository>]
 	      [--depth <depth>] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
-'git submodule' [--quiet] sync [--recursive] [--] [<path>...]
+'git submodule' [--quiet] sync [--error-unmatch] [--recursive] [--] [<path>...]
 
 
 DESCRIPTION
@@ -260,6 +260,11 @@ OPTIONS
 	The name of the branch is recorded as `submodule.<name>.branch` in
 	`.gitmodules` for `update --remote`.
 
+--error-unmatch::
+	If the pathspec included a specification that did not match,
+	the usual operation is to error out. This switch suppresses
+	error reporting and continues the operation.
+
 -f::
 --force::
 	This option is only valid for add, deinit and update commands.
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5295b72..91c49ec 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -19,7 +19,8 @@ struct module_list {
 static int module_list_compute(int argc, const char **argv,
 			       const char *prefix,
 			       struct pathspec *pathspec,
-			       struct module_list *list)
+			       struct module_list *list,
+			       int unmatch)
 {
 	int i, result = 0;
 	char *ps_matched = NULL;
@@ -36,10 +37,9 @@ static int module_list_compute(int argc, const char **argv,
 
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
-
-		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce),
-				    0, ps_matched, 1) ||
-		    !S_ISGITLINK(ce->ce_mode))
+		if (!S_ISGITLINK(ce->ce_mode) ||
+		    !match_pathspec(pathspec, ce->name, ce_namelen(ce),
+				    0, ps_matched, 1))
 			continue;
 
 		ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
@@ -53,7 +53,9 @@ static int module_list_compute(int argc, const char **argv,
 			i++;
 	}
 
-	if (ps_matched && report_path_error(ps_matched, pathspec, prefix))
+	if (!unmatch &&
+	    ps_matched &&
+	    report_path_error(ps_matched, pathspec, prefix))
 		result = -1;
 
 	free(ps_matched);
@@ -63,11 +65,12 @@ static int module_list_compute(int argc, const char **argv,
 
 static int module_list(int argc, const char **argv, const char *prefix)
 {
-	int i;
+	int i, unmatch = 0;
 	struct pathspec pathspec;
 	struct module_list list = MODULE_LIST_INIT;
 
 	struct option module_list_options[] = {
+		OPT_BOOL(0, "unmatch", &unmatch, N_("Do not report error if no matches are found")),
 		OPT_STRING(0, "prefix", &prefix,
 			   N_("path"),
 			   N_("alternative anchor for relative paths")),
@@ -82,7 +85,7 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, module_list_options,
 			     git_submodule_helper_usage, 0);
 
-	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0) {
+	if (module_list_compute(argc, argv, prefix, &pathspec, &list, unmatch) < 0) {
 		printf("#unmatched\n");
 		return 1;
 	}
diff --git a/git-submodule.sh b/git-submodule.sh
index fb68f1f..f10e10a 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -6,13 +6,13 @@
 
 dashless=$(basename "$0" | sed -e 's/-/ /')
 USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
-   or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
-   or: $dashless [--quiet] init [--] [<path>...]
-   or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
-   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--reference <repository>] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] status [--error-unmatch] [--cached] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] init [--error-unmatch] [--] [<path>...]
+   or: $dashless [--quiet] deinit [--error-unmatch] [-f|--force] (--all| [--] <path>...)
+   or: $dashless [--quiet] update [--error-unmatch] [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--reference <repository>] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
-   or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
+   or: $dashless [--quiet] sync [--error-unmatch] [--recursive] [--] [<path>...]"
 OPTIONS_SPEC=
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
@@ -391,6 +391,9 @@ cmd_foreach()
 		--recursive)
 			recursive=1
 			;;
+		--error-unmatch)
+			unmatch=1
+			;;
 		-*)
 			usage
 			;;
@@ -407,7 +410,7 @@ cmd_foreach()
 	# command in the subshell (and a recursive call to this function)
 	exec 3<&0
 
-	git submodule--helper list --prefix "$wt_prefix"|
+	git submodule--helper list ${unmatch:+--unmatch} --prefix "$wt_prefix"|
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
@@ -453,6 +456,9 @@ cmd_init()
 		-q|--quiet)
 			GIT_QUIET=1
 			;;
+		--error-unmatch)
+			unmatch=1
+			;;
 		--)
 			shift
 			break
@@ -467,7 +473,7 @@ cmd_init()
 		shift
 	done
 
-	git submodule--helper list --prefix "$wt_prefix" "$@" |
+	git submodule--helper list ${unmatch:+--unmatch} --prefix "$wt_prefix" "$@" |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
@@ -534,6 +540,9 @@ cmd_deinit()
 		--all)
 			deinit_all=t
 			;;
+		--error-unmatch)
+			unmatch=1
+			;;
 		--)
 			shift
 			break
@@ -558,7 +567,7 @@ cmd_deinit()
 		die "$(eval_gettext "Use '--all' if you really want to deinitialize all submodules")"
 	fi
 
-	git submodule--helper list --prefix "$wt_prefix" "$@" |
+	git submodule--helper list ${unmatch:+--unmatch} --prefix "$wt_prefix" "$@" |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
@@ -661,6 +670,9 @@ cmd_update()
 		--recursive)
 			recursive=1
 			;;
+		--error-unmatch)
+			unmatch=1
+			;;
 		--checkout)
 			update="checkout"
 			;;
@@ -692,7 +704,7 @@ cmd_update()
 	fi
 
 	cloned_modules=
-	git submodule--helper list --prefix "$wt_prefix" "$@" | {
+	git submodule--helper list ${unmatch:+--unmatch} --prefix "$wt_prefix" "$@" | {
 	err=
 	while read mode sha1 stage sm_path
 	do
@@ -1115,6 +1127,9 @@ cmd_status()
 		--recursive)
 			recursive=1
 			;;
+		--error-unmatch)
+			unmatch=1
+			;;
 		--)
 			shift
 			break
@@ -1129,7 +1144,7 @@ cmd_status()
 		shift
 	done
 
-	git submodule--helper list --prefix "$wt_prefix" "$@" |
+	git submodule--helper list ${unmatch:+--unmatch} --prefix "$wt_prefix" "$@" |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
@@ -1193,6 +1208,10 @@ cmd_sync()
 			recursive=1
 			shift
 			;;
+		--error-unmatch)
+			unmatch=1
+			shift
+			;;
 		--)
 			shift
 			break
@@ -1206,7 +1225,7 @@ cmd_sync()
 		esac
 	done
 	cd_to_toplevel
-	git submodule--helper list --prefix "$wt_prefix" "$@" |
+	git submodule--helper list ${unmatch:+--unmatch} --prefix "$wt_prefix" "$@" |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
-- 
2.8.0.2.gaa9b48a.dirty
