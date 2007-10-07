From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 3/5] Make "stg push" subdirectory safe
Date: Mon, 08 Oct 2007 01:24:54 +0200
Message-ID: <20071007232453.13070.2930.stgit@yoghurt>
References: <20071007231949.13070.49517.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:26:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IefVV-0004S3-IR
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089AbXJGXY6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Oct 2007 19:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756087AbXJGXY6
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:24:58 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1222 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756084AbXJGXY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:24:58 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IefUV-0000QU-00; Mon, 08 Oct 2007 00:24:55 +0100
In-Reply-To: <20071007231949.13070.49517.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60253>

Make "stg push" subdirectory safe by letting it internally cd up to
the top of the worktree. This is possibly not the best long-term fix;
one could argue that the push subroutine should instead be safe to run
from a subdirectory. However, pushing from a subdirectory currently
erases the parts of a patch that doesn't touch that subdirectory, and
that has to be fixed.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/push.py |    2 +-
 t/t1205-push-subdir.sh |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)


diff --git a/stgit/commands/push.py b/stgit/commands/push.py
index b91bc5e..4d5de26 100644
--- a/stgit/commands/push.py
+++ b/stgit/commands/push.py
@@ -39,7 +39,7 @@ command run.
 The command also notifies when the patch becomes empty (fully merged
 upstream) or is modified (three-way merged) by the 'push' operation.""=
"
=20
-directory =3D DirectoryHasRepository()
+directory =3D DirectoryGotoToplevel()
 options =3D [make_option('-a', '--all',
                        help =3D 'push all the unapplied patches',
                        action =3D 'store_true'),
diff --git a/t/t1205-push-subdir.sh b/t/t1205-push-subdir.sh
index 6502c20..f9a84f6 100755
--- a/t/t1205-push-subdir.sh
+++ b/t/t1205-push-subdir.sh
@@ -27,7 +27,7 @@ test_expect_success 'Fast-forward push from a subdir'=
 '
     [ "$(echo $(cat foo/y.txt))" =3D "y0 y1 y2" ]
 '
=20
-test_expect_failure 'Modifying push from a subdir' '
+test_expect_success 'Modifying push from a subdir' '
     stg pop &&
     [ "$(echo $(cat x.txt))" =3D "x0 x1" ] &&
     [ "$(echo $(cat foo/y.txt))" =3D "y0 y1" ] &&
@@ -42,7 +42,7 @@ test_expect_failure 'Modifying push from a subdir' '
     [ "$(echo $(cat foo/y.txt))" =3D "y0 y1 y2" ]
 '
=20
-test_expect_failure 'Conflicting push from subdir' '
+test_expect_success 'Conflicting push from subdir' '
     stg pop p1 p2 &&
     [ "$(echo $(cat x.txt))" =3D "x0" ] &&
     [ "$(echo $(cat foo/y.txt))" =3D "y0" ] &&
