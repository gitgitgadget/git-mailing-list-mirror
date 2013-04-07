From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/2] submodule: drop the top-level requirement
Date: Sun,  7 Apr 2013 20:55:21 +0100
Message-ID: <da121bcc33e63b7f33318ef920e85a77bb304d44.1365364193.git.john@keeping.me.uk>
References: <cover.1365364193.git.john@keeping.me.uk>
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 08:45:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5p7-0000sy-Ug
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933864Ab3DGTzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 15:55:48 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:55121 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933821Ab3DGTzr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 15:55:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id EE9F16064E0;
	Sun,  7 Apr 2013 20:55:46 +0100 (BST)
X-Quarantine-ID: <jQ+L9ybRnPiM>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.999
X-Spam-Level: 
X-Spam-Status: No, score=-0.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jQ+L9ybRnPiM; Sun,  7 Apr 2013 20:55:46 +0100 (BST)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id D9EAD6064AA;
	Sun,  7 Apr 2013 20:55:39 +0100 (BST)
X-Mailer: git-send-email 1.8.2.694.ga76e9c3.dirty
In-Reply-To: <cover.1365364193.git.john@keeping.me.uk>
In-Reply-To: <cover.1365364193.git.john@keeping.me.uk>
References: <cover.1365364193.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220368>

Use the new rev-parse --filename-prefix option to process all paths
given to the submodule command, dropping the requirement that it be run
from the top-level of the repository.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-submodule.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index 79bfaac..10216aa 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -14,10 +14,13 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <re
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
 OPTIONS_SPEC=
+SUBDIRECTORY_OK=Yes
 . git-sh-setup
 . git-sh-i18n
 . git-parse-remote
 require_work_tree
+wt_prefix=$(git rev-parse --show-prefix)
+cd_to_toplevel
 
 command=
 branch=
@@ -112,6 +115,7 @@ resolve_relative_url ()
 #
 module_list()
 {
+	eval "set $(git rev-parse --sq --filename-prefix "$wt_prefix" -- "$@")"
 	(
 		git ls-files --error-unmatch --stage -- "$@" ||
 		echo "unmatched pathspec exists"
@@ -335,6 +339,8 @@ cmd_add()
 		usage
 	fi
 
+	sm_path="$wt_prefix$sm_path"
+
 	# assure repo is absolute or relative to parent
 	case "$repo" in
 	./*|../*)
@@ -942,6 +948,7 @@ cmd_summary() {
 	fi
 
 	cd_to_toplevel
+	eval "set $(git rev-parse --sq --filename-prefix "$wt_prefix" -- "$@")"
 	# Get modified modules cared by user
 	modules=$(git $diff_cmd $cached --ignore-submodules=dirty --raw $head -- "$@" |
 		sane_egrep '^:([0-7]* )?160000' |
-- 
1.8.2.694.ga76e9c3.dirty
