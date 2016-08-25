Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E40EC1F859
	for <e@80x24.org>; Thu, 25 Aug 2016 15:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934179AbcHYPIe (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 11:08:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:55963 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932312AbcHYPIa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 11:08:30 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LjrDd-1b1OQu2lOD-00bu8Y; Thu, 25 Aug 2016 17:06:45
 +0200
Date:   Thu, 25 Aug 2016 17:06:44 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/6] pull: drop confusing prefix parameter of
 die_on_unclean_work_tree()
In-Reply-To: <cover.1472137582.git.johannes.schindelin@gmx.de>
Message-ID: <8fd43aabe0ee2427276b94928a4d9d8d2ef08613.1472137582.git.johannes.schindelin@gmx.de>
References: <cover.1472137582.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:m3qIWhHgfWMVYoJ5LbjiW8TsKhwDH9M1o+DnQMpZ90If8NCJHX1
 wzfsP/vAI+Qulo51nMnabPxHcCy0vwrsKsOLVJNNLEeGtajx+oI5Yc0vS6O9iSJSXGECavy
 3UMNR53gGrbvhSJ3wb4Hw4Z9jb4ULVZN3m92M0TG2sll6zAAs3llN402womstzvR9kM6S83
 4+INn8QSOUbQojQ8B9oew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZfE75xVToQ4=:8wIDpontjq5yNVO90WakJV
 mHdYYYKesyZ5BI/pRVi5OPO2z0O51+MMIPtnpv5gb6912W9oIkRW8xIqB9oGUoJ38CTzr7Pho
 wwXkLbaN41RwPPpsGWRSE82Seg+WeCxvqcFpnb7xafjxIrME+V+fhmi17558HUr4YPNV4Iw4o
 LBE7amUw41MSMuN8m1AkGGN5NHLJVySEmGGHckdY9abncBKScJUAyUPKvIHik1BSL/IRs6TJo
 J6zFRPa1jehxkB8/EBwpUwU2iNcwpC7+u1s1NVXBnYrEaQOMtKKdbehqi0pTluiLce//aET0W
 WGojjFy07RvArefcZb+iUNWlZtrpILRJ5XAgaR+oOso1QKmCqQENYhQDcHPgRwpRYUg20pt8J
 kmQjW5PP3VbaRkWFfxWIBZbutiLQaeLNGA9JoedPpbv5qTzuDNQdnsSEONkFpQ0HOJhE2ACbR
 K5Tufl0N4krGoo9Fs9bMDHRjuZ49wFY3/sv09op0zPlp1NdxJOiLoO3UFEg5E3Tw86bgayvbK
 11toC+R6VZavWMUzIg6B0R15qCGHoxvkPiGxzx9R2DEYmAu+UpRLVrUOOglhcpBVtRI5MbOQf
 4IY+lyYeetpZzhZaGCJ+96oaw0JVM+osj4RKt4fwKUZGybSZk9useUBF8Ql0tTikh7QVXV3IC
 mIbOwHTujuolQP0UPkZTexX149BgmZFGM5eU7lZ1BGTKpPKz+6iGY15jSCcRoB3DFpOA4FNW8
 td7KEN94c2D/qXuaXZiayFZ8+DxGffgGIf8fsRuwHlNXkGotvzrQDN8o8FLQ+GDM9qkoMh1EC
 9O/ikDS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In cmd_pull(), when verifying that there are no changes preventing a
rebasing pull, we diligently pass the prefix parameter to the
die_on_unclean_work_tree() function which in turn diligently passes it
to the has_unstaged_changes() and has_uncommitted_changes() functions.

The casual reader might now be curious (as this developer was) whether
that means that calling `git pull --rebase` in a subdirectory will
ignore unstaged changes in other parts of the working directory. And be
puzzled that `git pull --rebase` (correctly) complains about those
changes outside of the current directory.

The puzzle is easily resolved: while we take pains to pass around the
prefix and even pass it to init_revisions(), the fact that no paths are
passed to init_revisions() ensures that the prefix is simply ignored.

That, combined with the fact that we will *always* want a *full* working
directory check before running a rebasing pull, is reason enough to
simply do away with the actual prefix parameter and to pass NULL
instead, as if we were running this from the top-level working directory
anyway.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pull.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 398aae1..d4bd635 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -328,12 +328,12 @@ static int git_pull_config(const char *var, const char *value, void *cb)
 /**
  * Returns 1 if there are unstaged changes, 0 otherwise.
  */
-static int has_unstaged_changes(const char *prefix)
+static int has_unstaged_changes(void)
 {
 	struct rev_info rev_info;
 	int result;
 
-	init_revisions(&rev_info, prefix);
+	init_revisions(&rev_info, NULL);
 	DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
 	DIFF_OPT_SET(&rev_info.diffopt, QUICK);
 	diff_setup_done(&rev_info.diffopt);
@@ -344,7 +344,7 @@ static int has_unstaged_changes(const char *prefix)
 /**
  * Returns 1 if there are uncommitted changes, 0 otherwise.
  */
-static int has_uncommitted_changes(const char *prefix)
+static int has_uncommitted_changes(void)
 {
 	struct rev_info rev_info;
 	int result;
@@ -352,7 +352,7 @@ static int has_uncommitted_changes(const char *prefix)
 	if (is_cache_unborn())
 		return 0;
 
-	init_revisions(&rev_info, prefix);
+	init_revisions(&rev_info, NULL);
 	DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
 	DIFF_OPT_SET(&rev_info.diffopt, QUICK);
 	add_head_to_pending(&rev_info);
@@ -365,7 +365,7 @@ static int has_uncommitted_changes(const char *prefix)
  * If the work tree has unstaged or uncommitted changes, dies with the
  * appropriate message.
  */
-static void die_on_unclean_work_tree(const char *prefix)
+static void die_on_unclean_work_tree(void)
 {
 	struct lock_file *lock_file = xcalloc(1, sizeof(*lock_file));
 	int do_die = 0;
@@ -375,12 +375,12 @@ static void die_on_unclean_work_tree(const char *prefix)
 	update_index_if_able(&the_index, lock_file);
 	rollback_lock_file(lock_file);
 
-	if (has_unstaged_changes(prefix)) {
+	if (has_unstaged_changes()) {
 		error(_("Cannot pull with rebase: You have unstaged changes."));
 		do_die = 1;
 	}
 
-	if (has_uncommitted_changes(prefix)) {
+	if (has_uncommitted_changes()) {
 		if (do_die)
 			error(_("Additionally, your index contains uncommitted changes."));
 		else
@@ -875,7 +875,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			die(_("Updating an unborn branch with changes added to the index."));
 
 		if (!autostash)
-			die_on_unclean_work_tree(prefix);
+			die_on_unclean_work_tree();
 
 		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
 			hashclr(rebase_fork_point);
-- 
2.10.0.rc1.99.gcd66998


