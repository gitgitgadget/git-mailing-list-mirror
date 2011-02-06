From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 24/31] rebase: extract code for writing basic state
Date: Sun,  6 Feb 2011 13:43:53 -0500
Message-ID: <1297017841-20678-25-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 19:47:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm9eL-0005ZO-Jl
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842Ab1BFSqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:46:55 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58585 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742Ab1BFSq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:46:29 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so3014077qwa.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=P5XV4fxMbFRgdkf44KaffYOhEiwMJz0aGx2Yh/qRiyo=;
        b=eI015g8HiWDUanp3iHJc1MK4lqkpMWJQm5lO+bPbqy2EKK9yDt0ZCJwqemb4lVwLTI
         SLmPQxoY1MfPQ1lXROqUt718XFSeflTQPceKVMSZLP/ju1OiWwF5nDv36RVMNDh4APuc
         hMFjQCEdYMxASoyyh9EXHYY1UEID53uAcYIU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UjvpHuBpN3OYDE2tIZ7UGcPnw/nuZA/HMVFV0VkR0W/P4JgzytpTNtI9lK4HnUAVPY
         PUAKC271L6V8EDya/S0PNbjvW7zhGEzZHsZhfOEfmWkEG8av/M4N7Puq992wHNEooqiN
         TA3avEBmdKbTQtW5zmBhTSXQLn8uoDzlCMWeM=
Received: by 10.224.80.146 with SMTP id t18mr13571091qak.69.1297017989238;
        Sun, 06 Feb 2011 10:46:29 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.46.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:46:28 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166186>

Extract the code for writing the state to rebase-apply/ or
rebase-merge/ when a rebase is initiated. This will make it easier to
later make both interactive and non-interactive rebase remember the
options used.

Note that non-interactive rebase stores the sha1 of the original head
in a file called orig-head, while interactive rebase stores it in a
file called head. Change this by writing to orig-head in both
cases. When reading, try to read from orig-head. If that fails, read
from head instead. This protects users who upgraded git while they had
an ongoing interactive rebase, while still making it possible to
remove the code that reads from head at some point in the future.

Helped-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
Changes since v1:

 * As suggested by Thomas, always write to orig-head file. When
   reading, try orig-head first and fall back to reading from head.


 git-rebase--am.sh          |    6 +-----
 git-rebase--interactive.sh |    5 +----
 git-rebase--merge.sh       |    5 +----
 git-rebase.sh              |   16 +++++++++++++---
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 263987c..c9604a6 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -26,9 +26,5 @@ git format-patch -k --stdout --full-index --ignore-if-in-upstream \
 git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" &&
 move_to_original_branch
 ret=$?
-test 0 != $ret -a -d "$state_dir" &&
-	echo $head_name > "$state_dir/head-name" &&
-	echo $onto > "$state_dir/onto" &&
-	echo $orig_head > "$state_dir/orig-head" &&
-	echo "$GIT_QUIET" > "$state_dir/quiet"
+test 0 != $ret -a -d "$state_dir" && write_basic_state
 exit $ret
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 4af0bc6..437cc52 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -707,16 +707,13 @@ orig_head=$(git rev-parse --verify HEAD) || die "No HEAD?"
 mkdir "$state_dir" || die "Could not create temporary $state_dir"
 
 : > "$state_dir"/interactive || die "Could not mark as interactive"
-echo "$head_name" > "$state_dir"/head-name
-
-echo $orig_head > "$state_dir"/head
+write_basic_state
 case "$rebase_root" in
 '')
 	rm -f "$state_dir"/rebase-root ;;
 *)
 	: >"$state_dir"/rebase-root ;;
 esac
-echo $onto > "$state_dir"/onto
 test -z "$strategy" || echo "$strategy" > "$state_dir"/strategy
 test t = "$verbose" && : > "$state_dir"/verbose
 if test t = "$preserve_merges"
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index c04ce8a..eb0f7bc 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -127,10 +127,7 @@ esac
 
 mkdir -p "$state_dir"
 echo "$onto_name" > "$state_dir/onto_name"
-echo "$head_name" > "$state_dir/head-name"
-echo "$onto" > "$state_dir/onto"
-echo "$orig_head" > "$state_dir/orig-head"
-echo "$GIT_QUIET" > "$state_dir/quiet"
+write_basic_state
 
 msgnum=0
 for cmt in `git rev-list --reverse --no-merges "$revisions"`
diff --git a/git-rebase.sh b/git-rebase.sh
index 21bb027..5a399aa 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -70,15 +70,25 @@ test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
 read_basic_state () {
 	head_name=$(cat "$state_dir"/head-name) &&
 	onto=$(cat "$state_dir"/onto) &&
-	if test "$type" = interactive
+	# We always write to orig-head, but interactive rebase used to write to
+	# head. Fall back to reading from head to cover for the case that the
+	# user upgraded git with an ongoing interactive rebase.
+	if test -f "$state_dir"/orig-head
 	then
-		orig_head=$(cat "$state_dir"/head)
-	else
 		orig_head=$(cat "$state_dir"/orig-head)
+	else
+		orig_head=$(cat "$state_dir"/head)
 	fi &&
 	GIT_QUIET=$(cat "$state_dir"/quiet)
 }
 
+write_basic_state () {
+	echo "$head_name" > "$state_dir"/head-name &&
+	echo "$onto" > "$state_dir"/onto &&
+	echo "$orig_head" > "$state_dir"/orig-head &&
+	echo "$GIT_QUIET" > "$state_dir"/quiet
+}
+
 output () {
 	case "$verbose" in
 	'')
-- 
1.7.4.rc2.33.g8a14f
