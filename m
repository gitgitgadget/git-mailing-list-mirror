From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] test: fetch/receive with fsckobjects
Date: Sun,  4 Sep 2011 19:21:37 -0700
Message-ID: <1315189297-19497-4-git-send-email-gitster@pobox.com>
References: <7vliu4yv8w.fsf@alter.siamese.dyndns.org>
 <1315189297-19497-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 04:22:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0Ooz-0004Bj-Kd
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 04:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758Ab1IECVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 22:21:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35487 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318Ab1IECVp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 22:21:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38C28450D
	for <git@vger.kernel.org>; Sun,  4 Sep 2011 22:21:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Qvga
	zkm99VXCKUjYyzjWjXNn7rA=; b=Fmk9SQ0inMDyAiThkaW4MpIjuQp1yO01qfn/
	eK/MxEWTJnZCvJMR2fskfuDuqQrgEhuhCL7b3gkC5hrmriVKbxBSZoEpeUL1GXPJ
	tDuSNyXZqkJm6OacmWhIh1Rt+nzGfVPYJ3DL/50cfJ05GSjdZjUOB0hjuele1M8r
	FEKK74Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Ltzk7/
	jtnSKgzKR4Ci1vi8bfk9lyVmIR1IEzXOdNhL9jZ/jgXb855LjUKn4PHdI1OfRamU
	+CkEpVsp8ZbKmf7V2UYItP5c03nS0xvVEU4R2fwbkxZlZnyGU+0t8hrZLJlfSz3t
	x0+f5TcsSGDoDd/+0l6Sg0fVXV3d2Jew9bZwA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 311FC450C
	for <git@vger.kernel.org>; Sun,  4 Sep 2011 22:21:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99EA4450B for
 <git@vger.kernel.org>; Sun,  4 Sep 2011 22:21:44 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.175.gb3212
In-Reply-To: <1315189297-19497-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CCA8DEBE-D765-11E0-A8A2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180710>

Add tests for the new fetch.fsckobjects, and also tests for
receive.fsckobjects we have had for quite some time.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5504-fetch-receive-strict.sh |  104 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 104 insertions(+), 0 deletions(-)
 create mode 100755 t/t5504-fetch-receive-strict.sh

diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
new file mode 100755
index 0000000..6610012
--- /dev/null
+++ b/t/t5504-fetch-receive-strict.sh
@@ -0,0 +1,104 @@
+#!/bin/sh
+
+test_description='fetch/receive strict mode'
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo hello >greetings &&
+	git add greetings &&
+	git commit -m greetings &&
+
+	S=$(git rev-parse :greetings | sed -e "s|^..|&/|") &&
+	X=$(echo bye | git hash-object -w --stdin | sed -e "s|^..|&/|") &&
+	mv -f .git/objects/$X .git/objects/$S &&
+
+	test_must_fail git fsck
+'
+
+test_expect_success 'fetch without strict' '
+	rm -rf dst &&
+	git init dst &&
+	(
+		cd dst &&
+		git config fetch.fsckobjects false &&
+		git config transfer.fsckobjects false &&
+		git fetch ../.git master
+	)
+'
+
+test_expect_success 'fetch with !fetch.fsckobjects' '
+	rm -rf dst &&
+	git init dst &&
+	(
+		cd dst &&
+		git config fetch.fsckobjects false &&
+		git config transfer.fsckobjects true &&
+		git fetch ../.git master
+	)
+'
+
+test_expect_success 'fetch with fetch.fsckobjects' '
+	rm -rf dst &&
+	git init dst &&
+	(
+		cd dst &&
+		git config fetch.fsckobjects true &&
+		git config transfer.fsckobjects false &&
+		test_must_fail git fetch ../.git master
+	)
+'
+
+test_expect_success 'fetch with transfer.fsckobjects' '
+	rm -rf dst &&
+	git init dst &&
+	(
+		cd dst &&
+		git config transfer.fsckobjects true &&
+		test_must_fail git fetch ../.git master
+	)
+'
+
+test_expect_success 'push without strict' '
+	rm -rf dst &&
+	git init dst &&
+	(
+		cd dst &&
+		git config fetch.fsckobjects false &&
+		git config transfer.fsckobjects false
+	) &&
+	git push dst master:refs/heads/test
+'
+
+test_expect_success 'push with !receive.fsckobjects' '
+	rm -rf dst &&
+	git init dst &&
+	(
+		cd dst &&
+		git config receive.fsckobjects false &&
+		git config transfer.fsckobjects true
+	) &&
+	git push dst master:refs/heads/test
+'
+
+test_expect_success 'push with receive.fsckobjects' '
+	rm -rf dst &&
+	git init dst &&
+	(
+		cd dst &&
+		git config receive.fsckobjects true &&
+		git config transfer.fsckobjects false
+	) &&
+	test_must_fail git push dst master:refs/heads/test
+'
+
+test_expect_success 'push with transfer.fsckobjects' '
+	rm -rf dst &&
+	git init dst &&
+	(
+		cd dst &&
+		git config transfer.fsckobjects true
+	) &&
+	test_must_fail git push dst master:refs/heads/test
+'
+
+test_done
-- 
1.7.7.rc0.175.gb3212
