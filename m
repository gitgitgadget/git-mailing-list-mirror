From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] filter-branch: work correctly with ambiguous refnames
Date: Sat, 05 Jan 2008 12:28:23 -0800
Message-ID: <7vabnk81aw.fsf_-_@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0712301700580.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	<1199040667-31850-1-git-send-email-dpotapov@gmail.com>
	<7v7iiqppkw.fsf@gitster.siamese.dyndns.org>
	<20080104155114.GS3373@dpotapov.dyndns.org>
	<7vr6gxjpyn.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801051601490.10101@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 05 21:29:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBFdj-0006B0-U3
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 21:29:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756319AbYAEU2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 15:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756189AbYAEU2i
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 15:28:38 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50826 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756179AbYAEU2h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 15:28:37 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AC3F6B09;
	Sat,  5 Jan 2008 15:28:36 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C3AD6B08;
	Sat,  5 Jan 2008 15:28:30 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0801051601490.10101@racer.site> (Johannes
	Schindelin's message of "Sat, 5 Jan 2008 16:03:55 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69683>

'git-filter-branch branch' could fail producing the error:
"Which ref do you want to rewrite?" if existed another branch
or tag, which name was 'branch-something' or 'something/branch'.

[jc: original report and fix were done between Dmitry Potapov
and Dscho; I rewrote it using "rev-parse --symbolic-full-name"]

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

 >> But at that point I would say that exposing the refname dwimming
 >> logic to the scripts could be a much cleaner solution.
 >
 > I considered that when ripping the script from cogito, but it seemed to me 
 > at that time that not requiring an up-to-date git for testing the script 
 > would be better.
 >
 > Now is a different situation, however, so I agree.

 It was already tied to the specific git version when
 git-filter-branch became part of git.git ;-)  

 I do not use filter-branch myself very often, but I think this
 is worth fixing.  The additional --no-flags and sed are to deal
 with something like:

	--topo-order master..next

 although I do not offhand know if filter-branch would work with
 things like --topo-order and --first-parent.

 git-filter-branch.sh |   22 +++-------------------
 1 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index ae29f47..ebf05ca 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -209,25 +209,9 @@ ORIG_GIT_INDEX_FILE="$GIT_INDEX_FILE"
 GIT_WORK_TREE=.
 export GIT_DIR GIT_WORK_TREE
 
-# These refs should be updated if their heads were rewritten
-
-git rev-parse --revs-only --symbolic "$@" |
-while read ref
-do
-	# normalize ref
-	case "$ref" in
-	HEAD)
-		ref="$(git symbolic-ref "$ref")"
-	;;
-	refs/*)
-	;;
-	*)
-		ref="$(git for-each-ref --format='%(refname)' |
-			grep /"$ref")"
-	esac
-
-	git check-ref-format "$ref" && echo "$ref"
-done > "$tempdir"/heads
+# The refs should be updated if their heads were rewritten
+git rev-parse --no-flags --revs-only --symbolic-full-name "$@" |
+sed -e '/^^/d' >"$tempdir"/heads
 
 test -s "$tempdir"/heads ||
 	die "Which ref do you want to rewrite?"
-- 
1.5.4.rc2.38.gd6da3
