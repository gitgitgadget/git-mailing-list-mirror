From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] get_remote_url(): use the same data source as ls-remote to get remote urls
Date: Mon, 28 Feb 2011 10:36:19 +0100
Message-ID: <1298885779-10045-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110114090645.GA13060@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kernel@pengutronix.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 28 10:36:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtzWp-00038W-TW
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 10:36:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801Ab1B1Jg1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Feb 2011 04:36:27 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51826 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655Ab1B1JgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 04:36:25 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1PtzWg-0006lt-Pg; Mon, 28 Feb 2011 10:36:22 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1PtzWg-0002cd-OS; Mon, 28 Feb 2011 10:36:22 +0100
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <20110114090645.GA13060@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168083>

The formerly implemented algorithm behaved differently to
remote.c:remote_get() at least for remotes that contain a slash.  While=
 the
former just assumes a/b is a path the latter checks the config for
remote."a/b" first which is more reasonable.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Hello,

with this patch git-request-pull.sh (=3D=3D the only in-tree user of
git-parse-remote.sh:get_remote_url()) could directly use

	git ls-remote --get-url

=2E  I guess you wouldn't want to remove git-parse-remote.sh:get_remote=
_url()
though?!  Maybe add a deprecation warning to it?  The same applies to
git-parse-remote.sh:get_data_source() that isn't used anymore already w=
ith this
patch.

Best regards
Uwe

 builtin/ls-remote.c |   11 +++++++++++
 git-parse-remote.sh |   24 +-----------------------
 2 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 97eed40..1a1ff87 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -33,6 +33,7 @@ int cmd_ls_remote(int argc, const char **argv, const =
char *prefix)
 	int i;
 	const char *dest =3D NULL;
 	unsigned flags =3D 0;
+	int get_url =3D 0;
 	int quiet =3D 0;
 	const char *uploadpack =3D NULL;
 	const char **pattern =3D NULL;
@@ -69,6 +70,10 @@ int cmd_ls_remote(int argc, const char **argv, const=
 char *prefix)
 				quiet =3D 1;
 				continue;
 			}
+			if (!strcmp("--get-url", arg)) {
+				get_url =3D 1;
+				continue;
+			}
 			usage(ls_remote_usage);
 		}
 		dest =3D arg;
@@ -94,6 +99,12 @@ int cmd_ls_remote(int argc, const char **argv, const=
 char *prefix)
 	}
 	if (!remote->url_nr)
 		die("remote %s has no configured URL", dest);
+
+	if (get_url) {
+		printf("%s\n", *remote->url);
+		return 0;
+	}
+
 	transport =3D transport_get(remote, NULL);
 	if (uploadpack !=3D NULL)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK, uploadpack);
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 1cc2ba6..4fb778e 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -29,29 +29,7 @@ get_data_source () {
 }
=20
 get_remote_url () {
-	data_source=3D$(get_data_source "$1")
-	case "$data_source" in
-	'')
-		echo "$1"
-		;;
-	self)
-		echo "$1"
-		;;
-	config)
-		git config --get "remote.$1.url"
-		;;
-	remotes)
-		sed -ne '/^URL: */{
-			s///p
-			q
-		}' "$GIT_DIR/remotes/$1"
-		;;
-	branches)
-		sed -e 's/#.*//' "$GIT_DIR/branches/$1"
-		;;
-	*)
-		die "internal error: get-remote-url $1" ;;
-	esac
+	git ls-remote --get-url "$1"
 }
=20
 get_default_remote () {
--=20
1.7.2.3
