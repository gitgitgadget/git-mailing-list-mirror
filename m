From: Johan Herland <johan@herland.net>
Subject: [PATCH 1/2] t3312-notes-empty: Test that 'git notes' removes empty notes by default
Date: Wed,  5 Nov 2014 02:32:54 +0100
Message-ID: <1415151175-1682-1-git-send-email-johan@herland.net>
Cc: gitster@pobox.com, mackyle@gmail.com, jhf@trifork.com,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 05 02:33:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlpTC-000896-QP
	for gcvg-git-2@plane.gmane.org; Wed, 05 Nov 2014 02:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341AbaKEBdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2014 20:33:05 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:44874 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbaKEBdE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2014 20:33:04 -0500
Received: by mail-lb0-f178.google.com with SMTP id f15so13382367lbj.23
        for <git@vger.kernel.org>; Tue, 04 Nov 2014 17:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id;
        bh=RsWnCrwXLyg9ODJZ6HUAgUZtahmGtVI+zMIKviVtzY0=;
        b=IuZYooOChgUZ88YqP30E61YRiG7y9Nl/+ujAen8Qb6T+MMfPRK8033TooGV7ACu7X2
         +dixd05eEuLycvIHijrgh0mo8DlKiSJoz0S64i3Sk7Cp9CLsVbnI45UmHCaZjgax42ST
         TFwkjk135GwP1D7H3Mhno/R/IV/Wlw1ukbtMQctGvEZlOHXJwN7yZbVYqSHDC1Za5/3U
         iIozAZXAZCt4RCvn8lDWOGzRquLLfCTQfNYAv6CEXnyP9tqGsmYw47jbP2U+ddhUZlhM
         7fQ7FscdYQ4ije+RipVyvdGf9onR0x8dUHGOjU5PG18shW2KWuFbwDJgQJjZWyOVuhJk
         4mEg==
X-Received: by 10.112.171.6 with SMTP id aq6mr15933235lbc.28.1415151181934;
        Tue, 04 Nov 2014 17:33:01 -0800 (PST)
Received: from alpha.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id q1sm745005lal.6.2014.11.04.17.33.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Nov 2014 17:33:00 -0800 (PST)
X-Mailer: git-send-email 2.0.0.rc4.501.gdaf83ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add test cases documenting the current behavior when trying to
add/append/edit empty notes. This is in preparation for adding
--allow-empty; to allow empty notes to be stored.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3312-notes-empty.sh | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100755 t/t3312-notes-empty.sh

diff --git a/t/t3312-notes-empty.sh b/t/t3312-notes-empty.sh
new file mode 100755
index 0000000..2806d27
--- /dev/null
+++ b/t/t3312-notes-empty.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+
+test_description='Test adding/editing of empty notes'
+. ./test-lib.sh
+
+cat >fake_editor.sh <<\EOF
+#!/bin/sh
+echo "$MSG" >"$1"
+echo "$MSG" >& 2
+EOF
+chmod a+x fake_editor.sh
+GIT_EDITOR=./fake_editor.sh
+export GIT_EDITOR
+
+test_expect_success 'setup' '
+	test_commit one &&
+	empty_blob=$(git hash-object -w /dev/null)
+'
+
+cleanup_notes() {
+	git update-ref -d refs/notes/commits
+}
+
+cat >expect_missing <<\EOF
+commit d79ce1670bdcb76e6d1da2ae095e890ccb326ae9
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:13:13 2005 -0700
+
+    one
+EOF
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
