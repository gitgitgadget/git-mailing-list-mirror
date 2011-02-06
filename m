From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 12/31] rebase: reorder validation steps
Date: Sun,  6 Feb 2011 13:43:41 -0500
Message-ID: <1297017841-20678-13-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 19:47:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm9e8-0005ZO-Vp
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672Ab1BFSqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:46:13 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58585 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653Ab1BFSqH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:46:07 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so3014077qwa.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=CSxjEkJXn/8Gzdgs5JZV0bvrQUcAC6IN7qZB74OOwNs=;
        b=Eo0jzKN1XOzL1iOwgvj4sJnUdgjRLvGAm3EBc7QHL1SZa/huBy0HuwZTz+o7w0+Ig+
         VvmWhW73+n4klurGAfVaT9htcXvyl6c4LIF9/CqBfv34n7qZt6JdGPYCVuWtHBR8z2lv
         jr8dV9FatnaRDo1qyrNqBNwC2S0nwAdvvMt+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rZTIljGQYHSXXq+U84fzEgb/FxQ5TgKqdhgsPRJ5AfVLn4uktxumfxLS6GUd1BCiC4
         TTOvJiyb69A7Cafv1YMReokTHUIvLjOqCflUyo8OEyX6fUgIMQ1vIR1LUUh0HIxj96KA
         WtReNobza+FG/PjoTc8Yvev+yLUnJG+fhkjgY=
Received: by 10.224.19.207 with SMTP id c15mr13157688qab.50.1297017967167;
        Sun, 06 Feb 2011 10:46:07 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.46.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:46:06 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166173>

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
index 4f4fb29..0f04f36 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -792,12 +792,12 @@ else
 	test -z "$onto" &&
 		die "You must specify --onto when using --root"
 fi
+require_clean_work_tree "rebase" "Please commit or stash them."
+
 run_pre_rebase_hook "$upstream_arg" "$@"
 
 comment_for_reflog start
 
-require_clean_work_tree "rebase" "Please commit or stash them."
-
 if test ! -z "$1"
 then
 	output git checkout "$1" -- ||
diff --git a/git-rebase.sh b/git-rebase.sh
index aa1bcaf..4a83d10 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -433,8 +433,6 @@ fi
 
 test "$type" = interactive && run_interactive_rebase "$@"
 
-require_clean_work_tree "rebase" "Please commit or stash them."
-
 if test -z "$rebase_root"
 then
 	# The upstream head must be given.  Make sure it is valid.
@@ -476,9 +474,6 @@ case "$onto_name" in
 	;;
 esac
 
-# If a hook exists, give it a chance to interrupt
-run_pre_rebase_hook "$upstream_arg" "$@"
-
 # If the branch to rebase is given, that is the branch we will rebase
 # $branch_name -- branch being rebased, or HEAD (already detached)
 # $orig_head -- commit object name of tip of the branch before rebasing
@@ -517,6 +512,8 @@ case "$#" in
 esac
 orig_head=$branch
 
+require_clean_work_tree "rebase" "Please commit or stash them."
+
 # Now we are rebasing commits $upstream..$branch (or with --root,
 # everything leading up to $branch) on top of $onto
 
@@ -538,6 +535,9 @@ then
 	fi
 fi
 
+# If a hook exists, give it a chance to interrupt
+run_pre_rebase_hook "$upstream_arg" "$@"
+
 # Detach HEAD and reset the tree
 say "First, rewinding head to replay your work on top of it..."
 git checkout -q "$onto^0" || die "could not detach HEAD"
-- 
1.7.4.rc2.33.g8a14f
