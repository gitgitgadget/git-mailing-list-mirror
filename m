From: Paul Smith <paul@mad-scientist.net>
Subject: [PATCH] git-new-workdir: Don't fail if the target directory is empty
Date: Tue, 18 Nov 2014 14:36:48 -0500
Message-ID: <1416339408.3899.22.camel@mad-scientist.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 18 20:43:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqogs-0008Qf-Bo
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 20:43:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755833AbaKRTnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 14:43:41 -0500
Received: from qproxy4-pub.mail.unifiedlayer.com ([66.147.248.250]:56713 "HELO
	qproxy4-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755824AbaKRTnj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Nov 2014 14:43:39 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Nov 2014 14:43:39 EST
Received: (qmail 6171 invoked by uid 0); 18 Nov 2014 19:36:59 -0000
Received: from unknown (HELO cmgw3) (10.0.90.84)
  by qproxy4.mail.unifiedlayer.com with SMTP; 18 Nov 2014 19:36:59 -0000
Received: from box531.bluehost.com ([74.220.219.131])
	by cmgw3 with 
	id H7cw1p00X2qhmhE017czCm; Tue, 18 Nov 2014 12:36:59 -0700
X-Authority-Analysis: v=2.1 cv=W++rC3mk c=1 sm=1 tr=0
 a=GcR8MKwCKDX7fzHfRD/fNg==:117 a=GcR8MKwCKDX7fzHfRD/fNg==:17 a=cNaOj0WVAAAA:8
 a=f5113yIGAAAA:8 a=IkcTkHD0fZMA:10 a=pBbsfl06AAAA:8 a=cdVwids0oJMA:10
 a=2NV5t7OSZ7cA:10 a=5y4faFyK3SkA:10 a=V6TWb17wjVuPg6hANYEA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mad-scientist.net; s=default;
	h=Content-Transfer-Encoding:Mime-Version:Content-Type:Date:To:From:Subject:Message-ID; bh=BhdwcyvjAOxGOCa1kCY92TK5YmV3gBjoQ/+buGoIkEw=;
	b=OuPRhN+1XThty2kYWhsnoj5ezknsbaXSakmsLwa1KEeIfAAwdHaRe9EJim3QPqRl4x2X1mXspZ8YhOJPgU/3YL+cSKyF/wvrez+kAaKOTu/9QojVuxc82eqOXxRIT7eJ;
Received: from [173.9.45.73] (port=34993 helo=pdsdesk)
	by box531.bluehost.com with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.82)
	(envelope-from <paul@mad-scientist.net>)
	id 1Xqoa7-00031Y-Vg
	for git@vger.kernel.org; Tue, 18 Nov 2014 12:36:56 -0700
X-Mailer: Evolution 3.12.7-0ubuntu1 
X-Identified-User: {678:box531.bluehost.com:madscie1:mad-scientist.us} {sentby:smtp auth 173.9.45.73 authed with paul@mad-scientist.us}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow new workdirs to be created in an empty directory (similar to "git
clone").  Provide more error checking and clean up on failure.

Signed-off-by: Paul Smith <paul@mad-scientist.net>
---

Getting rid of ls/wc was not as simple as I'd hoped, due to glob
pathname expansion (can't rely on nullglob e.g.)  If you want this let
me know; it will require some yucky code to do the whole thing in native
shell.  Since new-workdir only works on systems with "ln -s" I think we
can feel confident requiring "ls" and "wc" as well.

 contrib/workdir/git-new-workdir | 55 +++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
index 75e8b25..aef632d 100755
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
@@ -48,35 +52,48 @@ then
 		"a complete repository."
 fi
 
-# don't recreate a workdir over an existing repository
-if test -e "$new_workdir"
+# make sure the links in the workdir have full paths to the original repo
+git_dir=$(cd "$git_dir"; pwd)
+
+# don't recreate a workdir over an existing directory, unless it's empty
+if test -d "$new_workdir"
 then
-	die "destination directory '$new_workdir' already exists."
+	if test $(ls -a1 "$new_workdir/." | wc -l) -ne 2
+	then
+		die "destination directory '$new_workdir' is not empty."
+	fi
+	cleandir="$new_workdir"/.git
+else
+	mkdir -p "$new_workdir" || failed
+	cleandir="$new_workdir"
 fi
 
-# make sure the links use full paths
-git_dir=$(cd "$git_dir"; pwd)
+cleanup () {
+	rm -rf "$cleandir"
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
 
-# now setup the workdir
-cd "$new_workdir"
 # copy the HEAD from the original repository as a default branch
-cp "$git_dir/HEAD" .git/HEAD
-# checkout the branch (either the same as HEAD from the original repository, or
-# the one that was asked for)
-git checkout -f $branch
+cp "$git_dir/HEAD" "$new_workdir"/.git/HEAD || failed
+
+# the workdir is set up.  if the checkout fails, the user can fix it.
+trap - $siglist
+
+# checkout the branch (either the same as HEAD from the original repository,
+# or the one that was asked for)
+git --git-dir="$new_workdir"/.git --work-tree="$new_workdir" checkout -f $branch
-- 
1.8.5.3
