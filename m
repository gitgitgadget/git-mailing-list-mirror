From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH/RFC 12/20] rebase: reorder validation steps
Date: Thu, 25 Nov 2010 20:57:55 +0100
Message-ID: <1290715083-16919-13-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 02:59:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLnaz-00026e-Tg
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 02:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390Ab0KZB6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 20:58:49 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48617 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158Ab0KZB6T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 20:58:19 -0500
Received: by mail-vw0-f46.google.com with SMTP id 3so348001vws.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 17:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=aWgH99YTA+r+ttQgGBEoglmwWXmEoHxSlwrxA6gYkBc=;
        b=Y+Br+XK8X+1ec7mr/WajoEbr1DjkYmohMFCri1WfBmRJWr1QJtNBQ/fmdwnDPQFoAb
         N/I5tIFBwWj/+KKBHocxX9qIIEeQOsgqdsgWZn3bJtjhQVmFAzAH2Wa4Gqfzq0uyBZBB
         E6yHPEr4x8/Ndpg6+wW0BF3KYEMApOMrbcTjs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GAToXQTnVtpZKamXcbqrfJMyTty1JFY1dJbSUHcCQTUCSOxSxKCOMAkZsBl3kt8adQ
         s7Q23rNCOqOpL56VJ5DhoXg6qjX7NSNPw96YMXI/CZ+o1jjOHRuwy5fOCb7DEhHhkYLf
         ucnHzHdLghre7EkoDsOeyFk9x2iOzqIKV6tXQ=
Received: by 10.220.94.213 with SMTP id a21mr436669vcn.20.1290736698982;
        Thu, 25 Nov 2010 17:58:18 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id y14sm193301vch.28.2010.11.25.17.58.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 17:58:18 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162179>

Reorder validation steps in preparation for the validation to be factored
out from git-rebase--interactive.sh into git-rebase.sh.

The main functional difference is that the pre-rebase hook will no longer
be run if the work tree is dirty.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase--interactive.sh |    4 ++--
 git-rebase.sh              |   10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 07c10f3..f07472a 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -793,12 +793,12 @@ else
 	test -z "$onto" &&
 		die "You must specify --onto when using --root"
 fi
+require_clean_work_tree "rebase" "Please commit or stash them."
+
 run_pre_rebase_hook "$UPSTREAM_ARG" "$@"
 
 comment_for_reflog start
 
-require_clean_work_tree "rebase" "Please commit or stash them."
-
 if test ! -z "$1"
 then
 	output git checkout "$1" ||
diff --git a/git-rebase.sh b/git-rebase.sh
index 2b19d2f..5b0b73a 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -417,8 +417,6 @@ esac
 
 test -n "$interactive_rebase" && run_interactive_rebase "$@"
 
-require_clean_work_tree "rebase" "Please commit or stash them."
-
 if test -z "$rebase_root"
 then
 	# The upstream head must be given.  Make sure it is valid.
@@ -460,9 +458,6 @@ case "$onto_name" in
 	;;
 esac
 
-# If a hook exists, give it a chance to interrupt
-run_pre_rebase_hook "$upstream_arg" "$@"
-
 # If the branch to rebase is given, that is the branch we will rebase
 # $branch_name -- branch being rebased, or HEAD (already detached)
 # $orig_head -- commit object name of tip of the branch before rebasing
@@ -500,6 +495,8 @@ case "$#" in
 esac
 orig_head=$branch
 
+require_clean_work_tree "rebase" "Please commit or stash them."
+
 # Now we are rebasing commits $upstream..$branch (or with --root,
 # everything leading up to $branch) on top of $onto
 
@@ -521,6 +518,9 @@ then
 	fi
 fi
 
+# If a hook exists, give it a chance to interrupt
+run_pre_rebase_hook "$upstream_arg" "$@"
+
 # Detach HEAD and reset the tree
 say "First, rewinding head to replay your work on top of it..."
 git checkout -q "$onto^0" || die "could not detach HEAD"
-- 
1.7.3.2.864.gbbb96
