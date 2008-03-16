From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git pull" throws away dirty state
Date: Sun, 16 Mar 2008 14:13:53 -0700
Message-ID: <7vk5k2id7y.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0803161055510.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803161123260.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803161434450.2947@xanadu.home>
 <7vprtuieb4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Mar 16 22:14:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb0Bt-0006xG-2g
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 22:14:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbYCPVOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 17:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752550AbYCPVOJ
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 17:14:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:32779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476AbYCPVOH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 17:14:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8BA27124A;
	Sun, 16 Mar 2008 17:14:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 390861249; Sun, 16 Mar 2008 17:14:01 -0400 (EDT)
In-Reply-To: <7vprtuieb4.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 16 Mar 2008 13:50:23 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77384>

Junio C Hamano <gitster@pobox.com> writes:

> Nicolas Pitre <nico@cam.org> writes:
>
>> We really should have more tests to cover all those bugs that were 
>> introduced and fixed lately.

Yeah.

>> Given that Git should work fine in some cases even with a dirty work 
>> tree by design, I'm a bit surprised that we don't have any test case 
>> covering that.

Here is one.  I'll change the "expect_failure" to "expect_success" and
squash it into Linus's patch.

---

 t/t1004-read-tree-m-u-wf.sh |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index d609a55..df58c8d 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -116,4 +116,45 @@ test_expect_success 'three-way not complaining on an untracked file' '
 	git read-tree -m -u --exclude-per-directory=.gitignore branch-point master side
 '
 
+test_expect_success '3-way not overwriting local changes (setup)' '
+
+	git reset --hard &&
+	git checkout -b side-a branch-point &&
+	echo >>file1 "new line to be kept in the merge result" &&
+	git commit -a -m "side-a changes file1" &&
+	git checkout -b side-b branch-point &&
+	echo >>file2 "new line to be kept in the merge result" &&
+	git commit -a -m "side-b changes file2" &&
+	git checkout side-a
+
+'
+
+test_expect_failure '3-way not overwriting local changes (our side)' '
+
+	# At this point, file1 from side-a should be kept as side-b
+	# did not touch it.
+
+	git reset --hard &&
+
+	echo >>file1 "local changes" &&
+	git read-tree -m -u branch-point side-a side-b &&
+	grep "new line to be kept" file1 &&
+	grep "local changes" file1
+
+'
+
+test_expect_success '3-way not overwriting local changes (their side)' '
+
+	# At this point, file2 from side-b should be taken as side-a
+	# did not touch it.
+
+	git reset --hard &&
+
+	echo >>file2 "local changes" &&
+	test_must_fail git read-tree -m -u branch-point side-a side-b &&
+	! grep "new line to be kept" file2 &&
+	grep "local changes" file2
+
+'
+
 test_done
