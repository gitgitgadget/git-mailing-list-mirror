From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] builtin-apply: accept patch to an empty file
Date: Sat, 17 May 2008 02:18:49 -0700
Message-ID: <7vr6c1cmpy.fsf_-_@gitster.siamese.dyndns.org>
References: <1210257579-30975-1-git-send-email-imre.deak@gmail.com>
 <7vlk2h8t4d.fsf@gitster.siamese.dyndns.org>
 <500f3d130805131316m59898392l46e0dbf7cb352981@mail.gmail.com>
 <7vprrpswof.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0805131514300.3019@woody.linux-foundation.org>
 <7vlk2dsujm.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0805131552410.3019@woody.linux-foundation.org>
 <7vve1hrbct.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0805131811540.3019@woody.linux-foundation.org>
 <7vve1dcn0m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Imre Deak <imre.deak@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat May 17 11:19:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxIa1-0001Ri-M4
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 11:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520AbYEQJTD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 05:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752298AbYEQJTB
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 05:19:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46949 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbYEQJTA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 05:19:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 062674B5F;
	Sat, 17 May 2008 05:18:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C849A4B5E; Sat, 17 May 2008 05:18:51 -0400 (EDT)
In-Reply-To: <7vve1dcn0m.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 17 May 2008 02:12:25 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 46EF3FB8-23F2-11DD-85F4-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82337>

A patch from a foreign SCM (or plain "diff" output) often have both
preimage and postimage filename on ---/+++ lines even for a patch that
creates a new file.  However, when there is a filename for preimage, we
used to insist the file to exist (either in the work tree and/or in the
index).  When we cannot be sure by parsing the patch that it is not a
creation patch, we shouldn't complain when if there is no such a file.
This commit fixes the logic.

Refactor the code that validates the preimage file into a separate
function while we are at it, as it is getting rather big.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-apply.c |  133 ++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 77 insertions(+), 56 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 776e596..10b1f88 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2267,16 +2267,11 @@ static int verify_index_match(struct cache_entry *ce, struct stat *st)
 	return ce_match_stat(ce, st, CE_MATCH_IGNORE_VALID);
 }
 
-static int check_patch(struct patch *patch, struct patch *prev_patch)
+static int check_preimage(struct patch *patch, struct cache_entry **ce, struct stat *st)
 {
-	struct stat st;
 	const char *old_name = patch->old_name;
-	const char *new_name = patch->new_name;
-	const char *name = old_name ? old_name : new_name;
-	struct cache_entry *ce = NULL;
-	int ok_if_exists;
-
-	patch->rejected = 1; /* we will drop this after we succeed */
+	int stat_ret = 0;
+	unsigned st_mode = 0;
 
 	/*
 	 * Make sure that we do not have local modifications from the
@@ -2284,58 +2279,84 @@ static int check_patch(struct patch *patch, struct patch *prev_patch)
 	 * we have the preimage file to be patched in the work tree,
 	 * unless --cached, which tells git to apply only in the index.
 	 */
-	if (old_name) {
-		int stat_ret = 0;
-		unsigned st_mode = 0;
-
-		if (!cached)
-			stat_ret = lstat(old_name, &st);
-		if (check_index) {
-			int pos = cache_name_pos(old_name, strlen(old_name));
-			if (pos < 0)
-				return error("%s: does not exist in index",
-					     old_name);
-			ce = active_cache[pos];
-			if (stat_ret < 0) {
-				struct checkout costate;
-				if (errno != ENOENT)
-					return error("%s: %s", old_name,
-						     strerror(errno));
-				/* checkout */
-				costate.base_dir = "";
-				costate.base_dir_len = 0;
-				costate.force = 0;
-				costate.quiet = 0;
-				costate.not_new = 0;
-				costate.refresh_cache = 1;
-				if (checkout_entry(ce,
-						   &costate,
-						   NULL) ||
-				    lstat(old_name, &st))
-					return -1;
-			}
-			if (!cached && verify_index_match(ce, &st))
-				return error("%s: does not match index",
-					     old_name);
-			if (cached)
-				st_mode = ce->ce_mode;
-		} else if (stat_ret < 0)
-			return error("%s: %s", old_name, strerror(errno));
-
-		if (!cached)
-			st_mode = ce_mode_from_stat(ce, st.st_mode);
+	if (!old_name)
+		return 0;
 
+	assert(patch->is_new <= 0);
+	if (!cached) {
+		stat_ret = lstat(old_name, st);
+		if (stat_ret && errno != ENOENT)
+			return error("%s: %s", old_name, strerror(errno));
+	}
+	if (check_index) {
+		int pos = cache_name_pos(old_name, strlen(old_name));
+		if (pos < 0) {
+			if (patch->is_new < 0)
+				goto is_new;
+			return error("%s: does not exist in index", old_name);
+		}
+		*ce = active_cache[pos];
+		if (stat_ret < 0) {
+			struct checkout costate;
+			/* checkout */
+			costate.base_dir = "";
+			costate.base_dir_len = 0;
+			costate.force = 0;
+			costate.quiet = 0;
+			costate.not_new = 0;
+			costate.refresh_cache = 1;
+			if (checkout_entry(*ce, &costate, NULL) ||
+			    lstat(old_name, st))
+				return -1;
+		}
+		if (!cached && verify_index_match(*ce, st))
+			return error("%s: does not match index", old_name);
+		if (cached)
+			st_mode = (*ce)->ce_mode;
+	} else if (stat_ret < 0) {
 		if (patch->is_new < 0)
-			patch->is_new = 0;
-		if (!patch->old_mode)
-			patch->old_mode = st_mode;
-		if ((st_mode ^ patch->old_mode) & S_IFMT)
-			return error("%s: wrong type", old_name);
-		if (st_mode != patch->old_mode)
-			fprintf(stderr, "warning: %s has type %o, expected %o\n",
-				old_name, st_mode, patch->old_mode);
+			goto is_new;
+		return error("%s: %s", old_name, strerror(errno));
 	}
 
+	if (!cached)
+		st_mode = ce_mode_from_stat(*ce, st->st_mode);
+
+	if (patch->is_new < 0)
+		patch->is_new = 0;
+	if (!patch->old_mode)
+		patch->old_mode = st_mode;
+	if ((st_mode ^ patch->old_mode) & S_IFMT)
+		return error("%s: wrong type", old_name);
+	if (st_mode != patch->old_mode)
+		fprintf(stderr, "warning: %s has type %o, expected %o\n",
+			old_name, st_mode, patch->old_mode);
+	return 0;
+
+ is_new:
+	patch->is_new = 1;
+	patch->is_delete = 0;
+	patch->old_name = NULL;
+	return 0;
+}
+
+static int check_patch(struct patch *patch, struct patch *prev_patch)
+{
+	struct stat st;
+	const char *old_name = patch->old_name;
+	const char *new_name = patch->new_name;
+	const char *name = old_name ? old_name : new_name;
+	struct cache_entry *ce = NULL;
+	int ok_if_exists;
+	int status;
+
+	patch->rejected = 1; /* we will drop this after we succeed */
+
+	status = check_preimage(patch, &ce, &st);
+	if (status)
+		return status;
+	old_name = patch->old_name;
+
 	if (new_name && prev_patch && 0 < prev_patch->is_delete &&
 	    !strcmp(prev_patch->old_name, new_name))
 		/*
-- 
1.5.5.1.443.g123e3
