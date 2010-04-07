From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC] war on "sleep" in tests
Date: Tue, 06 Apr 2010 17:08:54 -0700
Message-ID: <7vfx38gm3t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 07 02:09:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzIpa-0008F6-AR
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 02:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228Ab0DGAJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 20:09:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46148 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932182Ab0DGAJB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 20:09:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 14CFAA8B71;
	Tue,  6 Apr 2010 20:08:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=D2kC
	5uM15szH4NqGSyM63/J10hw=; b=ncFcE8EyYtzeE/HFYzOiE5AEGCltpwu7zeLK
	z3yorBrzCk8nuoBpSJXMaveNpM6G67SNWvzbCRDu++ByEb/VtfQ1Z56apiR/vzfO
	XCGuXyINwc853/BGfAOnH0qi9XE7f6O5FLcCDHVkG9rSOwIjQK/2Ux9UXKlX73BX
	Y187cbg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=E4I
	1XoNIvNwAHvBNwwYK9oM7yJXcugQyDgUwQCaw+7XqUxW36TLqK7QtMXO0p8764ql
	CSlMaWtbRVnVCRrZMW0j02mqcN+QoWpENjs6fPb3a2sHG5LdbReQyPHZz9wgu76h
	F+dxBqxdgWZnRJWzLFbxD+Yh1MM+x4W3+XYcMWUE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 96D1FA8B6E;
	Tue,  6 Apr 2010 20:08:57 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 690DAA8B67; Tue,  6 Apr
 2010 20:08:55 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C2A3C5E6-41D9-11DF-ADFF-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144181>

In many places in test suite we have "sleep"s that do not have to be
there.

 - I do not simply see the point of the one in t3500.  It may be making
   sure that the timestamp order of commits generated during the test is
   stable, in which case test_tick is the right ingredient to use without
   wasting tester's time.

 - The one in t4011 is to make sure that the plumbing diff-index notices
   the stat-dirtyness of a removed then identically recreated symlink.
   Keeping the old symlink around to make sure that a newly created
   symlink gets different ino would be sufficient for that purpose.

 - The one in t7600 is to make sure that "git merge" does not get confused
   by stat-dirty "file" in the working tree.  Again, keeping the old file
   around and creating an identical copy to ensure a different ino would
   be sufficient for that purpose.

The "racy git" tests in t0010 are inherently about mtime between the index
itself and index entries.  The "sleep" in that test must stay as they are.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 t/t3500-cherry.sh       |    5 ++++-
 t/t4011-diff-symlink.sh |    5 ++---
 t/t7600-merge.sh        |    3 +--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
index dadbbc2..f038f34 100755
--- a/t/t3500-cherry.sh
+++ b/t/t3500-cherry.sh
@@ -17,17 +17,19 @@ test_expect_success \
     'prepare repository with topic branch, and check cherry finds the 2 patches from there' \
     'echo First > A &&
      git update-index --add A &&
+     test_tick &&
      git commit -m "Add A." &&
 
      git checkout -b my-topic-branch &&
 
      echo Second > B &&
      git update-index --add B &&
+     test_tick &&
      git commit -m "Add B." &&
 
-     sleep 2 &&
      echo AnotherSecond > C &&
      git update-index --add C &&
+     test_tick &&
      git commit -m "Add C." &&
 
      git checkout -f master &&
@@ -35,6 +37,7 @@ test_expect_success \
 
      echo Third >> A &&
      git update-index A &&
+     test_tick &&
      git commit -m "Modify A." &&
 
      expr "$(echo $(git cherry master my-topic-branch) )" : "+ [^ ]* + .*"
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index d7e327c..e12fbea 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -54,7 +54,7 @@ EOF
 
 test_expect_success \
     'diff removed symlink' \
-    'rm frotz &&
+    'mv frotz frotz2 &&
     git diff-index -M -p $tree > current &&
     compare_diff_patch current expected'
 
@@ -64,8 +64,7 @@ EOF
 
 test_expect_success \
     'diff identical, but newly created symlink' \
-    'sleep 3 &&
-    ln -s xyzzy frotz &&
+    'ln -s xyzzy frotz &&
     git diff-index -M -p $tree > current &&
     compare_diff_patch current expected'
 
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 57f6d2b..cde8390 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -554,8 +554,7 @@ test_debug 'gitk --all'
 
 test_expect_success 'refresh the index before merging' '
 	git reset --hard c1 &&
-	sleep 1 &&
-	touch file &&
+	cp file file.n && mv -f file.n file &&
 	git merge c3
 '
 
