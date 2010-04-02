From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH v2 4/4] git status: refresh the index if possible
Date: Fri,  2 Apr 2010 23:44:21 +0200
Message-ID: <1270244661-24173-1-git-send-email-markus.heidelberg@web.de>
References: <1270211241-10795-5-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 23:42:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxodY-0003Vg-R7
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 23:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249Ab0DBVmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 17:42:40 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:43780 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754814Ab0DBVmj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 17:42:39 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 847A814AFAD13;
	Fri,  2 Apr 2010 23:42:37 +0200 (CEST)
Received: from [91.19.8.199] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1NxodR-0006gT-00; Fri, 02 Apr 2010 23:42:37 +0200
X-Mailer: git-send-email 1.7.0.4.300.g6e84d
In-Reply-To: <1270211241-10795-5-git-send-email-markus.heidelberg@web.de>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+IUSw0IGKG5XbVVaYcporRHSCIaR3Yhj8yFMMg
	pXTHxlS+F1Wc1FdMcChiX/Qc2UBx80E8Ec8L8sGANrdpxz+D/2
	gO8MmvrKgXJ6jEsIvaSQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143854>

This was already the case before commit 9e4b7ab6 (git status: not
"commit --dry-run" anymore, 2009-08-15) with the difference that it died
at failure.
It got lost during the new implementation of "git status", which was
meant to only change behaviour when invoked with arguments.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

v2:
Doesn't die when writing the index fails and so works for read-only
repositories.
Is rollback_lock_file(&index_lock) necessary? It isn't used in
"git commit --dry-run" when commit_style is COMMIT_AS_IS.

 builtin/commit.c  |    9 +++++++++
 t/t7508-status.sh |    2 +-
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index c5ab683..3c14ade 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1017,6 +1017,7 @@ static int git_status_config(const char *k, const char *v, void *cb)
 int cmd_status(int argc, const char **argv, const char *prefix)
 {
 	struct wt_status s;
+	int fd;
 	unsigned char sha1[20];
 	static struct option builtin_status_options[] = {
 		OPT__VERBOSE(&verbose),
@@ -1050,6 +1051,14 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 
 	read_cache_preload(s.pathspec);
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, s.pathspec, NULL, NULL);
+
+	fd = hold_locked_index(&index_lock, 0);
+	if (0 <= fd) {
+		if (!write_cache(fd, active_cache, active_nr))
+			commit_locked_index(&index_lock);
+		rollback_lock_file(&index_lock);
+	}
+
 	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
 	s.in_merge = in_merge;
 	wt_status_collect(&s);
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 086ec3a..c317bde 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -499,7 +499,7 @@ test_expect_success 'dry-run of partial commit excluding new file in index' '
 cat >expect <<EOF
 :100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0000000000000000000000000000000000000000 M	dir1/modified
 EOF
-test_expect_failure 'status refreshes the index' '
+test_expect_success 'status refreshes the index' '
 	touch dir2/added &&
 	git status &&
 	git diff-files >output &&
-- 
1.7.0.4.300.ge0630
