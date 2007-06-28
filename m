From: Jason Sewall <jasonsewall@gmail.com>
Subject: [PATCH] Add emacs 'ediff' mode to git-mergetool's tools
Date: Wed, 27 Jun 2007 23:25:11 -0700
Message-ID: <11830119113828-git-send-email-jasonsewall@gmail.com>
Cc: Jason Sewall <jasonsewall@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 28 08:25:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3nRP-0002DG-BW
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 08:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758190AbXF1GZS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 02:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758178AbXF1GZR
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 02:25:17 -0400
Received: from qb-out-0506.google.com ([72.14.204.232]:28003 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646AbXF1GZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 02:25:16 -0400
Received: by qb-out-0506.google.com with SMTP id e11so263qbe
        for <git@vger.kernel.org>; Wed, 27 Jun 2007 23:25:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=GcUP7OI0kjYoQi14eTjxJC1sNFFwz5WjSoeV2UUCV7kb9jRy0vXWHk2L0498Twm7mbVAlVG5SYCz+VBZfR3/RxEjDepSfauwKyX2SyeGjYwrnJjzBY9sPdk6eQc0PyYvgEIwAZa/PfIrFpJoslIYQky3NnE+NT3kRpvkkYEHU7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=AXKITG7C0rQTemAFyae35tpAIQRlIEfK6e5qBAbqlnT9CMxIoINvqMoe///HB4UIo7gRpMWUxCaDW7tQUxTdrJBbB2Hxj9NyK++fSWAYxiDG+73Skg6rkvhNcVVTD2nw85vTY8sggLCOKqYwzj6q7NKwDmMku9kon/RwYFnSmYM=
Received: by 10.141.15.19 with SMTP id s19mr331492rvi.1183011914624;
        Wed, 27 Jun 2007 23:25:14 -0700 (PDT)
Received: from localhost ( [76.102.154.60])
        by mx.google.com with ESMTP id b34sm11704681rvf.2007.06.27.23.25.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jun 2007 23:25:14 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.2.589.g4b646
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51085>

It is now possible to specifiy 'ediff' as a value to the '--tool=' option to git-mergetool; this invokes an ediff session in emacs with the appropriate files.

Signed-off-by: Jason Sewall <jasonsewall@gmail.com>
---

Ediff is is an emacs mode similar to emerge for performing merges; it is fuller-featured than emerge and I find it easier to use.

 git-mergetool.sh |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 7b66309..c27d212 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -258,6 +258,15 @@ merge_file () {
 	    status=$?
 	    save_backup
 	    ;;
+	ediff)
+	    if base_present ; then
+		emacs --eval "(ediff-merge-files-with-ancestor \"$LOCAL\" \"$REMOTE\" \"$BASE\" \"$path\")"
+	    else
+		emacs --eval "(ediff-merge-files \"$LOCAL\" \"$REMOTE\" \"$path\")"
+	    fi
+	    status=$?
+	    save_backup
+	    ;;
     esac
     if test "$status" -ne 0; then
 	echo "merge of $path failed" 1>&2
@@ -299,7 +308,7 @@ done
 if test -z "$merge_tool"; then
     merge_tool=`git-config merge.tool`
     case "$merge_tool" in
-	kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | "")
+	kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | ediff | vimdiff | gvimdiff | "")
 	    ;; # happy
 	*)
 	    echo >&2 "git config option merge.tool set to unknown tool: $merge_tool"
@@ -320,7 +329,7 @@ if test -z "$merge_tool" ; then
         fi
     fi
     if echo "${VISUAL:-$EDITOR}" | grep 'emacs' > /dev/null 2>&1; then
-        merge_tool_candidates="$merge_tool_candidates emerge"
+        merge_tool_candidates="$merge_tool_candidates emerge ediff"
     fi
     if echo "${VISUAL:-$EDITOR}" | grep 'vim' > /dev/null 2>&1; then
         merge_tool_candidates="$merge_tool_candidates vimdiff"
@@ -328,7 +337,7 @@ if test -z "$merge_tool" ; then
     merge_tool_candidates="$merge_tool_candidates opendiff emerge vimdiff"
     echo "merge tool candidates: $merge_tool_candidates"
     for i in $merge_tool_candidates; do
-        if test $i = emerge ; then
+        if test $i = emerge -o $i = ediff ; then
             cmd=emacs
         else
             cmd=$i
@@ -351,7 +360,7 @@ case "$merge_tool" in
 	    exit 1
 	fi
 	;;
-    emerge)
+    emerge|ediff)
 	if ! type "emacs" > /dev/null 2>&1; then
 	    echo "Emacs is not available"
 	    exit 1
--
1.5.2.2.589.g4b646
