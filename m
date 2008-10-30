From: "Jan =?UTF-8?B?S3LDvGdlcg==?=" <jk@jk.gs>
Subject: [PATCH] Introduce receive.denyDeletes
Date: Thu, 30 Oct 2008 19:11:34 +0100
Message-ID: <20081030191134.62455c24@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 30 19:19:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvc6L-000723-HV
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 19:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757912AbYJ3SRQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Oct 2008 14:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757828AbYJ3SRP
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 14:17:15 -0400
Received: from zoidberg.org ([213.133.99.5]:33287 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756988AbYJ3SRO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Oct 2008 14:17:14 -0400
X-Greylist: delayed 329 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Oct 2008 14:17:14 EDT
Received: from perceptron (xdsl-87-78-167-87.netcologne.de [::ffff:87.78.167.87])
  (IDENT: unknown, AUTH: LOGIN jast, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu.zoidberg.org with esmtp; Thu, 30 Oct 2008 19:11:45 +0100
  id 001627BD.4909F8E1.00000539
X-Mailer: Claws Mail 3.3.1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99516>

Occasionally, it may be useful to prevent branches from getting deleted=
 from
a centralized repository, particularly when no administrative access to=
 the
server is available to undo it via reflog. It also makes
receive.denyNonFastForwards more useful if it is used for access contro=
l, since
it prevents force-updating refs by deleting and re-creating a ref.

Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
---
=46airly low invasiveness. Includes documentation and test case. I have=
 run all
parts of the test suite that use receive-pack, send-pack and friends.

 Documentation/config.txt |    4 ++++
 builtin-receive-pack.c   |   12 ++++++++++++
 t/t5400-send-pack.sh     |   11 +++++++++++
 3 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 29369d0..965ed74 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1188,6 +1188,10 @@ receive.unpackLimit::
 	especially on slow filesystems.  If not set, the value of
 	`transfer.unpackLimit` is used instead.
=20
+receive.denyDeletes::
+	If set to true, git-receive-pack will deny a ref update that deletes
+	the ref. Use this to prevent such a ref deletion via a push.
+
 receive.denyNonFastForwards::
 	If set to true, git-receive-pack will deny a ref update which is
 	not a fast forward. Use this to prevent such an update via a push,
diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index 9f60f31..2c0225c 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -11,6 +11,7 @@
=20
 static const char receive_pack_usage[] =3D "git-receive-pack <git-dir>=
";
=20
+static int deny_deletes =3D 0;
 static int deny_non_fast_forwards =3D 0;
 static int receive_fsck_objects;
 static int receive_unpack_limit =3D -1;
@@ -23,6 +24,11 @@ static int capabilities_sent;
=20
 static int receive_pack_config(const char *var, const char *value, voi=
d *cb)
 {
+	if (strcmp(var, "receive.denydeletes") =3D=3D 0) {
+		deny_deletes =3D git_config_bool(var, value);
+		return 0;
+	}
+
 	if (strcmp(var, "receive.denynonfastforwards") =3D=3D 0) {
 		deny_non_fast_forwards =3D git_config_bool(var, value);
 		return 0;
@@ -185,6 +191,12 @@ static const char *update(struct command *cmd)
 		      "but I can't find it!", sha1_to_hex(new_sha1));
 		return "bad pack";
 	}
+	if (deny_deletes && is_null_sha1(new_sha1) &&
+	    !is_null_sha1(old_sha1) &&
+	    !prefixcmp(name, "refs/heads/")) {
+		error("denying ref deletion for %s", name);
+		return "deletion prohibited";
+	}
 	if (deny_non_fast_forwards && !is_null_sha1(new_sha1) &&
 	    !is_null_sha1(old_sha1) &&
 	    !prefixcmp(name, "refs/heads/")) {
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 544771d..6db9e18 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -104,6 +104,17 @@ HOME=3D`pwd`/no-such-directory
 export HOME ;# this way we force the victim/.git/config to be used.
=20
 test_expect_success \
+	'pushing a delete should be denied with denyDeletes' '
+	cd victim &&
+	git config receive.denyDeletes true &&
+	git branch extra master &&
+	cd .. &&
+	test -f victim/.git/refs/heads/extra &&
+	git send-pack ./victim/.git/ :extra master && return 1
+	rm -f victim/.git/refs/heads/extra
+'
+
+test_expect_success \
         'pushing with --force should be denied with denyNonFastforward=
s' '
 	cd victim &&
 	git config receive.denyNonFastforwards true &&
--=20
1.6.0.3.523.g304d0.dirty
