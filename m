Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61EE3203C2
	for <e@80x24.org>; Fri, 15 Jul 2016 23:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbcGOXXy (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 19:23:54 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:45102 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751413AbcGOXXw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 19:23:52 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1bOCSQ-0003B3-VM; Sat, 16 Jul 2016 08:23:46 +0900
From:	Mike Hommey <mh@glandium.org>
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v3 1/2] blame: Allow to blame paths freshly added to the index
Date:	Sat, 16 Jul 2016 08:23:45 +0900
Message-Id: <20160715232346.12176-1-mh@glandium.org>
X-Mailer: git-send-email 2.9.1.277.gdbc86c9.dirty
In-Reply-To: <xmqqr3auli2x.fsf@gitster.mtv.corp.google.com>
References: <xmqqr3auli2x.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When blaming files, changes in the work tree are taken into account
and displayed as being "Not Committed Yet".

However, when blaming a file that is not known to the current HEAD,
git blame fails with `no such path 'foo' in HEAD`, even when the file
was git add'ed.

This would seem uninteresting with the plain `git blame` case, which
it is, but it becomes useful when using copy detection, and the new file
was created from pieces already in HEAD, moved or copied from other
files.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 builtin/blame.c               | 10 +++++++++-
 t/t8003-blame-corner-cases.sh | 45 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 1e214bd..f297a7f 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2230,6 +2230,7 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 static void verify_working_tree_path(struct commit *work_tree, const char *path)
 {
 	struct commit_list *parents;
+	int pos;
 
 	for (parents = work_tree->parents; parents; parents = parents->next) {
 		const unsigned char *commit_sha1 = parents->item->object.oid.hash;
@@ -2240,7 +2241,14 @@ static void verify_working_tree_path(struct commit *work_tree, const char *path)
 		    sha1_object_info(blob_sha1, NULL) == OBJ_BLOB)
 			return;
 	}
-	die("no such path '%s' in HEAD", path);
+
+	pos = cache_name_pos(path, strlen(path));
+	if (pos >= 0)
+		; /* path is in the index */
+	else if (!strcmp(active_cache[-1 - pos]->name, path))
+		; /* path is in the index, unmerged */
+	else
+		die("no such path '%s' in HEAD", path);
 }
 
 static struct commit_list **append_parent(struct commit_list **tail, const unsigned char *sha1)
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index a9b266f..eab2e28 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -137,6 +137,51 @@ test_expect_success 'blame wholesale copy and more' '
 
 '
 
+test_expect_success 'blame wholesale copy and more in the index' '
+
+	cat >horse <<-\EOF &&
+	ABC
+	DEF
+	XXXX
+	YYYY
+	GHIJK
+	EOF
+	git add horse &&
+	test_when_finished "git rm -f horse" &&
+	git blame -f -C -C1 -- horse | sed -e "$pick_fc" >current &&
+	cat >expected <<-\EOF &&
+	mouse-Initial
+	mouse-Second
+	cow-Fifth
+	horse-Not
+	mouse-Third
+	EOF
+	test_cmp expected current
+
+'
+
+test_expect_success 'blame during cherry-pick with file rename conflict' '
+
+	test_when_finished "git reset --hard && git checkout master" &&
+	git checkout HEAD~3 &&
+	echo MOUSE >> mouse &&
+	git mv mouse rodent &&
+	git add rodent &&
+	GIT_AUTHOR_NAME=Rodent git commit -m "rodent" &&
+	git checkout --detach master &&
+	(git cherry-pick HEAD@{1} || test $? -eq 1) &&
+	git show HEAD@{1}:rodent > rodent &&
+	git add rodent &&
+	git blame -f -C -C1 rodent | sed -e "$pick_fc" >current &&
+	cat current &&
+	cat >expected <<-\EOF &&
+	mouse-Initial
+	mouse-Second
+	rodent-Not
+	EOF
+	test_cmp expected current
+'
+
 test_expect_success 'blame path that used to be a directory' '
 	mkdir path &&
 	echo A A A A A >path/file &&
-- 
2.9.1.277.gdbc86c9.dirty

