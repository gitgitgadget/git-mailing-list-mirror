From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: 'git commit' duplicates parents?
Date: Mon, 20 Jun 2005 11:48:26 +0200
Message-ID: <42B690EA.2080605@gmail.com>
References: <42B59CF7.3080509@pobox.com> <Pine.LNX.4.58.0506191921270.2268@ppc970.osdl.org> <Pine.LNX.4.58.0506191926530.2268@ppc970.osdl.org> <42B62C85.10701@pobox.com> <Pine.LNX.4.58.0506191958010.2268@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010605060901000101000806"
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 20 11:43:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkIo9-0002DK-8Q
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 11:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVFTJso (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Jun 2005 05:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVFTJso
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jun 2005 05:48:44 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:43675 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261301AbVFTJs3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jun 2005 05:48:29 -0400
Received: by rproxy.gmail.com with SMTP id r35so837518rna
        for <git@vger.kernel.org>; Mon, 20 Jun 2005 02:48:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=QX6ZMYQc6LpV4jOgau4WHQvg9FcYtB6h50snMeDgrrisVI4Ob7FcRuEZYq8VkzqPfJ2mKGn1BpJ9OIqCkiEWybtZm8Sy7GdYCa/wrqjmBHPHX3P6CROISl7fRsz5kjMl0Ke8qF4KguTbycGm4xl5/b0ff3d82yiV6hVuU7TXv34=
Received: by 10.38.90.78 with SMTP id n78mr1863302rnb;
        Mon, 20 Jun 2005 02:48:29 -0700 (PDT)
Received: from ?192.168.0.4? ([80.217.52.214])
        by mx.gmail.com with ESMTP id c3sm3693233rne.2005.06.20.02.48.28;
        Mon, 20 Jun 2005 02:48:29 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506191958010.2268@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------010605060901000101000806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> Keep the complaints coming when something doesn't work the way it should.  
> I'll continue to try to blame your incompetence as much as I humanly can,
> but hey, some of it is occasionally mine too... ;(

Well, since it's obviously complaint time :-)

git-resolve-script still seems a bit too eager to write MERGE_HEAD and 
ORIG_HEAD - they only make sense if there's actually been any merging 
done, don't they?

Patch below shows what I mean.

/dan

---

[PATCH] Make git-resolve-script less eager to write MERGE_HEAD

MERGE_HEAD and ORIG_HEAD should only be written if there's actually
been any merging done.

Signed-off-by: Dan Holmsand <holmsand@gmail.com>

--------------010605060901000101000806
Content-Type: text/plain;
 name="git-resolve-script.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-resolve-script.patch.txt"

diff --git a/git-resolve-script b/git-resolve-script
--- a/git-resolve-script
+++ b/git-resolve-script
@@ -12,8 +12,6 @@ merge_repo="$3"
 : ${GIT_OBJECT_DIRECTORY="${SHA1_FILE_DIRECTORY-"$GIT_DIR/objects"}"}
 
 rm -f "$GIT_DIR"/MERGE_HEAD "$GIT_DIR"/ORIG_HEAD
-echo $head > "$GIT_DIR"/ORIG_HEAD
-echo $merge > "$GIT_DIR"/MERGE_HEAD
 
 #
 # The remote name is just used for the message,
@@ -32,15 +30,13 @@ fi
 
 if [ "$common" == "$merge" ]; then
 	echo "Already up-to-date. Yeeah!"
-	rm -f -- "$GIT_DIR/ORIG_HEAD" "$GIT_DIR/MERGE_HEAD"
 	exit 0
 fi
 if [ "$common" == "$head" ]; then
 	echo "Updating from $head to $merge."
 	git-read-tree -u -m $head $merge || exit 1
 	echo $merge > "$GIT_DIR"/HEAD
-	git-diff-tree -p ORIG_HEAD HEAD | git-apply --stat
-	rm -f -- "$GIT_DIR/ORIG_HEAD" "$GIT_DIR/MERGE_HEAD"
+	git-diff-tree -p $head HEAD | git-apply --stat
 	exit 0
 fi
 echo "Trying to merge $merge into $head"
@@ -51,6 +47,8 @@ if [ $? -ne 0 ]; then
 	echo "Simple merge failed, trying Automatic merge"
 	git-merge-cache -o git-merge-one-file-script -a
 	if [ $? -ne 0 ]; then
+		echo $merge > "$GIT_DIR"/MERGE_HEAD
+		echo $head > "$GIT_DIR"/ORIG_HEAD
 		echo "Automatic merge failed, fix up by hand"
 		exit 1
 	fi
@@ -60,4 +58,3 @@ result_commit=$(echo "$merge_msg" | git-
 echo "Committed merge $result_commit"
 echo $result_commit > "$GIT_DIR"/HEAD
 git-diff-tree -p $head $result_commit | git-apply --stat
-rm -f -- "$GIT_DIR/ORIG_HEAD" "$GIT_DIR/MERGE_HEAD"

--------------010605060901000101000806--
