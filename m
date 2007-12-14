From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH] Fix config lockfile handling.
Date: Fri, 14 Dec 2007 15:59:57 -0500
Message-ID: <1197665998-32386-2-git-send-email-krh@redhat.com>
References: <1197665998-32386-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Dec 14 21:25:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3H67-00080o-EX
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 21:25:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755041AbXLNUZF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 15:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754268AbXLNUZE
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 15:25:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55401 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754316AbXLNUZB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 15:25:01 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lBEKIV85024370;
	Fri, 14 Dec 2007 15:18:31 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBEKIUen002802;
	Fri, 14 Dec 2007 15:18:30 -0500
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id lBEKIUZs000415;
	Fri, 14 Dec 2007 15:18:30 -0500
X-Mailer: git-send-email 1.5.4.rc0.9.g7b331-dirty
In-Reply-To: <1197665998-32386-1-git-send-email-krh@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68339>

When we commit or roll back the lock file the fd is automatically close=
d,
so don't do that again.

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 config.c |   17 +++--------------
 1 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/config.c b/config.c
index 49d2b42..2e52b17 100644
--- a/config.c
+++ b/config.c
@@ -751,7 +751,7 @@ int git_config_set_multivar(const char* key, const =
char* value,
 	const char* value_regex, int multi_replace)
 {
 	int i, dot;
-	int fd =3D -1, in_fd;
+	int fd, in_fd;
 	int ret;
 	char* config_filename;
 	struct lock_file *lock =3D NULL;
@@ -955,26 +955,15 @@ int git_config_set_multivar(const char* key, cons=
t char* value,
 		munmap(contents, contents_sz);
 	}
=20
-	if (close(fd) || commit_lock_file(lock) < 0) {
+	if (commit_lock_file(lock) < 0) {
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
 	if (lock)
 		rollback_lock_file(lock);
 	free(config_filename);
@@ -1072,7 +1061,7 @@ int git_config_rename_section(const char *old_nam=
e, const char *new_name)
 	}
 	fclose(config_file);
  unlock_and_out:
-	if (close(out_fd) || commit_lock_file(lock) < 0)
+	if (commit_lock_file(lock) < 0)
 			ret =3D error("Cannot commit config file!");
  out:
 	free(config_filename);
--=20
1.5.3.4
