From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v1 19/19] rebase -i: enable options --signoff, --reset-author for pick, reword
Date: Tue, 29 Jul 2014 01:18:19 +0200
Message-ID: <de80b265966e8287317029de1dabd7f117af9971.1406589435.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1406589435.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 01:21:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBuEN-0006Li-FO
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 01:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbaG1XVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 19:21:10 -0400
Received: from mail-we0-f180.google.com ([74.125.82.180]:34765 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbaG1XVF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 19:21:05 -0400
Received: by mail-we0-f180.google.com with SMTP id w61so8168246wes.39
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 16:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U/VzykhpurqHDObakdzxY144XFL3L0sCKZREDDE1FNM=;
        b=LYj29DDuYmkhY7zPneH92l+kWg5sQyNe9DkarCqtkPOmyEKsU6/VXxpt7mVbxHKe0f
         YWTPP19fI2rxdJisnD/MwDTY7zCvbZHmbGccpCFdeWuxiCnMOxmc3wwoxMPtXgc/mBTr
         KqWaKQDjCP5ztMxNCIOIXDNB0kAEEL1N9QFG008PXf8af6xvcxK3MQFSniQ1gHKDdBU+
         ztrMF8ItgpS/Tl98RXgwOBengpNX9xMwlalog6+qMDU3FAgOY3ngabZfPbLDzNLL8MLO
         PNWAJeNnydDZ5NVeRZYoEjQVGgQH7p0AArnMDPYf/TfFx5BDgzaXcJ8XPpis0x1n7zCd
         fCqA==
X-Received: by 10.194.110.7 with SMTP id hw7mr10935533wjb.38.1406589664007;
        Mon, 28 Jul 2014 16:21:04 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id pj6sm52914690wjb.21.2014.07.28.16.21.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jul 2014 16:21:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1406589435.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254375>

pick and reword are atomic to-do list commands in the sense that they
open a new task which is closed after the respective command is
completed. squash and fixup are not atomic. They create a new task
which is not completed until the last squash or fixup is processed.

Lift the general unknown option blockade for the pick and reword
commands. If `do_cmd` comes across one of the options `--signoff` and
`--reset-author` while parsing a to-do entry and the scheduled
command is either `pick` or `reword`, relay the option to `do_pick`.

The `do_pick` options `--gpg-sign` and `--file` are not yet supported
because `do_cmd` cannot handle option arguments and options with
spaces at the moment. It is true that edit is one of the atomic
commands but it displays hash information when the rebase is stopped
and some options rewrite the picked commit which alters that
information. squash and fixup still do not accept user options as the
interplay of `--reset-author` and the author script are yet to be
determined.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 9324ed3..32fd047 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -627,6 +627,16 @@ do_replay () {
 	while test $# -gt 0
 	do
 		case "$1" in
+		--signoff|--reset-author)
+			case "$command" in
+			pick|reword)
+				;;
+			*)
+				warn "Unsupported option: $1"
+				command=unknown
+				;;
+			esac
+			;;
 		-*)
 			warn "Unknown option: $1"
 			command=unknown
@@ -647,21 +657,24 @@ do_replay () {
 		comment_for_reflog pick
 
 		mark_action_done
-		do_pick $sha1 || die_with_patch $sha1 "Could not apply $sha1... $rest"
+		eval do_pick $opts $sha1 \
+			|| die_with_patch $sha1 "Could not apply $sha1... $rest"
 		record_in_rewritten $sha1
 		;;
 	reword|r)
 		comment_for_reflog reword
 
 		mark_action_done
-		do_pick --edit $sha1 || die_with_patch $sha1 "Could not apply $sha1... $rest"
+		eval do_pick --edit $opts $sha1 \
+			|| die_with_patch $sha1 "Could not apply $sha1... $rest"
 		record_in_rewritten $sha1
 		;;
 	edit|e)
 		comment_for_reflog edit
 
 		mark_action_done
-		do_pick $sha1 || die_with_patch $sha1 "Could not apply $sha1... $rest"
+		eval do_pick $opts $sha1 \
+			|| die_with_patch $sha1 "Could not apply $sha1... $rest"
 		warn "Stopped at $sha1... $rest"
 		exit_with_patch $sha1 0
 		;;
-- 
2.0.1
