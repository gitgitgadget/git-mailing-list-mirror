From: newren@gmail.com
Subject: [PATCHv3 6/6] fast-import: Improve robustness when D->F changes provided in wrong order
Date: Tue,  6 Jul 2010 23:20:34 -0600
Message-ID: <1278480034-22939-7-git-send-email-newren@gmail.com>
References: <1278480034-22939-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, spearce@spearce.org, agladysh@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 07 07:13:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWMwr-0002I3-S6
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 07:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874Ab0GGFNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 01:13:22 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47654 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743Ab0GGFNN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 01:13:13 -0400
Received: by mail-gx0-f174.google.com with SMTP id 23so3440291gxk.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 22:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=MMpzThI55mv5IWs2y7WnvJCLzbtzRz5qsgypI4mGfKY=;
        b=NDlPvMLN+7f6INk4TT/8zOZa7FlnCPwUDIdyRLlgPyf3gOQIb72de/cInKFjP04Rws
         kZAnYrq0ja2syRWrQP//OnUyzFG+2esKsZ5fYgFoM9Wnfe95OV/hCIUKcZ7uA0UDUS5/
         Cwm+eRlDYrjGx706Kd2g6LNSfvrQAznYUd09Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CNprScCqqVGIMI58MWcWQEhXhI9G6De4/gd7pSwpqiIgESAVuh/YRMDMjCX0vlivkI
         g1+SfWBkUxJ1WHADEwe0v8TnLVHkXVhMKGUxo3XmSfyVUZE1QXcTVE8DhbAsOkTS75pX
         yYPfnkL18xJ55cJcpFBiWFgq05YyAx3+ulhQc=
Received: by 10.101.158.39 with SMTP id k39mr7213678ano.203.1278479592811;
        Tue, 06 Jul 2010 22:13:12 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-59-120.hsd1.nm.comcast.net [76.113.59.120])
        by mx.google.com with ESMTPS id h5sm60464675anb.28.2010.07.06.22.13.10
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 22:13:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1.10.g6dbc5
In-Reply-To: <1278480034-22939-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150444>

From: Elijah Newren <newren@gmail.com>

When older versions of fast-export came across a directory changing to a
symlink (or regular file), it would output the changes in the form
  M 120000 :239821 dir-changing-to-symlink
  D dir-changing-to-symlink/filename1
When fast-import sees the first line, it deletes the directory named
dir-changing-to-symlink (and any files below it) and creates a symlink in
its place.  When fast-import came across the second line, it was previously
trying to remove the file and relevant leading directories in
tree_content_remove(), and as a side effect it would delete the symlink
that was just created.  This resulted in the symlink silently missing from
the resulting repository.

To improve robustness, we ignore file deletions underneath directory names
that correspond to non-directories.  This can also be viewed as a minor
optimization: since there cannot be a file and a directory with the same
name in the same directory, the file clearly can't exist so nothing needs
to be done to delete it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Quoting Shawn's comments on the previous version of this patch:

  I'm not against making the input parser more robust...

  It probably makes sense to still do this in fast-import, deleting
  something that doesn't exist is probably OK, its still going to
  be deleted in the end anyway.

I'm guessing that probably qualifies as an Acked-by, but I'm not quite
sure.  However, I made a minor change to the patch: the previous
version only handled directory->symlink changes (S_ISLNK), whereas
this one also handles directory->(normal)file changes and
directory->gitlink changes (!S_ISDIR).

 fast-import.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 309f2c5..c8c717a 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1528,6 +1528,13 @@ static int tree_content_remove(
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
 		if (e->name->str_len == n && !strncmp(p, e->name->str_dat, n)) {
+			if (slash1 && !S_ISDIR(e->versions[1].mode))
+				/* If p names a file in some subdirectory, and a
+				 * file or symlink matching the name of the
+				 * parent directory of p exists, then p cannot
+				 * exist and need not be deleted.
+				 */
+				return 1;
 			if (!slash1 || !S_ISDIR(e->versions[1].mode))
 				goto del_entry;
 			if (!e->tree)
-- 
1.7.1.1.10.g2e807
