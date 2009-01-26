From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: [PATCH] Allow format-patch to create patches for merges
Date: Mon, 26 Jan 2009 08:04:10 -0600
Message-ID: <1232978650-7008-1-git-send-email-nathan.panike@gmail.com>
Cc: "Nathan W. Panike" <nathan.panike@gmail.com>,
	Johannes.Schindelin@gmx.de, gitster@pobox.com, aspotashev@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 15:06:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRS5t-0007Kf-M5
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 15:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbZAZOEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 09:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbZAZOEP
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 09:04:15 -0500
Received: from wf-out-1314.google.com ([209.85.200.168]:10344 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbZAZOEO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 09:04:14 -0500
Received: by wf-out-1314.google.com with SMTP id 27so6895179wfd.4
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 06:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=rIGtNsyqpfBtGS/94nzEW34cN2X/Rq1lU47FezLKa/w=;
        b=bSYD+/U5jMllYSKz9n/r5sTU35qGW6qe3mdljWCZW3P6Td3SsqcNRMZUgjKzls+d9u
         RsWr8t35UXQlZcGrV3oftE9fwUgvGovPVd+RABLn6dRB6Bhg+yNsvw0+bZvSBdl1PbIV
         TY/PHt8FZRb5tXx70gb2gzV6gAl80XYdMKAsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=prm4f+1LmStyhP8ZxPGfjutYfmuHBbXssxDyrOnnPtz453AkejRVJS1U1UWmRncjQJ
         Ukk/nmVHbEAGT4on/5AM3mdfK8be8WI41KO12SQ7x059WzgUTAI+ePWIeGYt6AqA+dNx
         985wY1lv46/J3ozS8TnZVMqBvsEUFD37YonHs=
Received: by 10.142.125.4 with SMTP id x4mr357805wfc.223.1232978653836;
        Mon, 26 Jan 2009 06:04:13 -0800 (PST)
Received: from localhost (adsl-76-204-100-245.dsl.mdsnwi.sbcglobal.net [76.204.100.245])
        by mx.google.com with ESMTPS id 22sm23081242wfg.30.2009.01.26.06.04.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jan 2009 06:04:13 -0800 (PST)
X-Mailer: git-send-email 1.6.1.1.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107211>

The behavior for git format-patch is to ignore merge commits, producing an
empty patch.  The code does not allow the user to change this behavior. This
patch changes that behavior by allowing the user to specify -c or -m at the
command line to produce a patch for a merge commit.
---
Hi:

I am sure there are good reasons for the current behavior of format-patch, but
it seems to me that if the user explicitly wants to produce a patch for a merge
commit, he should be allowed to do so.  If merge_commit represents a merge,
then this patch allows the user to issue the command

git format-patch -m -1 $merge_commit 

or 

git format-patch -c -1 $merge_commit

and actually produce a patch.  The current behavior is that neither command
will produce a patch.  With or without the patch applied, the command

git format-patch -1 $merge_commit

does not produce a patch when merge_commit is a merge.  Thus the patch does not
change the default behavior of ignoring merges, at least by the limited testing
I have done.  

Thanks for your consideration.

Nathan Panike

 builtin-log.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 2ae39af..ea4729d 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -994,10 +994,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		/* ignore merges */
-		if (commit->parents && commit->parents->next)
-			continue;
-
 		if (ignore_if_in_upstream &&
 				has_commit_patch_id(commit, &ids))
 			continue;
-- 
1.6.1.1.GIT
