From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Add test that checks diverse aspects of updating remote
	and tracking branches
Date: Wed, 14 Nov 2007 23:49:27 +0100
Message-ID: <20071114224926.GF3973@steel.home>
References: <20071112213823.GB2918@steel.home> <20071112213938.GC2918@steel.home> <20071113075240.GA21799@sigill.intra.peff.net> <20071113194731.GC3268@steel.home> <20071113194909.GD3268@steel.home> <20071113230234.GI3268@steel.home> <7vbq9wfqb0.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 23:50:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsR3p-0008C2-Q3
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 23:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756396AbXKNWtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 17:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756601AbXKNWtd
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 17:49:33 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:59603 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755433AbXKNWtb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 17:49:31 -0500
Received: from tigra.home (Fad5d.f.strato-dslnet.de [195.4.173.93])
	by post.webmailer.de (fruni mo35) (RZmta 14.0)
	with ESMTP id a021dfjAEMg6WU ; Wed, 14 Nov 2007 23:49:28 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 01F15277AE;
	Wed, 14 Nov 2007 23:49:27 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 64DDC56D22; Wed, 14 Nov 2007 23:49:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vbq9wfqb0.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyCll4dQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65022>

Because we haven't settled on what the exit status from
"git push" command itself should be in such a partial
failure case, do not check the exit status from it for
now.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Junio C Hamano, Wed, Nov 14, 2007 22:52:19 +0100:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > Ignore exit code of git push in t5404, as it is not relevant for the
> > test: it already checks whether the references updated correctly.
> 
> I think the Subject: goes a lot better with a description like this:
> 
> 	Add test that checks the case where X does Y and make
> 	sure Z happens.

Add test that checks diverse aspects of updating remote and tracking
branches.

> 	Because we haven't settled on what the exit status from
> 	"git push" command itself should be in such a partial
> 	failure case, do not check the exit status from it for
> 	now.

This I'll leave as is.

> > +	git branch b3 &&
> 
> So it makes another ref "b3" point at the initial commit,... 

Right

> > +	b3=$(git rev-parse origin/b3) &&
> 
> ... then records what was cloned,...

Precisely

> > +		test "$(git rev-parse origin/b3)" = "$b3" &&
> 
> ... and checks that untouched "b3" stays the same (iow, tests
> up-to-date case).

Yep.

> > +
> > +test_expect_success 'delete remote branch' '
> > +	git push origin :refs/heads/b3
> > +	{
> > +		git rev-parse origin/b3
> > +		test $? != 0 || \
> > +		say "Hmm... Maybe tracking ref should be deleted?"
> > +        } &&
> 
> Ah, you meant that tracking should be deleted so this should be
> fixed in the code but the test is disabled for now.  Let's be a
> bit more explicit about such a temporary disabled test, like
> this:
> 
> 	git push origin :refs/heads/b3
> 
> 	# The remote-tracking branch origin/b3 should be deleted;
>         # we need to update the code and enable this test.
>         : git rev-parse --verify origin/b3 &&

Nice, will take this. Except we have to check for absence of the
tracking branch. git-rev-parse must fail.

 t/t5404-tracking-branches.sh |   64 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)
 create mode 100755 t/t5404-tracking-branches.sh

diff --git a/t/t5404-tracking-branches.sh b/t/t5404-tracking-branches.sh
new file mode 100755
index 0000000..d861a14
--- /dev/null
+++ b/t/t5404-tracking-branches.sh
@@ -0,0 +1,64 @@
+#!/bin/sh
+
+test_description='tracking branch update checks for git push'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo 1 >file &&
+	git add file &&
+	git commit -m 1 &&
+	git branch b1 &&
+	git branch b2 &&
+	git branch b3 &&
+	git clone . aa &&
+	git checkout b1 &&
+	echo b1 >>file &&
+	git commit -a -m b1 &&
+	git checkout b2 &&
+	echo b2 >>file &&
+	git commit -a -m b2
+'
+
+start_dir="$(pwd)"
+
+test_expect_success 'check tracking branches updated correctly after push' '
+	cd aa &&
+	b1=$(git rev-parse origin/b1) &&
+	b2=$(git rev-parse origin/b2) &&
+	b3=$(git rev-parse origin/b3) &&
+	git checkout -b b1 origin/b1 &&
+	echo aa-b1 >>file &&
+	git commit -a -m aa-b1 &&
+	git checkout -b b2 origin/b2 &&
+	echo aa-b2 >>file &&
+	git commit -a -m aa-b2 &&
+	git checkout master &&
+	echo aa-master >>file &&
+	git commit -a -m aa-master &&
+	{
+		git push
+		test "$(git rev-parse origin/b1)" = "$b1" &&
+		test "$(git rev-parse origin/b2)" = "$b2" &&
+		test "$(git rev-parse origin/b3)" = "$b3" &&
+		test "$(git rev-parse origin/master)" = \
+		"$(git rev-parse master)"
+	}
+'
+
+test_expect_success 'delete remote branch' '
+	git push origin :refs/heads/b3
+	{
+	# The remote-tracking branch origin/b3 should be deleted;
+	# we need to update the code and enable this test.
+		: git rev-parse --verify origin/b3
+		: test $? != 0
+        } &&
+	cd "$start_dir" &&
+	{
+		git rev-parse refs/heads/b3
+		test $? != 0
+        }
+'
+
+test_done
-- 
1.5.3.5.692.ge1737
