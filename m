From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix t6031 on filesystems without working exec bit
Date: Wed, 21 May 2008 10:14:43 -0700
Message-ID: <7v8wy360l8.fsf@gitster.siamese.dyndns.org>
References: <20080518145727.GA3058@steel.home>
 <7v7idqaocb.fsf@gitster.siamese.dyndns.org>
 <20080519060015.GA3179@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 21 19:16:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jyruk-0007dA-Ij
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 19:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbYEUROx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 13:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbYEUROw
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 13:14:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37124 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765710AbYEUROv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 13:14:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7C39367FC;
	Wed, 21 May 2008 13:14:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6F6CB67F8; Wed, 21 May 2008 13:14:45 -0400 (EDT)
In-Reply-To: <20080519060015.GA3179@steel.home> (Alex Riesen's message of
 "Mon, 19 May 2008 08:00:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6A98A57A-2759-11DD-84C5-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82557>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Mon, May 19, 2008 06:51:16 +0200:
> ...
>> I have to wonder if this is enough on a filesystem with usable executable
>> bit.  Has this been tested on both kinds of filesystems?
>
> Yes and yes.

I am very much regretting for having extracted the above answer from you.
After actually running the test myself on a machine with executable bit, I
have to conclude that I now have to review any patch from you with much
more suspicion than I have done before.  Unless the test I ran on my
machine is lying to me, that is...

>> You aren't setting +x on work tree file anymore, but only flipping the bit
>> inside the index before committing.  Because of this change, after "b1"
>> commit, work tree has a local modification relative to the commit (namely,
>> reversion of chmod +x is in the work tree), which is different from the
>> original test sequence.  Doesn't this local modification interact with
>> switching to a1 branch and what merge-recursive does?
>
> I think no (I depend on this in my workflows on both systems).

Look at what the "switch to a1 branch after committing to b1" does again.
You modify "file1" and commit to "b1" and you now have a local change in
file1 (because you update only the index and not the work tree) that is
effectively a revert of what you committed just now, and a1 and b1 differs
at that path.  You get "Entry 'file1' not uptodate. Cannot merge."  when
you try to switch to "a1".

    $ sh t6031-merge-recursive.sh -i -v
    * expecting success: 
            : >file1 &&
            git add file1 &&
            git commit -m initial &&
            git checkout -b a1 master &&
            : >dummy &&
            git add dummy &&
            git commit -m a &&
            git checkout -b b1 master &&
            git update-index --chmod=+x file1 &&
            git commit -m b1 &&
            git checkout a1 &&
            git merge-recursive master -- a1 b1 &&
            test -x file1

    Created initial commit bae7a40: initial
     0 files changed, 0 insertions(+), 0 deletions(-)
     create mode 100644 file1
    Switched to a new branch "a1"
    Created commit 1f64f65: a
     0 files changed, 0 insertions(+), 0 deletions(-)
     create mode 100644 dummy
    Switched to a new branch "b1"
    Created commit 98a1cf4: b1
     0 files changed, 0 insertions(+), 0 deletions(-)
     mode change 100644 => 100755 file1
    error: Entry 'file1' not uptodate. Cannot merge.
    * FAIL 1: mode change in one branch: keep changed version

If we squash the following on top of your patch, I think we can help
filesystems without executable bit without breaking filesystems with one.
Can you see if it works on your executable-bit-less setup?

-- >8 --
 t/t6031-merge-recursive.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/t/t6031-merge-recursive.sh b/t/t6031-merge-recursive.sh
index f1c91c8..8073e0c 100755
--- a/t/t6031-merge-recursive.sh
+++ b/t/t6031-merge-recursive.sh
@@ -3,6 +3,9 @@
 test_description='merge-recursive: handle file mode'
 . ./test-lib.sh
 
+# Note that we follow "chmod +x F" with "update-index --chmod=+x F" to
+# help filesystems that do not have the executable bit.
+
 test_expect_success 'mode change in one branch: keep changed version' '
 	: >file1 &&
 	git add file1 &&
@@ -12,6 +15,7 @@ test_expect_success 'mode change in one branch: keep changed version' '
 	git add dummy &&
 	git commit -m a &&
 	git checkout -b b1 master &&
+	chmod +x file1 &&
 	git update-index --chmod=+x file1 &&
 	git commit -m b1 &&
 	git checkout a1 &&
@@ -24,6 +28,7 @@ test_expect_success 'mode change in both branches: expect conflict' '
 	git checkout -b a2 master &&
 	: >file2 &&
 	H=$(git hash-object file2) &&
+	chmod +x file2 &&
 	git update-index --add --chmod=+x file2 &&
 	git commit -m a2 &&
 	git checkout -b b2 master &&
