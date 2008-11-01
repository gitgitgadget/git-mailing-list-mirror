From: "Jan =?UTF-8?B?S3LDvGdlcg==?=" <jk@jk.gs>
Subject: [PATCH v2] Introduce receive.denyDeletes
Date: Sat, 1 Nov 2008 15:42:16 +0100
Message-ID: <20081101154216.45021eee@perceptron>
References: <20081030191134.62455c24@perceptron>
	<20081030183210.GO14786@spearce.org>
	<20081030194503.2f9ece1a@perceptron>
	<7v63n99omx.fsf@gitster.siamese.dyndns.org>
	<20081031143022.GQ14786@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 15:44:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwHht-0006ig-Dp
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 15:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbYKAOmw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Nov 2008 10:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751603AbYKAOmw
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 10:42:52 -0400
Received: from zoidberg.org ([213.133.99.5]:45741 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751584AbYKAOmv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Nov 2008 10:42:51 -0400
Received: from perceptron (p54BBB5F2.dip0.t-ipconnect.de [::ffff:84.187.181.242])
  (AUTH: LOGIN jast, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu.zoidberg.org with esmtp; Sat, 01 Nov 2008 15:42:49 +0100
  id 001627D7.490C6AE9.00002B73
In-Reply-To: <20081031143022.GQ14786@spearce.org>
X-Mailer: Claws Mail 3.3.1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99746>

Occasionally, it may be useful to prevent branches from getting deleted=
 from
a centralized repository, particularly when no administrative access to=
 the
server is available to undo it via reflog. It also makes
receive.denyNonFastForwards more useful if it is used for access contro=
l
since it prevents force-updating by deleting and re-creating a ref.

Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
---
Like this, then?

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
index 544771d..6fe2f87 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -103,6 +103,17 @@ unset GIT_CONFIG GIT_CONFIG_LOCAL
 HOME=3D`pwd`/no-such-directory
 export HOME ;# this way we force the victim/.git/config to be used.
=20
+test_expect_failure \
+	'pushing a delete should be denied with denyDeletes' '
+	cd victim &&
+	git config receive.denyDeletes true &&
+	git branch extra master &&
+	cd .. &&
+	test -f victim/.git/refs/heads/extra &&
+	test_must_fail git send-pack ./victim/.git/ :extra master
+'
+rm -f victim/.git/refs/heads/extra
+
 test_expect_success \
         'pushing with --force should be denied with denyNonFastforward=
s' '
 	cd victim &&
--=20
1.6.0.3.524.g86cf.dirty
