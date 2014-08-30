From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/32] nd/multiple-work-trees cleanup
Date: Sat, 30 Aug 2014 15:33:30 +0700
Message-ID: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 10:34:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNe6q-00015i-8s
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 10:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbaH3IeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2014 04:34:00 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:63119 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbaH3Id6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 04:33:58 -0400
Received: by mail-pd0-f174.google.com with SMTP id ft15so2068604pdb.33
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 01:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=HVqjDFfun8MIrypd+iO6q/byzqwgviEY8HeziR0TP+E=;
        b=rn8KZ440olnNzoh6vEKJleQEpAb1RI4rRACMgLpR9yN9Mvn2btLFWEVb81Uqgx2MyR
         AHmAo5xPgBBYFCMAaXlQEWubRoHIQYaOsinQpkkkNR2t3ie9e0DuO++ZnQe6pJfJ8CCj
         EKJHyX+NNUClh0zRSUETZHTvOm2MdbJAEelYI+g/6lty7gst8Gkhba1Qfo5MgJZHvJTi
         /smIqTY2qYmqD+oB+jx85WMz95v6txKMl+Voooz6UVM03ZC+2/xuFBKL2BwOrCnSOPGT
         mBXFCrP6VXggOwIB75iE3z5gSWvmTderWdEVRxXRDeNc6fZRhB02cIhzVq8/7zbQ42ol
         PqYw==
X-Received: by 10.68.65.101 with SMTP id w5mr21885696pbs.5.1409387637674;
        Sat, 30 Aug 2014 01:33:57 -0700 (PDT)
Received: from lanh ([115.73.195.142])
        by mx.google.com with ESMTPSA id ty8sm7547812pab.26.2014.08.30.01.33.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Aug 2014 01:33:56 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Aug 2014 15:34:06 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256210>

This collapes some bug fix patches into the main ones, adds a few more
tests to cover recent changes, and removes advice.checkoutLocked (when
things are controversal, probably best to go without them until they
are settled). Diff against current version in 'pu'

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b2c3388..57999fa 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -201,10 +201,6 @@ advice.*::
 	rmHints::
 		In case of failure in the output of linkgit:git-rm[1],
 		show directions on how to proceed from the current state.
-	checkoutLocked::
-		In multiple checkout setup, attempting to checkout a
-		branch already checked out elsewhere will fail. Show
-		some useful options to proceed.
 --
 
 core.fileMode::
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index 6bd82af..c9a7d1a 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -139,8 +139,8 @@ is often called 'detached HEAD.'  See linkgit:git-checkout[1]
 for details.
 
 config::
-	Repository specific configuration file. This file is ignored if
-	$GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/config" will be
+	Repository specific configuration file. This file is ignored
+	if $GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/config" will be
 	used instead.
 
 branches::
@@ -218,11 +218,10 @@ remotes::
 	"$GIT_COMMON_DIR/remotes" will be used instead.
 
 logs::
-	Records of changes made to refs are stored in this
-	directory.  See linkgit:git-update-ref[1]
-	for more information. This directory is ignored if
-	$GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/logs" will be used
-	instead.
+	Records of changes made to refs are stored in this directory.
+	See linkgit:git-update-ref[1] for more information. This
+	directory is ignored $GIT_COMMON_DIR is set and
+	"$GIT_COMMON_DIR/logs" will be used instead.
 
 logs/refs/heads/`name`::
 	Records all changes made to the branch tip named `name`.
diff --git a/advice.c b/advice.c
index cf3b0f7..9b42033 100644
--- a/advice.c
+++ b/advice.c
@@ -15,7 +15,6 @@ int advice_detached_head = 1;
 int advice_set_upstream_failure = 1;
 int advice_object_name_warning = 1;
 int advice_rm_hints = 1;
-int advice_checkout_locked = 1;
 
 static struct {
 	const char *name;
@@ -36,7 +35,6 @@ static struct {
 	{ "setupstreamfailure", &advice_set_upstream_failure },
 	{ "objectnamewarning", &advice_object_name_warning },
 	{ "rmhints", &advice_rm_hints },
-	{ "checkoutlocked", &advice_checkout_locked },
 
 	/* make this an alias for backward compatibility */
 	{ "pushnonfastforward", &advice_push_update_rejected }
diff --git a/advice.h b/advice.h
index 935631d..5ecc6c1 100644
--- a/advice.h
+++ b/advice.h
@@ -18,7 +18,6 @@ extern int advice_detached_head;
 extern int advice_set_upstream_failure;
 extern int advice_object_name_warning;
 extern int advice_rm_hints;
-extern int advice_checkout_locked;
 
 int git_default_advice_config(const char *var, const char *value);
 __attribute__((format (printf, 1, 2)))
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3dc416c..b88c646 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -862,7 +862,7 @@ static int prepare_linked_checkout(const struct checkout_opts *opts,
 	if (!new->commit)
 		die(_("no branch specified"));
 	if (file_exists(path))
-		die(_("%s already exists"), path);
+		die(_("'%s' already exists"), path);
 
 	len = strlen(path);
 	while (len && is_dir_sep(path[len - 1]))
@@ -1038,16 +1038,7 @@ static void check_linked_checkout(struct branch_info *new, const char *id)
 		strbuf_rtrim(&gitdir);
 	} else
 		strbuf_addstr(&gitdir, get_git_common_dir());
-	if (advice_checkout_locked)
-		die(_("'%s' is already checked out at %s\n"
-		      "Either go there and continue working, or detach HEAD using\n"
-		      "    git checkout --detach [more options] %s\n"
-		      "or create a new branch based off '%s' using\n"
-		      "    git checkout -b <branch name> [more options] %s\n"
-		      "or switch to another branch at the other checkout and retry."),
-		    new->name, gitdir.buf, new->name, new->name, new->name);
-	else
-		die(_("'%s' is already checked out at %s"), new->name, gitdir.buf);
+	die(_("'%s' is already checked out at '%s'"), new->name, gitdir.buf);
 done:
 	strbuf_release(&path);
 	strbuf_release(&sb);
diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
index 508993f..aa24ea8 100755
--- a/t/t2025-checkout-to.sh
+++ b/t/t2025-checkout-to.sh
@@ -12,6 +12,11 @@ test_expect_success 'checkout --to not updating paths' '
 	test_must_fail git checkout --to -- init.t
 '
 
+test_expect_success 'checkout --to an existing worktree' '
+	mkdir existing &&
+	test_must_fail git checkout --detach --to existing master
+'
+
 test_expect_success 'checkout --to refuses to checkout locked branch' '
 	test_must_fail git checkout --to zere master &&
 	! test -d zere &&
@@ -31,6 +36,16 @@ test_expect_success 'checkout --to a new worktree' '
 	)
 '
 
+test_expect_success 'checkout --to a new worktree from a subdir' '
+	(
+		mkdir sub &&
+		cd sub &&
+		git checkout --detach --to here master &&
+		cd here &&
+		test_cmp ../../init.t init.t
+	)
+'
+
 test_expect_success 'checkout --to from a linked checkout' '
 	(
 		cd here &&
-- 
2.1.0.rc0.78.gc0d8480
