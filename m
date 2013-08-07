From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] t5802: add test for connect helper
Date: Wed,  7 Aug 2013 16:30:38 -0700
Message-ID: <1375918242-4655-2-git-send-email-gitster@pobox.com>
References: <1375918242-4655-1-git-send-email-gitster@pobox.com>
Cc: Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 08 01:30:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7DBw-00059C-As
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 01:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757517Ab3HGXat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 19:30:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60492 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752651Ab3HGXas (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 19:30:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C0AB37F97;
	Wed,  7 Aug 2013 23:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=uhHM
	EaMf1zQZ8sYusna3Y8Vuf+E=; b=ILwrvpg2IKDUwnQjmMByTGQ3d/o9W9I/VmCj
	vYak4tYNQORU1YybKmsdqL1pJFrbAx4Z0L8x4MNJk/4Bae7mWaJ5pzhfBFpG2E3r
	KmOlWFJQSWFgWVrGcTvZhXnWvNO3otoYAph0Khx7T+0mct6pti07ZBJs6sH99Xq7
	thHjgF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	wMfj84tfJ2nzo8SYTf5ogqN1lwjZJtE7yVafwZW/QRJwTYkRv/yyx2wcIhaMkJLW
	sJHuEbIK88GI6eBj6L2esUtrtjSeKAguETcjv9vWxwhrj9jJb2DC9HmP9jpJZxrA
	DkrhXZNDKENUBXmF2anYtf/SEmvYCUsXbqj7yfneCNU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EF0F37F96;
	Wed,  7 Aug 2013 23:30:47 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95B3837F94;
	Wed,  7 Aug 2013 23:30:46 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-rc1-210-gf6d87e2
In-Reply-To: <1375918242-4655-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 62CDBAD6-FFB9-11E2-BE8E-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231848>

This is an attempt to reproduce a problem reported for a third-party
custom "connect" remote helper.  The conjecture is that sometimes
"git fetch" wants to make two connections (one for the primary
transfer with 'follow-tags' option set, and then after noticing that
some tags are not packed because the primary transfer did not have
to send any commit that is pointed by them, another to explicitly
ask for the missing tags), and their "connect" helper is not called
in the second request, breaking the "fetch" as a whole.

Unfortunately this test script does not trigger the alleged failure
and happily passes when talking to upload-pack from git-core (see
patch 5/5 for details).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5802-connect-helper.sh | 72 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100755 t/t5802-connect-helper.sh

diff --git a/t/t5802-connect-helper.sh b/t/t5802-connect-helper.sh
new file mode 100755
index 0000000..878faf2
--- /dev/null
+++ b/t/t5802-connect-helper.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+
+test_description='ext::cmd remote "connect" helper'
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_tick &&
+	git commit --allow-empty -m initial &&
+	test_tick &&
+	git commit --allow-empty -m second &&
+	test_tick &&
+	git commit --allow-empty -m third &&
+	test_tick &&
+	git tag -a -m "tip three" three &&
+
+	test_tick &&
+	git commit --allow-empty -m fourth
+'
+
+test_expect_success clone '
+	cmd=$(echo "echo >&2 ext::sh invoked && %S .." | sed -e "s/ /% /g") &&
+	git clone "ext::sh -c %S% ." dst &&
+	git for-each-ref refs/heads/ refs/tags/ >expect &&
+	(
+		cd dst &&
+		git config remote.origin.url "ext::sh -c $cmd" &&
+		git for-each-ref refs/heads/ refs/tags/
+	) >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'update following tag' '
+	test_tick &&
+	git commit --allow-empty -m fifth &&
+	test_tick &&
+	git tag -a -m "tip five" five &&
+	git for-each-ref refs/heads/ refs/tags/ >expect &&
+	(
+		cd dst &&
+		git pull &&
+		git for-each-ref refs/heads/ refs/tags/ >../actual
+	) &&
+	test_cmp expect actual
+'
+
+test_expect_success 'update backfilled tag' '
+	test_tick &&
+	git commit --allow-empty -m sixth &&
+	test_tick &&
+	git tag -a -m "tip two" two three^1 &&
+	git for-each-ref refs/heads/ refs/tags/ >expect &&
+	(
+		cd dst &&
+		git pull &&
+		git for-each-ref refs/heads/ refs/tags/ >../actual
+	) &&
+	test_cmp expect actual
+'
+
+test_expect_success 'update backfilled tag without primary transfer' '
+	test_tick &&
+	git tag -a -m "tip one " one two^1 &&
+	git for-each-ref refs/heads/ refs/tags/ >expect &&
+	(
+		cd dst &&
+		git pull &&
+		git for-each-ref refs/heads/ refs/tags/ >../actual
+	) &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.8.4-rc1-210-gf6d87e2
