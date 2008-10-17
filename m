From: Junio C Hamano <gitster@pobox.com>
Subject: "checkout --track -b" broken? (with suggested fix)
Date: Thu, 16 Oct 2008 23:37:44 -0700
Message-ID: <7vej2fohfr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 17 08:39:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqize-0002xN-Fg
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 08:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbYJQGiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 02:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbYJQGiO
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 02:38:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64811 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbYJQGiO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 02:38:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4134C70CA3;
	Fri, 17 Oct 2008 02:38:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 93D1270CA2; Fri, 17 Oct 2008 02:37:59 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 286EA83E-9C16-11DD-9E5A-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98449>

Sorry for bringing up a potentially old issue, but I do not think the test
added by 9ed36cf (branch: optionally setup branch.*.merge from upstream
local branches, 2008-02-19) is correct.  It does this:

    test_expect_success \
        'checkout w/--track from non-branch HEAD fails' '
        git checkout -b delete-me master &&
        rm .git/refs/heads/delete-me &&
        test refs/heads/delete-me = "$(git symbolic-ref HEAD)" &&
        test_must_fail git checkout --track -b track'

It creates branch 'delete-me' at the tip of 'master' to check it out, and
then it manually deletes the branch.  It expects "checkout --track -b track"
to fail because the current branch is broken and there is no way to set up
a tracking information for the new branch.

But I think this is bogus.  The checkout fails not because of lack of
trackability (due to broken current _branch_), but because there is no
current _commit_ to branch from.

	Jay CC'ed because 9ed36cf is his; Daniel CC'ed as branch.c was
	originally his.

Here is an attempt to fix the test, which then revealed that the feature
the commit introduced is broken in the tip of 'maint'.  Back when 9ed36cf
was written, test_must_fail was unavailable, and test_expect_failure meant
something different, so transplanting this on top of that old commit won't
reveal the breakage, but I strongly suspect that the feature was broken
from the very beginning.

The patch to branch.c is a quick fix for this issue.  The resulting code
passes all the tests, but I am not very proud of hardcoding the "HEAD" in
the code.  There must be a better way to do this.

 branch.c      |    4 +++-
 t/t7201-co.sh |   11 +++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git c/branch.c w/branch.c
index b1e59f2..6a75057 100644
--- c/branch.c
+++ w/branch.c
@@ -129,7 +129,9 @@ void create_branch(const char *head,
 			die("Cannot setup tracking information; starting point is not a branch.");
 		break;
 	case 1:
-		/* Unique completion -- good */
+		/* Unique completion -- good, only if it is a real ref */
+		if (track == BRANCH_TRACK_EXPLICIT && !strcmp(real_ref, "HEAD"))
+			die("Cannot setup tracking information; starting point is not a branch.");
 		break;
 	default:
 		die("Ambiguous object name: '%s'.", start_name);
diff --git c/t/t7201-co.sh w/t/t7201-co.sh
index fbec70d..da1fbf8 100755
--- c/t/t7201-co.sh
+++ w/t/t7201-co.sh
@@ -330,12 +330,11 @@ test_expect_success \
     test "$(git config branch.track2.merge)"
     git config branch.autosetupmerge false'
 
-test_expect_success \
-    'checkout w/--track from non-branch HEAD fails' '
-    git checkout -b delete-me master &&
-    rm .git/refs/heads/delete-me &&
-    test refs/heads/delete-me = "$(git symbolic-ref HEAD)" &&
-    test_must_fail git checkout --track -b track'
+test_expect_success 'checkout w/--track from non-branch HEAD fails' '
+    git checkout master^0 &&
+    test_must_fail git symbolic-ref HEAD &&
+    test_must_fail git checkout --track -b track
+'
 
 test_expect_success 'checkout an unmerged path should fail' '
 	rm -f .git/index &&
