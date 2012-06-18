From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2 v2] sha1_name: don't trigger detailed diagnosis for file arguments
Date: Mon, 18 Jun 2012 20:18:20 +0200
Message-ID: <1340043501-6170-1-git-send-email-Matthieu.Moy@imag.fr>
References: <7vvcio4mbe.fsf@alter.siamese.dyndns.org>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 18 20:20:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SggYQ-0006M1-59
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jun 2012 20:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579Ab2FRSTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 14:19:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60120 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137Ab2FRSTx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 14:19:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5IIJZ5h024820
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 18 Jun 2012 20:19:36 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SggYG-0003zR-Mw; Mon, 18 Jun 2012 20:19:48 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SggYG-0001cX-HT; Mon, 18 Jun 2012 20:19:48 +0200
X-Mailer: git-send-email 1.7.11.rc0.57.g84a04c7
In-Reply-To: <7vvcio4mbe.fsf@alter.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 18 Jun 2012 20:19:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5IIJZ5h024820
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1340648377.31533@nIEYNUhhSJGYHl40liV2tg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200156>

diagnose_invalid_sha1_path is normally meant to be called to diagnose
<treeish>:<pathname> when <pathname> does not exist in <treeish>.
However, the current code may call it if <treeish>:<pathname> is invalid
(which triggers another call with only_to_die == 1), but for another
reason. This happens when calling e.g.

  git log existing-file HEAD:existing-file

(because existing-file is a file and not a revision, the next arguments
are assumed to be files too), leading to incorrect message like
"existing-file does not exist in HEAD".

Check that the search for <pathname> in <treeish> fails before triggering
the diagnosis.

Bug report and code fix by: Junio C Hamano <gitster@pobox.com>
Test by: Matthieu Moy <Matthieu.Moy@imag.fr>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
No change since v1

 sha1_name.c                    |  2 +-
 t/t1506-rev-parse-diagnosis.sh | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/sha1_name.c b/sha1_name.c
index c633113..5d81ea0 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1127,7 +1127,7 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 			if (new_filename)
 				filename = new_filename;
 			ret = get_tree_entry(tree_sha1, filename, sha1, &oc->mode);
-			if (only_to_die) {
+			if (ret && only_to_die) {
 				diagnose_invalid_sha1_path(prefix, filename,
 							   tree_sha1, object_name);
 				free(object_name);
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index 0843a1c..4a39ac5 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -171,4 +171,15 @@ test_expect_success 'relative path when startup_info is NULL' '
 	grep "BUG: startup_info struct is not initialized." error
 '
 
+test_expect_success '<commit>:file correctly diagnosed after a pathname' '
+	test_must_fail git rev-parse file.txt HEAD:file.txt 1>actual 2>error &&
+	test_i18ngrep ! "exists on disk" error &&
+	test_i18ngrep "unknown revision or path not in the working tree" error &&
+	cat >expect <<EOF &&
+file.txt
+HEAD:file.txt
+EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.11.rc0.57.g84a04c7
