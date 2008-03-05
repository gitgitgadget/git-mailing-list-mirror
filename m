From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t5300: add test for "unpack-objects --strict"
Date: Wed, 05 Mar 2008 00:47:04 -0800
Message-ID: <7v4pblpng7.fsf@gitster.siamese.dyndns.org>
References: <7vbq5u91lf.fsf@gitster.siamese.dyndns.org>
 <20080304152635.40451f7c.vsu@altlinux.ru>
 <7vfxv65kkl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Sergey Vlasov <vsu@altlinux.ru>
X-From: git-owner@vger.kernel.org Wed Mar 05 09:48:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWpIM-0006Y4-0H
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 09:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbYCEIrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 03:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752692AbYCEIrg
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 03:47:36 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33535 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbYCEIrf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 03:47:35 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 93BE42AE6;
	Wed,  5 Mar 2008 03:47:33 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B232C2AE4; Wed,  5 Mar 2008 03:47:29 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76196>

This adds a test for unpacking deltified objects with --strict option.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Junio C Hamano <gitster@pobox.com> writes:

 > Sergey Vlasov <vsu@altlinux.ru> writes:
 > ...
 >> However, I do not have time to create a proper test case for this.
 >
 > That's Ok.  What we need is a fix but it is not that urgent as the stuff
 > is now reverted for now.

 t/t5300-pack-object.sh |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index cd3c149..0cf0ff7 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -274,4 +274,40 @@ test_expect_success \
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
+	PACK=$( (
+		echo "$LIST"
+		echo "$LI"
+		echo "$ST"
+	) | git pack-objects test-5 ) &&
+
+	test_create_repo another &&
+
+	(
+		cd another &&
+		git unpack-objects --strict <../test-5-$PACK.pack
+	)
+
+'
+
 test_done
-- 
1.5.4.3.529.gb25fb

