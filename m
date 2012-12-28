From: esr@thyrsus.com (Eric S. Raymond)
Subject: (unknown)
Date: Fri, 28 Dec 2012 11:43:22 -0500 (EST)
Message-ID: <20121228164322.B102B4413A@snark.thyrsus.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 28 17:44:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tod2f-0005oU-Of
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 17:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814Ab2L1Qn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 11:43:59 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:32853
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686Ab2L1Qn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 11:43:58 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id B102B4413A; Fri, 28 Dec 2012 11:43:22 -0500 (EST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212244>

From: "Eric S. Raymond" <esr@thyrsus.com>
Date: Fri, 28 Dec 2012 11:40:59 -0500
Subject: [PATCH] Add checks to Python scripts for version dependencies.

---
 contrib/ciabot/ciabot.py           | 8 +++++++-
 contrib/fast-import/import-zips.py | 7 ++++++-
 contrib/hg-to-git/hg-to-git.py     | 5 +++++
 contrib/p4import/git-p4import.py   | 5 +++++
 contrib/svn-fe/svnrdump_sim.py     | 4 ++++
 git-p4.py                          | 8 +++++++-
 git-remote-testgit.py              | 5 +++++
 git_remote_helpers/git/__init__.py | 5 +++++
 8 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/contrib/ciabot/ciabot.py b/contrib/ciabot/ciabot.py
index bd24395..81c3ebd 100755
--- a/contrib/ciabot/ciabot.py
+++ b/contrib/ciabot/ciabot.py
@@ -47,7 +47,13 @@
 # we default to that.
 #
 
-import os, sys, commands, socket, urllib
+import sys
+if sys.hexversion < 0x02000000:
+	# The limiter is the xml.sax module
+        sys.stderr.write("ciabot.py: requires Python 2.0.0 or later.\n")
+        sys.exit(1)
+
+import os, commands, socket, urllib
 from xml.sax.saxutils import escape
 
 # Changeset URL prefix for your repo: when the commit ID is appended
diff --git a/contrib/fast-import/import-zips.py b/contrib/fast-import/import-zips.py
index 82f5ed3..b989941 100755
--- a/contrib/fast-import/import-zips.py
+++ b/contrib/fast-import/import-zips.py
@@ -9,10 +9,15 @@
 ##  git log --stat import-zips
 
 from os import popen, path
-from sys import argv, exit
+from sys import argv, exit, hexversion
 from time import mktime
 from zipfile import ZipFile
 
+if hexversion < 0x01060000:
+	# The limiter is the zipfile module
+        sys.stderr.write("import-zips.py: requires Python 1.6.0 or later.\n")
+        sys.exit(1)
+
 if len(argv) < 2:
 	print 'Usage:', argv[0], '<zipfile>...'
 	exit(1)
diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
index 046cb2b..232625a 100755
--- a/contrib/hg-to-git/hg-to-git.py
+++ b/contrib/hg-to-git/hg-to-git.py
@@ -23,6 +23,11 @@ import os, os.path, sys
 import tempfile, pickle, getopt
 import re
 
+if sys.hexversion < 0x02030000:
+   # The behavior of the pickle module changed significantly in 2.3
+   sys.stderr.write("hg-to-git.py: requires Python 2.3 or later.\n")
+   sys.exit(1)
+
 # Maps hg version -> git version
 hgvers = {}
 # List of children for each hg revision
diff --git a/contrib/p4import/git-p4import.py b/contrib/p4import/git-p4import.py
index b6e534b..593d6a0 100644
--- a/contrib/p4import/git-p4import.py
+++ b/contrib/p4import/git-p4import.py
@@ -14,6 +14,11 @@ import sys
 import time
 import getopt
 
+if sys.hexversion < 0x02020000:
+   # The behavior of the marshal module changed significantly in 2.2
+   sys.stderr.write("git-p4import.py: requires Python 2.2 or later.\n")
+   sys.exit(1)
+
 from signal import signal, \
    SIGPIPE, SIGINT, SIG_DFL, \
    default_int_handler
diff --git a/contrib/svn-fe/svnrdump_sim.py b/contrib/svn-fe/svnrdump_sim.py
index 1cfac4a..95a80ae 100755
--- a/contrib/svn-fe/svnrdump_sim.py
+++ b/contrib/svn-fe/svnrdump_sim.py
@@ -7,6 +7,10 @@ to the highest revision that should be available.
 """
 import sys, os
 
+if sys.hexversion < 0x02040000:
+	# The limiter is the ValueError() calls. This may be too conservative
+        sys.stderr.write("svnrdump-sim.py: requires Python 2.4 or later.\n")
+        sys.exit(1)
 
 def getrevlimit():
         var = 'SVNRMAX'
diff --git a/git-p4.py b/git-p4.py
index 551aec9..69f1452 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -8,7 +8,13 @@
 # License: MIT <http://www.opensource.org/licenses/mit-license.php>
 #
 
-import optparse, sys, os, marshal, subprocess, shelve
+import sys
+if sys.hexversion < 0x02040000:
+    # The limiter is the subprocess module
+    sys.stderr.write("git-p4: requires Python 2.4 or later.\n")
+    sys.exit(1)
+
+import optparse, os, marshal, subprocess, shelve
 import tempfile, getopt, os.path, time, platform
 import re, shutil
 
diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index 5f3ebd2..91faabd 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -31,6 +31,11 @@ from git_remote_helpers.git.exporter import GitExporter
 from git_remote_helpers.git.importer import GitImporter
 from git_remote_helpers.git.non_local import NonLocalGit
 
+if sys.hexversion < 0x01050200:
+    # os.makedirs() is the limiter
+    sys.stderr.write("git-remote-testgit: requires Python 1.5.2 or later.\n")
+    sys.exit(1)
+
 def get_repo(alias, url):
     """Returns a git repository object initialized for usage.
     """
diff --git a/git_remote_helpers/git/__init__.py b/git_remote_helpers/git/__init__.py
index e69de29..1dbb1b0 100644
--- a/git_remote_helpers/git/__init__.py
+++ b/git_remote_helpers/git/__init__.py
@@ -0,0 +1,5 @@
+import sys
+if sys.hexversion < 0x02040000:
+    # The limiter is the subprocess module
+    sys.stderr.write("git_remote_helpers: requires Python 2.4 or later.\n")
+    sys.exit(1)
-- 
1.8.1.rc2




-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

A ``decay in the social contract'' is detectable; there is a growing
feeling, particularly among middle-income taxpayers, that they are not
getting back, from society and government, their money's worth for
taxes paid. The tendency is for taxpayers to try to take more control
of their finances...	-- IRS Strategic Plan, (May 1984)
