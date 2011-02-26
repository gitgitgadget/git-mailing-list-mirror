From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 2/2] merge-recursive: When we detect we can skip an update, actually skip it
Date: Sat, 26 Feb 2011 11:34:57 -0700
Message-ID: <1298745297-25713-3-git-send-email-newren@gmail.com>
References: <20110224115233.GA31356@sigill.intra.peff.net>
 <1298745297-25713-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 26 19:35:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtOzO-0001TU-0K
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 19:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630Ab1BZSfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 13:35:19 -0500
Received: from mail-gw0-f51.google.com ([74.125.83.51]:35461 "EHLO
	mail-gw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372Ab1BZSfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 13:35:16 -0500
Received: by gwb15 with SMTP id 15so1681072gwb.10
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 10:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=QRAmz44W0KkIwbqlKJ2tlqOZQy8U3/upVQcxSs7m4Fk=;
        b=unfgr/mnM3l9MCbtD7625aPUjKk25l+BbnGQwgIm75mqy8vmweOYijQPddwZjGbpRu
         r3wQiPswOB8FJz2jxUnahxia03oCFyLLdvIBJ5HFIISWwE5bDYzC7h8VvC+oST2kz2aN
         ijZtzUzZHpKxdAUynAD+vh/3P/7qR+gUfPoto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gvTujMiitXv8mBEhkRu+UaMg/mDV5RcJcILAO98TZhfWqnbRWfssVcB2MZrBH0cTZr
         KuNhzaeL1O5QA8s9tXC6654YIi/Egd062RlLBkAH3CwredcxqS89w5XQ2CuMVsTc8od5
         vWfmitwTTyFkYBtVxUUmaBBgmW/LeZqoTjscU=
Received: by 10.90.72.17 with SMTP id u17mr5334229aga.180.1298745315077;
        Sat, 26 Feb 2011 10:35:15 -0800 (PST)
Received: from Miney.hsd1.nm.comcast.net. (c-174-56-87-200.hsd1.nm.comcast.net [174.56.87.200])
        by mx.google.com with ESMTPS id b11sm2491718ana.18.2011.02.26.10.35.12
        (version=SSLv3 cipher=OTHER);
        Sat, 26 Feb 2011 10:35:14 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1.23.g4865dd
In-Reply-To: <1298745297-25713-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167988>

In 882fd11 (merge-recursive: Delay content merging for renames 2010-09-20),
the code that checked for whether we could skip updating a file in the
working directory (due to the merged version matching the current copy) was
moved into a separate function.  In order to defer the content merging, we
had to update the index with unmerged entries.  As part of the move, a bug
was introduced such that the message about skipping the update would be
printed (if GIT_MERGE_VERBOSITY was sufficiently high) but the file would
be updated in the working copy anyway.

When we detect that the file does not need to be updated in the working
copy, update the index to remove the unmerged entries and then return early
before updating the working copy.

STILL BROKEN: Unfortunately, this change leaves the index in a state where
the renamed file is only racily clean; a 'git diff-files' will report the
file as modified.

---
No Signed-off-by since it still doesn't work.

 merge-recursive.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 16c2dbe..94b818c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1274,9 +1274,12 @@ static int merge_content(struct merge_options *o,
 	}
 
 	if (mfi.clean && !df_conflict_remains &&
-	    sha_eq(mfi.sha, a_sha) && mfi.mode == a.mode)
+	    sha_eq(mfi.sha, a_sha) && mfi.mode == a.mode) {
 		output(o, 3, "Skipped %s (merged same as existing)", path);
-	else
+		add_cacheinfo(mfi.mode, mfi.sha, path,
+			      0, 0, ADD_CACHE_OK_TO_REPLACE);
+		return mfi.clean;
+	} else
 		output(o, 2, "Auto-merging %s", path);
 
 	if (!mfi.clean) {
-- 
1.7.4.1.23.g4865dd
