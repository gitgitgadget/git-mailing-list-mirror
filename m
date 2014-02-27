From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 1/2] fetch: add a failing test for prunning with overlapping refspecs
Date: Thu, 27 Feb 2014 10:00:09 +0100
Message-ID: <1393491610-19476-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 27 10:06:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIwva-0000Nf-El
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 10:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbaB0JGl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Feb 2014 04:06:41 -0500
Received: from hessy.cmartin.tk ([78.47.67.53]:57135 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750907AbaB0JGi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 04:06:38 -0500
Received: from cmartin.tk (unknown [IPv6:2001:6f8:900:8cd0:922b:34ff:fe1c:e3e4])
	by hessy.dwim.me (Postfix) with ESMTPA id 1497480265
	for <git@vger.kernel.org>; Thu, 27 Feb 2014 10:00:12 +0100 (CET)
Received: (nullmailer pid 19516 invoked by uid 1000);
	Thu, 27 Feb 2014 09:00:10 -0000
X-Mailer: git-send-email 1.9.0.rc3.244.g3497008
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242793>

=46rom: Carlos Mart=C3=ADn Nieto <cmn@dwim.me>

When a remote has multiple fetch refspecs and these overlap in the
target namespace, fetch may prune a remote-tracking branch which still
exists in the remote. The test uses a popular form of this, by putting
pull requests as stored in a popular hosting platform alongside "real"
remote-tracking branches.

The fetch command makes a decision of whether to prune based
on the first matching refspec, which in this case is insufficient, as i=
t
covers the pull request names. This pair of refspecs does work as
expected if the more "specific" refspec is the first in the list.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---

This setup is used by GitHub for Windows, but nobody has noticed this
break because it puts the PR refspec in the system config, which makes
that one the first. I was alerted to this by someone who had done this
setup manually and thus added the PR refspec after the default one.

 t/t5510-fetch.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 1f0f8e6..4949e3d 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -113,6 +113,26 @@ test_expect_success 'fetch --prune with a namespac=
e keeps other namespaces' '
 	git rev-parse origin/master
 '
=20
+test_expect_failure 'fetch --prune handles overlapping refspecs' '
+	cd "$D" &&
+	git update-ref refs/pull/42/head master &&
+	git clone . prune-overlapping &&
+	cd prune-overlapping &&
+	git config --add remote.origin.fetch refs/pull/*/head:refs/remotes/or=
igin/pr/* &&
+
+	git fetch --prune origin &&
+	git rev-parse origin/master &&
+	git rev-parse origin/pr/42 &&
+
+	git config --unset-all remote.origin.fetch
+	git config remote.origin.fetch refs/pull/*/head:refs/remotes/origin/p=
r/* &&
+	git config --add remote.origin.fetch refs/heads/*:refs/remotes/origin=
/* &&
+
+	git fetch --prune origin &&
+	git rev-parse origin/master &&
+	git rev-parse origin/pr/42
+'
+
 test_expect_success 'fetch --prune --tags does not delete the remote-t=
racking branches' '
 	cd "$D" &&
 	git clone . prune-tags &&
--=20
1.9.0.rc3.244.g3497008
