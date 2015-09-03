From: David Turner <dturner@twopensource.com>
Subject: [PATCH 40/43] refs: allow ref backend to be set for clone
Date: Wed,  2 Sep 2015 21:55:10 -0400
Message-ID: <1441245313-11907-41-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:56:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJln-0006qa-9m
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbbICB4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:56:46 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:35364 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932401AbbICB4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:56:24 -0400
Received: by qgt47 with SMTP id 47so18604415qgt.2
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CU/Fj/dexz6+SyKF2odyut9K6jZSAyOAMYaFYNY/YAc=;
        b=XTiZIUilXlbjO6E3T4jYYzd5CJlTQdUZc4iWuougofgNrCLuRiraPEm3xLOdfzT0Bw
         TsNw865bLqq3NMhZ2OG6xmAgVMEFghvxx3/pV114Psnbyg7vsWbDTOPFj74tbMC48hfw
         LpgeLGaR9zVTd2qnjQ34NDPu2rl7ozfNPTcGB5ftM6NCQJUZjG3Ubd8QHB1HoUuZSHUK
         OQutaYEFyxGBGrEFZUlUo1kjnzpwY599FemWrBcBBWtM/lbTJg9pcLHosHHy0ik1aKqi
         Tsu7dR7Hcjeaj8hXgzIrd6oxJase2Gr7uUvcA6ohbbLEG4lvgUQus2MHBrb2bZlsO9z9
         tfAA==
X-Gm-Message-State: ALoCoQkEL7DXQZMzKwhxFA5Fg6eDS/dmQ+WYEmYnIyGzI7p1SFNAwhEu3/getxnQ9KUPM1izndmu
X-Received: by 10.140.237.73 with SMTP id i70mr65775251qhc.37.1441245383473;
        Wed, 02 Sep 2015 18:56:23 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.56.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:56:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277161>

Add a new option, --refs-backend-type, to allow the ref backend type to
be set on new clones.

Submodules must use the same ref backend as the parent repository, so
we also pass the --refs-backend-type option option when cloning
submodules.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-clone.txt |  4 ++++
 builtin/clone.c             | 27 +++++++++++++++++++++++++--
 builtin/submodule--helper.c |  4 ++++
 cache.h                     |  1 +
 refs.c                      |  2 ++
 5 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index f1f2a3f..d7a4cb0 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
 	  [--dissociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch]
+	  [--refs-backend-type=<name>]
 	  [--recursive | --recurse-submodules] [--] <repository>
 	  [<directory>]
 
@@ -216,6 +217,9 @@ objects from the source repository into a pack in the cloned repository.
 	The result is Git repository can be separated from working
 	tree.
 
+--refs-backend-type=<name>::
+	Type of refs backend. Default is to use the original files based
+	backend.
 
 <repository>::
 	The (possibly remote) repository to clone from.  See the
diff --git a/builtin/clone.c b/builtin/clone.c
index cf19eeb..539eed9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -92,11 +92,13 @@ static struct option builtin_clone_options[] = {
 		   N_("separate git dir from working tree")),
 	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
 			N_("set config inside the new repository")),
+	OPT_STRING(0, "refs-backend-type", &refs_backend_type,
+		   N_("name"), N_("name of backend type to use")),
 	OPT_END()
 };
 
 static const char *argv_submodule[] = {
-	"submodule", "update", "--init", "--recursive", NULL
+	"submodule", "update", "--init", "--recursive", NULL, NULL
 };
 
 static const char *get_repo_path_1(struct strbuf *path, int *is_bundle)
@@ -717,8 +719,24 @@ static int checkout(void)
 	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
 			   sha1_to_hex(sha1), "1", NULL);
 
-	if (!err && option_recursive)
+	if (!err && option_recursive) {
+		const char **backend_arg = argv_submodule;
+		char *new_backend_arg = NULL;
+		if (refs_backend_type) {
+			while (*backend_arg)
+				++backend_arg;
+
+			new_backend_arg = xmalloc(21 + strlen(refs_backend_type));
+			sprintf(new_backend_arg, "--refs-backend-type=%s",
+				refs_backend_type);
+			*backend_arg = new_backend_arg;
+		}
 		err = run_command_v_opt(argv_submodule, RUN_GIT_CMD);
+		if (refs_backend_type) {
+			free(new_backend_arg);
+			*backend_arg = NULL;
+		}
+	}
 
 	return err;
 }
@@ -737,6 +755,11 @@ static void write_config(struct string_list *config)
 					       write_one_config, NULL) < 0)
 			die("unable to write parameters to config file");
 	}
+
+	if (refs_backend_type &&
+	    write_one_config("core.refs-backend-type",
+			     refs_backend_type, NULL) < 0)
+			die("unable to write backend parameter to config file");
 }
 
 static void write_refspec_config(const char *src_ref_prefix,
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index adfa0e4..a2ed0cc 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -150,6 +150,10 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
 		argv_array_push(&cp.args, "--separate-git-dir");
 		argv_array_push(&cp.args, gitdir);
 	}
+	if (refs_backend_type) {
+		argv_array_push(&cp.args, "--refs-backend-type");
+		argv_array_push(&cp.args, refs_backend_type);
+	}
 	argv_array_push(&cp.args, url);
 	argv_array_push(&cp.args, path);
 
diff --git a/cache.h b/cache.h
index a9669de..6193143 100644
--- a/cache.h
+++ b/cache.h
@@ -694,6 +694,7 @@ enum object_creation_mode {
 extern enum object_creation_mode object_creation_mode;
 
 extern char *notes_ref_name;
+extern const char *refs_backend_type;
 
 extern int grafts_replace_parents;
 
diff --git a/refs.c b/refs.c
index 3f8fa8e..3a2cafb 100644
--- a/refs.c
+++ b/refs.c
@@ -16,6 +16,8 @@ struct ref_be *the_refs_backend = &refs_be_files;
  */
 struct ref_be *refs_backends = &refs_be_files;
 
+const char *refs_backend_type;
+
 /*
  * This function is used to switch to an alternate backend.
  */
-- 
2.0.4.315.gad8727a-twtrsrc
