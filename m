From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2] submodule: Port resolve_relative_url from shell to C
Date: Wed, 16 Dec 2015 16:26:39 -0800
Message-ID: <1450311999-3992-2-git-send-email-sbeller@google.com>
References: <1450311999-3992-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, jens.lehmann@web.de, j6t@kdbg.org
To: sbeller@google.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 17 01:26:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9MPC-00084J-Tc
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 01:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933027AbbLQA0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 19:26:46 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34896 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932601AbbLQA0p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 19:26:45 -0500
Received: by mail-pa0-f52.google.com with SMTP id jx14so3082400pad.2
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 16:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=cSBptq+o7Y6i78r9EAb6V+Pvp8EIPl3ofbsqlFVBpyc=;
        b=oPy2s/snyS2efnZJvrf9NlucOnWpooGqhF5hIGrkUaNpZ8GehijYtdZewCkL07B4ro
         oddEt3kVFGyveWkgdse2I/muqOoqP5btKrmwh6gLAODN/THiX3FCO82i6AUvnsw+DJYI
         UD6D+KoH2jxLeqtVtA4J2Y1oskaWNPnt2a3k9lvae10AnYy5TJuyr/yPDQcTGGiZA6Tl
         sFAd7/FX0OxpuaUVH6u6dJmwbZ4Wp7jN74WJzMg8myLInTJ8VP5mHutl5jqD5EDP9Gcq
         FfgRFkIImO+UUOyVmas4hh79S4tuhuwMNFcdmvODYkTAKdxSAnm0oJqaZWH8Jq4SbAAl
         uQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=cSBptq+o7Y6i78r9EAb6V+Pvp8EIPl3ofbsqlFVBpyc=;
        b=lVDCq50v0N3PZuYNUH/KrmAegceIZoMyuUQBLNfzYSARAQXQgs5wugiHZVKg5NjmdM
         m4heKZRYaHHqYT6XjrWRh0vfSpXTRRRa5odzL1fnqjoMX770V6W+Ad6D4e14FZzueD2q
         U0EXXmtUs9oQZTnCBwc8VitQxEhwfekN+xZ8C6XksTiPBkzKz8IzP85gWs4mAGCLPCfr
         xHHoqj4PTjIghfKAOLHfKO/xxUIWKpdARwipNwTWOfUjAtIIODY+c7/XykAI5wltuynx
         pUETIDkacnAD6IztVK+S3YAS6IEG/qvjSVFWSGTlxxG8teVGcRwYGUSH0z71CWb/AIqB
         ahtg==
X-Gm-Message-State: ALoCoQl+wZx/xKp2+jHQg00SxXWiv0dM799QpxtbB6UutTlTnkSsU281ihjtbi40XvaNN2T7ak3SvPA4cUtg3ENyk9tbJVEAZQ==
X-Received: by 10.66.158.169 with SMTP id wv9mr67275680pab.138.1450312004630;
        Wed, 16 Dec 2015 16:26:44 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b866:3ab5:f751:fa9b])
        by smtp.gmail.com with ESMTPSA id w62sm7035531pfi.48.2015.12.16.16.26.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 16 Dec 2015 16:26:43 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc1.2.gfc39790.dirty
In-Reply-To: <1450311999-3992-1-git-send-email-sbeller@google.com>
In-Reply-To: <1449709654-30189-1-git-send-email-sbeller@google.com>
References: <1449709654-30189-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282627>

This reimplements the helper function `resolve_relative_url` in shell
in C. This functionality is needed in C for introducing the groups
feature later on. When using groups, the user should not need to run
`git submodule init`, but it should be implicit at all appropriate places,
which are all in C code. As the we would not just call out to `git
submodule init`, but do a more fine grained structure there, we actually
need all the init functionality in C before attempting the groups
feature. To get the init functionality in C, rewriting the
resolve_relative_url subfunction is a major step.

This also improves the performance:
(Best out of 3) time ./t7400-submodule-basic.sh
Before:
real	0m9.575s
user	0m2.683s
sys	0m6.773s
After:
real	0m9.293s
user	0m2.691s
sys	0m6.549s

That's about 3%.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 151 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  81 ++----------------------
 2 files changed, 155 insertions(+), 77 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f4c3eff..b925bed 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -9,6 +9,156 @@
 #include "submodule-config.h"
 #include "string-list.h"
 #include "run-command.h"
+#include "remote.h"
+#include "refs.h"
+
+static const char *get_default_remote(void)
+{
+	char *dest = NULL;
+	unsigned char sha1[20];
+	int flag;
+	struct strbuf sb = STRBUF_INIT;
+	const char *refname = resolve_ref_unsafe("HEAD", 0, sha1, &flag);
+
+	if (!refname)
+		die("No such ref: HEAD");
+
+	refname = shorten_unambiguous_ref(refname, 0);
+	strbuf_addf(&sb, "branch.%s.remote", refname);
+	if (git_config_get_string(sb.buf, &dest))
+		return "origin";
+	else
+		return xstrdup(dest);
+}
+
+static int has_same_dir_prefix(const char *str, const char **out)
+{
+#ifdef GIT_WINDOWS_NATIVE
+	return skip_prefix(str, "./", out)
+		|| skip_prefix(str, ".\\", out);
+#else
+	return skip_prefix(str, "./", out);
+#endif
+}
+
+static int has_upper_dir_prefix(const char *str, const char **out)
+{
+#ifdef GIT_WINDOWS_NATIVE
+	return skip_prefix(str, "../", out)
+		|| skip_prefix(str, "..\\", out);
+#else
+	return skip_prefix(str, "../", out);
+#endif
+}
+
+static char *last_dir_separator(const char *str)
+{
+#ifdef GIT_WINDOWS_NATIVE
+	return strrchr(str, "/")
+		|| strrchr(str, "\\");
+#else
+	return strrchr(str, '/');
+#endif
+}
+
+/*
+ * The function takes at most 2 arguments. The first argument is the
+ * URL that navigates to the submodule origin repo. When relative, this URL
+ * is relative to the superproject origin URL repo. The second up_path
+ * argument, if specified, is the relative path that navigates
+ * from the submodule working tree to the superproject working tree.
+ *
+ * The output of the function is the origin URL of the submodule.
+ *
+ * The output will either be an absolute URL or filesystem path (if the
+ * superproject origin URL is an absolute URL or filesystem path,
+ * respectively) or a relative file system path (if the superproject
+ * origin URL is a relative file system path).
+ *
+ * When the output is a relative file system path, the path is either
+ * relative to the submodule working tree, if up_path is specified, or to
+ * the superproject working tree otherwise.
+ */
+static const char *relative_url(const char *url, const char *up_path)
+{
+	int is_relative = 0;
+	size_t len;
+	char *remoteurl = NULL;
+	char *sep = "/";
+	const char *out;
+	struct strbuf sb = STRBUF_INIT;
+	const char *remote = get_default_remote();
+	strbuf_addf(&sb, "remote.%s.url", remote);
+
+	if (git_config_get_string(sb.buf, &remoteurl))
+		/* the repository is its own authoritative upstream */
+		remoteurl = xgetcwd();
+
+	len = strlen(remoteurl);
+	if (is_dir_sep(remoteurl[len]))
+		remoteurl[len] = '\0';
+
+	if (strchr(remoteurl, ':') || is_dir_sep(*remoteurl))
+		is_relative = 0;
+	else if (has_same_dir_prefix(remoteurl, &out) ||
+		    has_upper_dir_prefix(remoteurl, &out))
+		is_relative = 1;
+	else {
+		is_relative = 1;
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "./%s", remoteurl);
+		remoteurl = strbuf_detach(&sb, NULL);
+	}
+
+	while (url) {
+		if (has_upper_dir_prefix(url, &out)) {
+			char *rfind;
+			url = out;
+
+			rfind = last_dir_separator(remoteurl);
+			if (rfind)
+				*rfind = '\0';
+			else {
+				rfind = strrchr(remoteurl, ':');
+				if (rfind) {
+					*rfind = '\0';
+					sep = ":";
+				} else {
+					if (is_relative || !strcmp(".", remoteurl))
+						die(N_("cannot strip one component off url '%s'"), remoteurl);
+					else
+						remoteurl = ".";
+				}
+			}
+		} else if (has_same_dir_prefix(url, &out))
+			url = out;
+		else
+			break;
+	}
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s%s%s", remoteurl, sep, url);
+
+	if (!has_same_dir_prefix(sb.buf, &out))
+		out = sb.buf;
+	out = xstrdup(out);
+
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s%s", is_relative && up_path ? up_path : "", out);
+
+	free((char*)out);
+	return strbuf_detach(&sb, NULL);
+}
+
+static int resolve_relative_url(int argc, const char **argv, const char *prefix)
+{
+	if (argc == 2)
+		printf("%s\n", relative_url(argv[1], NULL));
+	else if (argc == 3)
+		printf("%s\n", relative_url(argv[1], argv[2]));
+	else
+		die("BUG: resolve_relative_url only accepts one or two arguments");
+	return 0;
+}
 
 struct module_list {
 	const struct cache_entry **entries;
@@ -264,6 +414,7 @@ static struct cmd_struct commands[] = {
 	{"list", module_list},
 	{"name", module_name},
 	{"clone", module_clone},
+	{"resolve_relative_url", resolve_relative_url},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index 9bc5c5f..6a7a3e4 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -46,79 +46,6 @@ prefix=
 custom_name=
 depth=
 
-# The function takes at most 2 arguments. The first argument is the
-# URL that navigates to the submodule origin repo. When relative, this URL
-# is relative to the superproject origin URL repo. The second up_path
-# argument, if specified, is the relative path that navigates
-# from the submodule working tree to the superproject working tree.
-#
-# The output of the function is the origin URL of the submodule.
-#
-# The output will either be an absolute URL or filesystem path (if the
-# superproject origin URL is an absolute URL or filesystem path,
-# respectively) or a relative file system path (if the superproject
-# origin URL is a relative file system path).
-#
-# When the output is a relative file system path, the path is either
-# relative to the submodule working tree, if up_path is specified, or to
-# the superproject working tree otherwise.
-resolve_relative_url ()
-{
-	remote=$(get_default_remote)
-	remoteurl=$(git config "remote.$remote.url") ||
-		remoteurl=$(pwd) # the repository is its own authoritative upstream
-	url="$1"
-	remoteurl=${remoteurl%/}
-	sep=/
-	up_path="$2"
-
-	case "$remoteurl" in
-	*:*|/*)
-		is_relative=
-		;;
-	./*|../*)
-		is_relative=t
-		;;
-	*)
-		is_relative=t
-		remoteurl="./$remoteurl"
-		;;
-	esac
-
-	while test -n "$url"
-	do
-		case "$url" in
-		../*)
-			url="${url#../}"
-			case "$remoteurl" in
-			*/*)
-				remoteurl="${remoteurl%/*}"
-				;;
-			*:*)
-				remoteurl="${remoteurl%:*}"
-				sep=:
-				;;
-			*)
-				if test -z "$is_relative" || test "." = "$remoteurl"
-				then
-					die "$(eval_gettext "cannot strip one component off url '\$remoteurl'")"
-				else
-					remoteurl=.
-				fi
-				;;
-			esac
-			;;
-		./*)
-			url="${url#./}"
-			;;
-		*)
-			break;;
-		esac
-	done
-	remoteurl="$remoteurl$sep${url%/}"
-	echo "${is_relative:+${up_path}}${remoteurl#./}"
-}
-
 # Resolve a path to be relative to another path.  This is intended for
 # converting submodule paths when git-submodule is run in a subdirectory
 # and only handles paths where the directory separator is '/'.
@@ -281,7 +208,7 @@ cmd_add()
 		die "$(gettext "Relative path can only be used from the toplevel of the working tree")"
 
 		# dereference source url relative to parent's url
-		realrepo=$(resolve_relative_url "$repo") || exit
+		realrepo=$(git submodule--helper resolve_relative_url "$repo") || exit
 		;;
 	*:*|/*)
 		# absolute url
@@ -485,7 +412,7 @@ cmd_init()
 			# Possibly a url relative to parent
 			case "$url" in
 			./*|../*)
-				url=$(resolve_relative_url "$url") || exit
+				url=$(git submodule--helper resolve_relative_url "$url") || exit
 				;;
 			esac
 			git config submodule."$name".url "$url" ||
@@ -1190,9 +1117,9 @@ cmd_sync()
 			# guarantee a trailing /
 			up_path=${up_path%/}/ &&
 			# path from submodule work tree to submodule origin repo
-			sub_origin_url=$(resolve_relative_url "$url" "$up_path") &&
+			sub_origin_url=$(git submodule--helper resolve_relative_url "$url" "$up_path") &&
 			# path from superproject work tree to submodule origin repo
-			super_config_url=$(resolve_relative_url "$url") || exit
+			super_config_url=$(git submodule--helper resolve_relative_url "$url") || exit
 			;;
 		*)
 			sub_origin_url="$url"
-- 
2.7.0.rc1.2.gfc39790.dirty
