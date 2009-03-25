From: newren@gmail.com
Subject: Re: [PATCH] fast-export: Avoid dropping files from commits
Date: Wed, 25 Mar 2009 17:53:23 -0600
Message-ID: <1238025203-27194-1-git-send-email-newren@gmail.com>
References: <alpine.DEB.1.00.0903252312460.26370@intel-tinevez-2-302>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Elijah Newren <newren@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Thu Mar 26 00:56:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmcxC-0002w4-1q
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 00:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbZCYXyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 19:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbZCYXyn
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 19:54:43 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:40933 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbZCYXym (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 19:54:42 -0400
Received: by wf-out-1314.google.com with SMTP id 29so320741wff.4
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 16:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=eKcHEiwpLiQZH0zB838nY6uYIxCWdrOibH5hYdvbRnM=;
        b=T2hHgXcfYOzX5uESsGfwJPovVOtk4QvRjQX5NOHE7nGg39DoEPxjn/zJTalC63WJjx
         cXk80lGXFXYueEwVY/EzPbbPx+zsuJhkqDHZt+mTMgaU5sNqivbVwmLZ4M9nPqGNfXyC
         QPODGnGw/HIdESKHHctBat5/DaOyNky7WQtmE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hMsi2n4SU1KH4xtbiVqTJnKfWzDbYKLZLSNERLvcpX+SrU0a+n47CTcG0iColhbIX3
         h6kna6DCvEUo+pUdnHBEqJy82f7z5dvDb4PxVud2p4krPA9sVcE4MJdtVdaFJoXNHxkI
         MtW1+s701oCbrbSJkmAdJRaAvA/R/jdDOJR00=
Received: by 10.142.84.5 with SMTP id h5mr79211wfb.81.1238025280855;
        Wed, 25 Mar 2009 16:54:40 -0700 (PDT)
Received: from localhost.localdomain (c-69-254-130-124.hsd1.nm.comcast.net [69.254.130.124])
        by mx.google.com with ESMTPS id 22sm16730974wfd.46.2009.03.25.16.54.39
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Mar 2009 16:54:40 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.317.gb96244
In-Reply-To: <alpine.DEB.1.00.0903252312460.26370@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114693>

From: Elijah Newren <newren@gmail.com>

When exporting a subset of commits on a branch that do not go back to a
root commit (e.g. master~2..master), we still want each exported commit to
have the same files in the exported tree as in the original tree.

Previously, when given such a range, we would omit master~2 as a parent of
master~1, but we would still diff against master~2 when selecting the list
of files to include in master~1.  This would result in only files that
had changed in the given range showing up in the resulting export.  In such
cases, we should diff master~1 against the root instead (i.e. use
diff_root_tree_sha1 instead of diff_tree_sha1).

There's a special case to consider here: incremental exports (i.e. exports
where the --import-marks flag is specified).  If master~2 is an imported
mark, then we still want to diff master~1 against master~2 when selecting
the list of files to include.

We can handle all cases, including the special case, by just checking
whether master~2 corresponds to a known object mark when deciding what to
diff against.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin-fast-export.c  |    3 ++-
 t/t9301-fast-export.sh |    7 +++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index fdf4ae9..34a419c 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -221,7 +221,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 	if (message)
 		message += 2;
 
-	if (commit->parents) {
+	if (commit->parents &&
+	    get_object_mark(&commit->parents->item->object) != 0) {
 		parse_commit(commit->parents->item);
 		diff_tree_sha1(commit->parents->item->tree->object.sha1,
 			       commit->tree->object.sha1, "", &rev->diffopt);
diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index 86c3760..b860626 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -8,6 +8,9 @@ test_description='git fast-export'
 
 test_expect_success 'setup' '
 
+	echo break it > file0 &&
+	git add file0 &&
+	test_tick &&
 	echo Wohlauf > file &&
 	git add file &&
 	test_tick &&
@@ -57,8 +60,8 @@ test_expect_success 'fast-export master~2..master' '
 		(cd new &&
 		 git fast-import &&
 		 test $MASTER != $(git rev-parse --verify refs/heads/partial) &&
-		 git diff master..partial &&
-		 git diff master^..partial^ &&
+		 git diff --exit-code master partial &&
+		 git diff --exit-code master^ partial^ &&
 		 test_must_fail git rev-parse partial~2)
 
 '
-- 
1.6.0.6
