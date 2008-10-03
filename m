From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] builtin-merge: refresh the index before calling a strategy
Date: Fri,  3 Oct 2008 15:02:31 +0200
Message-ID: <1223038951-25190-1-git-send-email-vmiklos@frugalware.org>
References: <20080928151135.GF23137@genesis.frugalware.org>
Cc: spearce@spearce.org, msoulier@digitaltorque.ca, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Oct 03 15:04:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlkJp-00068Y-Az
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 15:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbYJCNCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 09:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752052AbYJCNCM
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 09:02:12 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:60633 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbYJCNCL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 09:02:11 -0400
Received: from vmobile.example.net (dsl5401CD67.pool.t-online.hu [84.1.205.103])
	by yugo.frugalware.org (Postfix) with ESMTPA id 03BB5149C60;
	Fri,  3 Oct 2008 15:02:09 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 863E919E7C3; Fri,  3 Oct 2008 15:02:32 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <20080928151135.GF23137@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97424>

In case a file is touched but has no real changes then we just have to
update the index and should not error out.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Sun, Sep 28, 2008 at 05:11:35PM +0200, Miklos Vajna <vmiklos@frugalware.org> wrote:
> Thanks for the reproducer, I'll write a proper testcase for this and
> try to
> provide a fix for it as well.

Try this one.

 builtin-merge.c  |   10 ++++++++++
 t/t7600-merge.sh |    9 +++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index 4c9ed5d..6c9dfe6 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -548,6 +548,16 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 	int i = 0, ret;
 	struct commit_list *j;
 	struct strbuf buf;
+	int index_fd;
+	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
+
+	index_fd = hold_locked_index(lock, 1);
+	refresh_cache(REFRESH_QUIET);
+	if (active_cache_changed &&
+			(write_cache(index_fd, active_cache, active_nr) ||
+			 commit_locked_index(lock)))
+		return error("Unable to write index.");
+	rollback_lock_file(lock);
 
 	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree")) {
 		int clean;
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 98cfc53..61db3c3 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -520,4 +520,13 @@ test_expect_success 'merge --no-ff --no-commit && commit' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'refresh the index before merging' '
+	git reset --hard c1 &&
+	sleep 1 &&
+	touch file &&
+	git merge c3
+'
+
+test_debug 'gitk --all'
+
 test_done
-- 
1.6.0.2
