From: Paul Smith <paul@mad-scientist.net>
Subject: [PATCH] git-new-workdir: Don't fail if the target directory is empty
Date: Sat, 15 Nov 2014 12:49:20 -0500
Organization: GNU's Not UNIX!
Message-ID: <1416073760.9305.174.camel@homebase>
Reply-To: paul@mad-scientist.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 15 18:57:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xphal-0002Qh-GZ
	for gcvg-git-2@plane.gmane.org; Sat, 15 Nov 2014 18:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271AbaKOR4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2014 12:56:47 -0500
Received: from qproxy1-pub.mail.unifiedlayer.com ([173.254.64.10]:43562 "HELO
	qproxy1-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754259AbaKOR4q (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Nov 2014 12:56:46 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Nov 2014 12:56:46 EST
Received: (qmail 7581 invoked by uid 0); 15 Nov 2014 17:50:06 -0000
Received: from unknown (HELO CMOut01) (10.0.90.82)
  by qproxy1.mail.unifiedlayer.com with SMTP; 15 Nov 2014 17:50:06 -0000
Received: from box531.bluehost.com ([74.220.219.131])
	by CMOut01 with 
	id Ftp61p00j2qhmhE01tp94y; Sat, 15 Nov 2014 10:49:11 -0700
X-Authority-Analysis: v=2.1 cv=dfgTgxne c=1 sm=1 tr=0
 a=GcR8MKwCKDX7fzHfRD/fNg==:117 a=GcR8MKwCKDX7fzHfRD/fNg==:17 a=cNaOj0WVAAAA:8
 a=f5113yIGAAAA:8 a=IkcTkHD0fZMA:10 a=pBbsfl06AAAA:8 a=cdVwids0oJMA:10
 a=qenwzdlAJUAA:10 a=wEg50LEFLPybhIfnLwwA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mad-scientist.net; s=default;
	h=Content-Transfer-Encoding:Mime-Version:Content-Type:Date:To:Reply-To:From:Subject:Message-ID; bh=UDQIeDDL3uY1U1wnYC9NFpiUQfvp3LnZ99W+oiPyfDw=;
	b=Oo3RFR+wWYCt3xP9pUNWiLvTDz+eJ8Hgs+mKnBITKgRL3xwN8qfAI7lyeD8bKTG/toStUjHiU9PaUi35i9ywOSnvkb30YeOUrQm/JaJOkSeC8bapbpP4eKG4Ly3cG7qs;
Received: from [72.74.248.26] (port=41161 helo=homebase.local)
	by box531.bluehost.com with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
	(Exim 4.82)
	(envelope-from <paul@mad-scientist.net>)
	id 1XphT8-0007qK-Gx
	for git@vger.kernel.org; Sat, 15 Nov 2014 10:49:06 -0700
X-Mailer: Evolution 3.11.3-fta1~13.10 
X-Identified-User: {678:box531.bluehost.com:madscie1:mad-scientist.us} {sentby:smtp auth 72.74.248.26 authed with paul@mad-scientist.us}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>From 545c0d526eaa41f9306b567275a7d53799987482 Mon Sep 17 00:00:00 2001
From: Paul Smith <paul@mad-scientist.net>
Date: Fri, 14 Nov 2014 17:11:19 -0500
Subject: [PATCH] git-new-workdir: Don't fail if the target directory is empty

Also provide more error checking and clean up on failure.

Signed-off-by: Paul Smith <paul@mad-scientist.net>
---

Thanks Junio.  I've reworked the change so it will automatically succeed
if the directory does not exists or exists but is empty, and fail
otherwise, which as far as I can tell is the behavior "git clone" uses
as well.  I removed the -f flag as no longer needed.  I also added some
cleanup that is performed if the new-workdir operation fails for any
reason so you don't get partly-constructed workdirs.  I also added more
error checking so that we immediately stop if any step fails.  Some may
suggest "set -e" but that flag can be tricky... I preferred to make the
failure explicit.

 contrib/workdir/git-new-workdir | 54 +++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 15 deletions(-)

diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
index 75e8b25..c402000 100755
--- a/contrib/workdir/git-new-workdir
+++ b/contrib/workdir/git-new-workdir
@@ -10,6 +10,10 @@ die () {
 	exit 128
 }
 
+failed () {
+	die "unable to create new workdir \"$new_workdir\"!"
+}
+
 if test $# -lt 2 || test $# -gt 3
 then
 	usage "$0 <repository> <new_workdir> [<branch>]"
@@ -48,35 +52,55 @@ then
 		"a complete repository."
 fi
 
-# don't recreate a workdir over an existing repository
-if test -e "$new_workdir"
+# make sure the links use full paths
+git_dir=$(cd "$git_dir"; pwd)
+
+# don't recreate a workdir over an existing directory unless it's empty
+if test -d "$new_workdir"
 then
-	die "destination directory '$new_workdir' already exists."
+	if test $(ls -a1 "$new_workdir/." | wc -l) -ne 2
+	then
+		die "destination directory '$new_workdir' is not empty."
+	fi
+	was_existing=true
+else
+	mkdir -p "$new_workdir" || failed
+	was_existing=false
 fi
 
-# make sure the links use full paths
-git_dir=$(cd "$git_dir"; pwd)
+cleanup () {
+	if $was_existing
+	then
+		rm -rf "$new_workdir"/* "$new_workdir"/.[!.] "$new_workdir"/.??*
+	else
+		rm -rf "$new_workdir"
+	fi
+}
+siglist="0 1 2 15"
+trap cleanup $siglist
 
-# create the workdir
-mkdir -p "$new_workdir/.git" || die "unable to create \"$new_workdir\"!"
+# create embedded directories
+for x in logs
+do
+	mkdir -p "$new_workdir/.git/$x" || failed
+done
 
 # create the links to the original repo.  explicitly exclude index, HEAD and
 # logs/HEAD from the list since they are purely related to the current working
 # directory, and should not be shared.
 for x in config refs logs/refs objects info hooks packed-refs remotes rr-cache svn
 do
-	case $x in
-	*/*)
-		mkdir -p "$(dirname "$new_workdir/.git/$x")"
-		;;
-	esac
-	ln -s "$git_dir/$x" "$new_workdir/.git/$x"
+	ln -s "$git_dir/$x" "$new_workdir/.git/$x" || failed
 done
 
 # now setup the workdir
-cd "$new_workdir"
+cd "$new_workdir" || failed
 # copy the HEAD from the original repository as a default branch
-cp "$git_dir/HEAD" .git/HEAD
+cp "$git_dir/HEAD" .git/HEAD || failed
+
+# don't delete the new workdir on exit
+trap - $siglist
+
 # checkout the branch (either the same as HEAD from the original repository, or
 # the one that was asked for)
 git checkout -f $branch
-- 
1.8.5.3
