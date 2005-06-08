From: Junio C Hamano <junkio@cox.net>
Subject: Re: Handling merge conflicts a bit more gracefully..
Date: Wed, 08 Jun 2005 16:07:47 -0700
Message-ID: <7vis0o30sc.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0506081336080.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 01:07:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg9bf-0002Xq-TJ
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 01:05:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVFHXJB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 19:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVFHXJB
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 19:09:01 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:57848 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261450AbVFHXHz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2005 19:07:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050608230748.SQFN1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Jun 2005 19:07:48 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506081336080.2286@ppc970.osdl.org> (Linus
 Torvalds's message of "Wed, 8 Jun 2005 13:55:23 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> What happens now in the case of a merge conflict is:
LT>  - the merge is obviously not committed
LT>  - we do all the successful merges, and update the index file for them
LT>  - for the files that conflict, we force the index to contain the old
LT>    version of the file (ie we remove the merge from the index), and we
LT>    write the (failed) output of the merge into the working directory, and
LT>    we complain loudly:

LT> Comments? It would be good to have people test this and maybe even write a 
LT> few automated tests that it all works as expected..

OK, I'll bite.  Other than some minor details, the work tree
seems to be updated with the result of the merge, either
successful one or failed one.

2a68a8659f7dc55fd285d235ae2d19e7a8116c30 \
(from f9e7750621ca5e067f58a679caff5ff2f9881c4c)
diff --git a/git-merge-one-file-script b/git-merge-one-file-script
--- a/git-merge-one-file-script
+++ b/git-merge-one-file-script
@@ -19,22 +19,25 @@ case "${1:-.}${2:-.}${3:-.}" in
 # Deleted in both.
 #
 "$1..")
-	echo "ERROR: $4 is removed in both branches."
-	echo "ERROR: This is a potential rename conflict."
-	exit 1;;
+	echo "WARNING: $4 is removed in both branches."
+	echo "WARNING: This is a potential rename conflict."
+	exec git-update-cache --remove -- "$4" ;;

Making sure that the path does not exist in the work tree with
test -f "$4" would be more sensible, before running --remove.

 #
 # Deleted in one and unchanged in the other.
 #
 "$1.." | "$1.$1" | "$1$1.")
 	echo "Removing $4"
-	exec git-update-cache --force-remove "$4" ;;
+	rm -f -- "$4"
+	exec git-update-cache --remove -- "$4" ;;

Make sure "$4" is not a directory, perhaps?  At least barf if
that 'rm -f -- "$4"' fails?

 #
 # Modified in both, but differently.
 #

@@ -55,19 +60,21 @@ case "${1:-.}${2:-.}${3:-.}" in
 	orig=`git-unpack-file $1`
 	src1=`git-unpack-file $2`
 	src2=`git-unpack-file $3`
-	merge "$src2" "$orig" "$src1"
+	merge -p "$src1" "$orig" "$src2" > "$4"
 	ret=$?
+	rm -f -- "$orig" "$src1" "$src2"
 	if [ "$6" != "$7" ]; then
 		echo "ERROR: Permissions $5->$6->$7 don't match."
+		ret=1
 	fi
 	if [ $ret -ne 0 ]; then
-		echo "ERROR: Leaving conflict merge in $src2."
+		# Reset the index to the first branch, making
+		# git-diff-file useful
+		git-update-cache --add --cacheinfo "$6" "$2" "$4"
+		echo "ERROR: Merge conflict in $4."
 		exit 1
 	fi
-	sha1=`git-write-blob "$src2"` || {
-		echo "ERROR: Leaving conflict merge in $src2."
-	}
-	exec git-update-cache --add --cacheinfo "$6" $sha1 "$4" ;;
+	exec git-update-cache --add -- "$4" ;;
 *)
 	echo "ERROR: Not handling case $4: $1 -> $2 -> $3" ;;
 esac

Again, make sure "$4" is not a directory before redirecting into
it from merge, so that you can tell merge failures from it?

