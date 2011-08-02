From: <trast@student.ethz.ch>
Subject: [PATCH] commit: write out cache-tree information
Date: Tue, 2 Aug 2011 18:36:34 +0200
Message-ID: <9f5e031045b55c4738de8bc9aae290827e128cd3.1312302862.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Thomas Rast <trast@student.ethz.ch>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 02 18:42:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoI3T-0006R9-Jw
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 18:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602Ab1HBQmv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Aug 2011 12:42:51 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:3390 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754554Ab1HBQmt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 12:42:49 -0400
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Aug 2011 12:42:49 EDT
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.289.1; Tue, 2 Aug
 2011 18:36:32 +0200
Received: from localhost.localdomain (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.289.1; Tue, 2 Aug
 2011 18:36:35 +0200
X-Mailer: git-send-email 1.7.6.668.g17b0a
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178480>

=46rom: Thomas Rast <trast@student.ethz.ch>

While write-tree has code to write out the cache-tree information
(since we have to compute it anyway if the cache is stale), commit
lost this capability when it became a builtin and moved away from
using write-tree.

Add the necessary code to write out the cache.  This is extremely
similar to what write_cache_as_tree() does.

Reported-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Reported on IRC.

There's a similar disparity between read-tree and checkout, but I
first have to understand the exact conditions in or around
unpack_trees() [checkout.c:417] where the read-tree reasoning applies.

 builtin/commit.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index e1af9b1..47b0eea 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -637,6 +637,8 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 	const char *hook_arg2 =3D NULL;
 	int ident_shown =3D 0;
 	int clean_message_contents =3D (cleanup_mode !=3D CLEANUP_NONE);
+	int fd;
+	struct lock_file *lock_file;
=20
 	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
 		return 0;
@@ -861,6 +863,8 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 	 * the editor and after we invoke run_status above.
 	 */
 	discard_cache();
+	lock_file =3D xcalloc(1, sizeof(struct lock_file));
+	fd =3D hold_lock_file_for_update(lock_file, index_file, LOCK_DIE_ON_E=
RROR);
 	read_cache_from(index_file);
 	if (!active_cache_tree)
 		active_cache_tree =3D cache_tree();
@@ -869,6 +873,11 @@ static int prepare_to_commit(const char *index_fil=
e, const char *prefix,
 		error(_("Error building trees"));
 		return 0;
 	}
+	if (0 <=3D fd) {
+		if (write_cache(fd, active_cache, active_nr) ||
+		    commit_lock_file(lock_file))
+			rollback_lock_file(lock_file);
+	}
=20
 	if (run_hook(index_file, "prepare-commit-msg",
 		     git_path(commit_editmsg), hook_arg1, hook_arg2, NULL))
--=20
1.7.6.668.g17b0a
