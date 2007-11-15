From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] git-bisect: modernize branch shuffling hack
Date: Thu, 15 Nov 2007 01:01:52 -0800
Message-ID: <7vfxz76fwf.fsf@gitster.siamese.dyndns.org>
References: <20071115081807.06fe092b.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 10:02:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isac9-0004vC-6Z
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 10:02:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757119AbXKOJB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 04:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756531AbXKOJB6
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 04:01:58 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:59534 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757122AbXKOJB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 04:01:57 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B1AA52F2;
	Thu, 15 Nov 2007 04:02:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 3EEE993C78;
	Thu, 15 Nov 2007 04:02:16 -0500 (EST)
In-Reply-To: <20071115081807.06fe092b.chriscool@tuxfamily.org> (Christian
	Couder's message of "Thu, 15 Nov 2007 08:18:07 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65095>

When switching to a new rev, we first made "new-bisect" branch to
point at the chosen commit, attempt to switch to it, and then
finally renamed the new-bisect branch to bisect by hand when
successful.  This is so that we can catch checkout failure (your
local modification may interfere with switching to the chosen
version) without losing information on which commit the next
attempt should be made.

Rewrite it using a more modern form but without breaking the
safety.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-bisect.sh |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 4b74a7b..dae8a8e 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -316,10 +316,9 @@ bisect_next() {
 	exit_if_skipped_commits "$bisect_rev"
 
 	echo "Bisecting: $bisect_nr revisions left to test after this"
-	echo "$bisect_rev" >"$GIT_DIR/refs/heads/new-bisect"
+	git branch -f new-bisect "$bisect_rev"
 	git checkout -q new-bisect || exit
-	mv "$GIT_DIR/refs/heads/new-bisect" "$GIT_DIR/refs/heads/bisect" &&
-	GIT_DIR="$GIT_DIR" git symbolic-ref HEAD refs/heads/bisect
+	git branch -M new-bisect bisect
 	git show-branch "$bisect_rev"
 }
 
-- 
1.5.3.5.1780.gca2b
