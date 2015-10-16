From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 10/12] git submodule update: Clone projects from within C
Date: Thu, 15 Oct 2015 18:52:11 -0700
Message-ID: <1444960333-16003-11-git-send-email-sbeller@google.com>
References: <1444960333-16003-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 03:52:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmuCC-0002He-1P
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 03:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772AbbJPBwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 21:52:30 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33744 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbbJPBw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 21:52:28 -0400
Received: by pabrc13 with SMTP id rc13so104123248pab.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 18:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=61vZPSFAbBLarWnPGm0+m3pkwpSnw4pqAiD41cOnlpE=;
        b=GfwX2OhKxBRzGmCc9WE6FtAb2B5nce5TO5OLhiiBa0ImcGt8VZ/I/ZgAMob+lI9+gx
         DM6NMPFPR/l94qeVTwuHNTJyCzVLkPnYXROvDQYrzbDNjOwkOT7j4Yz+gQOgfTQBLtIv
         W0qj65VLi5efoOCTAg3vmgnxfU+qr392ApfoP9u9Q12KmtayZSJCgv8oJE1QYVnm7JUA
         PARKiOWMXgyrN+I5+AWBYh9SWvs4Ko6tqMG2dhGhUBRXC+qWqrDxoF5h3uVVo/sxWQDu
         dg9zSpoCy0666vgcu+L8nsZcDtkyHilBzUNwoZCKODB+eTGMMqV3nFH2MrgtvKJalm3u
         833Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=61vZPSFAbBLarWnPGm0+m3pkwpSnw4pqAiD41cOnlpE=;
        b=LxpxsHNSpvpzH+GWHZZBOU5kjL9aWTYeUkNOtnpFND4mcnjkgJecE9gfAUVsZ3/9/u
         ht6CYl3cW1BDZkMZPanGV8L5tKOWD9+/xQcuulAUDyvuxhxVX+fsKUS1DYLrE8UlOryO
         YYeG3OyG2sZLXwYAgzYNkHULKsDByqveztPe64tLwiod/xq33msugX6BQ4TJtBxGBHUG
         PBsosvqfj/rmEVlPlZpqee35Wp1YCI81AR8O57FlxmGb4HUMAJiXEdsNM+9YXJ/7DZhL
         dz+B0QnS0uwH9Ssuedv6M3+it4H33cmbKgtOrnALyVbCmfKVjj1Kyr+h0WSrFKAiMCD5
         1QVg==
X-Gm-Message-State: ALoCoQkZh+Fzfq3UwZWEOHbxYzwSM0W69RhqZ95MorNFHPbUxVpILAt19XM7N2PLxpmQlM7U7gJG
X-Received: by 10.68.201.168 with SMTP id kb8mr13418565pbc.95.1444960347605;
        Thu, 15 Oct 2015 18:52:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8909:dd69:53c0:2cb6])
        by smtp.gmail.com with ESMTPSA id qk7sm12158520pbb.80.2015.10.15.18.52.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 Oct 2015 18:52:27 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.277.gfdc362b.dirty
In-Reply-To: <1444960333-16003-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279719>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 56 ++++++++++++++++++++++++++++++++++++++++++++-
 git-submodule.sh            | 12 ++++++----
 2 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 7a2fd4e..d1684cf 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -260,9 +260,40 @@ static int git_submodule_config(const char *var, const char *value, void *cb)
 	return parse_submodule_config_option(var, value);
 }
 
+static void fill_clone_command(struct child_process *cp, int quiet,
+			       const char *prefix, const char *path,
+			       const char *name, const char *url,
+			       const char *reference, const char *depth)
+{
+	cp->git_cmd = 1;
+	argv_array_push(&cp->args, "submodule--helper");
+	argv_array_push(&cp->args, "clone");
+	if (quiet)
+		argv_array_push(&cp->args, "--quiet");
+
+	if (prefix) {
+		argv_array_push(&cp->args, "--prefix");
+		argv_array_push(&cp->args, prefix);
+	}
+	argv_array_push(&cp->args, "--path");
+	argv_array_push(&cp->args, path);
+
+	argv_array_push(&cp->args, "--name");
+	argv_array_push(&cp->args, name);
+
+	argv_array_push(&cp->args, "--url");
+	argv_array_push(&cp->args, url);
+	if (reference)
+		argv_array_push(&cp->args, reference);
+	if (depth)
+		argv_array_push(&cp->args, depth);
+}
+
 static int module_list_or_clone(int argc, const char **argv, const char *prefix)
 {
 	int i;
+	int quiet;
+	char *reference = NULL, *depth = NULL;
 	char *update = NULL;
 	struct pathspec pathspec;
 	struct module_list list = MODULE_LIST_INIT;
@@ -274,6 +305,13 @@ static int module_list_or_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "update", &update,
 			   N_("string"),
 			   N_("update command for submodules")),
+		OPT_STRING(0, "reference", &reference, "<repository>",
+			N_("Use the local reference repository "
+			   "instead of a full clone")),
+		OPT_STRING(0, "depth", &depth, "<depth>",
+			N_("Create a shallow clone truncated to the "
+			   "specified number of revisions")),
+		OPT__QUIET(&quiet, N_("do't print cloning progress")),
 		OPT_END()
 	};
 
@@ -301,6 +339,7 @@ static int module_list_or_clone(int argc, const char **argv, const char *prefix)
 		struct strbuf sb = STRBUF_INIT;
 		const char *update_module = NULL;
 		const char *url = NULL;
+		int just_cloned = 0;
 
 		char *env_prefix = getenv("prefix");
 		if (ce_stage(ce)) {
@@ -350,7 +389,22 @@ static int module_list_or_clone(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		printf("%06o %s %d\t", ce->ce_mode, sha1_to_hex(ce->sha1), ce_stage(ce));
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "%s/.git", ce->name);
+		just_cloned = !file_exists(sb.buf);
+
+		if (just_cloned) {
+			struct child_process cp = CHILD_PROCESS_INIT;
+			fill_clone_command(&cp, quiet, prefix, ce->name,
+					   sub->name, url, reference, depth);
+
+			if (run_command(&cp)) {
+				printf("#unmatched\n");
+				return 1;
+			}
+		}
+
+		printf("%06o %s %d %d\t", ce->ce_mode, sha1_to_hex(ce->sha1), ce_stage(ce), just_cloned);
 		utf8_fprintf(stdout, "%s\n", ce->name);
 	}
 	return 0;
diff --git a/git-submodule.sh b/git-submodule.sh
index 80f41b2..28f1757 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -656,9 +656,14 @@ cmd_update()
 	fi
 
 	cloned_modules=
-	git submodule--helper list-or-clone --prefix "$wt_prefix" ${update:+--update "$update"} "$@" | {
+	git submodule--helper list-or-clone ${GIT_QUIET:+--quiet} \
+		--prefix "$wt_prefix" \
+		${update:+--update "$update"} \
+		${reference:+--reference "$reference"} \
+		${depth:+--depth "$depth"} \
+		"$@" | {
 	err=
-	while read mode sha1 stage sm_path
+	while read mode sha1 stage just_cloned sm_path
 	do
 		die_if_unmatched "$mode"
 
@@ -677,9 +682,8 @@ cmd_update()
 
 		displaypath=$(relative_path "$prefix$sm_path")
 
-		if ! test -d "$sm_path"/.git && ! test -f "$sm_path"/.git
+		if test "$just_cloned" = 1
 		then
-			git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$prefix" --path "$sm_path" --name "$name" --url "$url" "$reference" "$depth" || exit
 			cloned_modules="$cloned_modules;$name"
 			subsha1=
 		else
-- 
2.5.0.277.gfdc362b.dirty
