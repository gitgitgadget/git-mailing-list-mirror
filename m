From: Dan Holmsand <holmsand@gmail.com>
Subject: [PATCH] Make cg-status report added/removed files correctly
Date: Mon, 30 May 2005 00:11:09 +0200
Message-ID: <d7deh7$sbk$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020600020409060305060609"
X-From: git-owner@vger.kernel.org Mon May 30 00:11:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcW0F-0003q7-PI
	for gcvg-git@gmane.org; Mon, 30 May 2005 00:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVE2WNs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 18:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbVE2WNs
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 18:13:48 -0400
Received: from main.gmane.org ([80.91.229.2]:2961 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261301AbVE2WNn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 18:13:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DcVzN-0003fD-38
	for git@vger.kernel.org; Mon, 30 May 2005 00:10:33 +0200
Received: from 213-64-177-7-o871.telia.com ([213.64.177.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 May 2005 00:10:33 +0200
Received: from holmsand by 213-64-177-7-o871.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 May 2005 00:10:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-64-177-7-o871.telia.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------020600020409060305060609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

cg-status presently only cares about the cache (by parsing the output of 
git-update-cache and git-ls-files), when it should look at the tree in HEAD.

This patch fixes this, by using git-diff-cache HEAD instead (using 
git-diff-files only to detect the difference between missing files and 
cg-rm'd ones).

It also uses the exclusion mechanism in git-ls-files, instead of parsing 
git-ls-files output, and adds '*~' and '#*' to the list of patterns 
excluded by default.

Signed-off-by: Dan Holmsand <holmsand@gmail.com>

--------------020600020409060305060609
Content-Type: text/plain;
 name="cg-status.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cg-status.patch.txt"

diff --git a/cg-status b/cg-status
--- a/cg-status
+++ b/cg-status
@@ -7,33 +7,24 @@
 
 . ${COGITO_LIB}cg-Xlib
 
+[ 0 -eq $# ] || die "no arguments allowed"
+
 EXCLUDEFILE=$_git/exclude
 EXCLUDE=
 if [ -f $EXCLUDEFILE ]; then
 	EXCLUDE="--exclude-from=$EXCLUDEFILE"
 fi
 
-{
-	git-ls-files -z -t --others --deleted --unmerged $EXCLUDE
-} | sort -z -k 2 | xargs -0 sh -c '
-while [ "$1" ]; do
-	tag=${1% *};
-	filename=${1#* };
-	case "$filename" in
-	*.[ao] | tags | ,,merge*) ;;
-	*)   echo "$tag $filename";;
-	esac
-	shift
-done
-' padding
+git-update-cache --refresh > /dev/null
+
+git-ls-files --others --exclude='*.[ao]' --exclude='.*' --exclude=tags \
+	--exclude='*~' --exclude='#*' \
+	--exclude=',,merge*' $EXCLUDE | sed 's,^,? ,'
 
-{
-	git-update-cache --refresh
-} | cut -f 1 -d ":" | xargs sh -c '
-while [ "$1" ]; do
-	tag="M";
-	filename=${1%: *};
-	echo "$tag $filename";
-	shift
+git-diff-cache HEAD | cut -f5- -d' ' | 
+while IFS=$'\t' read -r mode file; do
+	if [ "$mode" = D ]; then
+		[ "$(git-diff-files "$file")" ] && mode=!
+	fi
+	echo "$mode $file"
 done
-' padding

--------------020600020409060305060609--

