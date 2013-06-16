From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 2/6] rebase: prepare to write reflog message for checkout
Date: Sun, 16 Jun 2013 14:15:12 +0530
Message-ID: <1371372316-16059-3-git-send-email-artagnon@gmail.com>
References: <1371372316-16059-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 16 10:47:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uo8ch-00028h-Vx
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 10:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755024Ab3FPIr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 04:47:28 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:42797 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754911Ab3FPIrK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 04:47:10 -0400
Received: by mail-pa0-f42.google.com with SMTP id rl6so1923437pac.15
        for <git@vger.kernel.org>; Sun, 16 Jun 2013 01:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=di/cYfKY1t+54pHGCmru6DAhEWsHyYIxuyQkzjw7Dyw=;
        b=uxJoz2BiDG0285kpv4vpTCv4sS6/p1XMOfuS2U5ZEToZNJDZP8pd2rPdY5SHcLkZ0Q
         p8vsThpD02LAdLvLihSPpO+cyUCLfsTEVPynmEJT3OU87M8xzcIDsxu3gnzQoqfSLUrK
         NlQqgyDeBHccrlVZbpu+MPgn2oupNTjdNxSMCyFXa74DTHUq/eoYmOtbrdkLwl6nbrF+
         9DnOANtTQlDdUwUo19Tn1DnKY8LVREeB/dqWXVzzDo1mCQAt4f4ZFxnjYF/DU47r8bMD
         HHMriEJigLBv7rrL7o2s1Yl7UfsUz1glSfQp5giQD5IWVVM9Ek0BXFP8aMeQCnF9Ncfs
         3N9w==
X-Received: by 10.68.213.231 with SMTP id nv7mr8877042pbc.70.1371372429603;
        Sun, 16 Jun 2013 01:47:09 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id vu5sm9917919pab.10.2013.06.16.01.47.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 16 Jun 2013 01:47:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.443.g4fd77b9
In-Reply-To: <1371372316-16059-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227998>

The branch-flipping rebase internally does is not 'checkout' as far as
the end-user is concerned; therefore, rebase should never write
"checkout: " messages to the reflog.  To achieve this, set a sensible
GIT_REFLOG_ACTION; checkout does not respect this variable yet, but a
future patch will change this.

After that patch, rebase will write the following line to the reflog
when started:

  rebase: checkout master

This is much better than the confusing message it currently writes:

  checkout: moving from master to 1462b67

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-rebase.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-rebase.sh b/git-rebase.sh
index d0c11a9..6587019 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -568,6 +568,8 @@ test "$type" = interactive && run_specific_rebase
 
 # Detach HEAD and reset the tree
 say "$(gettext "First, rewinding head to replay your work on top of it...")"
+
+GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
 git checkout -q "$onto^0" || die "could not detach HEAD"
 git update-ref ORIG_HEAD $orig_head
 
-- 
1.8.3.1.443.g4fd77b9
