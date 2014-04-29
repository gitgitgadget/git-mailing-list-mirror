From: Chris Packham <judge.packham@gmail.com>
Subject: [GIT GUI PATCH] git-gui: unconditionally use rev-parse --show-toplevel
Date: Tue, 29 Apr 2014 22:58:22 +1200
Message-ID: <1398769102-6401-1-git-send-email-judge.packham@gmail.com>
References: <CAFOYHZD=wxwm0nLhtZwvXDAhQ23j0C5maArQunc0CVe_-SF_mQ@mail.gmail.com>
Cc: Chris Packham <judge.packham@gmail.com>
To: patthoyts@users.sourceforge.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 12:58:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf5kP-0007Kc-OW
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 12:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933685AbaD2K6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 06:58:45 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:61027 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933674AbaD2K6o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 06:58:44 -0400
Received: by mail-pd0-f178.google.com with SMTP id fp1so29043pdb.9
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 03:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dMWD6FA/pwQwRIrzFvxBa577UpQgP14JqX0aiPjX5b0=;
        b=JyJTRQiyp3C9aBcaeCQZqAtRIdTsbQaDMf82/XEsKJQJhER6iPxESO3zLUrxP6Wqtq
         ejvgvYm7Xxvdu3+fH3lfSUJJpr6QOLdX5z741E/15tcaS23aMbhqvm2ByWG7wnq8Xfls
         Jx1jp2qC03pVG7HpavefsMTFLoAApoDVR3ESulVkc5iCxq3chZEwUTmXkcfn6MtkMEYv
         Ui/KKrO0jkrW9sFqYabMoyZdw5oiVqLS/MRAjebreS5Kn4J8xCA3UzSNqnBr1tCZ0em/
         +jrIOG3RWOJcIMaZ0AsTwRLBhJyKGxoETcYq6SgFdN8yxb07SgZijAGPoHhhZno5/C4t
         fszQ==
X-Received: by 10.66.102.39 with SMTP id fl7mr32027041pab.43.1398769121899;
        Tue, 29 Apr 2014 03:58:41 -0700 (PDT)
Received: from linux.lan (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id qx11sm108265024pab.35.2014.04.29.03.58.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 03:58:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.rc1.4.g27db5a0
In-Reply-To: <CAFOYHZD=wxwm0nLhtZwvXDAhQ23j0C5maArQunc0CVe_-SF_mQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247564>

Previously 'git rev-parse --show-toplevel' was used to determine the
canonical work-tree only when the installed git version was detected to
be 1.7.0 or better. The fall-back logic used the core.worktree config
variable which in the case of a submodule is a relative path from the
submodule's $GIT_DIR. Unfortunately vsatisfies doesn't handle versions
like v2.0.0.rc0 so the fall-back logic is triggered.

Given the fact that git 1.7.0 was released over 4 years ago rather than
fixing the fall-back logic it seems reasonable to drop the version
check.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
So I'm not sure if vsatisfies is failing because the version has .rc0 or
because it thinks v2.0.0 < 1.7.0. Regardless I think it's reasonably safe to
assume that people who are using the newer versions of git-gui are running new
enough versions of git.

There is also a similar section in rescan_stage2 that is checking for the
version being 1.6.3 or newer. Again I think it's probably safe to assume that
no-one is running a version of git that old (or at least no-one that wants to
run this version of git-gui). I'm not quite sure how to excercise that bit of
code so I haven't attempted to fix that.

 git-gui.sh | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index cf2209b..9ded5b9 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1282,23 +1282,11 @@ if {![file isdirectory $_gitdir]} {
 load_config 0
 apply_config
 
-# v1.7.0 introduced --show-toplevel to return the canonical work-tree
-if {[package vsatisfies $_git_version 1.7.0]} {
-	if { [is_Cygwin] } {
-		catch {set _gitworktree [exec cygpath --windows [git rev-parse --show-toplevel]]}
-	} else {
-		set _gitworktree [git rev-parse --show-toplevel]
-	}
+# Determine the canonical work-tree
+if { [is_Cygwin] } {
+	catch {set _gitworktree [exec cygpath --windows [git rev-parse --show-toplevel]]}
 } else {
-	# try to set work tree from environment, core.worktree or use
-	# cdup to obtain a relative path to the top of the worktree. If
-	# run from the top, the ./ prefix ensures normalize expands pwd.
-	if {[catch { set _gitworktree $env(GIT_WORK_TREE) }]} {
-		set _gitworktree [get_config core.worktree]
-		if {$_gitworktree eq ""} {
-			set _gitworktree [file normalize ./[git rev-parse --show-cdup]]
-		}
-	}
+	set _gitworktree [git rev-parse --show-toplevel]
 }
 
 if {$_prefix ne {}} {
-- 
1.8.2.rc1.4.g27db5a0
