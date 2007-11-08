From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] send-pack: segfault fix on forced push
Date: Thu, 08 Nov 2007 01:38:12 -0800
Message-ID: <7vsl3h2i2j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 08 10:38:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq3qO-0004aT-Et
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 10:38:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758344AbXKHJiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 04:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758268AbXKHJiV
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 04:38:21 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:60034 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756655AbXKHJiU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 04:38:20 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id DC3872EF;
	Thu,  8 Nov 2007 04:38:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 3C62A9279B;
	Thu,  8 Nov 2007 04:38:36 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63980>

When pushing to overwrite a ref that points at a commit we do
not even have, the recent "terse push" patch tried to get a
unique abbreviation for the non-existent (from our point of
view) object, which resulted in strcpy(buf, NULL) and
segfaulted.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-send-pack.c         |    5 +++--
 t/t5405-send-pack-rewind.sh |   42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index c1fd3f5..5a0f5c6 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -365,8 +365,9 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 			char quickref[83];
 			char type = ' ';
 			const char *msg = "";
-
-			strcpy(quickref, find_unique_abbrev(ref->old_sha1, DEFAULT_ABBREV));
+			const char *old_abb;
+			old_abb = find_unique_abbrev(ref->old_sha1, DEFAULT_ABBREV);
+			strcpy(quickref, old_abb ? old_abb : old_hex);
 			if (ref_newer(ref->peer_ref->new_sha1, ref->old_sha1))
 				strcat(quickref, "..");
 			else {
diff --git a/t/t5405-send-pack-rewind.sh b/t/t5405-send-pack-rewind.sh
new file mode 100755
index 0000000..86abc62
--- /dev/null
+++ b/t/t5405-send-pack-rewind.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+test_description='forced push to replace commit we do not have'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	>file1 && git add file1 && test_tick &&
+	git commit -m Initial &&
+
+	mkdir another && (
+		cd another &&
+		git init &&
+		git fetch .. master:master
+	) &&
+
+	>file2 && git add file2 && test_tick &&
+	git commit -m Second
+
+'
+
+test_expect_success 'non forced push should die not segfault' '
+
+	(
+		cd another &&
+		git push .. master:master
+		test $? = 1
+	)
+
+'
+
+test_expect_success 'forced push should succeed' '
+
+	(
+		cd another &&
+		git push .. +master:master
+	)
+
+'
+
+test_done
