From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v2 23/23] rebase -i: enable options --signoff, --reset-author for pick, reword
Date: Thu,  7 Aug 2014 01:59:30 +0200
Message-ID: <ed19a079924e11edac0163837500c2e8caa2a555.1407368621.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1407368621.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 02:01:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFB90-0004eT-Jj
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 02:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601AbaHGABF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 20:01:05 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:54396 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584AbaHGABD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 20:01:03 -0400
Received: by mail-qg0-f50.google.com with SMTP id q108so3533384qgd.23
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 17:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0PO5AMmW4HAiHc1pocKJB+j70ZFSSHTScJW7c7CdsEM=;
        b=KG9TJL8L8d0I8e22fVD+eSDSrwDky6mz4+Sd8SLns8YEh1+xGOeVz8f82L4oPJmsST
         1d0QFYUsQOyT3qRuy170UP6zK8r6l8zrShQ5E8mXXMPaI1TpTSqqtYh0GYSdFJ0/AS9w
         cEPm9OhVgMzY5K7M9lwIXFdyR1PEXZKV0uK3X03kiBY1mIuvTsQ7XEVKqTYr9GIC71ls
         vhZ5mdLQRjczw1lapP7pKgXPl3y45D8/DgyQKO4EEcK1oFNj0+EsNvAiv4kICVnNUY0Z
         1b/S05v8gnkjbjJ/WsENKHffWIfivJ5wfJo7cCb4Zq0f3Q0lSvO00rAl47e83hxyndmS
         EwaA==
X-Received: by 10.224.26.84 with SMTP id d20mr21863464qac.11.1407369663200;
        Wed, 06 Aug 2014 17:01:03 -0700 (PDT)
Received: from puffy.localdomain (HSI-KBW-046-005-203-106.hsi8.kabel-badenwuerttemberg.de. [46.5.203.106])
        by mx.google.com with ESMTPSA id n74sm2637391qga.34.2014.08.06.17.01.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Aug 2014 17:01:02 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1407368621.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254937>

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
index a22459f..4c05734 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -614,6 +614,16 @@ do_replay () {
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
@@ -634,21 +644,24 @@ do_replay () {
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
