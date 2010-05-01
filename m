From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 1/2] do not overwrite files marked "assume unchanged"
Date: Sat, 1 May 2010 11:25:12 +0200
Message-ID: <20100501092512.GA15941@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 01 11:41:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O89Cl-0004yy-UE
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 11:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844Ab0EAJll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 05:41:41 -0400
Received: from mail-fx0-f66.google.com ([209.85.161.66]:34603 "EHLO
	mail-fx0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802Ab0EAJlk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 05:41:40 -0400
X-Greylist: delayed 960 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 May 2010 05:41:40 EDT
Received: by fxm18 with SMTP id 18so346800fxm.1
        for <git@vger.kernel.org>; Sat, 01 May 2010 02:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:mime-version:content-type:content-disposition
         :user-agent;
        bh=8OsZqjnrh/StUn6dcKH/+IDrD7mZF+mTQDyfQ8U4EIM=;
        b=joetv04bLkzaNS6l4jXrxzzev/Zg8syBw19J2ub33g480RvjhA58UW7W1pvww/O02X
         n0VLeRUCXQuQrQTzUD9X2qRVTdO78JlwxdfuH38sILGQbVxD9kk39r0SOyNRe1L9gXZc
         ZKOktl6TZH+bUGlwUeblbLxRNwui+c/87hrto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        b=Li0JCi1IDt1IeDxs6afJMGaje1X1SzHKMrFIyzQktKKVrPoa4JXDAp5Q7r5mhKzC96
         AffDfed8K6TOWckGJScPFYWM3RoQfOuOoMEAtLPX2xxGRr1ekYalE6ck8eYSaDNzsI3b
         +K93M4qzoR+AOMNNpIqf0GFmSPfpyNAKZHSUo=
Received: by 10.87.5.30 with SMTP id h30mr5939208fgi.3.1272705938322;
        Sat, 01 May 2010 02:25:38 -0700 (PDT)
Received: from darc.lan (p549A6756.dip.t-dialin.net [84.154.103.86])
        by mx.google.com with ESMTPS id 12sm1562898fgg.14.2010.05.01.02.25.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 May 2010 02:25:38 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1O88wi-00088r-7N; Sat, 01 May 2010 11:25:12 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146082>

A merge will fail gracefully if it needs to update files marked
"assume unchanged", but other similar commands will not. In
particular, checkout and rebase will silently overwrite changes to
such files.

This is a regression introduced in commit 1dcafcc0 (verify_uptodate():
add ce_uptodate(ce) test), which avoids lstat's during a merge, if the
index entry is up-to-date. If the CE_VALID flag is set, however, we
cannot trust CE_UPTODATE.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 t/t2106-update-index-assume-unchanged.sh |   24 ++++++++++++++++++++++++
 unpack-trees.c                           |    2 +-
 2 files changed, 25 insertions(+), 1 deletions(-)
 create mode 100755 t/t2106-update-index-assume-unchanged.sh

diff --git a/t/t2106-update-index-assume-unchanged.sh b/t/t2106-update-index-assume-unchanged.sh
new file mode 100755
index 0000000..99d858c
--- /dev/null
+++ b/t/t2106-update-index-assume-unchanged.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+
+test_description='git update-index --assume-unchanged test.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' \
+	': >file &&
+	 git add file &&
+	 git commit -m initial &&
+	 git branch other &&
+	 echo upstream >file &&
+	 git add file &&
+	 git commit -m upstream'
+
+test_expect_success 'do not switch branches with dirty file' \
+	'git reset --hard &&
+	 git checkout other &&
+	 echo dirt >file &&
+	 git update-index --assume-unchanged file &&
+	 test_must_fail git checkout master'
+
+test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 75f54ca..1a8030c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -862,7 +862,7 @@ static int verify_uptodate_1(struct cache_entry *ce,
 {
 	struct stat st;
 
-	if (o->index_only || (!ce_skip_worktree(ce) && (o->reset || ce_uptodate(ce))))
+	if (o->index_only || (!((ce->ce_flags & CE_VALID) || ce_skip_worktree(ce)) && (o->reset || ce_uptodate(ce))))
 		return 0;
 
 	if (!lstat(ce->name, &st)) {
-- 
1.7.0.5.3.ga76e
