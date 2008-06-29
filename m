From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/2] Fix "stg sink" with no applied patches (bug 11887)
Date: Mon, 30 Jun 2008 00:45:47 +0200
Message-ID: <20080629224547.9267.92299.stgit@yoghurt>
References: <20080629224440.9267.3591.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Sandberg <mandolaerik@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 00:47:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD5g0-00056f-Fa
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 00:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796AbYF2WqZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jun 2008 18:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752787AbYF2WqY
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 18:46:24 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2453 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528AbYF2Wpv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 18:45:51 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KD5eV-0003Ua-00; Sun, 29 Jun 2008 23:45:47 +0100
In-Reply-To: <20080629224440.9267.3591.stgit@yoghurt>
User-Agent: StGIT/0.14.2.171.g5c0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86843>

There were two separate things to fix: bail out if we need a current
patch and there isn't one (because there are no applied patches), and
make sure we don't try to pop patches that don't exist.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/sink.py |    8 ++++++--
 t/t1501-sink.sh        |    2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)


diff --git a/stgit/commands/sink.py b/stgit/commands/sink.py
index 2167d87..d8f79b4 100644
--- a/stgit/commands/sink.py
+++ b/stgit/commands/sink.py
@@ -58,9 +58,13 @@ def func(parser, options, args):
     if len(args) > 0:
         patches =3D parse_patches(args, all)
     else:
-        patches =3D [ crt_series.get_current() ]
+        current =3D crt_series.get_current()
+        if not current:
+            raise CmdException('No patch applied')
+        patches =3D [current]
=20
-    crt_series.pop_patch(options.to or oldapplied[0])
+    if oldapplied:
+        crt_series.pop_patch(options.to or oldapplied[0])
     push_patches(crt_series, patches)
=20
     if not options.nopush:
diff --git a/t/t1501-sink.sh b/t/t1501-sink.sh
index 3872c4b..6af45fe 100755
--- a/t/t1501-sink.sh
+++ b/t/t1501-sink.sh
@@ -20,7 +20,7 @@ test_expect_success 'sink without applied patches' '
     ! stg sink
 '
=20
-test_expect_failure 'sink a specific patch without applied patches' '
+test_expect_success 'sink a specific patch without applied patches' '
     stg sink y &&
     test $(echo $(stg applied)) =3D "y"
 '
