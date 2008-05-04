From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] Fix diff regression for submodules not checked out
Date: Sat, 03 May 2008 23:45:23 -0700
Message-ID: <7vej8ir2ik.fsf@gitster.siamese.dyndns.org>
References: <46dff0320804300856w941d948rbcc1cee06f1b41a9@mail.gmail.com>
 <1209735336-4690-1-git-send-email-pkufranky@gmail.com>
 <1209735336-4690-2-git-send-email-pkufranky@gmail.com>
 <1209735336-4690-3-git-send-email-pkufranky@gmail.com>
 <1209735336-4690-4-git-send-email-pkufranky@gmail.com>
 <7vfxt0wdkq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 04 08:46:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsXzX-0000uR-3H
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 08:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbYEDGpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 02:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbYEDGpn
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 02:45:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51480 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059AbYEDGpm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 02:45:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 329B332F8;
	Sun,  4 May 2008 02:45:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E61AD32F7; Sun,  4 May 2008 02:45:36 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B706C7E6-19A5-11DD-8E48-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81149>

Junio C Hamano <gitster@pobox.com> writes:

> The second case is "not checked out -- treat me as unmodified", and the
> third case is "the user does not want the submodule there", and the latter
> is still reported as "removed".  That is exactly what your patch does.

Having looked at the code a bit more, I do not think we need the
three-kind distinction for this part.

The attached patch would be both sufficient and cleaner.  The real change
is a single-liner, and everything else is additional comment ;-)  I'd
follow it up with s/check_work_tree_entity/check_removed/ for
clarification.

A cleaned up series is queued near the tip of 'pu' for tonight, but 'pu'
itself has some uncompiable crap in it (not your series) and needs to be
rebuilt soon.

---
[PATCH] diff: a submodule not checked out is not modified

948dd34 (diff-index: careful when inspecting work tree items, 2008-03-30)
made the work tree check careful not to be fooled by a new directory that
exists at a place the index expects a blob.  For such a change to be a
typechange from blob to submodule, the new directory has to be a
repository.

However, if the index expects a submodule there, we should not insist the
work tree entity to be a repository --- a simple directory that is not a
full fledged repository (even an empty directory would do) should be
considered an unmodified subproject, because that is how a superproject
with a submodule is checked out sparsely by default.

This makes the function check_work_tree_entity() even more careful not to
report a submodule that is not checked out as removed.  It fixes the
recently added test in t4027.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff-lib.c                |   25 ++++++++++++++++++++++---
 t/t4027-diff-submodule.sh |    2 +-
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index cfd629d..e0ebcdc 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -337,9 +337,15 @@ int run_diff_files_cmd(struct rev_info *revs, int argc, const char **argv)
 	}
 	return run_diff_files(revs, options);
 }
+
 /*
- * See if work tree has an entity that can be staged.  Return 0 if so,
- * return 1 if not and return -1 if error.
+ * Has the work tree entity been removed?
+ *
+ * Return 1 if it was removed from the work tree, 0 if an entity to be
+ * compared with the cache entry ce still exists (the latter includes
+ * the case where a directory that is not a submodule repository
+ * exists for ce that is a submodule -- it is a submodule that is not
+ * checked out).  Return negative for an error.
  */
 static int check_work_tree_entity(const struct cache_entry *ce, struct stat *st, char *symcache)
 {
@@ -352,7 +358,20 @@ static int check_work_tree_entity(const struct cache_entry *ce, struct stat *st,
 		return 1;
 	if (S_ISDIR(st->st_mode)) {
 		unsigned char sub[20];
-		if (resolve_gitlink_ref(ce->name, "HEAD", sub))
+
+		/*
+		 * If ce is already a gitlink, we can have a plain
+		 * directory (i.e. the submodule is not checked out),
+		 * or a checked out submodule.  Either case this is not
+		 * a case where something was removed from the work tree,
+		 * so we will return 0.
+		 *
+		 * Otherwise, if the directory is not a submodule
+		 * repository, that means ce which was a blob turned into
+		 * a directory --- the blob was removed!
+		 */
+		if (!S_ISGITLINK(ce->ce_mode) &&
+		    resolve_gitlink_ref(ce->name, "HEAD", sub))
 			return 1;
 	}
 	return 0;
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 61caad0..ba6679c 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -50,7 +50,7 @@ test_expect_success 'git diff-files --raw' '
 	test_cmp expect actual.files
 '
 
-test_expect_failure 'git diff (empty submodule dir)' '
+test_expect_success 'git diff (empty submodule dir)' '
 	: >empty &&
 	rm -rf sub/* sub/.git &&
 	git diff > actual.empty &&
-- 
1.5.5.1.219.gb8f92
