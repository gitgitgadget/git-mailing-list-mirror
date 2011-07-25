From: Phil Hord <hordp@cisco.com>
Subject: [PATCH] Add two basic tests for "rerere remaining"
Date: Mon, 25 Jul 2011 18:31:32 -0400
Message-ID: <4E2DEEC4.4050000@cisco.com>
References: <4E1F22DF.7060209@cisco.com> <alpine.DEB.2.00.1107152208530.12060@debian> <7voc0szhzn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 26 00:32:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlThF-0000yx-M6
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 00:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751Ab1GYWbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 18:31:37 -0400
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:32046 "EHLO
	rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532Ab1GYWbf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 18:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=2826; q=dns/txt;
  s=iport; t=1311633095; x=1312842695;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=aG7JgaUqzWKVvo1Uavy62pQ36m75J9+WDKJC+JBHOWU=;
  b=mqOB6bpPJYwng3YLUL2jwabDOGfxro72OjgBngQzexo0WatUePiKhUKx
   vUHqBglYHs+GcWJtkbQcPqmKDOitCe0eF66twaQVxixHVxJNNG1xa2Pcb
   rI/DG3gdjM1la0Y7MPUm4bDbVf3Lsn6XU684MDaN7+4DFpjSwiN1u3gHw
   8=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av4EALTtLU6tJXG+/2dsb2JhbAA1AQEEFAFvAREtIg8JAwIBAgECUQcOAQgGAQEfpzR3q0yePoY/BJJwhQeLdQ
X-IronPort-AV: E=Sophos;i="4.67,265,1309737600"; 
   d="scan'208";a="6284627"
Received: from rcdn-core2-3.cisco.com ([173.37.113.190])
  by rcdn-iport-5.cisco.com with ESMTP; 25 Jul 2011 22:31:34 +0000
Received: from [64.100.104.94] (dhcp-64-100-104-94.cisco.com [64.100.104.94])
	by rcdn-core2-3.cisco.com (8.14.3/8.14.3) with ESMTP id p6PMVXN6007325;
	Mon, 25 Jul 2011 22:31:34 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110627 Thunderbird/5.0
In-Reply-To: <7voc0szhzn.fsf@alter.siamese.dyndns.org>
X-TagToolbar-Keys: D20110725183131807
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177829>

After a 'git stash apply' which results in a conflicted file,
git mergetool can be used to work on the conflicts.  However,
when rerere.enabled=true, git mergetool determines the list
of unresolved file conflicts by asking 'git rerere remaining'.

There is a problem with this because rerere does not record
the 'git stash apply' conflicts and so 'git rerere remaining'
does not report them.

Demonstrate this failing so it can be studied and addressed.

Also add a very basic test for 'git rerere remaining' after
a normal merge conflict.

Signed-off-by: Phil Hord <hordp@cisco.com>
---

This patch adds one failing test and one working test.

The working test is very limited and just repeats the
same test as the 'rerere status' one for 'rerere remaining'.
A better test should probably be added, one that demonstrates
and confirms the differences between 'rerere status' and
'rerere remaining'.  I don't understand this difference
well enough to code that test, though.

This patch is the same as before, but dropping the /RFC. 

 t/t4200-rerere.sh |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 36255d6..a96ebad 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -96,10 +96,42 @@ test_expect_success 'rerere.enabled works, too' '
 	grep ^=======$ $rr/preimage
 '
 
+test_expect_success 'set up conflicted stash apply' '
+	rm -rf .git/rr-cache &&
+	git config rerere.enabled true &&
+
+	git reset --hard &&
+	git checkout master &&
+	git show second:a1 >a1 &&
+
+	# should be 1 modified file and no unmerged files
+	test $(git ls-files -m |wc -l) = 1 &&
+	test $(git ls-files -u |wc -l) = 0 &&
+
+	git stash save &&
+	git checkout first &&
+
+	test_must_fail git stash apply &&
+
+	# there should be three states for one unresolved file
+	cnt=$(git ls-files -u | wc -l) &&
+	echo $cnt &&
+	test $cnt = 3
+'
+
+test_expect_failure 'rerere-remaining correctly reports stash-apply conflicts' '
+	echo a1 >expect &&
+	git rerere status >out &&
+	test_cmp expect out &&
+	git rerere remaining >out &&
+	test_cmp expect out
+'
+
 test_expect_success 'set up rr-cache' '
 	rm -rf .git/rr-cache &&
 	git config rerere.enabled true &&
 	git reset --hard &&
+	git checkout second &&
 	test_must_fail git merge first &&
 	sha1=$(perl -pe "s/	.*//" .git/MERGE_RR) &&
 	rr=.git/rr-cache/$sha1
@@ -160,6 +192,12 @@ test_expect_success 'rerere status' '
 	test_cmp expect out
 '
 
+test_expect_success 'rerere remaining' '
+	echo a1 >expect &&
+	git rerere remaining >out &&
+	test_cmp expect out
+'
+
 test_expect_success 'first postimage wins' '
 	git show first:a1 | sed "s/To die: t/To die! T/" >expect &&
 
-- 1.7.6.8.gd2879
