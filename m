From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4049: avoid test failures on filemode challenged file
 systems (Windows)
Date: Thu, 29 Nov 2012 09:51:42 -0800
Message-ID: <7vfw3sqoup.fsf@alter.siamese.dyndns.org>
References: <1354051310-29093-1-git-send-email-gitster@pobox.com>
 <50B71B33.1090000@viscovery.net> <7v38zss7zb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Nov 29 18:52:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te8HO-0002ve-QE
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 18:52:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399Ab2K2Rvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 12:51:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47781 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303Ab2K2Rvu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 12:51:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDDA3A575;
	Thu, 29 Nov 2012 12:51:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LRe5HCNNTRYw7Za4wuuVFibP2u4=; b=VbDs9E
	AV87vIkNMUN9dgLXB9DXpwjfbArBBSpVN2CXbyX/HiII5W9kPtKTSeQklTCPTZ4u
	vxWRKHch9iKoy2oFOU+oqyES7nTZorE2M6PKxl4t2osKU25qogzSUxO1WFFOa/qz
	qKpfza1ZBA0HqYwL28zlaafpMK107HsbjK2OM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=erkWUE0gKeTK3RvnhV4I18MjzjwAxQ/8
	6YWJ1ZmfWyrZV2S3BmXh4eJG5lPV6VPe8M+q0CQH6KRhESv17IvWZyx/ZVcrYouq
	EaY2yawzrZyPHa66KFLZrhITMKk8Vjvl77O360EW6vE46LLGYCYAWTZi/31SZ9p5
	rFbGO5Ohdz8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB943A573;
	Thu, 29 Nov 2012 12:51:44 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05700A56C; Thu, 29 Nov 2012
 12:51:43 -0500 (EST)
In-Reply-To: <7v38zss7zb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 29 Nov 2012 08:13:12 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6FFD5B8A-3A4D-11E2-8A6C-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210851>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Sixt <j.sixt@viscovery.net> writes:
>
>>> It turns out that there are at least two bugs in the diffstat
>>> counting code.  This series comes on top of the earlier 74faaa1 (Fix
>>> "git diff --stat" for interesting - but empty - file changes,
>>> 2012-10-17) to fix them.
>>
>> The tests still fail on Windows. I am not sure whether there is a
>> difference in comparing the file system against the index or a commit.
>> If there is, then the updated tests might not test the same thing.
>
> The hunks in the patch look fine.  The last one that tests unmerged
> entries do not have to have "chmod" if it gives you trouble (you
> would need to reduce number of files from 4 to 3 if you go that
> route, I think).

That is, something like this.

-- >8 --
Subject: [PATCH] t4049: refocus tests

The primary thing Linus's patch wanted to change was to make sure
that 0-line change appears for a mode-only change.  Update the
first test to chmod a file that we can see in the output (limited
by --stat-count) to demonstrate it.  Also make sure to use test_chmod
and compare the index and the tree, so that we can run this test
even on a filesystem without permission bits.

Later two tests are about fixes to separate issues that were
introduced and/or uncovered by Linus's patch as a side effect, but
the issues are not related to mode-only changes.  Remove chmod from
the tests.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4049-diff-stat-count.sh | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/t/t4049-diff-stat-count.sh b/t/t4049-diff-stat-count.sh
index 37f50cd..5b594e8 100755
--- a/t/t4049-diff-stat-count.sh
+++ b/t/t4049-diff-stat-count.sh
@@ -13,32 +13,31 @@ test_expect_success 'setup' '
 	git commit -m initial
 '
 
-test_expect_success 'limit output to 2 (simple)' '
+test_expect_success 'mode-only change show as a 0-line change' '
 	git reset --hard &&
-	chmod +x c d &&
+	test_chmod +x b d &&
 	echo a >a &&
-	echo b >b &&
+	echo c >c &&
 	cat >expect <<-\EOF
 	 a | 1 +
-	 b | 1 +
+	 b | 0
 	 ...
 	 4 files changed, 2 insertions(+)
 	EOF
-	git diff --stat --stat-count=2 >actual &&
+	git diff --stat --stat-count=2 HEAD >actual &&
 	test_i18ncmp expect actual
 '
 
 test_expect_success 'binary changes do not count in lines' '
 	git reset --hard &&
-	chmod +x c d &&
 	echo a >a &&
-	echo b >b &&
+	echo c >c &&
 	cat "$TEST_DIRECTORY"/test-binary-1.png >d &&
 	cat >expect <<-\EOF
 	 a | 1 +
-	 b | 1 +
+	 c | 1 +
 	 ...
-	 4 files changed, 2 insertions(+)
+	 3 files changed, 2 insertions(+)
 	EOF
 	git diff --stat --stat-count=2 >actual &&
 	test_i18ncmp expect actual
@@ -56,12 +55,11 @@ test_expect_success 'exclude unmerged entries from total file count' '
 	done |
 	git update-index --index-info &&
 	echo d >d &&
-	chmod +x c d &&
 	cat >expect <<-\EOF
 	 a | 1 +
 	 b | 1 +
 	 ...
-	 4 files changed, 3 insertions(+)
+	 3 files changed, 3 insertions(+)
 	EOF
 	git diff --stat --stat-count=2 >actual &&
 	test_i18ncmp expect actual
-- 
1.8.0.1.407.g3c58eb7
