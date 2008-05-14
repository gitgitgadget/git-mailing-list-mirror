From: "martin f. krafft" <madduck@madduck.net>
Subject: [PATCH] Export GIT_DIR after setting it
Date: Thu, 15 May 2008 00:23:21 +0100
Message-ID: <1210807401-11201-1-git-send-email-madduck@madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "martin f. krafft" <madduck@madduck.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 01:24:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwQKf-0001UO-Dx
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 01:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800AbYENXXd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 May 2008 19:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754766AbYENXXd
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 19:23:33 -0400
Received: from clegg.madduck.net ([82.197.162.59]:37546 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754733AbYENXXc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 19:23:32 -0400
Received: from lapse.madduck.net (ruou.ifi.unizh.ch [130.60.75.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id ECE2BA825E;
	Thu, 15 May 2008 01:23:22 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id AE6D04FD5B; Thu, 15 May 2008 00:23:21 +0100 (IST)
X-Mailer: git-send-email 1.5.5.1
X-Virus-Scanned: ClamAV 0.92.1/7125/Thu May 15 00:10:39 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82160>

git-sh-setup might set GIT_DIR, but not export it. When git-pull, for
instance, calls cd_to_toplevel, it changes the working directory, and l=
ater
calls git-ls-files, which does *not* inherit GIT_DIR since it's not imp=
orted.
It thus does the detection again, but in a different environment, since=
 the
working directory changed. This breaks stuff subtly, especially when
core.worktree is set.

The patch simply exports GIT_DIR and makes it work such that git-ls-fil=
es
doesn't redo the work (wrongly).

Thanks to Bj=C3=B6rn Steinbrink for his help.

Signed-off-by: martin f. krafft <madduck@madduck.net>
---
 git-sh-setup.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index a44b1c7..de90f07 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -128,6 +128,7 @@ get_author_ident_from_commit () {
 if test -z "$NONGIT_OK"
 then
 	GIT_DIR=3D$(git rev-parse --git-dir) || exit
+	export GIT_DIR
 	if [ -z "$SUBDIRECTORY_OK" ]
 	then
 		test -z "$(git rev-parse --show-cdup)" || {
--=20
1.5.5.1
