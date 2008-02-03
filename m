From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Sat, 02 Feb 2008 22:39:18 -0800
Message-ID: <7vr6fuzgq1.fsf@gitster.siamese.dyndns.org>
References: <20080202122135.GA5783@code-monkey.de>
	<20080203030054.GA18654@coredump.intra.peff.net>
	<20080203043310.GA5984@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 03 07:40:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLYWd-0001VR-TE
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 07:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbYBCGjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 01:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751603AbYBCGjl
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 01:39:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60313 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbYBCGjl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 01:39:41 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A8E1464DB;
	Sun,  3 Feb 2008 01:39:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D06DA64DA;
	Sun,  3 Feb 2008 01:39:34 -0500 (EST)
In-Reply-To: <20080203043310.GA5984@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 2 Feb 2008 23:33:10 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72331>

Jeff King <peff@peff.net> writes:

> On Sat, Feb 02, 2008 at 10:00:54PM -0500, Jeff King wrote:
>
>> That being said, the commit in your 'master' branch _is_ part of
>> 1dd567d5, and should be culled. So I'm not clear on why it shows up only
>> when you ask to see both branches, and that may be a bug.
>
> OK, there is definitely a bug here, but I'm having some trouble figuring
> out the correct fix. It's in the revision walker, so I have cc'd those
> who are more clueful than I.
>
> You can recreate a problematic repo using this script:
>
> -- >8 --
> mkdir repo && cd repo
> git init
>
> touch file && git add file
> commit() {
>   echo $1 >file && git commit -a -m $1 && git tag $1
> }
>
> commit one
> commit two
> commit three
> git checkout -b other two
> commit alt-three
> git checkout master
> git merge other || true
> commit merged
> commit four
> -- 8< --
>
> So a fairly simple repo, but with the key element that it contains a
> merge.

It is not so simple, it appears.  If I add for reproducibility
"test_tick" like this:

        commit () {
                test_tick &&
                echo $1 >file &&
                git commit -a -m $1 &&
                git tag $1
        }

the problem goes away.

So there is some interaction with "insert_by_date()".  Still
digging.

 t/t6009-rev-list-parent.sh |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/t/t6009-rev-list-parent.sh b/t/t6009-rev-list-parent.sh
new file mode 100755
index 0000000..66164e9
--- /dev/null
+++ b/t/t6009-rev-list-parent.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+
+test_description='properly cull all ancestors'
+
+. ./test-lib.sh
+
+commit () {
+	: test_tick &&
+	echo $1 >file &&
+	git commit -a -m $1 &&
+	git tag $1
+}
+
+test_expect_success setup '
+
+	touch file &&
+	git add file &&
+
+	commit one &&
+	commit two &&
+	commit three &&
+
+	git checkout -b other two &&
+	commit alt-three &&
+
+	git checkout master &&
+
+	git merge -s ours other &&
+
+	commit merged &&
+	commit four &&
+
+	git -p show-branch --more=999
+
+'
+
+test_expect_failure 'one is ancestor of others and should not be shown' '
+
+	git rev-list one --not four >result &&
+	>expect &&
+	diff -u expect result 
+
+'
