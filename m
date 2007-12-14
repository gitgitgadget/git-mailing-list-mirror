From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH 1/2] Fix config lockfile handling.
Date: Fri, 14 Dec 2007 14:22:36 -0500
Message-ID: <1197660157-24109-2-git-send-email-krh@redhat.com>
References: <1197660157-24109-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Dec 14 19:42:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3FUG-0000h5-Et
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 19:42:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418AbXLNSlq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 13:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752477AbXLNSlq
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 13:41:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55081 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbXLNSlp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 13:41:45 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lBEIf95r018943;
	Fri, 14 Dec 2007 13:41:09 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBEIf8Zq019773;
	Fri, 14 Dec 2007 13:41:08 -0500
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id lBEIf8en014282;
	Fri, 14 Dec 2007 13:41:08 -0500
X-Mailer: git-send-email 1.5.4.rc0.8.g8fc45-dirty
In-Reply-To: <1197660157-24109-1-git-send-email-krh@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68323>

When we commit or roll back the lock file the fd is automatically close=
d,
so don't do that again.  Also, just keep the lock on the stack.

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 config.c |   22 +++++-----------------
 1 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/config.c b/config.c
index 49d2b42..0725563 100644
--- a/config.c
+++ b/config.c
@@ -754,7 +754,7 @@ int git_config_set_multivar(const char* key, const =
char* value,
 	int fd =3D -1, in_fd;
 	int ret;
 	char* config_filename;
-	struct lock_file *lock =3D NULL;
+	struct lock_file lock;
 	const char* last_dot =3D strrchr(key, '.');
=20
 	config_filename =3D getenv(CONFIG_ENVIRONMENT);
@@ -811,8 +811,7 @@ int git_config_set_multivar(const char* key, const =
char* value,
 	 * The lock serves a purpose in addition to locking: the new
 	 * contents of .git/config will be written into it.
 	 */
-	lock =3D xcalloc(sizeof(struct lock_file), 1);
-	fd =3D hold_lock_file_for_update(lock, config_filename, 0);
+	fd =3D hold_lock_file_for_update(&lock, config_filename, 0);
 	if (fd < 0) {
 		fprintf(stderr, "could not lock config file\n");
 		free(store.key);
@@ -955,28 +954,17 @@ int git_config_set_multivar(const char* key, cons=
t char* value,
 		munmap(contents, contents_sz);
 	}
=20
-	if (close(fd) || commit_lock_file(lock) < 0) {
+	if (commit_lock_file(&lock) < 0) {
 		fprintf(stderr, "Cannot commit config file!\n");
 		ret =3D 4;
 		goto out_free;
 	}
=20
-	/* fd is closed, so don't try to close it below. */
-	fd =3D -1;
-	/*
-	 * lock is committed, so don't try to roll it back below.
-	 * NOTE: Since lockfile.c keeps a linked list of all created
-	 * lock_file structures, it isn't safe to free(lock).  It's
-	 * better to just leave it hanging around.
-	 */
-	lock =3D NULL;
 	ret =3D 0;
=20
 out_free:
-	if (0 <=3D fd)
-		close(fd);
-	if (lock)
-		rollback_lock_file(lock);
+	/* If we already committed the lock file, the rollback is a no-op. */
+	rollback_lock_file(&lock);
 	free(config_filename);
 	return ret;
=20
--=20
1.5.3.4
