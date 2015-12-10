From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule: Port resolve_relative_url from shell to C
Date: Wed,  9 Dec 2015 17:07:34 -0800
Message-ID: <1449709654-30189-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jens.lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 10 02:07:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6pi0-000657-R0
	for gcvg-git-2@plane.gmane.org; Thu, 10 Dec 2015 02:07:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbbLJBHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2015 20:07:45 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33153 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbbLJBHn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2015 20:07:43 -0500
Received: by pabur14 with SMTP id ur14so38354878pab.0
        for <git@vger.kernel.org>; Wed, 09 Dec 2015 17:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=WfZnqAKUFxcmquLuFAXmxI795QhsPDHlVWfOCUwEYq4=;
        b=Qv9EvqSa9GUYsTZvsmOUgwxB7Qj3TOZ1IElkM15ISyhF2Xe8PcHqtlm5XXCEaGfjo/
         7yR2U8lcb7EWyWMsXVPAjo+prlp7oRqyXGmAfWqbKP+O86cbG9vudlF5teG/RxOTaUqN
         ZAimBpzy1S++0QzvP/P9rA6JU32EZ3mAQ+r8GwNzfSQh+NRyS9T2qhyZTtf3Mf1j7Eby
         Wlu7FfbP7wtuXjTe3LDaA5gzqIbCmY9B8lhaQRca2ykJqPCa+pWHNVSYXghFUUObYTVv
         KKjy7a0/BzUvrkZoQXwGoWZDTeirJVsRGrKXwJU/3fX8u6UQVyni2aRlr6q1fpRmMn2G
         Qrcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WfZnqAKUFxcmquLuFAXmxI795QhsPDHlVWfOCUwEYq4=;
        b=Y+c6LYpyY6nX4jXAHCzzG79RuE1Weg6qcQzPeHhngxQrwoMIIiYaRu+tO5CfaKnuuD
         49+Dyo79hJbHizmxVaDMm6Xx8WxxHEjMu1QPNRXQVk4e9jgR2jebLvzDZTIFed7V44eq
         e5ILAOKwXLGCuGS23keav1rlSpm2oyndlG9trkfOauXimKDh/C+tDNVDkgpZCzKKamH/
         UVdQ4ukGKeIbVcHD0PZF4G5TW9/pRawyfw0OlfoMyQMxvQUYlMNPDeu0USUO3T4NnpNo
         /2+ENjXy9zZNHm45feC+/cDE+iMNQT/sg/jnvl4u+vc5mygKgmw+/Ou9vgofk9NSWfmp
         Zbfw==
X-Gm-Message-State: ALoCoQkEs6jo0Im6tXGelMjO+Ey7+XJ8s5bFl1XuZO1z4lY9W5e9UqjgUPqqCBiyzrs5sokJOpCr19XMa5VDeWFdX7V/vPrWZg==
X-Received: by 10.66.219.39 with SMTP id pl7mr12629446pac.88.1449709663312;
        Wed, 09 Dec 2015 17:07:43 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:548b:ca17:d17e:fa3a])
        by smtp.gmail.com with ESMTPSA id v64sm14221744pfi.50.2015.12.09.17.07.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 09 Dec 2015 17:07:42 -0800 (PST)
X-Mailer: git-send-email 2.6.3.470.g4b82c23.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282208>

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

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 This applies on origin/master, and I'd carry as its own feature branch
 as I am nowhere near done with the groups feature after reading Jens feedback.
 (It took me a while to identify this as a next best step.)
 
 Thanks,
 Stefan

 builtin/submodule--helper.c | 120 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  81 ++----------------------------
 2 files changed, 124 insertions(+), 77 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f4c3eff..f48b5b5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -9,6 +9,125 @@
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
+	if (strip_suffix(remoteurl, "/", &len))
+		remoteurl[len] = '\0';
+
+	if (strchr(remoteurl, ':') || skip_prefix(remoteurl, "/", &out))
+		is_relative = 0;
+	else if (skip_prefix(remoteurl, "./", &out) ||
+		    skip_prefix(remoteurl, "../", &out))
+		is_relative = 1;
+	else {
+		is_relative = 1;
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "./%s", remoteurl);
+		remoteurl = strbuf_detach(&sb, NULL);
+	}
+
+	while (url) {
+		if (skip_prefix(url, "../", &out)) {
+			char *rfind;
+			url = out;
+
+			rfind = strrchr(remoteurl, '/');
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
+		} else if (skip_prefix(url, "./", &out))
+			url = out;
+		else
+			break;
+	}
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s%s%s", remoteurl, sep, url);
+
+	if (!skip_prefix(sb.buf, "./", &out))
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
@@ -264,6 +383,7 @@ static struct cmd_struct commands[] = {
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
2.6.3.470.g4b82c23.dirty
