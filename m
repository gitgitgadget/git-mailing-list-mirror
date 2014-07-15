From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/2] rebase--am: use --cherry-pick instead of --ignore-if-in-upstream
Date: Tue, 15 Jul 2014 20:14:02 +0100
Message-ID: <47e67c62fb2a8c8846f5d3a12d71aebf8fa875d7.1405451643.git.john@keeping.me.uk>
References: <20140707211456.GA2322@serenity.lan>
Cc: Junio C Hamano <gitster@pobox.com>, Ted Felix <ted@tedfelix.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 15 21:14:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X78BK-0003e3-LD
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 21:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932906AbaGOTO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 15:14:28 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:59798 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932850AbaGOTO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 15:14:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id CD991CDA555;
	Tue, 15 Jul 2014 20:14:25 +0100 (BST)
X-Quarantine-ID: <7Q2uOywXEh51>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7Q2uOywXEh51; Tue, 15 Jul 2014 20:14:24 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id B7BF8CDA52A;
	Tue, 15 Jul 2014 20:14:14 +0100 (BST)
X-Mailer: git-send-email 2.0.1.472.g6f92e5f.dirty
In-Reply-To: <20140707211456.GA2322@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253587>

When using `git format-patch --ignore-if-in-upstream` we are only
allowed to give a single revision range.  In the next commit we will
want to add an additional exclusion revision in order to handle fork
points correctly, so convert `git-rebase--am` to use a symmetric
difference with `--cherry-pick --right-only`.

This does not change the result of the format-patch invocation, just how
we spell the arguments.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-rebase--am.sh | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index ca20e1e..902bf2d 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -29,7 +29,13 @@ skip)
 	;;
 esac
 
-test -n "$rebase_root" && root_flag=--root
+if test -z "$rebase_root"
+	# this is now equivalent to ! -z "$upstream"
+then
+	revisions=$upstream...$orig_head
+else
+	revisions=$onto...$orig_head
+fi
 
 ret=0
 if test -n "$keep_empty"
@@ -38,14 +44,15 @@ then
 	# empty commits and even if it didn't the format doesn't really lend
 	# itself well to recording empty patches.  fortunately, cherry-pick
 	# makes this easy
-	git cherry-pick ${gpg_sign_opt:+"$gpg_sign_opt"} --allow-empty "$revisions"
+	git cherry-pick ${gpg_sign_opt:+"$gpg_sign_opt"} --allow-empty \
+		--right-only "$revisions"
 	ret=$?
 else
 	rm -f "$GIT_DIR/rebased-patches"
 
-	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
+	git format-patch -k --stdout --full-index --cherry-pick --right-only \
 		--src-prefix=a/ --dst-prefix=b/ --no-renames --no-cover-letter \
-		$root_flag "$revisions" >"$GIT_DIR/rebased-patches"
+		"$revisions" >"$GIT_DIR/rebased-patches"
 	ret=$?
 
 	if test 0 != $ret
-- 
2.0.1.472.g6f92e5f.dirty
