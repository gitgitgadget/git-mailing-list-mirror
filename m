From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/3] Build jgit.jar and jgit_src.zip alongside jgit CLI wrapper
Date: Tue,  2 Sep 2008 09:28:11 -0700
Message-ID: <1220372892-15423-2-git-send-email-spearce@spearce.org>
References: <1220372892-15423-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 18:29:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaYkv-0006j9-M5
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 18:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718AbYIBQ2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 12:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752144AbYIBQ2Q
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 12:28:16 -0400
Received: from george.spearce.org ([209.20.77.23]:44743 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbYIBQ2N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 12:28:13 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 3969238379; Tue,  2 Sep 2008 16:28:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 941DF38375;
	Tue,  2 Sep 2008 16:28:12 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.1.207.g020e5
In-Reply-To: <1220372892-15423-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94681>

When we build jgit the CLI executable we have the classes already
compiled so we can easily construct a jgit.jar and jgit_src.zip
at the same time.  This makes it easier for folks who need the
library and not the command line interface package.

We do not include JSch in jgit.jar as we assume the downstream
user can supply us the package.  In an IDE scenario it is quite
likely the IDE already has a copy of JSch available for use, so
we really don't want to supply our own and potentially put two
different versions on the classpath.

The version we embed within our JAR manifest is now more like
the dotted format used by C Git or git-gui.  In particular we
embed the "-dirty" suffix if the tree contains modifications.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .gitignore   |    2 ++
 make_jgit.sh |   54 ++++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/.gitignore b/.gitignore
index 0763732..baf2766 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1 +1,3 @@
 /jgit
+/jgit.jar
+/jgit_src.zip
diff --git a/make_jgit.sh b/make_jgit.sh
index c119202..a15f73f 100755
--- a/make_jgit.sh
+++ b/make_jgit.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
-O=jgit
+O_CLI=jgit
+O_JAR=jgit.jar
+O_SRC=jgit_src.zip
+
 PLUGINS="
 	org.spearce.jgit
 	org.spearce.jgit.pgm
@@ -11,7 +14,7 @@ JARS="
 "
 
 PSEP=":"
-T=".temp$$.$O"
+T=".temp$$.$O_CLI"
 T_MF="$T.MF"
 R=`pwd`
 if [ "$OSTYPE" = "cygwin" ]
@@ -30,7 +33,7 @@ then
 fi
 
 cleanup_bin() {
-	rm -f $T $O+ $T_MF
+	rm -f $T $O_CLI+ $O_JAR+ $O_SRC+ $T_MF
 	for p in $PLUGINS
 	do
 		rm -rf $p/bin2
@@ -39,13 +42,21 @@ cleanup_bin() {
 
 die() {
 	cleanup_bin
-	rm -f $O
+	rm -f $O_CLI $O_JAR $O_SRC
 	echo >&2 "$@"
 	exit 1
 }
 
 cleanup_bin
-rm -f $O
+rm -f $O_CLI $O_JAR $O_SRC
+
+VN=`git describe --abbrev=4 HEAD 2>/dev/null`
+git update-index -q --refresh
+if [ -n "`git diff-index --name-only HEAD --`" ]
+then
+	VN="$VN-dirty"
+fi
+VN=`echo "$VN" | sed -e s/-/./g`
 
 CLASSPATH=
 for j in $JARS
@@ -73,20 +84,39 @@ do
 		-d ../bin2) || die "Building $p failed."
 	CLASSPATH="${CLASSPATH}${PSEP}$R/$p/bin2"
 done
+echo
 
+echo "Version $VN" &&
 echo Manifest-Version: 1.0 >$T_MF &&
 echo Implementation-Title: jgit >>$T_MF &&
-echo Implementation-Version: `git describe HEAD` >>$T_MF &&
+echo Implementation-Version: $VN >>$T_MF &&
+
+java org.spearce.jgit.pgm.build.JarLinkUtil \
+	-include org.spearce.jgit/bin2 \
+	-file META-INF/MANIFEST.MF=$T_MF \
+	>$O_JAR+ &&
+chmod 555 $O_JAR+ &&
+mv $O_JAR+ $O_JAR &&
+echo "Created $O_JAR." &&
+
+java org.spearce.jgit.pgm.build.JarLinkUtil \
+	-include org.spearce.jgit/src \
+	-file META-INF/MANIFEST.MF=$T_MF \
+	>$O_SRC+ &&
+chmod 555 $O_SRC+ &&
+mv $O_SRC+ $O_SRC &&
+echo "Created $O_SRC." &&
 
-sed s/@@use_self@@/1/ jgit.sh >$O+ &&
+M_TB=META-INF/services/org.spearce.jgit.pgm.TextBuiltin &&
+sed s/@@use_self@@/1/ jgit.sh >$O_CLI+ &&
 java org.spearce.jgit.pgm.build.JarLinkUtil \
 	`for p in $JARS   ; do printf %s " -include $p"     ;done` \
 	`for p in $PLUGINS; do printf %s " -include $p/bin2";done` \
-	-file META-INF/services/org.spearce.jgit.pgm.TextBuiltin=org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin \
+	-file $M_TB=org.spearce.jgit.pgm/src/$M_TB \
 	-file META-INF/MANIFEST.MF=$T_MF \
-	>>$O+ &&
-chmod 555 $O+ &&
-mv $O+ $O &&
-echo "Created $O." || die "Creating $O failed."
+	>>$O_CLI+ &&
+chmod 555 $O_CLI+ &&
+mv $O_CLI+ $O_CLI &&
+echo "Created $O_CLI." || die "Build failed."
 
 cleanup_bin
-- 
1.6.0.1.207.g020e5
