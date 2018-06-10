Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B16031F403
	for <e@80x24.org>; Sun, 10 Jun 2018 19:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753681AbeFJToq (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Jun 2018 15:44:46 -0400
Received: from mout.gmx.net ([212.227.15.15]:35027 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752723AbeFJTop (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jun 2018 15:44:45 -0400
Received: from localhost ([188.192.2.98]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MVN0w-1flDJF3cb8-00YiW5 for
 <git@vger.kernel.org>; Sun, 10 Jun 2018 21:44:44 +0200
Date:   Sun, 10 Jun 2018 21:44:45 +0200
From:   Clemens Buchacher <drizzd@gmx.net>
To:     git@vger.kernel.org
Subject: [PATCH] checkout files in-place
Message-ID: <20180610194444.GA1913@Sonnenschein.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Provags-ID: V03:K1:9DkpHhYdinrlgAMKpNzh6dQLc0QicC1hYmIW9TyC45ICGK3J7CR
 F2FFpzCDNdIyh81va4bMc5Q5ipZwWGpehM0wk0kC/CiHydgR2Fztxl9D10yLiY7hHXZ4moa
 CxFwjl8T86tjCMUEChrgukTaBCSvE0Y3E/kd2EyJ2Fzl+wFvhTPvehluMG3cQUA6UMuIDrr
 e98y74o9/TBvisV15n+zA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xg8WdNNpnso=:CKdSYzHycmk4sqtWDln1NK
 2KXJ+e+qRWEmNmyf2f8nJ7gnFSiBNuFfO+k9rkxk2UuOPCjEejXG3FTpFwzsUHac0IvOfKcHX
 C7lErVgMRc5LLx6AlXaltqnV5+ODPTdcrilS1w+WD7YuVsFrcFYKjxpT96z5bu6TGFps5pJoP
 6C8nXSx/ScBlX6jaqJJ8dNklYqJ55lK+4FEJnrchpqOKLXztp/4Xh6StM5bmHn1bdE3mEE1Zp
 CvMAAHWJhfvepRRMSD1/hVJYimEQBAh6MKX6eOXFO32uanptQtASNvebh0U4rx1omv/oR19+m
 4B6u2E3sZvd8ubIODR9qQBGqVXyPPHXf82DTra+EzBbw8zr2msWngsDVEIissivUPBemIx6gl
 yTNkkM2DvrkNg6LQ+IX+v8Z4XJ1/JDJYjA8lwwAmSpcghJ+6z1hlUQyNa1zGxTaNTSFanH0yJ
 3TveIwEuo8j4/3y9lUcJWBz9Or4z6rNo9kE8ihEtemdXsOYfgK1z7DbaBRwSxuszGFTQ7s+Ox
 J0iwGTrB28YnZGYVTGNihaJYuB6c9GhkyOLqRostM5+CtFEPkjaapG/mV5DzSIDk5f9h8DgRv
 f5GIQ4swRPnl/rNSU8G6Gj4w+rYVe+1R+kMIkuUsKqceB+nI0op6J/0rAaba7DyrR0EQw5dgx
 S1WmsRXLgh+dVgr14UAAVPM6t72/JvSJh4fMcYyO6NXcddoYIfsgD384OkrccsKPr0JV2buai
 e+u8HdO9o6NHDUzbM/83YpP5NOrvjWGgnzf/4SZff7teSJ1lJyZ3sZpS0PM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When replacing files with new content during checkout, we do not write
to them in-place. Instead we unlink and re-create the files in order to
let the system figure out ownership and permissions for the new file,
taking umask into account.

It is safe to do this on Linux file systems, even if open file handles
still exist, because unlink only removes the directory reference to the
file. On Windows, however, a file cannot be deleted until all handles to
it are closed. If a file cannot be deleted, its name cannot be reused.

This causes files to be deleted, but not checked out when switching
branches. This is frequently an issue with Qt Creator, which
continuously opens files in the work tree, as reported here:
https://github.com/git-for-windows/git/issues/1653

This change adds the core.checkout_inplace option. If enabled, checkout
will open files for writing the new content in-place. This fixes the
issue, but with this approach the system will not update file
permissions according to umask. Only essential updates of write and
executable permissions are performed.

The in-place checkout is therefore optional. It could be enabled by Git
installers on Windows, where umask is irrelevant.

Signed-off-by: Clemens Buchacher <drizzd@gmx.net>
---

I wonder if Git should be responsible for updating ownership and file
permissions when modifying existing files during checkout. We could
otherwise remove the unlink completely. Maybe this could even improve
performance in some cases. It made no difference in a short test on
Windows.

Regression tests are running. This will take a while.

 Documentation/config.txt    |  8 ++++++++
 cache.h                     |  2 ++
 config.c                    |  5 +++++
 entry.c                     | 18 +++++++++++++++---
 environment.c               |  1 +
 t/t2031-checkout-inplace.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 72 insertions(+), 3 deletions(-)
 create mode 100755 t/t2031-checkout-inplace.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b6cb997164..17af0fe163 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -923,6 +923,14 @@ core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
 	linkgit:git-read-tree[1] for more information.
 
+core.checkoutInplace::
+	Checkout file contents in-place. By default Git checkout removes existing
+	work tree files before it replaces them with different contents. If this
+	option is enabled Git will overwrite the contents of existing files
+	in-place. This is useful on systems where open file handles to a removed
+	file prevent creating new files at the same path. Note that Git will not
+	update read/write permissions according to umask.
+
 core.abbrev::
 	Set the length object names are abbreviated to.  If
 	unspecified or set to "auto", an appropriate value is
diff --git a/cache.h b/cache.h
index 2c640d4c31..c8fccd2a80 100644
--- a/cache.h
+++ b/cache.h
@@ -808,6 +808,7 @@ extern char *git_replace_ref_base;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
+extern int checkout_inplace;
 extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
@@ -1530,6 +1531,7 @@ struct checkout {
 	unsigned force:1,
 		 quiet:1,
 		 not_new:1,
+		 inplace:1,
 		 refresh_cache:1;
 };
 #define CHECKOUT_INIT { NULL, "" }
diff --git a/config.c b/config.c
index cd2b404b14..4ac2407057 100644
--- a/config.c
+++ b/config.c
@@ -1231,6 +1231,11 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.checkoutinplace")) {
+		checkout_inplace = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.precomposeunicode")) {
 		precomposed_unicode = git_config_bool(var, value);
 		return 0;
diff --git a/entry.c b/entry.c
index 31c00816dc..54c98870b9 100644
--- a/entry.c
+++ b/entry.c
@@ -78,8 +78,13 @@ static void remove_subtree(struct strbuf *path)
 
 static int create_file(const char *path, unsigned int mode)
 {
+	int flags;
+	if (checkout_inplace)
+		flags = O_WRONLY | O_CREAT | O_TRUNC;
+	else
+		flags = O_WRONLY | O_CREAT | O_EXCL;
 	mode = (mode & 0100) ? 0777 : 0666;
-	return open(path, O_WRONLY | O_CREAT | O_EXCL, mode);
+	return open(path, flags, mode);
 }
 
 static void *read_blob_entry(const struct cache_entry *ce, unsigned long *size)
@@ -470,8 +475,15 @@ int checkout_entry(struct cache_entry *ce,
 			if (!state->force)
 				return error("%s is a directory", path.buf);
 			remove_subtree(&path);
-		} else if (unlink(path.buf))
-			return error_errno("unable to unlink old '%s'", path.buf);
+		} else if (checkout_inplace) {
+			if (!(st.st_mode & 0200) ||
+			    (trust_executable_bit && (st.st_mode & 0100) != (ce->ce_mode & 0100)))
+				if (chmod(path.buf, (ce->ce_mode & 0100) ? 0777 : 0666))
+					return error_errno("unable to change mode of '%s'", path.buf);
+		} else {
+			if (unlink(path.buf))
+				return error_errno("unable to unlink old '%s'", path.buf);
+		}
 	} else if (state->not_new)
 		return 0;
 
diff --git a/environment.c b/environment.c
index d1ac37dd18..6a8036b144 100644
--- a/environment.c
+++ b/environment.c
@@ -63,6 +63,7 @@ enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents = 1;
 int core_apply_sparse_checkout;
+int checkout_inplace;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
diff --git a/t/t2031-checkout-inplace.sh b/t/t2031-checkout-inplace.sh
new file mode 100755
index 0000000000..60ea30cbf5
--- /dev/null
+++ b/t/t2031-checkout-inplace.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description='checkout inplace'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+
+	git config core.checkoutInplace true &&
+	echo hello >world &&
+	git add world &&
+	git commit -m initial &&
+	git branch other &&
+	echo "hello again" >>world &&
+	git add world &&
+	git commit -m second
+'
+
+test_expect_success 'checkout overwrites open file' '
+
+	git checkout -f master &&
+	mkfifo input &&
+	{
+		cat >>world <input &
+	} &&
+	pid=$! &&
+	test_when_finished "kill -KILL $pid; wait $pid; rm -f input" &&
+	git checkout other &&
+	echo hello >expect &&
+	test_cmp expect world
+'
+
+test_expect_success 'checkout overwrites read-only file' '
+
+	git checkout -f master &&
+	chmod -w world &&
+	git checkout other &&
+	echo hello >expect &&
+	test_cmp expect world
+'
+
+test_done
-- 
2.16.1.windows.1

