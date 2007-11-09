From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH v2] builtin-commit: Refresh cache after adding files.
Date: Fri,  9 Nov 2007 13:50:38 -0500
Message-ID: <1194634238-3308-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Nov 09 19:51:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqYwr-00078F-K1
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 19:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889AbXKISvG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Nov 2007 13:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754881AbXKISvG
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 13:51:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54105 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754512AbXKISvF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 13:51:05 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lA9Ioi5s006579;
	Fri, 9 Nov 2007 13:50:44 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA9Ioinc015669;
	Fri, 9 Nov 2007 13:50:44 -0500
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id lA9IohMq026418;
	Fri, 9 Nov 2007 13:50:43 -0500
X-Mailer: git-send-email 1.5.3.5.1717.gd3e8-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64249>

This fixes the race in the last test in t3700-add.sh.
add_files_to_cache() should leave the new index stat-clean, but some
times it doesn't.  Calling refresh_cache() in a few places works
around this for now.

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---

Should we add the refresh_cache() call in add_files_to_cache() instead?

 builtin-commit.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 7dc8977..81539c8 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -81,6 +81,7 @@ static char *prepare_index(const char **files, const =
char *prefix)
=20
 	if (all || also) {
 		add_files_to_cache(verbose, also ? prefix : NULL, files);
+		refresh_cache(REFRESH_QUIET);
 		if (write_cache(fd, active_cache, active_nr) || close(fd))
 			die("unable to write new_index file");
 		return lock_file.filename;
@@ -94,6 +95,7 @@ static char *prepare_index(const char **files, const =
char *prefix)
=20
 	/* update the user index file */
 	add_files_to_cache(verbose, prefix, files);
+	refresh_cache(REFRESH_QUIET);
 	if (write_cache(fd, active_cache, active_nr) || close(fd))
 		die("unable to write new_index file");
=20
@@ -110,6 +112,7 @@ static char *prepare_index(const char **files, cons=
t char *prefix)
 	fd =3D hold_lock_file_for_update(next_index_lock,
 				       git_path("next-index-%d", getpid()), 1);
 	add_files_to_cache(verbose, prefix, files);
+	refresh_cache(REFRESH_QUIET);
 	if (write_cache(fd, active_cache, active_nr) || close(fd))
 		die("unable to write new_index file");
=20
--=20
1.5.3.4.206.g58ba4
