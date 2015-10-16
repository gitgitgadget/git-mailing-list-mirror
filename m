From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 08/12] git submodule update: check for "none" in C
Date: Thu, 15 Oct 2015 18:52:09 -0700
Message-ID: <1444960333-16003-9-git-send-email-sbeller@google.com>
References: <1444960333-16003-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 03:52:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmuCN-0002W9-PG
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 03:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbbJPBw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 21:52:27 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33705 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbbJPBw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 21:52:26 -0400
Received: by pabrc13 with SMTP id rc13so104122407pab.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 18:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vcdcDkk3jotIKbAMj4D2DXIVWXWUVjx3FuOr+579m3A=;
        b=Vra3gy6WZU0gMHvOzzkO4ZBwdQD+4t+8m7sd87Hc53qlZAqq597+x00NEF/Gtnjqnx
         +7+N5c2h4v5H2xKOOrc6G9SgT7Kb0pgLjWUrbLaAFFFsRjzR4tW5q3R0PO70rlmP15Fm
         hX0cU2mn3979FTFBi9FflLKVyd01fyLQfgkWhp1HVPKSy1Z+5GEKSykR+Npa3n2naY5F
         Rk4BzL4O4t/YxVxLhs+ik7SLjYdpVajRzkTGsdr3CHqsM0MWPiY3ipqwu4dTV08Iemsv
         LbEEyWbJfJ6oot/Jp9RaK/kFZ28y7cO2MF2qlceqIbC1tcJkE9gZBO7j0h7OyeAeLZaF
         4U6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vcdcDkk3jotIKbAMj4D2DXIVWXWUVjx3FuOr+579m3A=;
        b=AXD5v4V8cSt5eHl2p/wZzJKyzTUrlNqaYUOJFQxPzE4A+XeIUSFEqNdthc38HYjraa
         tdX5e8DQj+/NjVYMTtlcDKAAXhuB9jgIcRa6Z6FhvpFpTrEriI0tkhKucuQymT3oRZ1I
         FYXQjK8Y0r46Lb4pdqwDlAA1qjpWu14Lbr4G2aGxX/KCdBSYdwqAqBTeIvijunduzC54
         8MQ1UQ3q6n6T9jXDkfFyVvwFOWdFgyF8g9w1WjUhvOH3INQ1y8X2Os06J/4RjiiYUJBu
         /HmBOqJV+6OVMpY4olSvEG2OUuNF9xHZNjHxOgAAgKCoz8Mvonh4a4KrxOR4hrYPlJy3
         57vg==
X-Gm-Message-State: ALoCoQnI6VZPMF+pnjykDBw+3H/EvM5KtpJrb3kYF46EMmmvM1OFrXucXM4sC4epjlchIQOYaxu3
X-Received: by 10.66.182.135 with SMTP id ee7mr13377276pac.95.1444960345491;
        Thu, 15 Oct 2015 18:52:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8909:dd69:53c0:2cb6])
        by smtp.gmail.com with ESMTPSA id i9sm17772872pbq.84.2015.10.15.18.52.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 Oct 2015 18:52:25 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.277.gfdc362b.dirty
In-Reply-To: <1444960333-16003-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279722>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 38 ++++++++++++++++++++++++++++++++++++--
 git-submodule.sh            |  8 +-------
 2 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f81f37a..73954ac 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -255,9 +255,15 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int git_submodule_config(const char *var, const char *value, void *cb)
+{
+	return parse_submodule_config_option(var, value);
+}
+
 static int module_list_or_clone(int argc, const char **argv, const char *prefix)
 {
 	int i;
+	char *update = NULL;
 	struct pathspec pathspec;
 	struct module_list list = MODULE_LIST_INIT;
 
@@ -265,6 +271,9 @@ static int module_list_or_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "prefix", &prefix,
 			   N_("path"),
 			   N_("alternative anchor for relative paths")),
+		OPT_STRING(0, "update", &update,
+			   N_("string"),
+			   N_("update command for submodules")),
 		OPT_END()
 	};
 
@@ -281,20 +290,45 @@ static int module_list_or_clone(int argc, const char **argv, const char *prefix)
 		return 1;
 	}
 
+	gitmodules_config();
+	/* Overlay the parsed .gitmodules file with .git/config */
+	git_config(git_submodule_config, NULL);
+
 	for (i = 0; i < list.nr; i++) {
+		const struct submodule *sub = NULL;
+		const char *displaypath = NULL;
 		const struct cache_entry *ce = list.entries[i];
+		struct strbuf sb = STRBUF_INIT;
+		const char *update_module = NULL;
 
 		char *env_prefix = getenv("prefix");
 		if (ce_stage(ce)) {
 			if (env_prefix)
-				fprintf(stderr, "Skipping unmerged submodule %s/%s",
+				fprintf(stderr, "Skipping unmerged submodule %s/%s\n",
 					env_prefix, ce->name);
 			else
-				fprintf(stderr, "Skipping unmerged submodule %s",
+				fprintf(stderr, "Skipping unmerged submodule %s\n",
 					ce->name);
 			continue;
 		}
 
+		sub = submodule_from_path(null_sha1, ce->name);
+		if (env_prefix)
+			displaypath = relative_path(env_prefix, ce->name, &sb);
+		else
+			displaypath = ce->name;
+
+		if (update)
+			update_module = update;
+		if (!update_module)
+			update_module = sub->update;
+		if (!update_module)
+			update_module = "checkout";
+		if (!strcmp(update_module, "none")) {
+			fprintf(stderr, "Skipping submodule '%s'\n", displaypath);
+			continue;
+		}
+
 		printf("%06o %s %d\t", ce->ce_mode, sha1_to_hex(ce->sha1), ce_stage(ce));
 		utf8_fprintf(stdout, "%s\n", ce->name);
 	}
diff --git a/git-submodule.sh b/git-submodule.sh
index 0754ecd..227fed6 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -656,7 +656,7 @@ cmd_update()
 	fi
 
 	cloned_modules=
-	git submodule--helper list-or-clone --prefix "$wt_prefix" "$@" | {
+	git submodule--helper list-or-clone --prefix "$wt_prefix" ${update:+--update "$update"} "$@" | {
 	err=
 	while read mode sha1 stage sm_path
 	do
@@ -677,12 +677,6 @@ cmd_update()
 
 		displaypath=$(relative_path "$prefix$sm_path")
 
-		if test "$update_module" = "none"
-		then
-			echo >&2 "Skipping submodule '$displaypath'"
-			continue
-		fi
-
 		if test -z "$url"
 		then
 			# Only mention uninitialized submodules when its
-- 
2.5.0.277.gfdc362b.dirty
