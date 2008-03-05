From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] t5300: add test for "unpack-objects --strict"
Date: Wed,  5 Mar 2008 02:09:07 -0800
Message-ID: <1204711748-10044-2-git-send-email-gitster@pobox.com>
References: <1204711748-10044-1-git-send-email-gitster@pobox.com>
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Sergey Vlasov <vsu@altlinux.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 11:10:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWqZr-0006Ol-Rp
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 11:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761115AbYCEKJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 05:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760757AbYCEKJe
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 05:09:34 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758175AbYCEKJd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 05:09:33 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 94AF9243E
	for <git@vger.kernel.org>; Wed,  5 Mar 2008 05:09:31 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C9F41243D for <git@vger.kernel.org>; Wed,  5 Mar 2008 05:09:30 -0500
 (EST)
X-Mailer: git-send-email 1.5.4.3.529.gb25fb
In-Reply-To: <1204711748-10044-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76208>

This adds test for unpacking deltified objects with --strict option.

 - unpacking full trees with --strict should pass;

 - unpacking only trees with --strict should be rejected due to
   missing blobs;

 - unpacking only trees with --strict into an existing
   repository with necessary blobs should succeed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Third time lucky.

 t/t5300-pack-object.sh |   49 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index cd3c149..b297393 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -274,4 +274,53 @@ test_expect_success \
      packname_4=$(git pack-objects test-4 <obj-list) &&
      test 3 = $(ls test-4-*.pack | wc -l)'
 
+test_expect_failure 'unpacking with --strict' '
+
+	git config --unset pack.packsizelimit &&
+	COPYING=$(git hash-object -w ../../COPYING) &&
+	for j in a b c d e f g
+	do
+		for i in 0 1 2 3 4 5 6 7 8 9
+		do
+			o=$(echo $j$i | git hash-object -w --stdin) &&
+			echo "100644 $o	0 $j$i"
+		done
+	done >LIST &&
+	rm -f .git/index &&
+	git update-index --index-info <LIST &&
+	LIST=$(git write-tree) &&
+	rm -f .git/index &&
+	head -n 10 LIST | git update-index --index-info &&
+	LI=$(git write-tree) &&
+	rm -f .git/index &&
+	tail -n 10 LIST | git update-index --index-info &&
+	ST=$(git write-tree) &&
+	PACK5=$( git rev-list --objects "$LIST" "$LI" "$ST" | \
+		git pack-objects test-5 ) &&
+	PACK6=$( (
+			echo "$LIST"
+			echo "$LI"
+			echo "$ST"
+		 ) | git pack-objects test-6 ) &&
+	test_create_repo test-5 &&
+	(
+		cd test-5 &&
+		git unpack-objects --strict <../test-5-$PACK5.pack &&
+		git ls-tree -r $LIST &&
+		git ls-tree -r $LI &&
+		git ls-tree -r $ST
+	) &&
+	test_create_repo test-6 &&
+	(
+		# tree-only into empty repo -- many unreachables
+		cd test-6 &&
+		test_must_fail git unpack-objects --strict <../test-6-$PACK6.pack
+	) &&
+	(
+		# already populated -- no unreachables
+		cd test-5 &&
+		git unpack-objects --strict <../test-6-$PACK6.pack
+	)
+'
+
 test_done
-- 
1.5.4.3.529.gb25fb

