From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] merge-recursive: tweak magic band-aid
Date: Thu, 17 Mar 2011 23:07:20 -0700
Message-ID: <7v1v250xnr.fsf_-_@alter.siamese.dyndns.org>
References: <7v4o7260no.fsf@alter.siamese.dyndns.org>
 <7vpqpp1kww.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 18 07:07:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0SqW-0003A9-Az
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 07:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756146Ab1CRGHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 02:07:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54370 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755987Ab1CRGHa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 02:07:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C59185E79;
	Fri, 18 Mar 2011 02:09:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y4XTUVjt2zfRsMNBYfhiV4Bl19k=; b=Em/nUf
	9C+QglZzPwUiatTJ+Sd1tczpie3gGB+XPDl+Cjrnj3omzXmGD2hMH2Nq/mP0qoDg
	T/3BvC3bn/09dB8M0YW/TI1djS8r6oGxreZXhNynw7YY8kNqHdBWoUXudIzCQ5Tf
	KzmKq4nPvNfLRBp0tSGc9R7JVymBZ/sEbyfJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=diRSxh85h/RQ/e2HjLcc92w6Lw5OlFWQ
	5OWHHkMLnxAZSdeFHJnw0vRB+woD8kbrZ58yVpWzJDS60g9cyFUdVVGkWRVlYlKF
	AqB0oNtgsQfs4BrNDzALoXeph2cT+z4bwiCgvqMZcC9SSEAoeQiNWDOmv4iSF5Ig
	5l8FKFs4eu8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9CA1C5E78;
	Fri, 18 Mar 2011 02:08:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 89A535E77; Fri, 18 Mar 2011
 02:08:56 -0400 (EDT)
In-Reply-To: <7vpqpp1kww.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 17 Mar 2011 14:45:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3710E11E-5126-11E0-9EEA-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169291>

Running checks against working tree (e.g. lstat()) and causing
changes to working tree (e.g. unlink()) while building a virtual
ancestor merge does not make any sense. Avoid doing so.

This is not a real fix; it is another magic band-aid on top of
another band-aid we placed earlier.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This does not fix the "even though we have local change in the working
   tree, we do have a clean index entry for that path that happens to be
   the one we renamed, and they didn't" case this message responds to, it
   does seem to fix the real-life breakage I saw when I merged 'maint' to
   'master' yesterday, admittedly in a clean working tree.

   merge-recursive is riddled with places that touch/inspect working tree
   when it shouldn't, and it is beyond salvage without a major refactoring
   in its current shape, so this magic band-aid should do for now.

   Generally speaking, the only valid kinds of accesses a merge strategy
   is allowed are:

   (1) to compare the working tree file with our original index entry to
       see if it has local changes. This should be done only for paths
       that the index entry of the merge result is different from the
       current one and the working tree file needs updating.  We need this
       check because the merge must not lose such local changes when we
       checkout the merge result. This check could use lstat(2) as part of
       ce_match_stat() from read-cache.c; or

   (2) to make sure there is no file that was not tracked in our original
       index in the working tree at the path that the result of the merge
       needs to create a file or a directory. We need this check because
       the merge must not lose such an untracked file when we checkout the
       merge result. This check would use lstat(2), as part of
       checkout_entry() from entry.c; or

   (3) when the result of the merge needs to create a file at a path and
       the working tree has a directory at the path, to make sure that the
       contents of the directory does not have any locally modified files
       relative to our original index, or untracked-and-unignored files.
       We need this check because the merge must be able to "rm -r" such a
       directory safely in order to checkout the merge result.

   As a special case, a file missing from the working tree is considered
   unmodified for the purpose of (1). IOW, removal of a path from the
   working tree without touching the index is considered a local change
   that we are willing to lose during a merge. This is to support a
   workflow (or a Porcelain script) that merges commits in a fresh
   temporary directory, e.g. this sequence

	cd_to_toplevel
	mkdir tmp_merge
        cd tmp_merge
        export GIT_DIR=../.git
        git read-tree pu ;# the branch may not be related to the current one
        git merge-resolve $(git merge-base pu topic) -- pu topic

   would start from an empty temporary merge directory, check out only the
   paths that were involved in the merge, potentially leaving conflict
   markers in them, and allows the user to resolve them, without touching
   the real working tree or the current branch. The resulting index can be
   written to a tree object to record the result of the merge.

 merge-recursive.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 847bc84..59482ff 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -370,6 +370,13 @@ static void make_room_for_directories_of_df_conflicts(struct merge_options *o,
 	struct stage_data *last_e;
 	int i;
 
+	/*
+	 * Do not do any of this crazyness during the recursive; we don't
+	 * even write anything to the working tree!
+	 */
+	if (o->call_depth)
+		return;
+
 	for (i = 0; i < entries->nr; i++) {
 		const char *path = entries->items[i].string;
 		int len = strlen(path);
@@ -1274,7 +1281,7 @@ static int merge_content(struct merge_options *o,
 
 	if (mfi.clean && !df_conflict_remains &&
 	    sha_eq(mfi.sha, a_sha) && mfi.mode == a.mode &&
-	    lstat(path, &st) == 0) {
+	    !o->call_depth && !lstat(path, &st)) {
 		output(o, 3, "Skipped %s (merged same as existing)", path);
 		add_cacheinfo(mfi.mode, mfi.sha, path,
 			      0 /*stage*/, 1 /*refresh*/, 0 /*options*/);
-- 
1.7.4.1.494.g5ddab
