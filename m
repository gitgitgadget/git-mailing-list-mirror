Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABD3D1F403
	for <e@80x24.org>; Mon, 11 Jun 2018 20:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933355AbeFKUkN (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 16:40:13 -0400
Received: from mout.gmx.net ([212.227.17.20]:42435 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754164AbeFKUkM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 16:40:12 -0400
Received: from localhost ([188.192.2.98]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M4Wwq-1gBL250Dm8-00yhEI; Mon, 11
 Jun 2018 22:40:01 +0200
Date:   Mon, 11 Jun 2018 22:39:58 +0200
From:   Clemens Buchacher <drizzd@gmx.net>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH v2] checkout files in-place
Message-ID: <20180611203958.GA1306@Sonnenschein.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180610194444.GA1913@Sonnenschein.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Provags-ID: V03:K1:4MttgqxRcuU4adWLI4SSAcRKoskXFzHVuPpt4SJLMBQccjcDfuX
 rMMMDvkWQWa82I6v1f7fP0U4BVChqepyKNK6BE/LJfsmOCKlq60nV/5zyXD6SY8IPlxdokj
 JbY3wiGs23GLjRfCNkGtnPT1uI2GhJ1ACa1/25dvklw6Ca5pPVQQv4426Q7dNIpSAl1oyPk
 f9yDYbLHwKpVuCcLRyslw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hpbeM1v3IEk=:0l1AHS7iqUV/TSBVyev2bm
 oHUWUriT6a3gTs6dLp4mifhSBRW9y5jh2l7T9e/0XEJWOr0cGSN8UrafBYM+MkfF4Kp9KNx5E
 otuQCjRhJhCqoId8rI4fRhqfc12OtzC0ft8igw8HGGDl8RFEcQP5lZ94YtXQcnMmdSVLSXkiC
 MyuneYqJrprjkK6m0h0/FZKO1TAGvuYvaaufUmBxZkl98mg1rrLqvwdJPg8+TcHzM6kVf8bn3
 XnYgIl7NlsMtKfUs44fy2TUXIMuXTQ7UwisEX6NLQvm14ye4c+Z1rpVk8CbxGTA/FPKgfofUg
 GZCSJk1Wqb02XSeVCf/R+oybnSSQQk15g04wrlkCZsYkM0if7Tq8YGwJPm/qD9lFVhaYlapD/
 p4vzr3yWOiUinAygtlkbQhWxVQ6iFl3+7ApkM39C1qgN/NT9xUHCINYo4O+M/kXzj0cdeOa4f
 lhBU6+kQ+Jly78JXp4qgwHCBuZ1Npt8Rs1GvW6fvyO/0ZhY9CECdTyXaLYRxsHESxG5ofWkif
 l9gvw2tTrMMmLOws9j434wvF02JI5KWKmBv2pgAifg1n3BEUcoTdGQdkRwLSFJ1UDfgwk1fuQ
 BbKcWlQWoB3qWgxxKkWaRQGfk19zW7qd1vm6Nlc5ts16ydITCB/hzlN1/cNhfCsH3nX8nRmCL
 hRp8HmNDCysN4wNIjol0AREjHL7VJQVyYYGoiQyFMMCooeS3j2UZZoj/rCiiInZMrFsWg3MTI
 2VaktOHjVCknl0fghc1vAFeHMvXjf3cab3SQp2y3X/kHFiJ+eZ8lnJReU9s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When replacing files with new content during checkout, we do not write
to them in place. Instead we unlink and recreate the files in order to
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

This change adds the core.checkoutInPlace option. If enabled, checkout
will open files for writing the new content in place. This fixes the
issue, but with this approach the system will not update file
permissions according to umask. Only essential updates of write and
executable permissions are performed.

The in-place checkout is therefore optional. It could be enabled by Git
installers on Windows, where umask is irrelevant.

Signed-off-by: Clemens Buchacher <drizzd@gmx.net>
Reviewed-by: Orgad Shaneh <orgads@gmail.com>
Reviewed-by: "brian m. carlson" <sandals@crustytoothpaste.net>
Reviewed-by: Duy Nguyen <pclouds@gmail.com>
Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Tested on Windows with Git-for-Windows and with Windows Subsystem for
Linux.

 Documentation/config.txt    | 11 ++++++
 cache.h                     |  2 ++
 config.c                    |  5 +++
 entry.c                     | 18 ++++++++--
 environment.c               |  1 +
 t/t2031-checkout-inplace.sh | 82 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 116 insertions(+), 3 deletions(-)
 create mode 100755 t/t2031-checkout-inplace.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab641bf..0860a81 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -912,6 +912,17 @@ core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
 	linkgit:git-read-tree[1] for more information.
 
+core.checkoutInPlace::
+	Check out file contents in place. By default Git checkout removes existing
+	work tree files before it replaces them with different content. If this
+	option is enabled, Git will overwrite the contents of existing files in
+	place. This is useful on Windows, where open file handles to a removed file
+	prevent creating new files at the same path.
+	Note that the current implementation of in-place checkout makes no effort
+	to update read/write permissions according to umask. Permissions are
+	however modified to enable write access and to update executable
+	permissions.
+
 core.abbrev::
 	Set the length object names are abbreviated to.  If
 	unspecified or set to "auto", an appropriate value is
diff --git a/cache.h b/cache.h
index 89a107a..5b8c4d6 100644
--- a/cache.h
+++ b/cache.h
@@ -815,6 +815,7 @@ extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_commit_graph;
 extern int core_apply_sparse_checkout;
+extern int checkout_inplace;
 extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
@@ -1518,6 +1519,7 @@ struct checkout {
 	unsigned force:1,
 		 quiet:1,
 		 not_new:1,
+		 inplace:1,
 		 refresh_cache:1;
 };
 #define CHECKOUT_INIT { NULL, "" }
diff --git a/config.c b/config.c
index fbbf0f8..8b35ecd 100644
--- a/config.c
+++ b/config.c
@@ -1318,6 +1318,11 @@ static int git_default_core_config(const char *var, const char *value)
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
index 2101201..a599fc1 100644
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
@@ -467,8 +472,15 @@ int checkout_entry(struct cache_entry *ce,
 			if (!state->force)
 				return error("%s is a directory", path.buf);
 			remove_subtree(&path);
-		} else if (unlink(path.buf))
-			return error_errno("unable to unlink old '%s'", path.buf);
+		} else if (checkout_inplace) {
+			if (!(st.st_mode & 0200) ||
+			    (trust_executable_bit && (st.st_mode & 0100) != (ce->ce_mode & 0100)))
+				if (chmod(path.buf, (ce->ce_mode & 0100) ? 0777 : 0666))
+					return error_errno(_("unable to change mode of '%s'"), path.buf);
+		} else {
+			if (unlink(path.buf))
+				return error_errno(_("unable to unlink old '%s'"), path.buf);
+		}
 	} else if (state->not_new)
 		return 0;
 
diff --git a/environment.c b/environment.c
index 2a6de23..5b91f30 100644
--- a/environment.c
+++ b/environment.c
@@ -68,6 +68,7 @@ char *notes_ref_name;
 int grafts_replace_parents = 1;
 int core_commit_graph;
 int core_apply_sparse_checkout;
+int checkout_inplace;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
diff --git a/t/t2031-checkout-inplace.sh b/t/t2031-checkout-inplace.sh
new file mode 100755
index 0000000..d70ecc4
--- /dev/null
+++ b/t/t2031-checkout-inplace.sh
@@ -0,0 +1,82 @@
+#!/bin/sh
+
+test_description='in-place checkout'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+
+	test_commit hello world &&
+	git branch other &&
+	test_commit hello-again world
+'
+
+test_expect_success 'in-place checkout overwrites open file' '
+
+	git config core.checkoutInPlace true &&
+	git checkout -f master &&
+	exec 8<world &&
+	git checkout other &&
+	exec 8<&- &&
+	echo hello >expect &&
+	test_cmp expect world
+'
+
+test_expect_success 'in-place checkout overwrites read-only file' '
+
+	git config core.checkoutInPlace true &&
+	git checkout -f master &&
+	chmod -w world &&
+	git checkout other &&
+	echo hello >expect &&
+	test_cmp expect world
+'
+
+test_expect_success 'in-place checkout updates executable permission' '
+
+	git config core.checkoutInPlace true &&
+	git checkout -f master^0 &&
+	test_chmod +x world &&
+	git commit -m executable &&
+	git checkout other &&
+	test ! -x world
+'
+
+test_expect_success POSIXPERM 'regular checkout respects umask' '
+
+	git config core.checkoutInPlace false &&
+	git checkout -f master &&
+	chmod 0660 world &&
+	umask 0022 &&
+	git checkout other &&
+	actual=$(ls -l world) &&
+	case "$actual" in
+	-rw-r--r--*)
+		: happy
+		;;
+	*)
+		echo Oops, world is not 0644 but $actual
+		false
+		;;
+	esac
+'
+
+test_expect_success POSIXPERM 'in-place checkout ignores umask' '
+
+	git config core.checkoutInPlace true &&
+	git checkout -f master &&
+	chmod 0660 world &&
+	umask 0022 &&
+	git checkout other &&
+	actual=$(ls -l world) &&
+	case "$actual" in
+	-rw-rw----*)
+		: happy
+		;;
+	*)
+		echo Oops, world is not 0660 but $actual
+		false
+		;;
+	esac
+'
+
+test_done
-- 
2.7.4
