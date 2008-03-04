From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fsck.c: fix bogus "empty tree" check
Date: Tue, 04 Mar 2008 03:21:16 -0800
Message-ID: <7vbq5u91lf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 12:22:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWVDm-0008AA-N2
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 12:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755913AbYCDLVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 06:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755078AbYCDLVb
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 06:21:31 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51809 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754544AbYCDLVa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 06:21:30 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0E05126F0;
	Tue,  4 Mar 2008 06:21:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4ED0826E5; Tue,  4 Mar 2008 06:21:26 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76065>

ba002f3 (builtin-fsck: move common object checking code to fsck.c) did
more than what it claimed to.  Most notably, it wrongly made an empty tree
object an error by pretending to only move code from fsck_tree() in
builtin-fsck.c to fsck_tree() in fsck.c, but in fact adding a bogus check
to barf on an empty tree.

An empty tree object is _unusual_.  Recent porcelains try reasonably hard
not to let the user create a commit that contains such a tree.  Perhaps
warning about them in git-fsck may have some merit.

However, being unusual and being errorneous are two quite different
things.  This is especially true now we seem to use the same
fsck_$object() code in places other than git-fsck itself.  For example,
receive-pack should not reject unusual objects, even if it would be a good
idea to tighten it to reject incorrect ones.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I've wasted a few hours tonight hunting for random breakages in "git
   push", the symptom of which is "fatal: unresolved deltas left after
   unpacking."  I was hoping this patch would fix it, but it seems that
   the problem is elsewhere.

   I'll revert the following two commits for now:

   d5ef408 (unpack-objects: prevent writing of inconsistent objects)
   28f72a0 (receive-pack: use strict mode for unpacking objects)

   as I have verified that running with receive.fsckobjects set to false
   fixes the issues for me, and the repository at the receiving end (both
   before and after the push) pass git-fsck without problems.  Needless to
   say, I am not a happy camper right now.

 fsck.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index 6883d1b..797e317 100644
--- a/fsck.c
+++ b/fsck.c
@@ -155,8 +155,6 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 	o_mode = 0;
 	o_name = NULL;
 	o_sha1 = NULL;
-	if (!desc.size)
-		return error_func(&item->object, FSCK_ERROR, "empty tree");
 
 	while (desc.size) {
 		unsigned mode;
-- 
1.5.4.3.529.gb25fb

