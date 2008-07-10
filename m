From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] apply: fix copy/rename breakage
Date: Wed, 09 Jul 2008 20:10:58 -0700
Message-ID: <7vy74aqvr1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Don Zickus <dzickus@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 10 05:12:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGmaH-0001oU-BR
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 05:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757034AbYGJDLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 23:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753651AbYGJDLP
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 23:11:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38739 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327AbYGJDLO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 23:11:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 56D0F1E38C;
	Wed,  9 Jul 2008 23:11:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 42CE71E388; Wed,  9 Jul 2008 23:11:08 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DA44EB04-4E2D-11DD-A118-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87934>

Recently, 7ebd52a (Merge branch 'dz/apply-again', 2008-07-01) taught
"git-apply" to grok a (non-git) patch that is a concatenation of separate
patches that touch the same file number of files, by recording the
postimage of patch application of previous round and using it as the
preimage for later rounds.

However, this "incremental" mode of patch application contradicts with the
way git rename/copy patches are fundamentally designed.  When a git patch
talks about a file A getting modified, and a new file B created out of B,
like this:

	diff --git a/A b/A
	--- a/A
	+++ b/A
	... change text here ...
	diff --git a/A b/B
	copy from A
	copy to B
	--- a/A
	+++ b/B
	... change text here ...

the second change to produce B does not depend on what is done to A with
the first change (this is explicitly done so for reviewability of
individual patches).

With this patch, we disable the postimage record 'fn_table' when applying
a patch to produce new files out of existing file by copying to fix this
issue.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Applies to 'master'.  I am CC'ing Linus not because he is in any way
   responsible for this breakage, but because this breakage can affect
   heavy users of "git apply".

 builtin-apply.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index b3fc290..d13313f 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2296,7 +2296,8 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
 
 	strbuf_init(&buf, 0);
 
-	if ((tpatch = in_fn_table(patch->old_name)) != NULL) {
+	if (!(patch->is_copy || patch->is_rename) &&
+	    ((tpatch = in_fn_table(patch->old_name)) != NULL)) {
 		if (tpatch == (struct patch *) -1) {
 			return error("patch %s has been renamed/deleted",
 				patch->old_name);
@@ -2375,7 +2376,7 @@ static int verify_index_match(struct cache_entry *ce, struct stat *st)
 static int check_preimage(struct patch *patch, struct cache_entry **ce, struct stat *st)
 {
 	const char *old_name = patch->old_name;
-	struct patch *tpatch;
+	struct patch *tpatch = NULL;
 	int stat_ret = 0;
 	unsigned st_mode = 0;
 
@@ -2389,7 +2390,9 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 		return 0;
 
 	assert(patch->is_new <= 0);
-	if ((tpatch = in_fn_table(old_name)) != NULL) {
+
+	if (!(patch->is_copy || patch->is_rename) &&
+	    (tpatch = in_fn_table(old_name)) != NULL) {
 		if (tpatch == (struct patch *) -1) {
 			return error("%s: has been deleted/renamed", old_name);
 		}
@@ -2399,6 +2402,7 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 		if (stat_ret && errno != ENOENT)
 			return error("%s: %s", old_name, strerror(errno));
 	}
+
 	if (check_index && !tpatch) {
 		int pos = cache_name_pos(old_name, strlen(old_name));
 		if (pos < 0) {
-- 
1.5.6.2.291.g7eef3
