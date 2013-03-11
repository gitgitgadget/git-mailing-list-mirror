From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH v2 3/3] git p4: avoid expanding client paths in chdir
Date: Mon, 11 Mar 2013 17:45:29 -0400
Message-ID: <1363038329-20185-4-git-send-email-pw@padd.com>
References: <5139883C.6080308@viscovery.net>
 <1363038329-20185-1-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Mikl=C3=B3s=20Fazekas?= <mfazekas@szemafor.com>,
	John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 11 22:55:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFAh8-000321-Kz
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 22:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572Ab3CKVzT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Mar 2013 17:55:19 -0400
Received: from honk.padd.com ([74.3.171.149]:56935 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754519Ab3CKVzS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 17:55:18 -0400
Received: from arf.padd.com (unknown [50.55.138.130])
	by honk.padd.com (Postfix) with ESMTPSA id 312412C15;
	Mon, 11 Mar 2013 14:55:17 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id C43622261E; Mon, 11 Mar 2013 17:46:29 -0400 (EDT)
X-Mailer: git-send-email 1.8.2.rc2.65.g92f3e2d
In-Reply-To: <1363038329-20185-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217917>

=46rom: Mikl=C3=B3s Fazekas <mfazekas@szemafor.com>

The generic chdir() helper sets the PWD environment
variable, as that is what is used by p4 to know its
current working directory.  Normally the shell would
do this, but in git-p4, we must do it by hand.

However, when the path contains a symbolic link,
os.getcwd() will return the physical location.  If the
p4 client specification includes symlinks, setting PWD
to the physical location causes p4 to think it is not
inside the client workspace.  It complains, e.g.

    Path /vol/bar/projects/foo/... is not under client root /p/foo

One workaround is to use AltRoots in the p4 client specification,
but it is cleaner to handle it directly in git-p4.

Other uses of chdir still require setting PWD to an
absolute path so p4 features like P4CONFIG work.  See
bf1d68f (git-p4: use absolute directory for PWD env
var, 2011-12-09).

[ pw: tweak patch and commit message ]

Thanks-to: John Keeping <john@keeping.me.uk>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py               | 29 ++++++++++++++++++++++-------
 t/t9808-git-p4-chdir.sh |  2 +-
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 647f110..7288c0b 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -79,12 +79,27 @@ def p4_build_cmd(cmd):
         real_cmd +=3D cmd
     return real_cmd
=20
-def chdir(dir):
-    # P4 uses the PWD environment variable rather than getcwd(). Since=
 we're
-    # not using the shell, we have to set it ourselves.  This path cou=
ld
-    # be relative, so go there first, then figure out where we ended u=
p.
-    os.chdir(dir)
-    os.environ['PWD'] =3D os.getcwd()
+def chdir(path, is_client_path=3DFalse):
+    """Do chdir to the given path, and set the PWD environment
+       variable for use by P4.  It does not look at getcwd() output.
+       Since we're not using the shell, it is necessary to set the
+       PWD environment variable explicitly.
+      =20
+       Normally, expand the path to force it to be absolute.  This
+       addresses the use of relative path names inside P4 settings,
+       e.g. P4CONFIG=3D.p4config.  P4 does not simply open the filenam=
e
+       as given; it looks for .p4config using PWD.
+
+       If is_client_path, the path was handed to us directly by p4,
+       and may be a symbolic link.  Do not call os.getcwd() in this
+       case, because it will cause p4 to think that PWD is not inside
+       the client path.
+       """
+
+    os.chdir(path)
+    if not is_client_path:
+        path =3D os.getcwd()
+    os.environ['PWD'] =3D path
=20
 def die(msg):
     if verbose:
@@ -1624,7 +1639,7 @@ class P4Submit(Command, P4UserMap):
             new_client_dir =3D True
             os.makedirs(self.clientPath)
=20
-        chdir(self.clientPath)
+        chdir(self.clientPath, is_client_path=3DTrue)
         if self.dry_run:
             print "Would synchronize p4 checkout in %s" % self.clientP=
ath
         else:
diff --git a/t/t9808-git-p4-chdir.sh b/t/t9808-git-p4-chdir.sh
index 4773296..11d2b51 100755
--- a/t/t9808-git-p4-chdir.sh
+++ b/t/t9808-git-p4-chdir.sh
@@ -58,7 +58,7 @@ test_expect_success 'p4 client root would be relative=
 due to clone --dest' '
=20
 # When the p4 client Root is a symlink, make sure chdir() does not use
 # getcwd() to convert it to a physical path.
-test_expect_failure SYMLINKS 'p4 client root symlink should stay symbo=
lic' '
+test_expect_success SYMLINKS 'p4 client root symlink should stay symbo=
lic' '
 	physical=3D"$TRASH_DIRECTORY/physical" &&
 	symbolic=3D"$TRASH_DIRECTORY/symbolic" &&
 	test_when_finished "rm -rf \"$physical\"" &&
--=20
1.8.2.rc2.65.g92f3e2d
