From: Paul Smith <paul@mad-scientist.net>
Subject: [PATCH] git-new-workdir: Don't fail if the target directory is empty
Date: Thu, 20 Nov 2014 10:46:35 -0500
Message-ID: <1416498395.23953.8.camel@mad-scientist.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 20 16:53:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrU37-0005HM-4Y
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 16:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757488AbaKTPxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 10:53:31 -0500
Received: from gproxy4-pub.mail.unifiedlayer.com ([69.89.23.142]:45418 "HELO
	gproxy4-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757481AbaKTPx3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Nov 2014 10:53:29 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Nov 2014 10:53:29 EST
Received: (qmail 1458 invoked by uid 0); 20 Nov 2014 15:46:48 -0000
Received: from unknown (HELO cmgw3) (10.0.90.84)
  by gproxy4.mail.unifiedlayer.com with SMTP; 20 Nov 2014 15:46:48 -0000
Received: from box531.bluehost.com ([74.220.219.131])
	by cmgw3 with 
	id Hrmj1p00t2qhmhE01rmmrP; Thu, 20 Nov 2014 08:46:48 -0700
X-Authority-Analysis: v=2.1 cv=W++rC3mk c=1 sm=1 tr=0
 a=GcR8MKwCKDX7fzHfRD/fNg==:117 a=GcR8MKwCKDX7fzHfRD/fNg==:17 a=cNaOj0WVAAAA:8
 a=f5113yIGAAAA:8 a=IkcTkHD0fZMA:10 a=pBbsfl06AAAA:8 a=cdVwids0oJMA:10
 a=2NV5t7OSZ7cA:10 a=5y4faFyK3SkA:10 a=V6TWb17wjVuPg6hANYEA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mad-scientist.net; s=default;
	h=Content-Transfer-Encoding:Mime-Version:Content-Type:Date:To:From:Subject:Message-ID; bh=aSaNEcrrD88zMPfGG/GwbEBwYdcRbfARWSWVQlVbF6s=;
	b=nsJAoBszfjxnq0XZ7SBNMEY+xurhrjcM2UzrNQI2zaGJe//fCNBue2NSr+4WLnZo5jeEsHMAydn/9aVIGHKoXpwYaoq2WG9c415iU7CnBuSIFoMkGjMDJipfyErVTs7q;
Received: from [173.9.45.73] (port=50446 helo=pdsdesk)
	by box531.bluehost.com with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.82)
	(envelope-from <paul@mad-scientist.net>)
	id 1XrTwR-0004dd-4l
	for git@vger.kernel.org; Thu, 20 Nov 2014 08:46:43 -0700
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
 contrib/workdir/git-new-workdir | 54 +++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
index 75e8b25..7334720 100755
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
@@ -35,7 +39,7 @@ esac
 
 # don't link to a configured bare repository
 isbare=$(git --git-dir="$git_dir" config --bool --get core.bare)
-if test ztrue = z$isbare
+if test ztrue = "z$isbare"
 then
 	die "\"$git_dir\" has core.bare set to true," \
 		" remove from \"$git_dir/config\" to use $0"
@@ -48,35 +52,49 @@ then
 		"a complete repository."
 fi
 
-# don't recreate a workdir over an existing repository
-if test -e "$new_workdir"
+# make sure the links in the workdir have full paths to the original repo
+git_dir=$(cd "$git_dir" && pwd) || exit 1
+
+# don't recreate a workdir over an existing directory, unless it's empty
+if test -d "$new_workdir"
 then
-	die "destination directory '$new_workdir' already exists."
+	if test $(ls -a1 "$new_workdir"/. | wc -l) -ne 2
+	then
+		die "destination directory '$new_workdir' is not empty."
+	fi
+	cleandir="$new_workdir"/.git
+else
+	cleandir="$new_workdir"
 fi
 
-# make sure the links use full paths
-git_dir=$(cd "$git_dir"; pwd)
+mkdir -p "$new_workdir"/.git || failed
+cleandir=$(cd "$cleandir" && pwd) || failed
 
-# create the workdir
-mkdir -p "$new_workdir/.git" || die "unable to create \"$new_workdir\"!"
+cleanup () {
+	rm -rf "$cleandir"
+}
+siglist="0 1 2 15"
+trap cleanup $siglist
 
 # create the links to the original repo.  explicitly exclude index, HEAD and
 # logs/HEAD from the list since they are purely related to the current working
 # directory, and should not be shared.
 for x in config refs logs/refs objects info hooks packed-refs remotes rr-cache svn
 do
+	# Create a containing directory if needed
 	case $x in
-	*/*)
-		mkdir -p "$(dirname "$new_workdir/.git/$x")"
-		;;
+		*/*) mkdir -p "$new_workdir/.git/${x%/*}" ;;
 	esac
-	ln -s "$git_dir/$x" "$new_workdir/.git/$x"
+
+	ln -s "$git_dir/$x" "$new_workdir/.git/$x" || failed
 done
 
-# now setup the workdir
-cd "$new_workdir"
 # copy the HEAD from the original repository as a default branch
-cp "$git_dir/HEAD" .git/HEAD
-# checkout the branch (either the same as HEAD from the original repository, or
-# the one that was asked for)
-git checkout -f $branch
+cp "$git_dir"/HEAD "$new_workdir"/.git/HEAD || failed
+
+# the workdir is set up.  if the checkout fails, the user can fix it.
+trap - $siglist
+
+# checkout the branch (either the same as HEAD from the original repository,
+# or the one that was asked for)
+git -C "$new_workdir" checkout -f $branch
-- 
1.8.5.3
