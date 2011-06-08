From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 29/48] merge-recursive: When we detect we can skip an update, actually skip it
Date: Wed,  8 Jun 2011 01:30:59 -0600
Message-ID: <1307518278-23814-30-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:31:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDEr-0006q0-LM
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755326Ab1FHHbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:31:23 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49887 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755059Ab1FHH3y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:29:54 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so118724pvg.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=y2A3U6Do7GaSe3PQOEnG6P65V+2GX/nA6UUCjEF9fjE=;
        b=hxC10w3/gHTaDaOw8pmwdFrMoAZIEkM58Scs40nW5abYGYkoyS8mnku4c+4pSbTnd2
         s07p16mmmSCyivZW8ttgVpEPCEUaBf+irkneUPbmP4Gcr7fEJYgHui9eAw27Lc0JpFGZ
         20m9TM7asruJslOcFO/9v7zYRLkx3/qZLdCtA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PbFT7e1RzKvGJ8pNOFZtEV7sGOC7QjpznA54amqwN33ayjN79W9iUiUVDV4tv1Gttg
         ZFMJscbOvpijtk4WqLF9/4r4cBT7yj1VrWfUjifEgfSHCwpVVbAeZ2a3nAZTBFZHWiHd
         KsxD8HkDa98iW7TQR6tpXwxT0CaF6OD4Po0VI=
Received: by 10.68.10.105 with SMTP id h9mr593504pbb.108.1307518194110;
        Wed, 08 Jun 2011 00:29:54 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.29.52
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:29:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175333>

In 882fd11 (merge-recursive: Delay content merging for renames 2010-09-20),
there was code that checked for whether we could skip updating a file in
the working directory, based on whether the merged version matched the
current working copy.  Due to the desire to handle directory/file conflicts
that were resolvable, that commit deferred content merging by first
updating the index with the unmerged entries and then moving the actual
merging (along with the skip-the-content-update check) to another function
that ran later in the merge process.  As part moving the content merging
code, a bug was introduced such that although the message about skipping
the update would be printed (whenever GIT_MERGE_VERBOSITY was sufficiently
high), the file would be unconditionally updated in the working copy
anyway.

When we detect that the file does not need to be updated in the working
copy, update the index appropriately and then return early before updating
the working copy.

Note that there was a similar change in b2c8c0a (merge-recursive: When we
detect we can skip an update, actually skip it 2011-02-28), but it was
reverted by 6db4105 (Revert "Merge branch 'en/merge-recursive'"
2011-05-19) since it did not fix both of the relevant types of unnecessary
update breakages and, worse, it made use of some band-aids that caused
other problems.  The reason this change works is due to the changes of the
last few patches to (a) record_df_conflict_files instead of just unlinking
them early, (b) allowing make_room_for_path() to remove D/F entries, and
(c) the splitting of update_stages_and_entry() to have its functionality
called at different points.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c       |    8 ++++++--
 t/t6022-merge-rename.sh |    4 ++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 7878b30..987a985 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1318,9 +1318,13 @@ static int merge_content(struct merge_options *o,
 	}
 
 	if (mfi.clean && !df_conflict_remains &&
-	    sha_eq(mfi.sha, a_sha) && mfi.mode == a.mode)
+	    sha_eq(mfi.sha, a_sha) && mfi.mode == a.mode &&
+	    was_tracked(path)) {
 		output(o, 3, "Skipped %s (merged same as existing)", path);
-	else
+		add_cacheinfo(mfi.mode, mfi.sha, path,
+			      0 /*stage*/, 1 /*refresh*/, 0 /*options*/);
+		return mfi.clean;
+	} else
 		output(o, 2, "Auto-merging %s", path);
 
 	if (!mfi.clean) {
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 52a8f0b..5e2a686 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -631,7 +631,7 @@ test_expect_success 'setup avoid unnecessary update, normal rename' '
 	git commit -m "Random, unrelated changes"
 '
 
-test_expect_failure 'avoid unnecessary update, normal rename' '
+test_expect_success 'avoid unnecessary update, normal rename' '
 	git checkout -q avoid-unnecessary-update-1^0 &&
 	test-chmtime =1000000000 rename &&
 	test-chmtime -v +0 rename >expect &&
@@ -664,7 +664,7 @@ test_expect_success 'setup to test avoiding unnecessary update, with D/F conflic
 	git commit -m "Only unrelated changes"
 '
 
-test_expect_failure 'avoid unnecessary update, with D/F conflict' '
+test_expect_success 'avoid unnecessary update, with D/F conflict' '
 	git checkout -q avoid-unnecessary-update-2^0 &&
 	test-chmtime =1000000000 df &&
 	test-chmtime -v +0 df >expect &&
-- 
1.7.6.rc0.62.g2d69f
