From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 4/5] commit: write cache-tree data when writing index anyway
Date: Tue, 6 Dec 2011 18:43:38 +0100
Message-ID: <fcb51622a521eaf418c82bfd5ff83e8a0b79498b.1323191497.git.trast@student.ethz.ch>
References: <cover.1323191497.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 06 18:44:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXz3p-0000N4-87
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 18:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179Ab1LFRnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 12:43:51 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:35844 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854Ab1LFRnq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 12:43:46 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Dec
 2011 18:43:39 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Dec
 2011 18:43:41 +0100
X-Mailer: git-send-email 1.7.8.431.g2abf2
In-Reply-To: <cover.1323191497.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186362>

In prepare_index(), we refresh the index, and then write it to disk if
this changed the index data.  After running hooks we re-read the index
and compute the root tree sha1 with the cache-tree machinery.

This gives us a mostly free opportunity to write up-to-date cache-tree
data: we can compute it in prepare_index() immediately before writing
the index to disk.

If we do this, we were going to write the index anyway, and the later
cache-tree update has no further work to do.  If we don't do it, we
don't do any extra work, though we still don't have have cache-tree
data after the commit.

The only case that suffers badly is when the pre-commit hook changes
many trees in the index.  I'm writing this off as highly unusual.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Don't ask me why git thinks the index has been changed only when
already building upon an earlier commit.  I don't know.  I suspect
it's some raciness issue though.

 builtin/commit.c      |    2 ++
 t/t0090-cache-tree.sh |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 0163086..57d028e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -394,6 +394,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 		fd = hold_locked_index(&index_lock, 1);
 		add_files_to_cache(also ? prefix : NULL, pathspec, 0);
 		refresh_cache_or_die(refresh_flags);
+		update_main_cache_tree(1);
 		if (write_cache(fd, active_cache, active_nr) ||
 		    close_lock_file(&index_lock))
 			die(_("unable to write new_index file"));
@@ -414,6 +415,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 		fd = hold_locked_index(&index_lock, 1);
 		refresh_cache_or_die(refresh_flags);
 		if (active_cache_changed) {
+			update_main_cache_tree(1);
 			if (write_cache(fd, active_cache, active_nr) ||
 			    commit_locked_index(&index_lock))
 				die(_("unable to write new_index file"));
diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 3d0702a..a3527a5 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -70,7 +70,7 @@ test_expect_success 'test-scrap-cache-tree works' '
 	test_no_cache_tree
 '
 
-test_expect_failure 'second commit has cache-tree' '
+test_expect_success 'second commit has cache-tree' '
 	test_commit bar &&
 	test_shallow_cache_tree
 '
-- 
1.7.8.425.ga639d3
