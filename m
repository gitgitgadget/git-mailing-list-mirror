From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/4] apply: make update_pre_post_images() sanity check the given postlen
Date: Thu, 22 Jan 2015 14:58:23 -0800
Message-ID: <1421967505-16879-3-git-send-email-gitster@pobox.com>
References: <xmqq1tmnwypp.fsf@gitster.dls.corp.google.com>
 <1421967505-16879-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 22 23:58:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEQi9-0007u0-EO
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 23:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753735AbbAVW6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 17:58:45 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52485 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753212AbbAVW6o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 17:58:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 88DFB3135B;
	Thu, 22 Jan 2015 17:58:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=kpFE
	1ylY8+GDugIcdrjYoVOfqlQ=; b=R0LqPpMghSb8fD1qULhSKxXrkO9R2XZpJzMr
	CtvRJCJ2anembUqhbRUiKBc5ViV4fFCu4AJNDD22ntSxN1gl+Z+huYZLb+pUVCn4
	YqFghPvCWEo4zaPNWrsLq+bwnSgLHnCpCLSewx8f8mm+tMAf6FWYMULhJ93ZyhVw
	2pvmGig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=V68SHn
	BgY9O/3EyQWC/AkpoXw/uddTnh0a/iiN1FR0nLFlCJMfp8x/0buXa9GcsMeGli68
	hnZPWvnWybFyVhaiOKmRqFDMdKb4zIJouaG3e/OZXoO+/PlTjD4FQDTj+OBT5wa+
	n4K6tHE6OCeGhMldB9dxEWVpn0Lycgs/EYUIQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8133A3135A;
	Thu, 22 Jan 2015 17:58:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B515B31346;
	Thu, 22 Jan 2015 17:58:29 -0500 (EST)
X-Mailer: git-send-email 2.3.0-rc1-150-gaf32ea2
In-Reply-To: <1421967505-16879-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2E834136-A28A-11E4-9FC5-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262883>

"git apply --whitespace=fix" used to be able to assume that fixing
errors will always reduce the size by e.g. stripping whitespaces at
the end of lines or collapsing runs of spaces into tabs at the
beginning of lines.  An update to accomodate fixes that lengthens
the result by e.g. expanding leading tabs into spaces were made long
time ago but the logic miscounted the necessary space after such
whitespace fixes, leading to either under-allocation or over-usage
of already allocated space.

Illustrate this with a runtime sanity-check to protect us from
future breakage.  The test was stolen from Kyle McKay who helped
to identify the problem.

Helped-by: "Kyle J. McKay" <mackyle@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c               |   6 +++
 t/t4138-apply-ws-expansion.sh | 121 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+)
 create mode 100755 t/t4138-apply-ws-expansion.sh

diff --git a/builtin/apply.c b/builtin/apply.c
index 31f8733..da6fb35 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2171,6 +2171,12 @@ static void update_pre_post_images(struct image *preimage,
 		ctx++;
 	}
 
+	if (postlen
+	    ? postlen < new - postimage->buf
+	    : postimage->len < new - postimage->buf)
+		die("BUG: caller miscounted postlen: asked %d, orig = %d, used = %d",
+		    (int)postlen, (int) postimage->len, (int)(new - postimage->buf));
+
 	/* Fix the length of the whole thing */
 	postimage->len = new - postimage->buf;
 	postimage->nr -= reduced;
diff --git a/t/t4138-apply-ws-expansion.sh b/t/t4138-apply-ws-expansion.sh
new file mode 100755
index 0000000..0ffe33f
--- /dev/null
+++ b/t/t4138-apply-ws-expansion.sh
@@ -0,0 +1,121 @@
+#!/bin/sh
+#
+# Copyright (C) 2015 Kyle J. McKay
+#
+
+test_description='git apply test patches with whitespace expansion.'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	#
+	## create test-N, patchN.patch, expect-N files
+	#
+
+	# test 1
+	printf "\t%s\n" 1 2 3 4 5 6 >before &&
+	printf "\t%s\n" 1 2 3 >after &&
+	printf "%64s\n" a b c >>after &&
+	printf "\t%s\n" 4 5 6 >>after &&
+	git diff --no-index before after |
+		sed -e "s/before/test-1/" -e "s/after/test-1/" >patch1.patch &&
+	printf "%64s\n" 1 2 3 4 5 6 >test-1 &&
+	printf "%64s\n" 1 2 3 a b c 4 5 6 >expect-1 &&
+
+	# test 2
+	printf "\t%s\n" a b c d e f >before &&
+	printf "\t%s\n" a b c >after &&
+	n=10 &&
+	x=1 &&
+	while test $x -lt $n
+	do
+		printf "%63s%d\n" "" $x >>after
+		x=$(( $x + 1 ))
+	done &&
+	printf "\t%s\n" d e f >>after &&
+	git diff --no-index before after |
+		sed -e "s/before/test-2/" -e "s/after/test-2/" >patch2.patch &&
+	printf "%64s\n" a b c d e f >test-2 &&
+	printf "%64s\n" a b c >expect-2 &&
+	x=1 &&
+	while test $x -lt $n
+	do
+		printf "%63s%d\n" "" $x >>expect-2
+		x=$(( $x + 1 ))
+	done &&
+	printf "%64s\n" d e f >>expect-2 &&
+
+	# test 3
+	printf "\t%s\n" a b c d e f >before &&
+	printf "\t%s\n" a b c >after &&
+	n=100 &&
+	x=0 &&
+	while test $x -lt $n
+	do
+		printf "%63s%02d\n" "" $x >>after
+		x=$(( $x + 1 ))
+	done &&
+	printf "\t%s\n" d e f >>after &&
+	git diff --no-index before after |
+	sed -e "s/before/test-3/" -e "s/after/test-3/" >patch3.patch &&
+	printf "%64s\n" a b c d e f >test-3 &&
+	printf "%64s\n" a b c >expect-3 &&
+	x=0 &&
+	while test $x -lt $n
+	do
+		printf "%63s%02d\n" "" $x >>expect-3
+		x=$(( $x + 1 ))
+	done &&
+	printf "%64s\n" d e f >>expect-3 &&
+
+	# test 4
+	>before &&
+	x=0 &&
+	while test $x -lt 50
+	do
+		printf "\t%02d\n" $x >>before
+		x=$(( $x + 1 ))
+	done &&
+	cat before >after &&
+	printf "%64s\n" a b c >>after &&
+	while test $x -lt 100
+	do
+		printf "\t%02d\n" $x >>before
+		printf "\t%02d\n" $x >>after
+		x=$(( $x + 1 ))
+	done &&
+	git diff --no-index before after |
+	sed -e "s/before/test-4/" -e "s/after/test-4/" >patch4.patch &&
+	>test-4 &&
+	x=0 &&
+	while test $x -lt 50
+	do
+		printf "%63s%02d\n" "" $x >>test-4
+		x=$(( $x + 1 ))
+	done &&
+	cat test-4 >expect-4 &&
+	printf "%64s\n" a b c >>expect-4 &&
+	while test $x -lt 100
+	do
+		printf "%63s%02d\n" "" $x >>test-4
+		printf "%63s%02d\n" "" $x >>expect-4
+		x=$(( $x + 1 ))
+	done &&
+
+	git config core.whitespace tab-in-indent,tabwidth=63 &&
+	git config apply.whitespace fix
+
+'
+
+# Note that `patch` can successfully apply all patches when run
+# with the --ignore-whitespace option.
+
+for t in 1 2 3 4
+do
+	test_expect_success 'apply with ws expansion (t=$t)' '
+		git apply patch$t.patch &&
+		test_cmp test-$t expect-$t
+	'
+done
+
+test_done
-- 
2.3.0-rc1-116-g84c5016
