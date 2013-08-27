From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] remote: filter out invalid remote configurations
Date: Tue, 27 Aug 2013 15:06:36 +0200
Message-ID: <1377608796-13732-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 15:06:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEIyw-0004LB-6f
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 15:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055Ab3H0NGq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Aug 2013 09:06:46 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:53360 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752479Ab3H0NGp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 09:06:45 -0400
Received: from cmartin.tk (unknown [46.189.27.162])
	by hessy.dwim.me (Postfix) with ESMTPA id A30AD80169
	for <git@vger.kernel.org>; Tue, 27 Aug 2013 15:06:42 +0200 (CEST)
Received: (nullmailer pid 13770 invoked by uid 1000);
	Tue, 27 Aug 2013 13:06:36 -0000
X-Mailer: git-send-email 1.8.4.561.g1c3d45d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233085>

In remote's configuration callback, anything that looks like
'remote.<name>.*' creates a remote '<name>'. This remote may not end
up having any configuration for a remote, but it's still in the list,
so 'git remote' shows it, which means something like

    [remote "bogus"]
        hocus =3D pocus

will show a remote 'bogus' in the listing, even though it won't work
as a remote name for either git-fetch or git-push.

=46ilter out the remotes that we created which have no urls in order to
work around such configuration entries.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>

---

Due to git's callback-based config, it seemed a lot simpler to let it
do it wrong and then filter out what won't be usable, rather than
delaying the creation of a remote until we're sure we do want it.

The tests that made use of a remote 'existing' with just .fetch seem
to be written that way because they can get away with it, rather than
any assertion that it should be allowed in day-to-day git usage, but
correct me if I'm wrong.

 remote.c          | 17 +++++++++++++++++
 t/t5505-remote.sh |  2 ++
 t/t7201-co.sh     |  2 +-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 68eb99b..00a1d7a 100644
--- a/remote.c
+++ b/remote.c
@@ -141,6 +141,9 @@ static struct remote *make_remote(const char *name,=
 int len)
 	int i;
=20
 	for (i =3D 0; i < remotes_nr; i++) {
+		if (!remotes[i])
+			continue;
+
 		if (len ? (!strncmp(name, remotes[i]->name, len) &&
 			   !remotes[i]->name[len]) :
 		    !strcmp(name, remotes[i]->name))
@@ -469,6 +472,19 @@ static int handle_config(const char *key, const ch=
ar *value, void *cb)
 	return 0;
 }
=20
+static void filter_valid_remotes(void)
+{
+	int i;
+	for (i =3D 0; i < remotes_nr; i++) {
+		if (!remotes[i])
+			continue;
+
+		/* It's not a remote unless it has at least one url */
+		if (remotes[i]->url_nr =3D=3D 0 && remotes[i]->pushurl_nr =3D=3D 0)
+			remotes[i] =3D NULL;
+	}
+}
+
 static void alias_all_urls(void)
 {
 	int i, j;
@@ -504,6 +520,7 @@ static void read_config(void)
 			make_branch(head_ref + strlen("refs/heads/"), 0);
 	}
 	git_config(handle_config, NULL);
+	filter_valid_remotes();
 	alias_all_urls();
 }
=20
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index dd10ff0..848e7b7 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -130,9 +130,11 @@ to delete them, use:
 EOF
 	} &&
 	git tag footag &&
+	git remote add oops .
 	git config --add remote.oops.fetch "+refs/*:refs/*" &&
 	git remote remove oops 2>actual1 &&
 	git branch foobranch &&
+	git remote add oops .
 	git config --add remote.oops.fetch "+refs/*:refs/*" &&
 	git remote rm oops 2>actual2 &&
 	git branch -d foobranch &&
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 0c9ec0a..4647f1c 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -431,7 +431,7 @@ test_expect_success 'detach a symbolic link HEAD' '
=20
 test_expect_success \
     'checkout with --track fakes a sensible -b <name>' '
-    git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/=
*" &&
+    git remote add origin . &&
     git update-ref refs/remotes/origin/koala/bear renamer &&
=20
     git checkout --track origin/koala/bear &&
--=20
1.8.4.561.g1c3d45d
