From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] diff: remove often unused parameters from diff_unmerge()
Date: Sun, 24 Apr 2011 13:51:28 -0700
Message-ID: <1303678289-27627-4-git-send-email-gitster@pobox.com>
References: <1303678289-27627-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 22:51:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QE6HZ-00079d-Do
	for gcvg-git-2@lo.gmane.org; Sun, 24 Apr 2011 22:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757803Ab1DXUvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2011 16:51:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33092 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757743Ab1DXUvj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2011 16:51:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B4CF346C2
	for <git@vger.kernel.org>; Sun, 24 Apr 2011 16:53:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=HSPv
	DBJgjoBz3i8aTRHeqB2qg0k=; b=k1lVIDpNeu+5s4pL7gb3qDP3CNq7/Ko/S06y
	OhuVbGnA3zFKq0spWtWhc29wZ7+AFyVfcSjarKJkLmDN66zj/M47VFT0wJFNfL7W
	GNwrgJlH4VMlOJkJyhZI9u0futWlm455xBL+iqrfa+pOZ8YT3pD9g0XhArGj1Auy
	9Cd0qh8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=hZwP1R
	/1FFOk76uMKIaCI0eNh1fFPp1dBlpCARU3EY+HUxueFJtkQgNPLHKEC4nVrWO/6/
	o4UEdQzKYiG934KwScU/MrD+5i/TsQpP3tHXHC2fA6i17crRvcWaPPVaIYJFgNE9
	ieYU/VI+o+Ke+h4d+l4Njn+PISDGJ+fbfFyuU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B070246C1
	for <git@vger.kernel.org>; Sun, 24 Apr 2011 16:53:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0E4AC46C0 for
 <git@vger.kernel.org>; Sun, 24 Apr 2011 16:53:39 -0400 (EDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1303678289-27627-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: EF23B1F4-6EB4-11E0-8181-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172003>

e9c8409 (diff-index --cached --raw: show tree entry on the LHS for
unmerged entries., 2007-01-05) added a <mode, object name> pair as
parameters to this function, to store them in the pre-image side of an
unmerged file pair.  Now the function is fixed to return the filepair it
queued, we can make the caller on the special case codepath to do so.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff-lib.c |    7 ++++---
 diff.c     |    5 +----
 diff.h     |    5 +----
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 392ce2b..a983855 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -183,7 +183,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			 * Show the diff for the 'ce' if we found the one
 			 * from the desired stage.
 			 */
-			diff_unmerge(&revs->diffopt, ce->name, 0, null_sha1);
+			diff_unmerge(&revs->diffopt, ce->name);
 			if (ce_stage(ce) != diff_unmerged_stage)
 				continue;
 		}
@@ -372,8 +372,9 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	match_missing = !revs->ignore_merges;
 
 	if (cached && idx && ce_stage(idx)) {
-		diff_unmerge(&revs->diffopt, idx->name, idx->ce_mode,
-			     idx->sha1);
+		struct diff_filepair *pair;
+		pair = diff_unmerge(&revs->diffopt, idx->name);
+		fill_filespec(pair->one, idx->sha1, idx->ce_mode);
 		return;
 	}
 
diff --git a/diff.c b/diff.c
index 4c34c64..d2c5c56 100644
--- a/diff.c
+++ b/diff.c
@@ -4308,9 +4308,7 @@ void diff_change(struct diff_options *options,
 		DIFF_OPT_SET(options, HAS_CHANGES);
 }
 
-struct diff_filepair *diff_unmerge(struct diff_options *options,
-				   const char *path,
-				   unsigned mode, const unsigned char *sha1)
+struct diff_filepair *diff_unmerge(struct diff_options *options, const char *path)
 {
 	struct diff_filepair *pair;
 	struct diff_filespec *one, *two;
@@ -4321,7 +4319,6 @@ struct diff_filepair *diff_unmerge(struct diff_options *options,
 
 	one = alloc_filespec(path);
 	two = alloc_filespec(path);
-	fill_filespec(one, sha1, mode);
 	pair = diff_queue(&diff_queued_diff, one, two);
 	pair->is_unmerged = 1;
 	return pair;
diff --git a/diff.h b/diff.h
index f51a8ee..3edb705 100644
--- a/diff.h
+++ b/diff.h
@@ -209,10 +209,7 @@ extern void diff_change(struct diff_options *,
 			const char *fullpath,
 			unsigned dirty_submodule1, unsigned dirty_submodule2);
 
-extern struct diff_filepair *diff_unmerge(struct diff_options *,
-			 const char *path,
-			 unsigned mode,
-			 const unsigned char *sha1);
+extern struct diff_filepair *diff_unmerge(struct diff_options *, const char *path);
 
 #define DIFF_SETUP_REVERSE      	1
 #define DIFF_SETUP_USE_CACHE		2
-- 
1.7.5
