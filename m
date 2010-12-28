From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 12/31] rebase: reorder validation steps
Date: Tue, 28 Dec 2010 10:30:29 +0100
Message-ID: <1293528648-21873-13-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:33:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbYi-0005Wr-SA
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:33:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870Ab0L1Pcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:32:47 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56716 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858Ab0L1Pcp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:32:45 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so9391760qwa.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 07:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=9mmfwpA0DKdfy9VpLjRekGhKU8DnCGBEmPGVIgKN6Cs=;
        b=jrOyg+qRIE+ZnjYYMwLpMsa1rwLK2ZSz+9h62jogYUFRJggpr9HznlTxGKbEEikQ/x
         FQkoZKdeME2j11leS7Ne8T/T9+BwaX8PMiNwfhBOyhRqXWTsHKLhwZPWlVfP7AMwS23p
         D8ZpPHWWMwrCC0rXfLxz2PHUzyMZcdY0TXKVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CA2+Xyn1mqLFd6+MMHtuD6beCZSLXSDDjIeEzEkcSJhowG00igy8lyRrz4LpRS4GcA
         GeX55o0zksJZXQaq1geMfKfZHHbz7ARtmfzyRUApXlsvSt3tx5gLNbHGBW3wx+sN2u4U
         +r3CJ5PQokGf2FbOv4/whOTS9aqGGqq8Ingvw=
Received: by 10.229.212.6 with SMTP id gq6mr12141656qcb.150.1293550364334;
        Tue, 28 Dec 2010 07:32:44 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6222962qco.35.2010.12.28.07.32.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:32:43 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164246>

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
index 21a9774..5a8f582 100755
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
 	output git checkout "$1" ||
diff --git a/git-rebase.sh b/git-rebase.sh
index e646b8f..26e4218 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -435,8 +435,6 @@ fi
 
 test "$type" = interactive && run_interactive_rebase "$@"
 
-require_clean_work_tree "rebase" "Please commit or stash them."
-
 if test -z "$rebase_root"
 then
 	# The upstream head must be given.  Make sure it is valid.
@@ -478,9 +476,6 @@ case "$onto_name" in
 	;;
 esac
 
-# If a hook exists, give it a chance to interrupt
-run_pre_rebase_hook "$upstream_arg" "$@"
-
 # If the branch to rebase is given, that is the branch we will rebase
 # $branch_name -- branch being rebased, or HEAD (already detached)
 # $orig_head -- commit object name of tip of the branch before rebasing
@@ -518,6 +513,8 @@ case "$#" in
 esac
 orig_head=$branch
 
+require_clean_work_tree "rebase" "Please commit or stash them."
+
 # Now we are rebasing commits $upstream..$branch (or with --root,
 # everything leading up to $branch) on top of $onto
 
@@ -539,6 +536,9 @@ then
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
