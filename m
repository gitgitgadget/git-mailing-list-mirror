From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv3 3/3] merge-recursive: When we detect we can skip an update, actually skip it
Date: Wed,  2 Mar 2011 23:13:12 -0700
Message-ID: <1299132792-17497-4-git-send-email-newren@gmail.com>
References: <1299132792-17497-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 03 07:13:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pv1n1-0003hV-4A
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 07:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300Ab1CCGNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2011 01:13:24 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37884 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153Ab1CCGNV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 01:13:21 -0500
Received: by mail-qw0-f46.google.com with SMTP id 7so617671qwd.19
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 22:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=ZY0Sn84J6Q/HUfWiAvc14pIW95VScJDu+ee1FdDU6g0=;
        b=D3wzk4/L2ecwQOIxvubDDJbVC5YQ8XNEWAyGFEWKJZ+quGoOhrRBEzOtd3pysjQN2K
         gNaXbkx+woYCQqfE1DMDfa0/sO70Yr531TL9R6oF0fYg7+TV1l85IauZXGVwQlrkogSf
         LsFc8j010SVw4IPTGf7quMv/iqpDqO0r6YVyI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YrrhtR1zD+LPbiu/EPOkY6q/V1mORDrZtZJ0EXnlCD7BffvUr5K1+prK1Hl0utN7xt
         /0eUNcCfzsehR93J06Dxrc3QqjBBbVh7bUn6KUAVqn9wf6V6mYvCNFWEXClyBRIWNBd8
         2kQaBWQAIv6fcnvOD/hCPo5O37jSrjH1pie4g=
Received: by 10.224.6.76 with SMTP id 12mr635381qay.299.1299132800856;
        Wed, 02 Mar 2011 22:13:20 -0800 (PST)
Received: from Miney.hsd1.nm.comcast.net. (c-174-56-87-200.hsd1.nm.comcast.net [174.56.87.200])
        by mx.google.com with ESMTPS id s32sm402361qco.38.2011.03.02.22.13.18
        (version=SSLv3 cipher=OTHER);
        Wed, 02 Mar 2011 22:13:20 -0800 (PST)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1299132792-17497-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168378>

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

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Elijah Newren <newren@gmail.com>
Acked-by: Jeff King <peff@peff.net>
---
 merge-recursive.c       |   17 +++++++++++------
 t/t6022-merge-rename.sh |    2 +-
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 16c2dbe..ec07a30 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -354,10 +354,11 @@ static void make_room_for_directories_of_df_conflicts(struct merge_options *o,
 	 * make room for the corresponding directory.  Such paths will
 	 * later be processed in process_df_entry() at the end.  If
 	 * the corresponding directory ends up being removed by the
-	 * merge, then the file will be reinstated at that time;
-	 * otherwise, if the file is not supposed to be removed by the
-	 * merge, the contents of the file will be placed in another
-	 * unique filename.
+	 * merge, then the file will be reinstated at that time
+	 * (albeit with a different timestamp!); otherwise, if the
+	 * file is not supposed to be removed by the merge, the
+	 * contents of the file will be placed in another unique
+	 * filename.
 	 *
 	 * NOTE: This function relies on the fact that entries for a
 	 * D/F conflict will appear adjacent in the index, with the
@@ -1274,9 +1275,13 @@ static int merge_content(struct merge_options *o,
 	}
 
 	if (mfi.clean && !df_conflict_remains &&
-	    sha_eq(mfi.sha, a_sha) && mfi.mode == a.mode)
+	    sha_eq(mfi.sha, a_sha) && mfi.mode == a.mode &&
+	    lstat(path, &st) == 0) {
 		output(o, 3, "Skipped %s (merged same as existing)", path);
-	else
+		add_cacheinfo(mfi.mode, mfi.sha, path,
+			      0 /*stage*/, 1 /*refresh*/, 0 /*options*/);
+		return mfi.clean;
+	} else
 		output(o, 2, "Auto-merging %s", path);
 
 	if (!mfi.clean) {
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 88cc410..6f9df68 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -630,7 +630,7 @@ test_expect_success 'setup avoid unnecessary update, normal rename' '
 	git commit -m "Random, unrelated changes"
 '
 
-test_expect_failure 'avoid unnecessary update, normal rename' '
+test_expect_success 'avoid unnecessary update, normal rename' '
 	git checkout -q avoid-unnecessary-update-1^0 &&
 	test-chmtime =1 rename &&
 	test-chmtime -v +0 rename >expect &&
-- 
1.7.4
