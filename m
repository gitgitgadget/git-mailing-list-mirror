From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH] format-patch: Remove last vestiges of --mbox option
Date: Tue, 7 Feb 2006 09:37:54 +0000 (UTC)
Message-ID: <20060207093739.BB4DF5BE7F@nox.op5.se>
X-From: git-owner@vger.kernel.org Tue Feb 07 10:37:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6PI8-0004Ys-BI
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 10:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWBGJhl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 04:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWBGJhl
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 04:37:41 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:35304 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932455AbWBGJhl
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Feb 2006 04:37:41 -0500
Received: from nox.op5.se (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id E1C056BD04
	for <git@vger.kernel.org>; Tue,  7 Feb 2006 10:37:39 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id BB4DF5BE7F; Tue,  7 Feb 2006 10:37:39 +0100 (CET)
To: git@vger.kernel.org
In-Reply-To: 20060207103739
Date: Mon Feb 6 16:24:49 2006 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15687>

Don't mention it in docs or --help output.
Remove mbox, date and author variables from git-format-patch.sh.

Use DESCRIPTION text from man-page to update LONG_USAGE output. It's
a bit silly to have two texts saying the same thing in different words,
and I'm too lazy to update both.

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 Documentation/git-format-patch.txt |   32 ++++++++++----------------------
 git-format-patch.sh                |   36 ++++++++++++++++++------------------
 2 files changed, 28 insertions(+), 40 deletions(-)

6fc31fee29cfea12a6213a775231ac6c136989d3
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 47705de..9ac0636 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -9,28 +9,27 @@ git-format-patch - Prepare patches for e
 SYNOPSIS
 --------
 [verse]
-'git-format-patch' [-n | -k] [-o <dir> | --stdout] [-s] [-c] [--mbox]
+'git-format-patch' [-n | -k] [-o <dir> | --stdout] [-s] [-c]
 		 [--diff-options] <his> [<mine>]
 
 DESCRIPTION
 -----------
 Prepare each commit with its patch since <mine> head forked from
-<his> head, one file per patch, for e-mail submission.  Each
-output file is numbered sequentially from 1, and uses the first
-line of the commit message (massaged for pathname safety) as the
-filename.
+<his> head, one file per patch formatted to resemble UNIX mailbox
+format, for e-mail submission or use with gitlink:git-am[1].
 
-When -o is specified, output files are created in that
-directory; otherwise in the current working directory.
+Each output file is numbered sequentially from 1, and uses the
+first line of the commit message (massaged for pathname safety)
+as the filename.
+
+When -o is specified, output files are created in <dir>; otherwise
+they are created in the current working directory.  This option
+is ignored if --stdout is specified.
 
 When -n is specified, instead of "[PATCH] Subject", the first
 line is formatted as "[PATCH N/M] Subject", unless you have only
 one patch.
 
-When --mbox is specified, the output is formatted to resemble
-UNIX mailbox format, and can be concatenated together for
-processing with applymbox.
-
 
 OPTIONS
 -------
@@ -45,11 +44,6 @@ OPTIONS
 	Do not strip/add '[PATCH]' from the first line of the
 	commit log message.
 
--a|--author, -d|--date::
-	Output From: and Date: headers for commits made by
-	yourself as well.  Usually these are output only for
-	commits made by people other than yourself.
-
 -s|--signoff::
 	Add `Signed-off-by:` line to the commit message, using
 	the committer identity of yourself.
@@ -61,12 +55,6 @@ OPTIONS
         has a SP character immediately followed by a TAB
         character.
 
--m|--mbox::
-	Format the output files for closer to mbox format by
-	adding a phony Unix "From " line, so they can be
-	concatenated together and fed to `git-applymbox`.
-	Implies --author and --date.
-
 --stdout::
 	This flag generates the mbox formatted output to the
 	standard output, instead of saving them into a file per
diff --git a/git-format-patch.sh b/git-format-patch.sh
index 5fb8ce1..e54c9e4 100755
--- a/git-format-patch.sh
+++ b/git-format-patch.sh
@@ -3,23 +3,23 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
-USAGE='[-n | -k] [-o <dir> | --stdout] [--signoff] [--check] [--mbox] [--diff-options] <upstream> [<our-head>]'
-LONG_USAGE='Prepare each commit with its patch since our-head forked from upstream,
-one file per patch, for e-mail submission.  Each output file is
-numbered sequentially from 1, and uses the first line of the commit
-message (massaged for pathname safety) as the filename.
-
-There are three output modes.  By default, output files are created in
-the current working directory; when -o is specified, they are created
-in that directory instead; when --stdout is specified, they are spit
-on standard output, and can be piped to git-am.
-
-When -n is specified, instead of "[PATCH] Subject", the first line is formatted
-as "[PATCH N/M] Subject", unless you have only one patch.
-
-When --mbox is specified, the output is formatted to resemble
-UNIX mailbox format, and can be concatenated together for processing
-with applymbox.'
+USAGE='[-n | -k] [-o <dir> | --stdout] [--signoff] [--check] [--diff-options] <his> [<mine>]'
+LONG_USAGE='Prepare each commit with its patch since <mine> head forked from
+<his> head, one file per patch formatted to resemble UNIX mailbox
+format, for e-mail submission or use with git-am.
+
+Each output file is numbered sequentially from 1, and uses the
+first line of the commit message (massaged for pathname safety)
+as the filename.
+
+When -o is specified, output files are created in <dir>; otherwise
+they are created in the current working directory.  This option
+is ignored if --stdout is specified.
+
+When -n is specified, instead of "[PATCH] Subject", the first
+line is formatted as "[PATCH N/M] Subject", unless you have only
+one patch.'
+
 . git-sh-setup
 
 # Force diff to run in C locale.
@@ -48,7 +48,7 @@ do
     -s|--s|--si|--sig|--sign|--signo|--signof|--signoff)
     signoff=t ;;
     --st|--std|--stdo|--stdou|--stdout)
-    stdout=t mbox=t date=t author=t ;;
+    stdout=t ;;
     -o=*|--o=*|--ou=*|--out=*|--outp=*|--outpu=*|--output=*|--output-=*|\
     --output-d=*|--output-di=*|--output-dir=*|--output-dire=*|\
     --output-direc=*|--output-direct=*|--output-directo=*|\
-- 
1.1.6.ga2c6
