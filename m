From: =?utf-8?q?Gr=C3=A9goire=20Barbier?= <gb@gbarbier.org>
Subject: [PATCH] http-push: fix webdav lock leak.
Date: Sat, 19 Jan 2008 16:22:47 +0100
Message-ID: <1200756171-11696-1-git-send-email-gb@gbarbier.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?utf-8?q?Gr=C3=A9goire=20Barbier?= <gb@gbarbier.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 19 16:23:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGFXd-0007U3-J5
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 16:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759864AbYASPXC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2008 10:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760022AbYASPXB
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 10:23:01 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:48541 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756271AbYASPWz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 10:22:55 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 6C6E91AB314;
	Sat, 19 Jan 2008 16:22:52 +0100 (CET)
Received: from localhost.localdomain (soy95-1-82-229-96-169.fbx.proxad.net [82.229.96.169])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 36AD81AB2C8;
	Sat, 19 Jan 2008 16:22:52 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc3.54.g4b665-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71115>

Releasing webdav lock even if push fails because of bad (or no) referen=
ce
on command line.

To reproduce the issue that this patch fixes, you need a test git repos=
itory
availlable over http+webdav, let's say at http://myhost/myrepo.git/
Then, you do this:
$ git clone http://myhost/myrepo.git/
$ cd myrepo
$ git push http
=46etching remote heads...
  refs/
  refs/heads/
  refs/tags/
No refs in common and none specified; doing nothing.
$ git push http
=46etching remote heads...
  refs/
  refs/heads/
  refs/tags/
No refs in common and none specified; doing nothing.
$

=46inally, you look at the web server logs, and will find one LOCK quer=
y and no
UNLOCK query, of course the second one will be in 423 return code inste=
ad of
200:
1.2.3.4 - gb [19/Jan/2008:14:24:56 +0100] "LOCK /myrepo.git/info/refs H=
TTP/1.1" 200 465
(...)
1.2.3.4 - gb [19/Jan/2008:14:25:10 +0100] "LOCK /myrepo.git/info/refs H=
TTP/1.1" 423 363

With this patch, there would have be two UNLOCKs in addition of the LOC=
Ks

=46rom the user point of view:
- If you realize that you should have typed e.g. "git push http master"
instead of "git push http", you will have to wait for 10 minutes for th=
e lock
to expire by its own.
- Furthermore, if somebody else is dumb enough to type "git push http" =
while
you need to push "master" branch, then you'll need too to wait for 10 m=
inutes
too.

Signed-off-by: Gr=C3=A9goire Barbier <gb@gbarbier.org>
---
 http-push.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/http-push.c b/http-push.c
index eef7674..2c4e91d 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2264,11 +2264,14 @@ int main(int argc, char **argv)
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
@@ -2399,10 +2402,10 @@ int main(int argc, char **argv)
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
1.5.4.rc3.52.g9a5bd-dirty
