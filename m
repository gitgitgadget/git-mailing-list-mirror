From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 7/8] rebase: write better reflog messages
Date: Tue, 18 Jun 2013 17:44:29 +0530
Message-ID: <1371557670-12534-8-git-send-email-artagnon@gmail.com>
References: <1371557670-12534-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 14:18:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UourL-0008Sz-7D
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 14:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177Ab3FRMRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 08:17:51 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34785 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932115Ab3FRMRt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 08:17:49 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so3849187pde.9
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 05:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=PGoSFwZNe0aWugaEu+WgpfOtoFd8qLn/QmW4jFEef/M=;
        b=sUCLAta+duxvFbMDcmuAESPulabs79Ee/vZoyIlCKNqegq0nCY2sFGGUHdjLpn46SZ
         qLOfFbVTtBOL3Ry9kalc8UXe4cRMk45Gquak8WNsCMIXXh+tZyV5tabX2LbF6Ap7gEoe
         80/kg+dL6a8DCeHyE42cJyt7woQ3ke+KAPQ64ZKc4txMWVMzTlIKQJNZgPpRf1QTrfrl
         15snzFo4TseSQSrTtgBXFZHxTMkCs9LlDVyiLOKOcnXi8ojlxl9ErFTo845oSctYo3i1
         I8r1tAOEHIUy+RbNOpztobp499MdN7ORJucXmz63Go1dEQm+lIQQGAFcXaotOA2AXJXA
         4afg==
X-Received: by 10.66.146.164 with SMTP id td4mr1928450pab.106.1371557869386;
        Tue, 18 Jun 2013 05:17:49 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id fm2sm19398332pab.13.2013.06.18.05.17.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 05:17:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.456.gb7f4cb6
In-Reply-To: <1371557670-12534-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228209>

Now that the "checkout" invoked internally from "rebase" knows to honor
GIT_REFLOG_ACTION, we can start to use it to write a better reflog
message when "rebase anotherbranch", "rebase --onto branch",
etc. internally checks out the new fork point.  We will write:

  rebase: checkout master

instead of the old

  rebase

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-rebase--am.sh | 2 ++
 git-rebase.sh     | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 34e3102..d4bade8 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -40,9 +40,11 @@ else
 		rm -f "$GIT_DIR/rebased-patches"
 		case "$head_name" in
 		refs/heads/*)
+			GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $head_name"
 			git checkout -q "$head_name"
 			;;
 		*)
+			GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $orig_head"
 			git checkout -q "$orig_head"
 			;;
 		esac
diff --git a/git-rebase.sh b/git-rebase.sh
index d0c11a9..b43600d 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -543,7 +543,11 @@ then
 	if test -z "$force_rebase"
 	then
 		# Lazily switch to the target branch if needed...
-		test -z "$switch_to" || git checkout "$switch_to" --
+		if test -n "$switch_to"
+		then
+			GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to"
+			git checkout "$switch_to" --
+		fi
 		say "$(eval_gettext "Current branch \$branch_name is up to date.")"
 		exit 0
 	else
@@ -568,6 +572,8 @@ test "$type" = interactive && run_specific_rebase
 
 # Detach HEAD and reset the tree
 say "$(gettext "First, rewinding head to replay your work on top of it...")"
+
+GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
 git checkout -q "$onto^0" || die "could not detach HEAD"
 git update-ref ORIG_HEAD $orig_head
 
-- 
1.8.3.1.456.gb7f4cb6
