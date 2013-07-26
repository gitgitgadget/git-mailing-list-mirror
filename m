From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] branch: make sure the upstream remote is configured
Date: Fri, 26 Jul 2013 19:39:37 +0200
Message-ID: <1374860377-17652-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 26 19:47:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2m6s-0005Mo-72
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 19:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120Ab3GZRq7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jul 2013 13:46:59 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:45632 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750754Ab3GZRq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 13:46:58 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Jul 2013 13:46:58 EDT
Received: from cmartin.tk (unknown [IPv6:2001:6f8:900:8cd0:922b:34ff:fe1c:e3e4])
	by hessy.dwim.me (Postfix) with ESMTPA id 2B6A78001B
	for <git@vger.kernel.org>; Fri, 26 Jul 2013 19:39:38 +0200 (CEST)
Received: (nullmailer pid 17689 invoked by uid 1000);
	Fri, 26 Jul 2013 17:39:37 -0000
X-Mailer: git-send-email 1.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231192>

A command of e.g.

    git push --set-upstream /tmp/t master

will call install_branch_config() with a remote name of "/tmp/t". This
function will set the 'branch.master.remote' key to, which is
nonsensical as there is no remote by that name.

Instead, make sure that the remote given does exist when writing the
configuration and warn if it does not. In order to distinguish named
remotes, introduce REMOTE_NONE as the default origin for remotes,
which the functions reading from the different sources will
overwrite. Thus, an origin of REMOTE_NONE means it has been created at
run-time in order to push to it.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---

It's somewhat surprising that there didn't seem to be a way to
distinguish named remotes from those created from a command-line path,
but I guess nobody needed to.

 branch.c                 | 11 +++++++++++
 remote.h                 |  1 +
 t/t5523-push-upstream.sh |  5 +++++
 3 files changed, 17 insertions(+)

diff --git a/branch.c b/branch.c
index c5c6984..cefb8f6 100644
--- a/branch.c
+++ b/branch.c
@@ -53,6 +53,7 @@ void install_branch_config(int flag, const char *loca=
l, const char *origin, cons
 	int remote_is_branch =3D !prefixcmp(remote, "refs/heads/");
 	struct strbuf key =3D STRBUF_INIT;
 	int rebasing =3D should_setup_rebase(origin);
+	struct remote *r =3D remote_get(origin);
=20
 	if (remote_is_branch
 	    && !strcmp(local, shortname)
@@ -62,6 +63,16 @@ void install_branch_config(int flag, const char *loc=
al, const char *origin, cons
 		return;
 	}
=20
+	/*
+	 * Make sure that the remote passed is a configured remote, or
+	 * we end up setting 'branch.foo.remote =3D /tmp/t' which is
+	 * nonsensical.
+	 */
+	if (origin && strcmp(origin, ".") && r->origin =3D=3D REMOTE_NONE) {
+		warning(_("there is no remote named '%s', no upstream configuration =
will be set."), origin);
+		return;
+	}
+
 	strbuf_addf(&key, "branch.%s.remote", local);
 	git_config_set(key.buf, origin ? origin : ".");
=20
diff --git a/remote.h b/remote.h
index cf56724..92f6e33 100644
--- a/remote.h
+++ b/remote.h
@@ -2,6 +2,7 @@
 #define REMOTE_H
=20
 enum {
+	REMOTE_NONE,
 	REMOTE_CONFIG,
 	REMOTE_REMOTES,
 	REMOTE_BRANCHES
diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index 3683df1..e84c2f8 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -71,6 +71,11 @@ test_expect_success 'push -u HEAD' '
 	check_config headbranch upstream refs/heads/headbranch
 '
=20
+test_expect_success 'push -u <url>' '
+        git push -u parent HEAD 2>err &&
+        grep "no upstream configuration will be set" err
+'
+
 test_expect_success TTY 'progress messages go to tty' '
 	ensure_fresh_upstream &&
=20
--=20
1.8.3
