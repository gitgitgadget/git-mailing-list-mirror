From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] bundle, fast-import: detect write failure
Date: Thu, 10 Jan 2008 09:54:25 +0100
Message-ID: <874pdmhxha.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 10 09:55:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCtCP-0001DI-SF
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 09:55:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754730AbYAJIy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 03:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753740AbYAJIy2
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 03:54:28 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:35403 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751833AbYAJIy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 03:54:27 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id B77ED17B58F
	for <git@vger.kernel.org>; Thu, 10 Jan 2008 09:54:25 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id A8A4117B55C
	for <git@vger.kernel.org>; Thu, 10 Jan 2008 09:54:25 +0100 (CET)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id 7AB413351E
	for <git@vger.kernel.org>; Thu, 10 Jan 2008 09:54:25 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70050>


I noticed some unchecked writes.  This fixes them.

* bundle.c (create_bundle): Die upon write failure.
* fast-import.c (keep_pack): Die upon write or close failure.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 bundle.c      |    6 +++---
 fast-import.c |    5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/bundle.c b/bundle.c
index be204d8..316aa74 100644
--- a/bundle.c
+++ b/bundle.c
@@ -320,9 +320,9 @@ int create_bundle(struct bundle_header *header, const char *path,
 	for (i = 0; i < revs.pending.nr; i++) {
 		struct object *object = revs.pending.objects[i].item;
 		if (object->flags & UNINTERESTING)
-			write(rls.in, "^", 1);
-		write(rls.in, sha1_to_hex(object->sha1), 40);
-		write(rls.in, "\n", 1);
+			write_or_die(rls.in, "^", 1);
+		write_or_die(rls.in, sha1_to_hex(object->sha1), 40);
+		write_or_die(rls.in, "\n", 1);
 	}
 	if (finish_command(&rls))
 		return error ("pack-objects died");
diff --git a/fast-import.c b/fast-import.c
index 74597c9..82e9161 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -878,8 +878,9 @@ static char *keep_pack(char *curr_index_name)
 	keep_fd = open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
 	if (keep_fd < 0)
 		die("cannot create keep file");
-	write(keep_fd, keep_msg, strlen(keep_msg));
-	close(keep_fd);
+	write_or_die(keep_fd, keep_msg, strlen(keep_msg));
+	if (close(keep_fd))
+		die("failed to write keep file");

 	snprintf(name, sizeof(name), "%s/pack/pack-%s.pack",
 		 get_object_directory(), sha1_to_hex(pack_data->sha1));
--
1.5.4.rc2.85.g71fd
