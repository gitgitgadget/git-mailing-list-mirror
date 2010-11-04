From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Wed,  3 Nov 2010 22:17:16 -0700
Message-ID: <1288847836-84882-1-git-send-email-kevin@sb.org>
Cc: Kevin Ballard <kevin@sb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 06:18:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDsD8-0006Zn-By
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 06:18:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753682Ab0KDFRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 01:17:30 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51103 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020Ab0KDFR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 01:17:28 -0400
Received: by pwj7 with SMTP id 7so102020pwj.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 22:17:28 -0700 (PDT)
Received: by 10.142.174.13 with SMTP id w13mr175891wfe.321.1288847848228;
        Wed, 03 Nov 2010 22:17:28 -0700 (PDT)
Received: from localhost.localdomain ([69.170.160.74])
        by mx.google.com with ESMTPS id y42sm14805565wfd.22.2010.11.03.22.17.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 22:17:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.2.202.g3b863.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160691>

Add a new command "shell", which takes an option commit. It simply exits
to the shell with the commit (if given) and a message telling the user how
to resume the rebase. This is effectively the same thing as "x false" but
much friendlier to the user.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
I discovered the need for this when I wanted to edit a commit, but apply
a fixup first. The only way with the existing tools was an exec command
that fails (e.g. "x false").

 git-rebase--interactive.sh |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 9121bb6..3501757 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -566,6 +566,26 @@ do_next () {
 			exit 1
 		fi
 		;;
+	!|"shell")
+		read -r command comment < "$TODO"
+		mark_action_done
+		# can't use $sha1 here for same reason as "exec"
+		line=$(git rev-list --pretty=oneline -1 --abbrev-commit --abbrev=7 HEAD)
+		sha1="${line%% *}"
+		rest="${line#* }"
+		echo "$sha1" > "$DOTEST"/stopped-sha
+		warn "Stopped at $sha1... $rest"
+		if test -n "$comment"; then
+			warn
+			warn "	$comment"
+		fi
+		warn
+		warn "Once you are ready to continue, run"
+		warn
+		warn "	git rebase --continue"
+		warn
+		exit 0
+		;;
 	*)
 		warn "Unknown command: $command $sha1 $rest"
 		if git rev-parse --verify -q "$sha1" >/dev/null
@@ -1007,6 +1027,7 @@ first and then run 'git rebase --continue' again."
 #  s, squash = use commit, but meld into previous commit
 #  f, fixup = like "squash", but discard this commit's log message
 #  x <cmd>, exec <cmd> = Run a shell command <cmd>, and stop if it fails
+#  !, shell = Exit to the shell
 #
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.
-- 
1.7.3.2.202.g3b863.dirty
