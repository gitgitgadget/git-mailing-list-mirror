From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 2/3] t3312-notes-empty: Test that 'git notes' removes empty notes by default
Date: Wed,  5 Nov 2014 09:32:26 +0100
Message-ID: <1415176347-18694-2-git-send-email-johan@herland.net>
References: <1415176347-18694-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 05 09:33:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xlw1g-0006Mv-5y
	for gcvg-git-2@plane.gmane.org; Wed, 05 Nov 2014 09:33:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924AbaKEIdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2014 03:33:06 -0500
Received: from mail-la0-f49.google.com ([209.85.215.49]:39277 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbaKEIdD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2014 03:33:03 -0500
Received: by mail-la0-f49.google.com with SMTP id ge10so223368lab.8
        for <git@vger.kernel.org>; Wed, 05 Nov 2014 00:33:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yqn6USHa7ilj/gW7sBIfDft53hjzORsoCGs8ADi2RMI=;
        b=OrwlvtQMU1YZO2+qkIrQ278k+S1jr9zmuQkzk1i8VBtQtpwfGwBQxJERA7QtP8CDo5
         rFWd+tm/va6+3aKKAtOjW7Bet0QlMSLJWFZkhSxWO0zPchI5XGfY5GE5GNiwHRpM9Fg1
         V2gVUvK/THH52Q01wpZptd6STtN8LlS6RGVP4aIIzWDJL/O62DEVy0QwlwfEyxYcfsiI
         gETg+i84JfpCX9wUnn4uMZlUpYXvSDG/i/tFl2kExJzgrfEkJ52x1vNBqIN/tkYRY+kd
         RXHh5kHMWsEcvKrmtcuiExTaR76hbEEcOZrPoox26HYQ/uYM3PcZ/YnrRWdzXY++r/KK
         cV4A==
X-Received: by 10.152.207.7 with SMTP id ls7mr42144126lac.9.1415176380944;
        Wed, 05 Nov 2014 00:33:00 -0800 (PST)
Received: from alpha.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id ro7sm1072041lbb.14.2014.11.05.00.32.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Nov 2014 00:32:59 -0800 (PST)
X-Mailer: git-send-email 2.0.0.rc4.501.gdaf83ca
In-Reply-To: <1415176347-18694-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add test cases documenting the current behavior when trying to
add/append/edit empty notes. This is in preparation for adding
--allow-empty; to allow empty notes to be stored.

Improved-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3312-notes-empty.sh | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100755 t/t3312-notes-empty.sh

diff --git a/t/t3312-notes-empty.sh b/t/t3312-notes-empty.sh
new file mode 100755
index 0000000..44074f6
--- /dev/null
+++ b/t/t3312-notes-empty.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+
+test_description='Test adding/editing of empty notes'
+. ./test-lib.sh
+
+write_script fake_editor <<\EOF
+	echo "$MSG" >"$1"
+EOF
+GIT_EDITOR=./fake_editor
+export GIT_EDITOR
+
+test_expect_success 'setup' '
+	test_commit one &&
+	git log -1 >expect_missing &&
+	empty_blob=$(git hash-object -w /dev/null)
+'
+
+cleanup_notes() {
+	git update-ref -d refs/notes/commits
+}
+
+verify_missing() {
+	git log -1 > actual &&
+	test_cmp expect_missing actual &&
+	! git notes list HEAD
+}
+
+for cmd in \
+	'add' \
+	'add -F /dev/null' \
+	'add -m ""' \
+	'add -c "$empty_blob"' \
+	'add -C "$empty_blob"' \
+	'append' \
+	'append -F /dev/null' \
+	'append -m ""' \
+	'append -c "$empty_blob"' \
+	'append -C "$empty_blob"' \
+	'edit'
+do
+	test_expect_success "'git notes $cmd' removes empty note" "
+		cleanup_notes &&
+		MSG= git notes $cmd &&
+		verify_missing
+	"
+done
+
+test_done
-- 
2.0.0.rc4.501.gdaf83ca
