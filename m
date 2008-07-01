From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 7/8] Pack jgit into a portable single file command line utility
Date: Mon, 30 Jun 2008 23:04:04 -0400
Message-ID: <1214881445-3931-8-git-send-email-spearce@spearce.org>
References: <1214881445-3931-1-git-send-email-spearce@spearce.org>
 <1214881445-3931-2-git-send-email-spearce@spearce.org>
 <1214881445-3931-3-git-send-email-spearce@spearce.org>
 <1214881445-3931-4-git-send-email-spearce@spearce.org>
 <1214881445-3931-5-git-send-email-spearce@spearce.org>
 <1214881445-3931-6-git-send-email-spearce@spearce.org>
 <1214881445-3931-7-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 05:14:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDWK8-0003pl-Od
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 05:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbYGADN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 23:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbYGADMw
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 23:12:52 -0400
Received: from george.spearce.org ([209.20.77.23]:58261 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbYGADMs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 23:12:48 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 2C4A938223; Tue,  1 Jul 2008 03:04:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=4.0 tests=ALL_TRUSTED,AWL autolearn=ham
	version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 9B14938193;
	Tue,  1 Jul 2008 03:04:30 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214881445-3931-7-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86995>

On UNIX (and even Cygwin) we can package the entire jgit library into
a single JAR file and prefix that JAR with a shell script to start the
JVM, passing in the script/JAR file as the only classpath.  This trick
works because the table of contents for the ZIP file is at the end of
the stream, and the JVM tends to only do random access through that
table when it looks up classes for loading.

A tiny shell script called make_jgit.sh compiles everything with the
command line javac and packages it into the portable jgit shell
script, making it possible to build and use jgit without touching
either Eclipse or Maven.

Currently this is quite easy to implement as we have only one support
library (JSch), but things may get more complicated if we add another
JAR to our classpath.

With this I can install JGit into my personal account and make use
of it on a daily basis from the command line:

	./make_jgit.sh
	mv jgit ~/bin
	jgit push ...

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .gitignore   |    1 +
 jgit         |   37 -------------------------------------
 jgit.sh      |   45 +++++++++++++++++++++++++++++++++++++++++++++
 make_jgit.sh |   26 ++++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 37 deletions(-)
 create mode 100644 .gitignore
 delete mode 100755 jgit
 create mode 100755 jgit.sh
 create mode 100755 make_jgit.sh

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 0000000..0763732
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1 @@
+/jgit
diff --git a/jgit b/jgit
deleted file mode 100755
index be7df7e..0000000
--- a/jgit
+++ /dev/null
@@ -1,37 +0,0 @@
-#!/bin/sh
-
-jgit_home=`dirname $0`
-cp="$jgit_home/org.spearce.jgit/bin"
-cp="$cp:$jgit_home/org.spearce.jgit/lib/jsch-0.1.37.jar"
-unset jgit_home
-java_args=
-
-# Cleanup paths for Cygwin.
-#
-case "`uname`" in
-CYGWIN*)
-	cp=`cygpath --windows --mixed --path "$cp"`
-	;;
-Darwin)
-	if test -e /System/Library/Frameworks/JavaVM.framework
-	then
-		java_args='
-			-Dcom.apple.mrj.application.apple.menu.about.name=JGit
-			-Dcom.apple.mrj.application.growbox.intrudes=false
-			-Dapple.laf.useScreenMenuBar=true
-			-Xdock:name=JGit
-		'
-	fi
-	;;
-esac
-
-CLASSPATH="$cp"
-export CLASSPATH
-
-java=java
-if test -n "$JAVA_HOME"
-then
-	java="$JAVA_HOME/bin/java"
-fi
-
-exec "$java" $java_args org.spearce.jgit.pgm.Main "$@"
diff --git a/jgit.sh b/jgit.sh
new file mode 100755
index 0000000..84927bc
--- /dev/null
+++ b/jgit.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+if [ "@@use_self@@" = "1" ]
+then
+	this_script=`which "$0" 2>/dev/null`
+	[ $? -gt 0 -a -f "$0" ] && this_script="$0"
+	cp=$this_script
+else
+	jgit_home=`dirname $0`
+	cp="$jgit_home/org.spearce.jgit/bin"
+	cp="$cp:$jgit_home/org.spearce.jgit/lib/jsch-0.1.37.jar"
+	unset jgit_home
+	java_args=
+fi
+
+# Cleanup paths for Cygwin.
+#
+case "`uname`" in
+CYGWIN*)
+	cp=`cygpath --windows --mixed --path "$cp"`
+	;;
+Darwin)
+	if test -e /System/Library/Frameworks/JavaVM.framework
+	then
+		java_args='
+			-Dcom.apple.mrj.application.apple.menu.about.name=JGit
+			-Dcom.apple.mrj.application.growbox.intrudes=false
+			-Dapple.laf.useScreenMenuBar=true
+			-Xdock:name=JGit
+		'
+	fi
+	;;
+esac
+
+CLASSPATH="$cp"
+export CLASSPATH
+
+java=java
+if test -n "$JAVA_HOME"
+then
+	java="$JAVA_HOME/bin/java"
+fi
+
+exec "$java" $java_args org.spearce.jgit.pgm.Main "$@"
+exit 1
diff --git a/make_jgit.sh b/make_jgit.sh
new file mode 100755
index 0000000..3889dca
--- /dev/null
+++ b/make_jgit.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+PATH=$JAVA_HOME/bin:$PATH
+O=jgit
+T=".temp$$.$O"
+
+rm -f $O
+rm -rf $T $O+ org.spearce.jgit/bin2
+cp org.spearce.jgit/lib/jsch-0.1.37.jar $T &&
+mkdir org.spearce.jgit/bin2 &&
+(cd org.spearce.jgit/src &&
+ find . -name \*.java -type f |
+ xargs javac \
+	-source 1.5 \
+	-target 1.5 \
+	-g \
+	-d ../bin2 \
+	-cp ../lib/jsch-0.1.37.jar) &&
+jar uf $T -C org.spearce.jgit/bin2 . &&
+jar uf $T -C org.spearce.jgit META-INF &&
+sed s/@@use_self@@/1/ jgit.sh >$O+ &&
+cat $T >>$O+ &&
+chmod 555 $O+ &&
+mv $O+ $O &&
+echo "Created $O." &&
+rm -rf $T $O+ org.spearce.jgit/bin2
-- 
1.5.6.74.g8a5e
