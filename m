From: =?UTF-8?q?Jan=20St=C4=99pie=C5=84?= 
	<jstepien@users.sourceforge.net>
Subject: [PATCH] fetch-pack: make the ssh connection quiet
Date: Wed, 27 Oct 2010 16:27:08 +0200
Message-ID: <1288189628-4883-1-git-send-email-jstepien@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Jan=20St=C4=99pie=C5=84?= 
	<jstepien@users.sourceforge.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:36:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB76s-000670-JQ
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758922Ab0J0OgI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:36:08 -0400
Received: from r245-52.iq.pl ([86.111.245.52]:53074 "EHLO stepien.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757239Ab0J0OgH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:36:07 -0400
X-Greylist: delayed 492 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Oct 2010 10:36:07 EDT
Received: from localhost.localdomain (chello089074007129.chello.pl [89.74.7.129])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by stepien.cc (Postfix) with ESMTPSA id 1AEBD2A10378;
	Wed, 27 Oct 2010 16:27:54 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160039>

The --quiet option passed to fetch-pack did not affect the ssh child
process. When an ssh server sent a motd it was displayed because the ss=
h
client wasn't launched with the -q option. This patch makes ssh run qui=
etly
when fetch-pack is called with -q.

An analogous change should be made to other commands which accept --qui=
et
and connect to remotes using ssh.

Signed-off-by: Jan St=C4=99pie=C5=84 <jstepien@users.sourceforge.net>
---
 builtin/fetch-pack.c |    3 ++-
 cache.h              |    1 +
 connect.c            |    2 ++
 3 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index dbd8b7b..ede1c34 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -876,7 +876,8 @@ int cmd_fetch_pack(int argc, const char **argv, con=
st char *prefix)
 		fd[1] =3D 1;
 	} else {
 		conn =3D git_connect(fd, (char *)dest, args.uploadpack,
-				   args.verbose ? CONNECT_VERBOSE : 0);
+				   (args.verbose ? CONNECT_VERBOSE : 0) |
+				   (args.quiet ? CONNECT_QUIET : 0));
 	}
=20
 	get_remote_heads(fd[0], &ref, 0, NULL, 0, NULL);
diff --git a/cache.h b/cache.h
index 33decd9..8622a78 100644
--- a/cache.h
+++ b/cache.h
@@ -938,6 +938,7 @@ struct ref {
 extern struct ref *find_ref_by_name(const struct ref *list, const char=
 *name);
=20
 #define CONNECT_VERBOSE       (1u << 0)
+#define CONNECT_QUIET         (1u << 1)
 extern char *git_getpass(const char *prompt);
 extern struct child_process *git_connect(int fd[2], const char *url, c=
onst char *prog, int flags);
 extern int finish_connect(struct child_process *conn);
diff --git a/connect.c b/connect.c
index 57dc20c..709601e 100644
--- a/connect.c
+++ b/connect.c
@@ -585,6 +585,8 @@ struct child_process *git_connect(int fd[2], const =
char *url_orig,
 			*arg++ =3D putty ? "-P" : "-p";
 			*arg++ =3D port;
 		}
+		if (!putty && flags & CONNECT_QUIET)
+			*arg++ =3D "-q";
 		*arg++ =3D host;
 	}
 	else {
--=20
1.7.0.4
