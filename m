From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH] rebase: Handle cases where format-patch fails
Date: Wed, 10 Oct 2012 23:54:03 -0400
Message-ID: <1349927643-7195-2-git-send-email-andrew.kw.w@gmail.com>
References: <7vtxu4io7o.fsf@alter.siamese.dyndns.org>
 <1349927643-7195-1-git-send-email-andrew.kw.w@gmail.com>
Cc: git@vger.kernel.org, alex.kostikov@gmail.com,
	Andrew Wong <andrew.kw.w@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Oct 11 05:54:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM9qx-0003Ml-7Z
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 05:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756439Ab2JKDyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 23:54:16 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:44465 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933149Ab2JKDyO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 23:54:14 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so2287043iea.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 20:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=upMaVAYRVEskH09BfNzSvFKVEeOk6wRWTxZ58Rq3EHI=;
        b=vkfXR6tvdq6JWXh5n7a4B685gv+dxAIEAgFyCnBP568vKbGELDYZeCbZZ1dE4i1RU5
         nlQWV+BioQLWoohW5J0L2mXxwGn9hzDjVp0Ps9hanK+lD5afHeLr6JWPagnvZC5mesAQ
         8NhCda0QlQUHEt/0UcARTBvN3jkObgUpcGd0Ljko9QfZIppNLUZgFuOwaGpD3yJZSGaJ
         6u7MQ31JTpvO7eSqTdjLMsVJvGlCbuEPMruiqSxg4FbxRoOWK+Z0pm4BQ/D0wLeVeXfT
         7bsqf8jM0h2vFYQtVtlv+oO8/O08Vt2NNOX+UiZMMZ6W2bVgCI0tEVsnZsoS2brgYwLn
         zG7w==
Received: by 10.42.165.200 with SMTP id l8mr5873220icy.9.1349927654138;
        Wed, 10 Oct 2012 20:54:14 -0700 (PDT)
Received: from localhost.localdomain ([69.165.255.59])
        by mx.google.com with ESMTPS id bg2sm7675702igb.1.2012.10.10.20.54.12
        (version=SSLv3 cipher=OTHER);
        Wed, 10 Oct 2012 20:54:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.0.rc0.19.gc58a63a.dirty
In-Reply-To: <1349927643-7195-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207461>

'format-patch' could fail due to reasons such as out of memory. Such
failures are not detected or handled, which causes rebase to incorrectly
think that it completed successfully and continue with cleanup. i.e.
calling move_to_original_branch

Instead of using a pipe, we separate 'format-patch' and 'am' by using an
intermediate file. This gurantees that we can invoke 'am' with the
complete input, or not invoking 'am' at all if 'format-patch' failed.

Also remove the use of '&&' at the end of the if-block, and rearrange
the 'write_basic_state' and 'move_to_original_branch' to make the logic
flow a bit better and easier to read.

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 git-rebase--am.sh | 51 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 392ebc9..85b594e 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -18,6 +18,7 @@ esac
 
 test -n "$rebase_root" && root_flag=--root
 
+ret=0
 if test -n "$keep_empty"
 then
 	# we have to do this the hard way.  git format-patch completely squashes
@@ -25,13 +26,51 @@ then
 	# itself well to recording empty patches.  fortunately, cherry-pick
 	# makes this easy
 	git cherry-pick --allow-empty "$revisions"
+	ret=$?
 else
+	rm -f "$GIT_DIR/format-patch"
+
 	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
 		--src-prefix=a/ --dst-prefix=b/ \
-		--no-renames $root_flag "$revisions" |
-	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg"
-fi && move_to_original_branch
+		--no-renames $root_flag "$revisions" > "$GIT_DIR/format-patch"
+	ret=$?
+
+	if test 0 != $ret
+	then
+		rm -f "$GIT_DIR/format-patch"
+
+		case "$head_name" in
+		refs/heads/*)
+			git checkout -q "$head_name"
+			;;
+		*)
+			git checkout -q "$orig_head"
+			;;
+		esac
+
+		cat >&2 <<-EOF
+
+		git encountered an error while preparing the patches to replay
+		these revisions:
+
+		    $revisions
+
+		As a result, git cannot rebase these revisions.
+		EOF
+
+		exit $?
+	fi
+
+	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" < "$GIT_DIR/format-patch"
+	ret=$?
+
+	rm -f "$GIT_DIR/format-patch"
+fi
+
+if test 0 != $ret
+then
+	test -d "$state_dir" && write_basic_state
+	exit $ret
+fi
 
-ret=$?
-test 0 != $ret -a -d "$state_dir" && write_basic_state
-exit $ret
+move_to_original_branch
-- 
1.8.0.rc0.19.gc58a63a.dirty
