From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to resolve git-am conflict (possible bug)
Date: Sat, 12 Aug 2006 12:49:38 -0700
Message-ID: <7vzme9oht9.fsf@assigned-by-dhcp.cox.net>
References: <ebj7er$64j$1@sea.gmane.org>
	<7vslk2rbq8.fsf@assigned-by-dhcp.cox.net> <ebk5tf$31k$1@sea.gmane.org>
	<ebk6be$31k$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 12 21:49:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBzUM-000125-Ut
	for gcvg-git@gmane.org; Sat, 12 Aug 2006 21:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbWHLTtk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Aug 2006 15:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030275AbWHLTtk
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Aug 2006 15:49:40 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:16290 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1030273AbWHLTtj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Aug 2006 15:49:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060812194939.PRLD554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 12 Aug 2006 15:49:39 -0400
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25264>

Jakub Narebski <jnareb@gmail.com> writes:

> Jakub Narebski wrote:
>
>> Junio C Hamano wrote:
> [...] 
>>> More likely explanation is that you edited the patch by hand for
>>> some reason, and made it inapplicable to the base blob the
>>> "index" line records.
>
> Original (not edited) version of patch generates nice merge conflict.

The moral of the story is that either (1) you hand edit the
patch to apply cleanly to the target, or (2) if you do edit, do
not make it inapplicable to the preimage blob recorded in the
patch, so that -3 still would work.

>> It would be nice then if git-am was more verbose, for example
>> "Applying patch to blob 7ea52b1... gitweb/gitweb.perl" or something
>> like that.
>
> Or at least some information what git-am is attempting before second 
> 'patch failed' error message...

How about this?

diff --git a/git-am.sh b/git-am.sh
index 04f0119..aff4bb7 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -45,6 +45,12 @@ go_next () {
 	this=$next
 }
 
+cannot_fallback () {
+	echo >&2 "$1"
+	echo >&2 "Cannot fall back to three-way merge."
+	exit 1
+}
+
 fall_back_3way () {
     O_OBJECT=`cd "$GIT_OBJECT_DIRECTORY" && pwd`
 
@@ -52,19 +58,23 @@ fall_back_3way () {
     mkdir "$dotest/patch-merge-tmp-dir"
 
     # First see if the patch records the index info that we can use.
-    if git-apply -z --index-info "$dotest/patch" \
-	>"$dotest/patch-merge-index-info" 2>/dev/null &&
-	GIT_INDEX_FILE="$dotest/patch-merge-tmp-index" \
-	git-update-index -z --index-info <"$dotest/patch-merge-index-info" &&
-	GIT_INDEX_FILE="$dotest/patch-merge-tmp-index" \
-	git-write-tree >"$dotest/patch-merge-base+" &&
-	# index has the base tree now.
-	GIT_INDEX_FILE="$dotest/patch-merge-tmp-index" \
+    git-apply -z --index-info "$dotest/patch" \
+    	>"$dotest/patch-merge-index-info" &&
+    GIT_INDEX_FILE="$dotest/patch-merge-tmp-index" \
+    git-update-index -z --index-info <"$dotest/patch-merge-index-info" &&
+    GIT_INDEX_FILE="$dotest/patch-merge-tmp-index" \
+    git-write-tree >"$dotest/patch-merge-base+" ||
+    cannot_fallback "Patch does not record usable index information."
+
+    echo Using index info to reconstruct a base tree...
+    if GIT_INDEX_FILE="$dotest/patch-merge-tmp-index" \
 	git-apply $binary --cached <"$dotest/patch"
     then
-	echo Using index info to reconstruct a base tree...
 	mv "$dotest/patch-merge-base+" "$dotest/patch-merge-base"
 	mv "$dotest/patch-merge-tmp-index" "$dotest/patch-merge-index"
+    else
+        cannot_fallback "Did you hand edit your patch?
+It does not apply to blobs recorded in its index."
     fi
 
     test -f "$dotest/patch-merge-index" &&
