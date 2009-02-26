From: Deskin Miller <deskinm@umich.edu>
Subject: [RFC PATCH 2/4] Add attach_reflog_info
Date: Wed, 25 Feb 2009 23:44:05 -0500
Message-ID: <dde2a04808e6791dafecfab811b6c55ba252c3c5.1235622145.git.deskinm@umich.edu>
References: <cover.1235622145.git.deskinm@umich.edu>
Cc: trast@student.ethz.ch, Deskin Miller <deskinm@umich.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 05:46:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcY8M-0000kl-74
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 05:46:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754395AbZBZEo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 23:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753923AbZBZEoZ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 23:44:25 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:18918 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753200AbZBZEoU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 23:44:20 -0500
Received: by yx-out-2324.google.com with SMTP id 8so295004yxm.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 20:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:in-reply-to
         :references;
        bh=kIcZHYH1DrYn5If8Yx7Dk4r0piwACuehjHxvqYiMvqs=;
        b=syCz0ivmrEdqi9PeKZ6wa5odmG3ohTyL/ITp6C+vVgaBWJqUcx0B2ATqSvlizydhwe
         OEiQ4bkpVSEvy3EactjDhuhr1+ICvdfMi4fPxOVy2bR9wRqwWWGpTg59PKgyK2m0Rfo7
         K6ToTidjNV6c2SWFA/+Zcoo+PtKGHgyE7anMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=TUeHg/VI3faZAH10d7/EGKrMd3Kf4yFNqja78SWDEf+9qY+6GpI2HvdS458c5+eRjq
         S8PGSQthvhkqb/upfVPp6iWYN86VaZ/zuyADsoRT547Fth7cl94o6T3H4nic88WWFn+1
         xMTOjJLHrkWIpfMnruaOCt32eDfkVCrinDtsg=
Received: by 10.231.15.130 with SMTP id k2mr1386891iba.3.1235623457183;
        Wed, 25 Feb 2009 20:44:17 -0800 (PST)
Received: from localhost.localdomain (67-194-38-22.wireless.umnet.umich.edu [67.194.38.22])
        by mx.google.com with ESMTPS id s35sm3517319qbs.6.2009.02.25.20.44.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Feb 2009 20:44:16 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.90.g0753
In-Reply-To: <cover.1235622145.git.deskinm@umich.edu>
In-Reply-To: <cover.1235622145.git.deskinm@umich.edu>
References: <cover.1235622145.git.deskinm@umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111525>

To enable pretty-printing to print reflog information, the commit object
needs to carry its associated reflog entry.  This function uses the util
field to point to the appropriate struct reflog_info.

Signed-off-by: Deskin Miller <deskinm@umich.edu>
---
 reflog-walk.c |   18 ++++++++++++++++++
 reflog-walk.h |    2 ++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index dd172ae..3e8457f 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -235,6 +235,24 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 	commit->object.flags &= ~(ADDED | SEEN | SHOWN);
 }
 
+void attach_reflog_info(struct reflog_walk_info *info, struct commit *commit)
+{
+	if (info && info->last_commit_reflog) {
+		struct commit_reflog *commit_reflog = info->last_commit_reflog;
+
+		if (commit->util &&
+		    (((void *)(commit_reflog->reflogs->items
+			       + commit_reflog->reflogs->nr) < commit->util)
+		     || ((void *)(commit_reflog->reflogs->items +
+				  commit_reflog->recno + 1) > commit->util))) {
+			die("commit->util being used, cannot attach reflog");
+		}
+
+		commit->util = &commit_reflog->reflogs->items
+			[commit_reflog->recno+1];
+	}
+}
+
 void show_reflog_message(struct reflog_walk_info* info, int oneline,
 	int relative_date)
 {
diff --git a/reflog-walk.h b/reflog-walk.h
index 7b00993..44f97e1 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -16,6 +16,8 @@ extern int add_reflog_for_walk(struct reflog_walk_info *info,
 		struct commit *commit, const char *name);
 extern void fake_reflog_parent(struct reflog_walk_info *info,
 		struct commit *commit);
+extern void attach_reflog_info(struct reflog_walk_info *info,
+		struct commit *commit);
 extern void show_reflog_message(struct reflog_walk_info *info, int, int);
 
 #endif
-- 
1.6.2.rc0.90.g0753
