From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] fix recursive-merge of empty files with different
	permissions
Date: Sat, 8 Mar 2008 18:17:26 +0100
Message-ID: <20080308171726.GA16129@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 18:18:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY2gV-0000dG-IM
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 18:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbYCHRRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 12:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753033AbYCHRRd
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 12:17:33 -0500
Received: from hu-out-0506.google.com ([72.14.214.229]:56709 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbYCHRRd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 12:17:33 -0500
Received: by hu-out-0506.google.com with SMTP id 19so735905hue.21
        for <git@vger.kernel.org>; Sat, 08 Mar 2008 09:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent:sender;
        bh=bs2EL760WmaG8G6VdMl0gnpeW6cgt6Es7sdMHeKHLdY=;
        b=ujxRMgXjYexu1QXJn9+AzKqS5zKbmj7g6qkxN+WWn1NXS3tJHgaTmRQKpCFfCRiNImMnaeBfRcUs3Cp2Qu8gpeVb7y3vZk/QQakpt2vvuZeUwMGMsaKu4oynhuX146jkMIhClVlwd6IUwwlBG2yAMMaotdmb7wwNxDT4sCXn1tU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent:sender;
        b=xuuNlETc1DC0n0GSiTBW5QluGn4idMQrG1aGeZ8T3CIRspUnkkISeFiTqDIP9S6wg4YPtidm+0bJHnW7C2vkYXoZbapaDqp7y5IOz/nl9dFU89iURFLvv73/DyaKBFOFMvQJGnefj59PRRjkeeT/pwRM6EBKpUs/LVBj46ldYvA=
Received: by 10.67.30.3 with SMTP id h3mr2418668ugj.35.1204996649855;
        Sat, 08 Mar 2008 09:17:29 -0800 (PST)
Received: from darc.dyndns.org ( [88.117.115.243])
        by mx.google.com with ESMTPS id 36sm7028923ugb.42.2008.03.08.09.17.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 08 Mar 2008 09:17:27 -0800 (PST)
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1JY2fn-0003il-15; Sat, 08 Mar 2008 18:17:27 +0100
Mail-Followup-To: git@vger.kernel.org, Johannes.Schindelin@gmx.de
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76567>

If git-merge-recursive attempts to merge two empty new files with
different executable flags, eventually xdl_merge() is called and produces
empty diffs for both files and therefore does not choose either file as
successor. Make xdl_merge() choose one of the files instead.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

Hi,

The change in indentation makes this patch look larger than it is. All I
actually did was remove the "if (xscr1 || xscr2)" condition.

Previously to this patch the included test showed the following output:

	Merging a with b
	Merging:
	82712b3 branch a
	7eacd6f branch b
	found 1 common ancestor(s):
	33b7ba5 initial commit
	Auto-merged a
	fatal: Failed to execute internal merge

I do not understand why, but this does not happen if the file permissions are
the same.

Thanks,
Clemens

 t/t6031-merge-recursive.sh |   23 +++++++++++++++++++++++
 xdiff/xmerge.c             |   30 ++++++++++++++----------------
 2 files changed, 37 insertions(+), 16 deletions(-)
 create mode 100755 t/t6031-merge-recursive.sh

diff --git a/t/t6031-merge-recursive.sh b/t/t6031-merge-recursive.sh
new file mode 100755
index 0000000..4e3456b
--- /dev/null
+++ b/t/t6031-merge-recursive.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+test_description='merge-recursive corner cases'
+. ./test-lib.sh
+
+test_expect_success 'merge empty files with different permission flags' '
+	: >dummy &&
+	git add dummy &&
+	git commit -m "initial commit" &&
+	git checkout -b a master &&
+	: >a &&
+	git add a &&
+	git commit -m "branch a" &&
+	git checkout -b b master &&
+	: >a &&
+	chmod +x a &&
+	git add a &&
+	git commit -m "branch b" &&
+	git checkout master &&
+	git merge-recursive master -- a b
+'
+
+test_done
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 82b3573..92127e1 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -470,23 +470,21 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const char *name1,
 		return -1;
 	}
 	status = 0;
-	if (xscr1 || xscr2) {
-		if (!xscr1) {
-			result->ptr = xdl_malloc(mf2->size);
-			memcpy(result->ptr, mf2->ptr, mf2->size);
-			result->size = mf2->size;
-		} else if (!xscr2) {
-			result->ptr = xdl_malloc(mf1->size);
-			memcpy(result->ptr, mf1->ptr, mf1->size);
-			result->size = mf1->size;
-		} else {
-			status = xdl_do_merge(&xe1, xscr1, name1,
-					      &xe2, xscr2, name2,
-					      level, xpp, result);
-		}
-		xdl_free_script(xscr1);
-		xdl_free_script(xscr2);
+	if (!xscr1) {
+		result->ptr = xdl_malloc(mf2->size);
+		memcpy(result->ptr, mf2->ptr, mf2->size);
+		result->size = mf2->size;
+	} else if (!xscr2) {
+		result->ptr = xdl_malloc(mf1->size);
+		memcpy(result->ptr, mf1->ptr, mf1->size);
+		result->size = mf1->size;
+	} else {
+		status = xdl_do_merge(&xe1, xscr1, name1,
+				      &xe2, xscr2, name2,
+				      level, xpp, result);
 	}
+	xdl_free_script(xscr1);
+	xdl_free_script(xscr2);
 	xdl_free_env(&xe1);
 	xdl_free_env(&xe2);
 
-- 
1.5.4.3.468.g36990.dirty

