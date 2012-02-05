From: Michael Schubert <mschub@elegosoft.com>
Subject: [RFC/PATCH] git-new-workdir: add option --rsync
Date: Sun, 05 Feb 2012 17:27:35 +0100
Message-ID: <4F2EADF7.5000907@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 05 17:28:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru4xS-0005Td-41
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 17:28:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956Ab2BEQ2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 11:28:50 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:52521 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799Ab2BEQ2s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 11:28:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 04D33DE7E1
	for <git@vger.kernel.org>; Sun,  5 Feb 2012 17:28:47 +0100 (CET)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SSIOpDRndlzB for <git@vger.kernel.org>;
	Sun,  5 Feb 2012 17:28:46 +0100 (CET)
Received: from [87.77.85.195] (z55c3.pia.fu-berlin.de [87.77.85.195])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id D1FA3DE7D0
	for <git@vger.kernel.org>; Sun,  5 Feb 2012 17:28:46 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0) Gecko/20120202 Thunderbird/10.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189948>

Currently, git-new-workdir doesn't allow you to rather duplicate your
old workdir instead of creating a new one based on a branch. This can be
annoying when you are used to carry untracked helper scripts in your
workdir (e.g. test.sh).

Add a new option -s | --rsync to allow users to "sync" the new workdir.

Signed-off-by: Michael Schubert <mschub@elegosoft.com>
---

Maybe we even want to stop after rsync'ing without doing the checkout -f.
Opinions?

 contrib/workdir/git-new-workdir |   31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
index 75e8b25..bac75f9 100755
--- a/contrib/workdir/git-new-workdir
+++ b/contrib/workdir/git-new-workdir
@@ -10,9 +10,30 @@ die () {
 	exit 128
 }
 
-if test $# -lt 2 || test $# -gt 3
+if test $# -lt 2
 then
-	usage "$0 <repository> <new_workdir> [<branch>]"
+	usage "$0 [-s | --rsync] <repository> <new_workdir> [<branch>]"
+fi
+
+rsync=
+
+while test $# != 0
+do
+  case "$1" in
+  -s|--rsync)
+    rsync=t ;;
+  *)
+    break ;;
+  esac
+  shift
+done
+
+if test -n "$rsync"
+then
+  if ! $(hash rsync 2>/dev/null)
+  then
+   die "cannot find rsync"
+  fi
 fi
 
 orig_git=$1
@@ -77,6 +98,12 @@ done
 cd "$new_workdir"
 # copy the HEAD from the original repository as a default branch
 cp "$git_dir/HEAD" .git/HEAD
+
+if test -n "$rsync"
+then
+  rsync --archive --exclude '.*' "../$orig_git/" .
+fi
+
 # checkout the branch (either the same as HEAD from the original repository, or
 # the one that was asked for)
 git checkout -f $branch
-- 
1.7.9.230.gbd302
