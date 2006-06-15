From: Sean <seanlkml@sympatico.ca>
Subject: [PATCH] Add a "--notags" option for git-p4import.
Date: Thu, 15 Jun 2006 17:26:21 -0400
Message-ID: <BAYC1-PASMTP0215C04B53D4FD5E21BE9FAE820@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jun 15 23:27:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqzNW-0004ue-4F
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 23:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031426AbWFOV1p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 17:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031438AbWFOV1p
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 17:27:45 -0400
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:53004 "EHLO
	BAYC1-PASMTP02.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1031426AbWFOV1o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jun 2006 17:27:44 -0400
X-Originating-IP: [65.93.43.191]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.191]) by BAYC1-PASMTP02.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 15 Jun 2006 14:27:43 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id BEDF6644C2A
	for <git@vger.kernel.org>; Thu, 15 Jun 2006 17:27:42 -0400 (EDT)
To: git@vger.kernel.org
Message-Id: <20060615172621.fac974f2.seanlkml@sympatico.ca>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.9.2; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 15 Jun 2006 21:27:44.0043 (UTC) FILETIME=[8A0757B0:01C690C2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


P4import currently creates a git tag for every commit it imports.
When importing from a large repository too many tags can be created
for git to manage, so this provides an option to shut that feature
off if necessary.

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>
---
 Documentation/git-p4import.txt |    5 ++++-
 git-p4import.py                |   12 ++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-p4import.txt b/Documentation/git-p4import.txt
index c198ff2..0858e5e 100644
--- a/Documentation/git-p4import.txt
+++ b/Documentation/git-p4import.txt
@@ -8,7 +8,7 @@ git-p4import - Import a Perforce reposit
 
 SYNOPSIS
 --------
-`git-p4import` [-q|-v] [--authors <file>] [-t <timezone>] <//p4repo/path> <branch>
+`git-p4import` [-q|-v] [--notags] [--authors <file>] [-t <timezone>] <//p4repo/path> <branch>
 
 `git-p4import` --stitch <//p4repo/path>
 
@@ -43,6 +43,9 @@ OPTIONS
 	Specify an authors file containing a mapping of Perforce user
 	ids to full names and email addresses (see Notes below).
 
+\--notags::
+	Do not create a tag for each imported commit.
+
 \--stitch::
 	Import the contents of the given perforce branch into the
 	currently checked out git branch.
diff --git a/git-p4import.py b/git-p4import.py
index 74172ab..908941d 100644
--- a/git-p4import.py
+++ b/git-p4import.py
@@ -23,7 +23,6 @@ s = signal(SIGINT, SIG_DFL)
 if s != default_int_handler:
    signal(SIGINT, s)
 
-
 def die(msg, *args):
     for a in args:
         msg = "%s %s" % (msg, a)
@@ -38,6 +37,7 @@ verbosity = 1
 logfile = "/dev/null"
 ignore_warnings = False
 stitch = 0
+tagall = True
 
 def report(level, msg, *args):
     global verbosity
@@ -261,10 +261,9 @@ class git_command:
         self.make_tag("p4/%s"%id, commit)
         self.git("update-ref HEAD %s %s" % (commit, current) )
 
-
 try:
     opts, args = getopt.getopt(sys.argv[1:], "qhvt:",
-                    ["authors=","help","stitch=","timezone=","log=","ignore"])
+            ["authors=","help","stitch=","timezone=","log=","ignore","notags"])
 except getopt.GetoptError:
     usage()
 
@@ -275,6 +274,8 @@ for o, a in opts:
         verbosity += 1
     if o in ("--log"):
         logfile = a
+    if o in ("--notags"):
+        tagall = False
     if o in ("-h", "--help"):
         usage()
     if o in ("--ignore"):
@@ -350,7 +351,10 @@ for id in changes:
     report(1, "Importing changeset", id)
     change = p4.describe(id)
     p4.sync(id)
-    git.commit(change.author, change.email, change.date, change.msg, id)
+    if tagall :
+            git.commit(change.author, change.email, change.date, change.msg, id)
+    else:
+            git.commit(change.author, change.email, change.date, change.msg, "import")
     if stitch == 1:
         git.clean_directories()
         stitch = 0
-- 
1.4.0.rc2
