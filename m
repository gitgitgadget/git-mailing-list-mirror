From: Dan Holmsand <holmsand@gmail.com>
Subject: [PATCH 3/6] Make showdate use "Linus format"
Date: Thu, 09 Jun 2005 13:19:30 +0200
Message-ID: <42A825C2.1060302@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020607060407060601030404"
Cc: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Jun 09 14:49:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgMCe-0007jt-Db
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 14:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbVFIMfg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 08:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbVFIMff
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 08:35:35 -0400
Received: from main.gmane.org ([80.91.229.2]:8909 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262355AbVFIMfE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 08:35:04 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DgLdZ-0001el-FQ
	for git@vger.kernel.org; Thu, 09 Jun 2005 13:55:53 +0200
Received: from 81-224-201-139-no45.tbcn.telia.com ([81.224.201.139])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jun 2005 13:55:53 +0200
Received: from holmsand by 81-224-201-139-no45.tbcn.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jun 2005 13:55:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 81-224-201-139-no45.tbcn.telia.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------020607060407060601030404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This makes showdate use the same date format as
git-rev-list --pretty, and gives some speedup. It might also
be more portable.

Note that this changes the calling convention: the previous
version used seconds from $1, but timezone from the global
variable $date. cg-mkpatch is modified to the new way.

Also fixes bash's belief that number literals starting with
zero are octal.

Signed-off-by: Dan Holmsand <holmsand@gmail.com>
---

--------------020607060407060601030404
Content-Type: text/plain;
 name="3-showdate.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="3-showdate.patch.txt"

 cg-Xlib    |   18 ++++++++----------
 cg-mkpatch |    2 +-
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/cg-Xlib b/cg-Xlib
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -60,19 +60,17 @@ stat () {
 }
 
 showdate () {
-	date="$1"
-	format="$2"
-	[ "$format" ] || format=-R
-	sec=${date[0]}; tz=${date[1]}
+	local secs=$1 tzhours=${2:0:3} tzmins=${2:0:1}${2:3} format=$3
+	# bash doesn't like leading zeros
+	[ "${tzhours:1:1}" = 0 ] && tzhours=${2:0:1}${2:2:1}
+	secs=$((secs + tzhours * 3600 + tzmins * 60))
 	if [ "$has_gnudate" ]; then
-	        dtz=${tz/+/}
-		lsec=$(($dtz / 100 * 3600 + $dtz % 100 * 60 + $sec))
-	        pdate="$(date -ud "1970-01-01 UTC + $lsec sec" "$format" 2>/dev/null)"
+		[ "$format" ] || format="+%a %b %-d %H:%M:%S %Y $2"
+		LANG=C date -ud "1970-01-01 UTC + $secs sec" "$format"
 	else
-		# FIXME: $format
-	        pdate="$(date -u -r ${date[0]} 2>/dev/null)"
+		[ "$format" ] || format="+%a %b %d %H:%M:%S %Y $2"
+		date -u -r $secs "$format"
 	fi
-	echo "${pdate/+0000/$tz}"
 }
 
 # Usage: tree_timewarp [--no-head-update] DIRECTION_STR ROLLBACK_BOOL BASE BRANCH
diff --git a/cg-mkpatch b/cg-mkpatch
--- a/cg-mkpatch
+++ b/cg-mkpatch
@@ -52,7 +52,7 @@ showpatch () {
 		case "$key" in
 		"author"|"committer")
 			date=(${rest#*> })
-			pdate="$(showdate $date)"
+			pdate="$(showdate ${date[*]})"
 			[ "$pdate" ] && rest="${rest%> *}> $pdate"
 			echo $key $rest >>$header
 			;;

--------------020607060407060601030404--

