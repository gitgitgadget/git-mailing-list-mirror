From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/2] get_remote_url(): use the same data source as ls-remote to get remote urls
Date: Tue,  1 Mar 2011 10:21:36 +0100
Message-ID: <1298971297-20326-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110301084110.GT22310@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kernel@pengutronix.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 10:22:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuLmH-0003nf-O2
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 10:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755909Ab1CAJVw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Mar 2011 04:21:52 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36571 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017Ab1CAJVu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 04:21:50 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1PuLm8-00071j-HL; Tue, 01 Mar 2011 10:21:48 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1PuLm7-0005tE-8t; Tue, 01 Mar 2011 10:21:47 +0100
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <20110301084110.GT22310@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168198>

The formerly implemented algorithm behaved differently to
remote.c:remote_get() at least for remotes that contain a slash.  While=
 the
former just assumes a/b is a path the latter checks the config for
remote."a/b" first which is more reasonable.

This removes the last user of git-parse-remote.sh:get_data_source(), so
this function is removed.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Hello,

compared with the previous patch this patch removes get_data_source
which is unused now.  The second patch also gets rid of get_remote_url.

 builtin/ls-remote.c |   11 +++++++++++
 git-parse-remote.sh |   48 +------------------------------------------=
-----
 2 files changed, 12 insertions(+), 47 deletions(-)


The changes in this series are also available in the git repository at:
  git.pengutronix.de:/git/ukl/git.git ls-remote-in-get-remote-url

basing on commit 7ed863a85a6ce2c4ac4476848310b8f917ab41f9:

  Git 1.7.4 (2011-01-30 19:02:37 -0800)

Uwe Kleine-K=C3=B6nig (2):
      get_remote_url(): use the same data source as ls-remote to get re=
mote urls
      git-request-pull: open-code the only invocation of get_remote_url

(Note: this pull request was generated using the new git-request-pull
and using a remote with a slash \o/)

 builtin/ls-remote.c |   11 +++++++++++
 git-parse-remote.sh |   50 -------------------------------------------=
-------
 git-request-pull.sh |    3 +--
 3 files changed, 12 insertions(+), 52 deletions(-)

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
index 1cc2ba6..0ab1192 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -4,54 +4,8 @@
 # this would fail in that case and would issue an error message.
 GIT_DIR=3D$(git rev-parse -q --git-dir) || :;
=20
-get_data_source () {
-	case "$1" in
-	*/*)
-		echo ''
-		;;
-	.)
-		echo self
-		;;
-	*)
-		if test "$(git config --get "remote.$1.url")"
-		then
-			echo config
-		elif test -f "$GIT_DIR/remotes/$1"
-		then
-			echo remotes
-		elif test -f "$GIT_DIR/branches/$1"
-		then
-			echo branches
-		else
-			echo ''
-		fi ;;
-	esac
-}
-
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
