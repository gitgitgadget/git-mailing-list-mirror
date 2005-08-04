From: James Ketrenos <jketreno@linux.intel.com>
Subject: [PATCH] interactive merge in cg-Xmergefile for cogito-0.12.1
Date: Thu, 04 Aug 2005 14:32:42 -0500
Message-ID: <42F26D5A.7010602@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060508060306000600060807"
X-From: git-owner@vger.kernel.org Thu Aug 04 21:34:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0lSn-00021k-Vj
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 21:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbVHDTcx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 15:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbVHDTcx
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 15:32:53 -0400
Received: from fmr20.intel.com ([134.134.136.19]:16512 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S262642AbVHDTct (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2005 15:32:49 -0400
Received: from orsfmr100.jf.intel.com (orsfmr100.jf.intel.com [10.7.209.16])
	by orsfmr005.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j74JWkN8019003
	for <git@vger.kernel.org>; Thu, 4 Aug 2005 19:32:46 GMT
Received: from [192.168.1.154] (logicsbox.jf.intel.com [134.134.16.142])
	by orsfmr100.jf.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j74JWgCW010671
	for <git@vger.kernel.org>; Thu, 4 Aug 2005 19:32:45 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050725
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------060508060306000600060807
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I use the attached patch here and its helped me quite a bit.  Thought
I'd send it out for others to use as well.  Prior to 0.12 I could do
this in my own scripts after a cg-merge exited with conflicts.  Resently
it seems 'git-ls-files --unmerged' will no longer list any files that
had conflicts during the merge.

So, this patch modifies cg-Xmergefile to interactively prompt you with
what to do in the event of a merge conflict.  It is set up to work
reasonably well with kdiff3 as is.

If it or a variant gets sucked into cogito -- great.  If there is
already a way to kick off a merge conflict resolution program while
cg-merge is running, please let me know.

Thanks,
James


--------------060508060306000600060807
Content-Type: text/plain;
 name="cg-Xmergefile.diffstat"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cg-Xmergefile.diffstat"

 cg-Xmergefile |   48 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 46 insertions(+), 2 deletions(-)

--------------060508060306000600060807
Content-Type: text/x-patch;
 name="cg-Xmergefile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cg-Xmergefile.patch"

diff -Nup a/cg-Xmergefile b/cg-Xmergefile
--- a/cg-Xmergefile	2005-08-04 14:20:38.000000000 -0500
+++ b/cg-Xmergefile	2005-08-04 15:20:01.000000000 -0500
@@ -35,6 +35,49 @@ warning () {
 }
 
 
+interactive_threeway() {
+	[ -z "$MERGE" ] && MERGE="kdiff3 -o"
+	dir=$(dirname $4)
+	[ ! -d $dir ] && mkdir -p $dir
+	cmd="$MERGE \"$4\" \"$4.base\" \"$4.parent\" \"$4.child\""
+	while true; do
+		echo "Do you wish to:"
+		echo -e "1. Invoke MERGE via:\n"\
+"$MERGE \"$4\" \"$4.base\" \"$4.parent\" \"$4.child\""
+		echo "2. restore from base"
+		echo "3. restore from parent"
+		echo "4. restore from child"
+		echo "5. commit changes and return"
+		echo "6. view file on disk"
+		echo "0. abort"
+		read -p "[1-6,0] : " reply <&1
+		case $reply in
+		1)	git-cat-file blob $1 > $4.base
+			git-cat-file blob $2 > $4.parent
+			git-cat-file blob $3 > $4.child
+			$MERGE "$4" "$4.base" "$4.parent" "$4.child"
+			;;
+		2)	git-cat-file blob "$1" > "$4"
+			echo "Restored $4 from base"
+			;;
+		3)	git-cat-file blob "$2" > "$4"
+			echo "Restored $4 from parent"
+			;;
+		4)	git-cat-file blob "$3" > "$4"
+			echo "Restored $4 from child"
+			;;
+		5)	git-update-cache -- $4 || return 1
+			return 0
+			;;
+		6)	[ ! -e "$4" ] && git-checkout-cache -q -f -u -- "$4"
+			less "$4"
+			;;
+		0)	return 1
+			;;
+		esac
+	done
+}
+
 case "${1:-.}${2:-.}${3:-.}" in
 #
 # Deleted in both or deleted in one and unchanged in the other
@@ -95,8 +138,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 	if [ $ret -ne 0 ]; then
 		# The user already gets the warning from merge itself and
 		# from merge-cache too. This is too much.
-		#error "Auto-merge failed"
-		exit 1
+		interactive_threeway $1 $2 $3 $4 || exit 1
 	fi
 	exec git-update-cache -- "$4"
 	;;
@@ -106,3 +148,5 @@ case "${1:-.}${2:-.}${3:-.}" in
 	;;
 esac
 exit 1
+
+

--------------060508060306000600060807--
