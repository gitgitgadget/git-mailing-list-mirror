From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 5/5] Make "stg refresh" subdirectory safe
Date: Mon, 08 Oct 2007 01:25:05 +0200
Message-ID: <20071007232505.13070.72826.stgit@yoghurt>
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
	id 1IefVX-0004S3-1f
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756378AbXJGXZM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Oct 2007 19:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756087AbXJGXZM
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:25:12 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1228 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756317AbXJGXZK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:25:10 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IefUg-0000Qz-00; Mon, 08 Oct 2007 00:25:06 +0100
In-Reply-To: <20071007231949.13070.49517.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60254>

Make "stg refresh" subdirectory safe by letting it internally cd up to
the top of the worktree. This is possibly not the best long-term fix;
one could argue that the refresh subroutine should instead be safe to
run from a subdirectory. However, refreshing from a subdirectory
currently only refreshes changes that are in the index, and not
changes in the working directory, and that has to be fixed.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/refresh.py |    2 +-
 t/t2300-refresh-subdir.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/stgit/commands/refresh.py b/stgit/commands/refresh.py
index b283892..f032375 100644
--- a/stgit/commands/refresh.py
+++ b/stgit/commands/refresh.py
@@ -37,7 +37,7 @@ options. The '--force' option is useful when a commit=
 object was
 created with a different tool but the changes need to be included in
 the current patch."""
=20
-directory =3D DirectoryHasRepository()
+directory =3D DirectoryGotoToplevel()
 options =3D [make_option('-f', '--force',
                        help =3D 'force the refresh even if HEAD and '\
                        'top differ',
diff --git a/t/t2300-refresh-subdir.sh b/t/t2300-refresh-subdir.sh
index d1c7168..bdd27c5 100755
--- a/t/t2300-refresh-subdir.sh
+++ b/t/t2300-refresh-subdir.sh
@@ -15,7 +15,7 @@ test_expect_success 'Refresh from a subdirectory' '
     [ "$(stg status)" =3D "" ]
 '
=20
-test_expect_failure 'Refresh again' '
+test_expect_success 'Refresh again' '
     echo foo2 >> foo.txt &&
     echo bar2 >> bar/bar.txt &&
     cd bar &&
