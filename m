From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 2/2] diff_index: honor in-index, not working-tree, .gitattributes
Date: Thu, 22 Sep 2011 17:44:21 -0400
Message-ID: <1316727861-90460-2-git-send-email-jaysoffian@gmail.com>
References: <1316727861-90460-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 23:44:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6r4W-00039J-4H
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 23:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089Ab1IVVog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 17:44:36 -0400
Received: from mail-gw0-f42.google.com ([74.125.83.42]:56952 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653Ab1IVVoe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 17:44:34 -0400
Received: by mail-gw0-f42.google.com with SMTP id 16so2191717gwj.1
        for <git@vger.kernel.org>; Thu, 22 Sep 2011 14:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bckdI+M/LB2hMdLz2DPE4lobQaOJoDD8T6E59ZhfmoU=;
        b=ixjHIDRYGnbILu8OE31cC6p5tujFAMY9yuDKlEz36spfaJE4IZ7KhziEH6CWWFgPVr
         1CmVLfR7ZoZUD1zMgyaysq1Mk8StkYrfhAtjSRIwKwYOkGSWKzDxopA9NoUOj0wf+bkJ
         GDAkXHjBoRvMkbTdAEGxVGm9+QoCbu+iaZsic=
Received: by 10.151.157.10 with SMTP id j10mr2989535ybo.68.1316727874417;
        Thu, 22 Sep 2011 14:44:34 -0700 (PDT)
Received: from localhost (cpe-174-097-218-168.nc.res.rr.com. [174.97.218.168])
        by mx.google.com with ESMTPS id t10sm34257855anl.26.2011.09.22.14.44.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Sep 2011 14:44:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc2.5.g12a2f
In-Reply-To: <1316727861-90460-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181921>

When diff'ing the index against a tree (using either diff-index
or diff --cached), git previously looked at .gitattributes in the
working tree before considering .gitattributes in the index, even
though the diff itself otherwise ignores the working tree.

Further, with an index, but no working tree, the in-index
.gitattributes were ignored entirely.

Calling git_attr_set_direction(GIT_ATTR_INDEX) before generating
the diff fixes both of these behaviors.

---
This is a weather balloon patch I guess.

Obviously there is a behavior change here as evidenced by the change to
t4020-diff-external.sh. I think the old behavior was wrong and this is a
bug fix. But the old behavior has been that way a long time, so maybe
we should use '--cached-attributes' instead for the "correct" behavior.

Since I'm not really sure what we should do with --cached -R, I'm
punting on that for now.

Jeff's message regarding diff-tree made my head hurt, so tackling that
will have to wait...

 diff-lib.c               |    3 +++
 t/t4020-diff-external.sh |    4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index f8454dd291..fe218931e6 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -11,6 +11,7 @@
 #include "unpack-trees.h"
 #include "refs.h"
 #include "submodule.h"
+#include "attr.h"
 
 /*
  * diff-files
@@ -476,6 +477,8 @@ static int diff_cache(struct rev_info *revs,
 int run_diff_index(struct rev_info *revs, int cached)
 {
 	struct object_array_entry *ent;
+	if (cached)
+		git_attr_set_direction(GIT_ATTR_INDEX, NULL);
 
 	ent = revs->pending.objects;
 	if (diff_cache(revs, ent->item->sha1, ent->name, cached))
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 083f62d1d6..c6fdab3e87 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -160,10 +160,10 @@ test_expect_success 'external diff with autocrlf = true' '
 '
 
 test_expect_success 'diff --cached' '
-	git add file &&
+	git add .gitattributes file &&
 	git update-index --assume-unchanged file &&
 	echo second >file &&
-	git diff --cached >actual &&
+	git diff --cached file >actual &&
 	test_cmp "$TEST_DIRECTORY"/t4020/diff.NUL actual
 '
 
-- 
1.7.7.rc2.5.g12a2f
