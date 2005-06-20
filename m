From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: 'git commit' duplicates parents?
Date: Mon, 20 Jun 2005 20:52:38 +0200
Message-ID: <42B71076.1050904@gmail.com>
References: <42B59CF7.3080509@pobox.com> <Pine.LNX.4.58.0506191921270.2268@ppc970.osdl.org> <Pine.LNX.4.58.0506191926530.2268@ppc970.osdl.org> <42B62C85.10701@pobox.com> <Pine.LNX.4.58.0506191958010.2268@ppc970.osdl.org> <42B690EA.2080605@gmail.com> <Pine.LNX.4.58.0506200808090.2268@ppc970.osdl.org> <42B6FAE5.6060904@gmail.com> <Pine.LNX.4.58.0506201040140.2268@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030106080403050101060205"
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 20 20:48:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkRJp-0007gm-9I
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 20:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVFTSxy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Jun 2005 14:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVFTSxy
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jun 2005 14:53:54 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:53826 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261452AbVFTSwq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jun 2005 14:52:46 -0400
Received: by zproxy.gmail.com with SMTP id 13so893392nzn
        for <git@vger.kernel.org>; Mon, 20 Jun 2005 11:52:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=IAWJdc1Lh+HQSJfG5V9zC2HW+OI7XDVDqvATwvsL555eZCGZ7k+qOM+YxGLRSywhaepoWcJ3/NoKJD/60Am6QEiJOhvQji7n5OqPQqbp5/4xKl+3ayXVy+0DbkqSvTzc1ruas/kQ+wIFV3CyI96yfckBeW4z2tB3vEDwdP3Fv6U=
Received: by 10.36.133.7 with SMTP id g7mr3365476nzd;
        Mon, 20 Jun 2005 11:52:42 -0700 (PDT)
Received: from ?10.0.1.4? ([80.217.78.97])
        by mx.gmail.com with ESMTP id 24sm1681909nzn.2005.06.20.11.52.41;
        Mon, 20 Jun 2005 11:52:42 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506201040140.2268@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------030106080403050101060205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> [ Side note: I should make "git-resolve-script" run "git-rev-parse" on its
>   arguments, so that it would expand HEAD and MERGE_HEAD on its own. Maybe 
>   somebody who is interested in this script might want to do that? Hint 
>   hint. ]

Got it. Included below.

> Note how we could make both of us happy by saving that temporary 
> MERGE_HEAD information somewhere _else_ instead. Maybe the answer is to 
> only use "MERGE_HEAD" for the "merge manually" case, and use something 
> else for the "this was the merge you tried to do last" case?

I like the "everybody happy" idea...

How about "LAST_MERGE"? And something like this?

/dan

---

[PATCH] git-resolve-script: Add LAST_MERGE and use git-rev-parse

Make git-resolve-script only write MERGE_HEAD if a merge actually
occurred. All merge failures leave ORIG_HEAD and LAST_MERGE
behind (instead of ORIG_HEAD and MERGE_HEAD).

Use git-rev-parse to expand arguments (and check for bad ones).

Signed-off-by: Dan Holmsand <holmsand@gmail.com>

--------------030106080403050101060205
Content-Type: text/plain;
 name="git-resolve-script.patch2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-resolve-script.patch2.txt"

diff --git a/git-resolve-script b/git-resolve-script
--- a/git-resolve-script
+++ b/git-resolve-script
@@ -4,26 +4,31 @@
 #
 # Resolve two trees.
 #
-head="$1"
-merge="$2"
+head=$(git-rev-parse --revs-only "$1")
+merge=$(git-rev-parse --revs-only "$2")
 merge_repo="$3"
 
 : ${GIT_DIR=.git}
 : ${GIT_OBJECT_DIRECTORY="${SHA1_FILE_DIRECTORY-"$GIT_DIR/objects"}"}
 
-rm -f "$GIT_DIR"/MERGE_HEAD "$GIT_DIR"/ORIG_HEAD
-echo $head > "$GIT_DIR"/ORIG_HEAD
-echo $merge > "$GIT_DIR"/MERGE_HEAD
+dropheads() {
+	rm -f -- "$GIT_DIR/ORIG_HEAD" "$GIT_DIR/MERGE_HEAD" \
+		"$GIT_DIR/LAST_MERGE" || exit 1
+}
 
 #
 # The remote name is just used for the message,
 # but we do want it.
 #
-if [ "$merge_repo" == "" ]; then
+if [ -z "$head" -o -z "$merge" -o -z "$merge_repo" ]; then
 	echo "git-resolve-script <head> <remote> <merge-repo-name>"
 	exit 1
 fi
 
+dropheads
+echo $head > "$GIT_DIR"/ORIG_HEAD
+echo $merge > "$GIT_DIR"/LAST_MERGE
+
 common=$(git-merge-base $head $merge)
 if [ -z "$common" ]; then
 	echo "Unable to find common commit between" $merge $head
@@ -32,7 +37,7 @@ fi
 
 if [ "$common" == "$merge" ]; then
 	echo "Already up-to-date. Yeeah!"
-	rm -f -- "$GIT_DIR/ORIG_HEAD" "$GIT_DIR/MERGE_HEAD"
+	dropheads
 	exit 0
 fi
 if [ "$common" == "$head" ]; then
@@ -40,7 +45,7 @@ if [ "$common" == "$head" ]; then
 	git-read-tree -u -m $head $merge || exit 1
 	echo $merge > "$GIT_DIR"/HEAD
 	git-diff-tree -p ORIG_HEAD HEAD | git-apply --stat
-	rm -f -- "$GIT_DIR/ORIG_HEAD" "$GIT_DIR/MERGE_HEAD"
+	dropheads
 	exit 0
 fi
 echo "Trying to merge $merge into $head"
@@ -51,6 +56,7 @@ if [ $? -ne 0 ]; then
 	echo "Simple merge failed, trying Automatic merge"
 	git-merge-cache -o git-merge-one-file-script -a
 	if [ $? -ne 0 ]; then
+		echo $merge > "$GIT_DIR"/MERGE_HEAD
 		echo "Automatic merge failed, fix up by hand"
 		exit 1
 	fi
@@ -60,4 +66,4 @@ result_commit=$(echo "$merge_msg" | git-
 echo "Committed merge $result_commit"
 echo $result_commit > "$GIT_DIR"/HEAD
 git-diff-tree -p $head $result_commit | git-apply --stat
-rm -f -- "$GIT_DIR/ORIG_HEAD" "$GIT_DIR/MERGE_HEAD"
+dropheads

--------------030106080403050101060205--
