From: =?utf-8?q?Gr=C3=A9goire=20Barbier?= <gb@gbarbier.org>
Subject: [PATCH] http-push: fix webdav lock leak.
Date: Sun, 13 Jan 2008 20:02:58 +0100
Message-ID: <1200250979-19604-2-git-send-email-gb@gbarbier.org>
References: <1200250979-19604-1-git-send-email-gb@gbarbier.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?utf-8?q?Gr=C3=A9goire=20Barbier?= <gb@gbarbier.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 20:03:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE87M-00078E-1k
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 20:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959AbYAMTDH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2008 14:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753616AbYAMTDH
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 14:03:07 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:37536 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753533AbYAMTDE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 14:03:04 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 98A1F1AB2E4;
	Sun, 13 Jan 2008 20:03:00 +0100 (CET)
Received: from localhost.localdomain (soy95-1-82-229-96-169.fbx.proxad.net [82.229.96.169])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 1C3E31AB38D;
	Sun, 13 Jan 2008 20:03:00 +0100 (CET)
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1200250979-19604-1-git-send-email-gb@gbarbier.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70407>

Releasing webdav lock even if push fails because of bad (or no) referen=
ce
on command line.

Signed-off-by: Gr=C3=A9goire Barbier <gb@gbarbier.org>
---
 http-push.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/http-push.c b/http-push.c
index c005903..cbbf432 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2275,11 +2275,14 @@ int main(int argc, char **argv)
 	if (!remote_tail)
 		remote_tail =3D &remote_refs;
 	if (match_refs(local_refs, remote_refs, &remote_tail,
-		       nr_refspec, (const char **) refspec, push_all))
-		return -1;
+		       nr_refspec, (const char **) refspec, push_all)) {
+		rc =3D -1;
+		goto cleanup;
+	}
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing=
=2E\n");
-		return 0;
+		rc =3D 0;
+		goto cleanup;
 	}
=20
 	new_refs =3D 0;
@@ -2410,10 +2413,10 @@ int main(int argc, char **argv)
 			fprintf(stderr, "Unable to update server info\n");
 		}
 	}
-	if (info_ref_lock)
-		unlock_remote(info_ref_lock);
=20
  cleanup:
+	if (info_ref_lock)
+		unlock_remote(info_ref_lock);
 	free(remote);
=20
 	curl_slist_free_all(no_pragma_header);
--=20
1.5.3.6
