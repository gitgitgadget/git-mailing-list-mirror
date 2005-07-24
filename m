From: A Large Angry SCM <gitzilla@gmail.com>
Subject: [PATCH] Add -a option to get-tag-script to annotate but not sign
 a tag
Date: Sun, 24 Jul 2005 11:35:07 -0400
Message-ID: <42E3B52B.2030602@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 24 17:35:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwiVs-0003RS-M8
	for gcvg-git@gmane.org; Sun, 24 Jul 2005 17:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVGXPfN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jul 2005 11:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVGXPfN
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jul 2005 11:35:13 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:55088 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261374AbVGXPfL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jul 2005 11:35:11 -0400
Received: by wproxy.gmail.com with SMTP id i36so775700wra
        for <git@vger.kernel.org>; Sun, 24 Jul 2005 08:35:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=XmVDEyb9B+FbVHbEln7iSJgFSa+v/FA/i8Kvc+o8jBhJb4vgSFNMsucu+eCdFazv9rhf+wHmtFddVGJy2F180wQmBZyBI1KpjEsc/Mvs0/ClVwddTEFZikwjTStd1KGW2yeqabMOMSX7tXwlnXQ5vIYue6efH75Ydw/QqWsy1M8=
Received: by 10.54.37.72 with SMTP id k72mr1940681wrk;
        Sun, 24 Jul 2005 08:35:10 -0700 (PDT)
Received: from ?10.0.0.6? ([70.89.97.97])
        by mx.gmail.com with ESMTP id d74sm2200600wra.2005.07.24.08.35.10;
        Sun, 24 Jul 2005 08:35:10 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add -a option to get-tag-script to annotate but not sign a tag

Also fix the test for an existing tag.

Signed-off-by: A Large Angry SCM <gitzilla@gmail.com>
---

  git-tag-script |   21 +++++++++++++++------
  1 files changed, 15 insertions(+), 6 deletions(-)

a49029e5cf9cca0c2999c0241e75789bcc38dbb5
diff --git a/git-tag-script b/git-tag-script
--- a/git-tag-script
+++ b/git-tag-script
@@ -3,11 +3,15 @@

  . git-sh-setup-script || die "Not a git archive"

+annotate=
  signed=
  force=
  while case "$#" in 0) break ;; esac
  do
      case "$1" in
+    -a)
+	annotate=1
+	;;
      -s)
  	signed=1
  	;;
@@ -23,15 +27,16 @@ done

  name="$1"
  [ "$name" ] || die "I need a tag-name"
-[ -e "$GIT_DIR/refs/tags/$name" ] &&
-	[ "$force" ] || die "tag '$name' already exists"
+if [ -e "$GIT_DIR/refs/tags/$name" -a -z "$force" ]; then
+    die "tag '$name' already exists"
+fi
  shift

  object=$(git-rev-parse --verify --revs-only --default HEAD "$@") || exit 1
  type=$(git-cat-file -t $object) || exit 1
  tagger=$(git-var GIT_COMMITTER_IDENT) || exit 1

-if [ "$signed" ]; then
+if [ "$annotate" -o "$signed" ]; then
      ( echo "#"
        echo "# Write a tag message"
        echo "#" ) > .editmsg
@@ -42,10 +47,14 @@ if [ "$signed" ]; then
      [ -s .tagmsg ] || exit

      ( echo -e "object $object\ntype $type\ntag $name\ntagger $tagger\n"; cat .tagmsg ) > .tmp-tag
-    rm -f .tmp-tag.asc .tagmsg
-    gpg -bsa .tmp-tag && cat .tmp-tag.asc >> .tmp-tag
+    rm -f .tagmsg
+    if [ "$signed" ]; then
+	rm -f .tmp-tag.asc
+	gpg -bsa .tmp-tag && cat .tmp-tag.asc >> .tmp-tag
+	rm -f .tmp-tag.sig
+    fi
      object=$(git-mktag < .tmp-tag)
-    rm -f .tmp-tag .tmp-tag.sig
+    rm -f .tmp-tag
  fi

  mkdir -p "$GIT_DIR/refs/tags"
