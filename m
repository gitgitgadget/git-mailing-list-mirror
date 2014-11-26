From: Paul Smith <paul@mad-scientist.net>
Subject: [PATCH v4] git-new-workdir: Don't fail if the target directory is
 empty
Date: Wed, 26 Nov 2014 15:38:28 -0500
Organization: GNU's Not UNIX!
Message-ID: <1417034308.23650.51.camel@homebase>
Reply-To: paul@mad-scientist.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 26 21:45:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtjSd-0004xT-D2
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 21:45:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbaKZUpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 15:45:09 -0500
Received: from qproxy5-pub.mail.unifiedlayer.com ([69.89.21.30]:52251 "HELO
	qproxy5-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750888AbaKZUpI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Nov 2014 15:45:08 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Nov 2014 15:45:08 EST
Received: (qmail 17070 invoked by uid 0); 26 Nov 2014 20:38:28 -0000
Received: from unknown (HELO cmgw4) (10.0.90.85)
  by qproxy5.bluehost.com with SMTP; 26 Nov 2014 20:38:28 -0000
Received: from box531.bluehost.com ([74.220.219.131])
	by cmgw4 with 
	id LLeR1p0122qhmhE01LeU1w; Wed, 26 Nov 2014 13:38:28 -0700
X-Authority-Analysis: v=2.1 cv=B+wqjodM c=1 sm=1 tr=0
 a=GcR8MKwCKDX7fzHfRD/fNg==:117 a=GcR8MKwCKDX7fzHfRD/fNg==:17 a=cNaOj0WVAAAA:8
 a=f5113yIGAAAA:8 a=IkcTkHD0fZMA:10 a=pBbsfl06AAAA:8 a=cdVwids0oJMA:10
 a=qenwzdlAJUAA:10 a=5y4faFyK3SkA:10 a=pbtBwwV6W54KHSXUWokA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mad-scientist.net; s=default;
	h=Content-Transfer-Encoding:Mime-Version:Content-Type:Date:To:Reply-To:From:Subject:Message-ID; bh=2o3SOyotgMzdWlle8OISKzHiVAF/QWqzsOStKyyC06A=;
	b=e1hfg5qWs6lPwK492SRNTXQ28TR3u2kE5kkQARoLx8a1Uciv2LidgTTqZKtRaOyiWS5SYXBmm39vpvCQezMqFe24jwVw58Voa8GMtGH2Euu+ghpnf0vamMNt7CpmTP7/;
Received: from [72.74.248.26] (port=39024 helo=homebase.home)
	by box531.bluehost.com with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
	(Exim 4.82)
	(envelope-from <paul@mad-scientist.net>)
	id 1XtjM1-0001cB-HH
	for git@vger.kernel.org; Wed, 26 Nov 2014 13:38:25 -0700
X-Mailer: Evolution 3.11.3-fta1~13.10 
X-Identified-User: {678:box531.bluehost.com:madscie1:mad-scientist.us} {sentby:smtp auth 72.74.248.26 authed with paul@mad-scientist.us}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260302>

Allow new workdirs to be created in an empty directory (similar to "git
clone").  Provide more error checking and clean up on failure.

Signed-off-by: Paul Smith <paul@mad-scientist.net>
---

Hopefully this doesn't contain unwanted stylistic changes.  There's a
kind of gross thing about the behavior here: because we cd much earlier
than in my previous version we could actually trap and "rm -rf" while
our current working directory is inside the removed location (inside
$cleandir).  On a traditional UNIX filesystem this is fine, of course,
but it's possible that some filesystems don't like this in some way.  In
Windows for example this will definitely fail (but new-workdir doesn't
support Windows anyway).  The only options are (a) don't worry about it
(that's what this patch does), (b) put the "cd" after the trap reset
again, (c) move the trap reset earlier and don't clean up if we get
failures after we "cd", or (d) "cd" again inside the cleanup function.
Of these, (d) is the most complex and hence my least favorite.

 contrib/workdir/git-new-workdir | 53 +++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
index 75e8b25..d1d7f32 100755
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
@@ -48,35 +52,54 @@ then
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
+	if test $(ls -a1 "$new_workdir/." | wc -l) -ne 2
+	then
+		die "destination directory '$new_workdir' is not empty."
+	fi
+	cleandir="$new_workdir/.git"
+else
+	cleandir="$new_workdir"
 fi
 
-# make sure the links use full paths
-git_dir=$(cd "$git_dir"; pwd)
+mkdir -p "$new_workdir/.git" || failed
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
+	# create a containing directory if needed
 	case $x in
 	*/*)
-		mkdir -p "$(dirname "$new_workdir/.git/$x")"
+		mkdir -p "$new_workdir/.git/${x%/*}"
 		;;
 	esac
-	ln -s "$git_dir/$x" "$new_workdir/.git/$x"
+
+	ln -s "$git_dir/$x" "$new_workdir/.git/$x" || failed
 done
 
-# now setup the workdir
-cd "$new_workdir"
+# commands below this are run in the context of the new workdir
+cd "$new_workdir" || failed
+
 # copy the HEAD from the original repository as a default branch
-cp "$git_dir/HEAD" .git/HEAD
-# checkout the branch (either the same as HEAD from the original repository, or
-# the one that was asked for)
+cp "$git_dir/HEAD" .git/HEAD || failed
+
+# the workdir is set up.  if the checkout fails, the user can fix it.
+trap - $siglist
+
+# checkout the branch (either the same as HEAD from the original repository,
+# or the one that was asked for)
 git checkout -f $branch
-- 
1.8.5.3
