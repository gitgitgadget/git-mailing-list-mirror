From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 31/31] rebase -i: remove unnecessary state rebase-root
Date: Sun,  6 Feb 2011 13:44:00 -0500
Message-ID: <1297017841-20678-32-git-send-email-martin.von.zweigbergk@gmail.com>
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
	id 1Pm9eK-0005ZO-1D
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822Ab1BFSqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:46:45 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58585 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816Ab1BFSql (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:46:41 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so3014077qwa.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=ivep9p/zPvCHFZBfjqabXPQqbzDXHBqvcDynOb8pWkI=;
        b=BeH6XriLPDTL6LYw79i2ktLslhiTF44hAHa6NR2ZC4xjx2Vy0bgfJT2JQtaXkdCi8A
         a3yKbh+aG2pxWedeTUOEn2ALNvfxqXK2xN8Dlzn5P3rXfIL5kcfhTr/3W2IZUsfTnyN4
         tKevwRRCFLoZL9RKmf9e0NxSC2mSLiq/CHII8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=guJqwznTi0aaB7e9PB57lC0i4FrZon3TBoZMUDHCYYDLm8QIH8iw+FiSrmJ/6uynut
         CsPPQc8KanRM9zFWxrttY6ko4eirGqWNDFdoc6beW3EBz69rIjJkUHKf3Cuu3K/XtiXG
         t+ef4av0mswttC3KiBbC5q3jO3Nid1AQ6TPWk=
Received: by 10.224.135.227 with SMTP id o35mr5399892qat.75.1297018001261;
        Sun, 06 Feb 2011 10:46:41 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.46.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:46:40 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166185>

Before calling 'git cherry-pick', interactive rebase currently checks
if we are rebasing from root (if --root was passed). If we are, the
'--ff' flag to 'git cherry-pick' is omitted. However, according to the
documentation for 'git cherry-pick --ff', "If the current HEAD is the
same as the parent of the cherry-picked commit, then a fast forward to
this commit will be performed.". This should never be the case when
rebasing from root, so it should not matter whether --ff is passed, so
simplify the code by removing the condition.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase--interactive.sh |   19 -------------------
 1 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index cf19bf5..6566d31 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -168,11 +168,6 @@ pick_one () {
 	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
 	test -d "$rewritten" &&
 		pick_one_preserving_merges "$@" && return
-	if test -n "$rebase_root"
-	then
-		output git cherry-pick "$@"
-		return
-	fi
 	output git cherry-pick $ff "$@"
 }
 
@@ -582,10 +577,6 @@ skip_unnecessary_picks () {
 	die "Could not skip unnecessary pick commands"
 }
 
-get_saved_options () {
-	test -f "$state_dir"/rebase-root && rebase_root=t
-}
-
 # Rearrange the todo list that has both "pick sha1 msg" and
 # "pick sha1 fixup!/squash! msg" appears in it so that the latter
 # comes immediately after the former, and change "pick" to
@@ -649,8 +640,6 @@ rearrange_squash () {
 
 case "$action" in
 continue)
-	get_saved_options
-
 	# do we have anything to commit?
 	if git diff-index --cached --quiet --ignore-submodules HEAD --
 	then
@@ -681,8 +670,6 @@ first and then run 'git rebase --continue' again."
 	do_rest
 	;;
 skip)
-	get_saved_options
-
 	git rerere clear
 
 	do_rest
@@ -705,12 +692,6 @@ mkdir "$state_dir" || die "Could not create temporary $state_dir"
 
 : > "$state_dir"/interactive || die "Could not mark as interactive"
 write_basic_state
-case "$rebase_root" in
-'')
-	rm -f "$state_dir"/rebase-root ;;
-*)
-	: >"$state_dir"/rebase-root ;;
-esac
 if test t = "$preserve_merges"
 then
 	if test -z "$rebase_root"
-- 
1.7.4.rc2.33.g8a14f
