From: Federico Cuello <fedux@lugmen.org.ar>
Subject: [PATCH] Fix git-apply with -p greater than 1
Date: Mon, 25 Oct 2010 11:11:37 -0300
Message-ID: <1288015897-21565-1-git-send-email-fedux@lugmen.org.ar>
References: <7v8w1qm5n2.fsf@alter.siamese.dyndns.org>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Federico Cuello <fedux@lugmen.org.ar>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 25 16:12:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PANn1-0006Sp-JW
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 16:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755760Ab0JYOMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 10:12:37 -0400
Received: from 64-76-18-116.static.impsat.net.ar ([64.76.18.116]:33783 "EHLO
	mother.lugmen.org.ar" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1755409Ab0JYOMh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 10:12:37 -0400
Received: from mail.fedux.com.ar (unknown [186.19.147.163])
	by mother.lugmen.org.ar (Postfix) with ESMTPSA id D14EE19E66C;
	Mon, 25 Oct 2010 11:12:34 -0300 (ART)
Received: by mail.fedux.com.ar (Postfix, from userid 1000)
	id D20CA100D9; Mon, 25 Oct 2010 11:12:32 -0300 (ART)
X-Mailer: git-send-email 1.7.3.2
In-Reply-To: <7v8w1qm5n2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159951>

Fix for rename/copy patches. Filenames don't include
'a/' or 'b/' prefix, then use p_value minus one.

Also add 'copy' test script.

Signed-off-by: Federico Cuello <fedux@lugmen.org.ar>
---
 builtin/apply.c       |    8 ++++----
 t/t4120-apply-popt.sh |   13 +++++++++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 14996f8..3197e38 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -919,28 +919,28 @@ static int gitdiff_newfile(const char *line, struct patch *patch)
 static int gitdiff_copysrc(const char *line, struct patch *patch)
 {
 	patch->is_copy = 1;
-	patch->old_name = find_name(line, NULL, 0, 0);
+	patch->old_name = find_name(line, NULL, p_value ? p_value - 1 : 0, 0);
 	return 0;
 }
 
 static int gitdiff_copydst(const char *line, struct patch *patch)
 {
 	patch->is_copy = 1;
-	patch->new_name = find_name(line, NULL, 0, 0);
+	patch->new_name = find_name(line, NULL, p_value ? p_value - 1 : 0, 0);
 	return 0;
 }
 
 static int gitdiff_renamesrc(const char *line, struct patch *patch)
 {
 	patch->is_rename = 1;
-	patch->old_name = find_name(line, NULL, 0, 0);
+	patch->old_name = find_name(line, NULL, p_value ? p_value - 1 : 0, 0);
 	return 0;
 }
 
 static int gitdiff_renamedst(const char *line, struct patch *patch)
 {
 	patch->is_rename = 1;
-	patch->new_name = find_name(line, NULL, 0, 0);
+	patch->new_name = find_name(line, NULL, p_value ? p_value - 1 : 0, 0);
 	return 0;
 }
 
diff --git a/t/t4120-apply-popt.sh b/t/t4120-apply-popt.sh
index 579c9e6..4ed06f0 100755
--- a/t/t4120-apply-popt.sh
+++ b/t/t4120-apply-popt.sh
@@ -82,4 +82,17 @@ test_expect_success 'apply (-p2) diff, rename' '
 	test_cmp expected file2
 '
 
+test_expect_success 'apply (-p2) diff, copy' '
+	cat >patch.copy <<-\EOF &&
+	diff --git a/sub/file1 b/sub/file2
+	similarity index 100%
+	copy from sub/file1
+	copy to sub/file2
+	EOF
+	cp file1.saved file1 &&
+	rm -f file2 &&
+	git apply -p2 patch.copy &&
+	test_cmp file1 file2
+'
+
 test_done
-- 
1.7.3.2
