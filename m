From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [RFC] rebase: Handle cases where format-patch fails
Date: Mon,  8 Oct 2012 15:36:28 -0400
Message-ID: <1349724988-14625-2-git-send-email-andrew.kw.w@gmail.com>
References: <7vipaou0zw.fsf@alter.siamese.dyndns.org>
 <1349724988-14625-1-git-send-email-andrew.kw.w@gmail.com>
Cc: git@vger.kernel.org, alex.kostikov@gmail.com,
	Andrew Wong <andrew.kw.w@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 08 21:36:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLJ8F-0000lK-AI
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 21:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274Ab2JHTgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 15:36:42 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:53834 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713Ab2JHTgk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 15:36:40 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so501572iea.19
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 12:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Iv1CWYJD3ARsBaG44uQkFUTkt/mi5z01jkkE6flMwlQ=;
        b=Vv0ng5dg1n1aEhY5MzVr890CxSIw4pvFNJf7RfAVN8FgqtktL4pcc+exqo2ZyB5GE0
         ooTb0k/ffnW9Qgvbm5Q8iuJxNIVZfNlW4V7OS87xsHttI70ytS/LcqnNlTNziego8E4C
         Fqlu8dfcFbMtTOu5j5ugK4SDjG1R/GYgRFkn2KoQshuC5WniN6qL04pEYEcUJDRHjPG3
         72RGD2QHZ6aEmFAjlMxl4Xs9lGXqKPopYkQey35yGQs9fxmKY7P64f/c3+Aldv4vQ5i5
         P6V2jJUZ/k01uydhkv6osWIYrnqzjmQzRqO9hoPBRGIof+CYRciQjxVR2JRIHV8NMXDt
         nlmg==
Received: by 10.50.46.199 with SMTP id x7mr9404901igm.19.1349725000523;
        Mon, 08 Oct 2012 12:36:40 -0700 (PDT)
Received: from localhost.localdomain ([69.165.255.59])
        by mx.google.com with ESMTPS id ff4sm8134062igc.5.2012.10.08.12.36.38
        (version=SSLv3 cipher=OTHER);
        Mon, 08 Oct 2012 12:36:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.0.rc0.19.ga19ab82.dirty
In-Reply-To: <1349724988-14625-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207263>

'format-patch' could fail due to reasons such as out of memory. Such
failures are not detected or handled, which causes rebase to incorrectly
think that it completed successfully and continue with cleanup. i.e.
calling move_to_original_branch

Instead of using a pipe, we separate 'format-patch' and 'am' by using an
intermediate file. This gurantees that we can invoke 'am' with the
complete input, or not invoking 'am' at all if 'format-patch' failed.

Also print messages to help user with how to recover from such failures.

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 git-rebase--am.sh | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 392ebc9..a955b38 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -26,10 +26,32 @@ then
 	# makes this easy
 	git cherry-pick --allow-empty "$revisions"
 else
-	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
+	rm -f "$GIT_DIR/format-patch"
+	if ! git format-patch -k --stdout --full-index --ignore-if-in-upstream \
 		--src-prefix=a/ --dst-prefix=b/ \
-		--no-renames $root_flag "$revisions" |
-	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg"
+		--no-renames $root_flag "$revisions" > "$GIT_DIR/format-patch" && ret=$?
+	then
+		rm "$GIT_DIR/format-patch"
+		echo
+		echo "'git format-patch' seems to have failed."
+		echo "It is impossible to continue or abort rebasing."
+		echo "You have to use the following to return to your original head:"
+		echo
+		case "$head_name" in
+		refs/*)
+			echo "    git checkout $head_name"
+			;;
+		*)
+			echo "    git checkout $orig_head"
+			;;
+		esac
+		echo
+		exit $ret
+	fi
+
+	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" < "$GIT_DIR/format-patch" || ret=$?
+	rm -f "$GIT_DIR/format-patch"
+	test 0 != ret && ( exit $ret )
 fi && move_to_original_branch
 
 ret=$?
-- 
1.8.0.rc0.19.ga19ab82.dirty
