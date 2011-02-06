From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 26/31] rebase: remember strategy and strategy options
Date: Sun,  6 Feb 2011 13:43:55 -0500
Message-ID: <1297017841-20678-27-git-send-email-martin.von.zweigbergk@gmail.com>
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
	id 1Pm9eG-0005ZO-58
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778Ab1BFSqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:46:35 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58585 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764Ab1BFSqd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:46:33 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so3014077qwa.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=ii7RQ4DzypGnqTPoXmAg59L7umsmog7Wu3rE4cDtaVE=;
        b=vtsppxr0TP3iJEuZDP/iW0H+2Dxha0INvr087JXQaFv0fXYJCGLWuE8KsbL8Nl6S3j
         xVu/wfnrszcJMkWpsxlT4zHUKx1lh3t6yCB18JNSRIA8jvjvbMAiJbSgUcKBcTdipN7y
         lN/3Hjm+DgDoVY0pG10GFUGIAF2CAVO8cY9NU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uXpAWnqDtVLt9y9zCLdMsb7GAOP6sDkgNZxeonC8S05dC+7hXoj6sx4uI+damSMwCo
         D2qjZURXmcYLhJSnNEApS874pjAI6YxHZIaXWme0uDX+wtY1fKeVTMcvcEwovUIXLMaP
         /ybVoWQIW+SjkD10GuXC/oHVkEWzV7A7e5Tzo=
Received: by 10.229.248.198 with SMTP id mh6mr12330495qcb.5.1297017992702;
        Sun, 06 Feb 2011 10:46:32 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.46.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:46:32 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166189>

When a rebase is resumed, interactive rebase remembers any merge
strategy passed when the rebase was initated. Make non-interactive
rebase remember any merge strategy as well. Also make non-interactive
rebase remember any merge strategy options.

To be able to resume a rebase that was initiated with an older version
of git (older than this commit), make sure not to expect the saved
option files to exist.

Test case idea taken from Junio's 71fc224 (t3402: test "rebase
-s<strategy> -X<opt>", 2010-11-11).

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase--interactive.sh |    2 --
 git-rebase.sh              |    6 ++++++
 t/t3418-rebase-continue.sh |   29 +++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f076a6e..5773b75 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -584,7 +584,6 @@ skip_unnecessary_picks () {
 
 get_saved_options () {
 	test -d "$rewritten" && preserve_merges=t
-	test -f "$state_dir"/strategy && strategy="$(cat "$state_dir"/strategy)"
 	test -f "$state_dir"/rebase-root && rebase_root=t
 }
 
@@ -713,7 +712,6 @@ case "$rebase_root" in
 *)
 	: >"$state_dir"/rebase-root ;;
 esac
-test -z "$strategy" || echo "$strategy" > "$state_dir"/strategy
 if test t = "$preserve_merges"
 then
 	if test -z "$rebase_root"
diff --git a/git-rebase.sh b/git-rebase.sh
index 8a36e7a..f4ad7c1 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -81,6 +81,9 @@ read_basic_state () {
 	fi &&
 	GIT_QUIET=$(cat "$state_dir"/quiet) &&
 	test -f "$state_dir"/verbose && verbose=t
+	test -f "$state_dir"/strategy && strategy="$(cat "$state_dir"/strategy)"
+	test -f "$state_dir"/strategy_opts &&
+		strategy_opts="$(cat "$state_dir"/strategy_opts)"
 }
 
 write_basic_state () {
@@ -89,6 +92,9 @@ write_basic_state () {
 	echo "$orig_head" > "$state_dir"/orig-head &&
 	echo "$GIT_QUIET" > "$state_dir"/quiet &&
 	test t = "$verbose" && : > "$state_dir"/verbose
+	test -n "$strategy" && echo "$strategy" > "$state_dir"/strategy
+	test -n "$strategy_opts" && echo "$strategy_opts" > \
+		"$state_dir"/strategy_opts
 }
 
 output () {
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 1d90191..5469546 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -45,4 +45,33 @@ test_expect_success 'rebase --continue can not be used with other options' '
 	test_must_fail git rebase --continue -v
 '
 
+test_expect_success 'rebase --continue remembers merge strategy and options' '
+	rm -fr .git/rebase-* &&
+	git reset --hard commit-new-file-F2-on-topic-branch &&
+	test_commit "commit-new-file-F3-on-topic-branch" F3 32 &&
+	test_when_finished "rm -fr test-bin funny.was.run" &&
+	mkdir test-bin &&
+	cat >test-bin/git-merge-funny <<-EOF
+	#!$SHELL_PATH
+	case "\$1" in --opt) ;; *) exit 2 ;; esac
+	shift &&
+	>funny.was.run &&
+	exec git merge-recursive "\$@"
+	EOF
+	chmod +x test-bin/git-merge-funny &&
+	(
+		PATH=./test-bin:$PATH
+		test_must_fail git rebase -s funny -Xopt master topic
+	) &&
+	test -f funny.was.run &&
+	rm funny.was.run &&
+	echo "Resolved" >F2 &&
+	git add F2 &&
+	(
+		PATH=./test-bin:$PATH
+		git rebase --continue
+	) &&
+	test -f funny.was.run
+'
+
 test_done
-- 
1.7.4.rc2.33.g8a14f
