From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 2/2] git-p4: fix submit regression with clientSpec and subdir clone
Date: Sat, 25 Feb 2012 20:06:25 -0500
Message-ID: <1330218385-22309-3-git-send-email-pw@padd.com>
References: <1330218385-22309-1-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Laurent=20Charri=C3=A8re?= <lcharriere@promptu.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 26 02:07:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1Sa8-00047I-5l
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 02:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212Ab2BZBHN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Feb 2012 20:07:13 -0500
Received: from honk.padd.com ([74.3.171.149]:55349 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881Ab2BZBHM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 20:07:12 -0500
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id C288FE8D;
	Sat, 25 Feb 2012 17:07:11 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id C41DF313D8; Sat, 25 Feb 2012 20:07:05 -0500 (EST)
X-Mailer: git-send-email 1.7.9.220.g4b839
In-Reply-To: <1330218385-22309-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191551>

When the --use-client-spec is given to clone, and the clone
path is a subset of the full tree as specified in the client,
future submits will go to the wrong place.

=46actor out getClientSpec() so both clone/sync and submit can
use it.  Introduce getClientRoot() that is needed for the client
spec case, and use it instead of p4Where().

Test the five possible submit behaviors (add, modify, rename,
copy, delete).

Reported-by: Laurent Charri=C3=A8re <lcharriere@promptu.com>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4    |   86 ++++++++++++++++---------
 t/t9809-git-p4-client-view.sh |  142 +++++++++++++++++++++++++++++++++=
++++---
 2 files changed, 185 insertions(+), 43 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 94f0a12..9ccc87b 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -555,6 +555,46 @@ def p4PathStartsWith(path, prefix):
         return path.lower().startswith(prefix.lower())
     return path.startswith(prefix)
=20
+def getClientSpec():
+    """Look at the p4 client spec, create a View() object that contain=
s
+       all the mappings, and return it."""
+
+    specList =3D p4CmdList("client -o")
+    if len(specList) !=3D 1:
+        die('Output from "client -o" is %d lines, expecting 1' %
+            len(specList))
+
+    # dictionary of all client parameters
+    entry =3D specList[0]
+
+    # just the keys that start with "View"
+    view_keys =3D [ k for k in entry.keys() if k.startswith("View") ]
+
+    # hold this new View
+    view =3D View()
+
+    # append the lines, in order, to the view
+    for view_num in range(len(view_keys)):
+        k =3D "View%d" % view_num
+        if k not in view_keys:
+            die("Expected view key %s missing" % k)
+        view.append(entry[k])
+
+    return view
+
+def getClientRoot():
+    """Grab the client directory."""
+
+    output =3D p4CmdList("client -o")
+    if len(output) !=3D 1:
+        die('Output from "client -o" is %d lines, expecting 1' % len(o=
utput))
+
+    entry =3D output[0]
+    if "Root" not in entry:
+        die('Client has no "Root"')
+
+    return entry["Root"]
+
 class Command:
     def __init__(self):
         self.usage =3D "usage: %prog [options]"
@@ -1119,11 +1159,20 @@ class P4Submit(Command, P4UserMap):
             print "Internal error: cannot locate perforce depot path f=
rom existing branches"
             sys.exit(128)
=20
-        self.clientPath =3D p4Where(self.depotPath)
+        self.useClientSpec =3D False
+        if gitConfig("git-p4.useclientspec", "--bool") =3D=3D "true":
+            self.useClientSpec =3D True
+        if self.useClientSpec:
+            self.clientSpecDirs =3D getClientSpec()
+
+        if self.useClientSpec:
+            # all files are relative to the client spec
+            self.clientPath =3D getClientRoot()
+        else:
+            self.clientPath =3D p4Where(self.depotPath)
=20
-        if len(self.clientPath) =3D=3D 0:
-            print "Error: Cannot locate perforce checkout of %s in cli=
ent view" % self.depotPath
-            sys.exit(128)
+        if self.clientPath =3D=3D "":
+            die("Error: Cannot locate perforce checkout of %s in clien=
t view" % self.depotPath)
=20
         print "Perforce checkout for depot path %s located at %s" % (s=
elf.depotPath, self.clientPath)
         self.oldWorkingDirectory =3D os.getcwd()
@@ -2078,33 +2127,6 @@ class P4Sync(Command, P4UserMap):
             print self.gitError.read()
=20
=20
-    def getClientSpec(self):
-        specList =3D p4CmdList("client -o")
-        if len(specList) !=3D 1:
-            die('Output from "client -o" is %d lines, expecting 1' %
-                len(specList))
-
-        # dictionary of all client parameters
-        entry =3D specList[0]
-
-        # just the keys that start with "View"
-        view_keys =3D [ k for k in entry.keys() if k.startswith("View"=
) ]
-
-        # hold this new View
-        view =3D View()
-
-        # append the lines, in order, to the view
-        for view_num in range(len(view_keys)):
-            k =3D "View%d" % view_num
-            if k not in view_keys:
-                die("Expected view key %s missing" % k)
-            view.append(entry[k])
-
-        self.clientSpecDirs =3D view
-        if self.verbose:
-            for i, m in enumerate(self.clientSpecDirs.mappings):
-                    print "clientSpecDirs %d: %s" % (i, str(m))
-
     def run(self, args):
         self.depotPaths =3D []
         self.changeRange =3D ""
@@ -2145,7 +2167,7 @@ class P4Sync(Command, P4UserMap):
             if gitConfig("git-p4.useclientspec", "--bool") =3D=3D "tru=
e":
                 self.useClientSpec =3D True
         if self.useClientSpec:
-            self.getClientSpec()
+            self.clientSpecDirs =3D getClientSpec()
=20
         # TODO: should always look at previous commits,
         # merge with previous imports, if possible.
diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view=
=2Esh
index 25e01a4..9642641 100755
--- a/t/t9809-git-p4-client-view.sh
+++ b/t/t9809-git-p4-client-view.sh
@@ -71,20 +71,24 @@ git_verify() {
 #   - dir2
 #     - file21
 #     - file22
+init_depot() {
+	for d in 1 2 ; do
+		mkdir -p dir$d &&
+		for f in 1 2 ; do
+			echo dir$d/file$d$f >dir$d/file$d$f &&
+			p4 add dir$d/file$d$f &&
+			p4 submit -d "dir$d/file$d$f"
+		done
+	done &&
+	find . -type f ! -name files >files &&
+	check_files_exist dir1/file11 dir1/file12 \
+			  dir2/file21 dir2/file22
+}
+
 test_expect_success 'init depot' '
 	(
 		cd "$cli" &&
-		for d in 1 2 ; do
-			mkdir -p dir$d &&
-			for f in 1 2 ; do
-				echo dir$d/file$d$f >dir$d/file$d$f &&
-				p4 add dir$d/file$d$f &&
-				p4 submit -d "dir$d/file$d$f"
-			done
-		done &&
-		find . -type f ! -name files >files &&
-		check_files_exist dir1/file11 dir1/file12 \
-				  dir2/file21 dir2/file22
+		init_depot
 	)
 '
=20
@@ -257,6 +261,122 @@ test_expect_success 'clone --use-client-spec sets=
 useClientSpec' '
 	)
 '
=20
+# clone just a subdir of the client spec
+test_expect_success 'subdir clone' '
+	client_view "//depot/... //client/..." &&
+	files=3D"dir1/file11 dir1/file12 dir2/file21 dir2/file22" &&
+	client_verify $files &&
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --use-client-spec --dest=3D"$git" //depot/dir1 &&
+	git_verify dir1/file11 dir1/file12
+'
+
+#
+# submit back, see what happens:  five cases
+#
+test_expect_success 'subdir clone, submit modify' '
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --use-client-spec --dest=3D"$git" //depot/dir1 &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		echo line >>dir1/file12 &&
+		git add dir1/file12 &&
+		git commit -m dir1/file12 &&
+		"$GITP4" submit
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_file dir1/file12 &&
+		test_line_count =3D 2 dir1/file12
+	)
+'
+
+test_expect_success 'subdir clone, submit add' '
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --use-client-spec --dest=3D"$git" //depot/dir1 &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		echo file13 >dir1/file13 &&
+		git add dir1/file13 &&
+		git commit -m dir1/file13 &&
+		"$GITP4" submit
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_file dir1/file13
+	)
+'
+
+test_expect_success 'subdir clone, submit delete' '
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --use-client-spec --dest=3D"$git" //depot/dir1 &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		git rm dir1/file12 &&
+		git commit -m "delete dir1/file12" &&
+		"$GITP4" submit
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_missing dir1/file12
+	)
+'
+
+test_expect_success 'subdir clone, submit copy' '
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --use-client-spec --dest=3D"$git" //depot/dir1 &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		git config git-p4.detectCopies true &&
+		cp dir1/file11 dir1/file11a &&
+		git add dir1/file11a &&
+		git commit -m "copy to dir1/file11a" &&
+		"$GITP4" submit
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_file dir1/file11a
+	)
+'
+
+test_expect_success 'subdir clone, submit rename' '
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --use-client-spec --dest=3D"$git" //depot/dir1 &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		git config git-p4.detectRenames true &&
+		git mv dir1/file13 dir1/file13a &&
+		git commit -m "rename dir1/file13 to dir1/file13a" &&
+		"$GITP4" submit
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_missing dir1/file13 &&
+		test_path_is_file dir1/file13a
+	)
+'
+
+test_expect_success 'reinit depot' '
+	(
+		cd "$cli" &&
+		p4 sync -f &&
+		rm files &&
+		p4 delete */* &&
+		p4 submit -d "delete all files" &&
+		init_depot
+	)
+'
+
 #
 # Rename directories to test quoting in depot-side mappings
 # //depot
--=20
1.7.9.219.g1d56c.dirty
