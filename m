From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] merge: teach -Xours/-Xtheirs to binary ll-merge driver
Date: Sat,  8 Sep 2012 21:40:38 -0700
Message-ID: <1347165639-12149-2-git-send-email-gitster@pobox.com>
References: <7v392twlnm.fsf@alter.siamese.dyndns.org>
 <1347165639-12149-1-git-send-email-gitster@pobox.com>
Cc: Stephen Bash <bash@genarts.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 09 06:41:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAZL2-0006Fo-1O
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 06:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452Ab2IIEl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 00:41:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39463 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065Ab2IIEkn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 00:40:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 831949E95;
	Sun,  9 Sep 2012 00:40:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=5FIu
	QA1f8Xzk2976h9Rx/trxLJg=; b=opkILvPc0fdo3erS8clwZpDGmGndbF6LfhjD
	P5x3o3rqdPanlgA0Nx7ivejJyR3c2upgA8qH/XKfQNGtnKg4PQoxpN9DSX83ioNf
	7tXFR5xzlhhjdk4OpLLu2cagL/2KObc7hPF7DoJ4GpSHAZC37MuZJZ351D2NI4lU
	ofFniOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	CMjJJ0cl5Ac4g/zeb5kXk3tIqoL3XihGIAkIgDcu3gWBQv17dAeLRc/3W9TbY9ct
	yEyknkidzG3ElNt0tfeXf6yDNyg52Lnc8I2PFMUb9RkcKxrZRrYu9H2t+OKH4A+z
	ReOyOovoe0PL+BUqKg0nMKvbT3PVUEMUnfUCOn1cS1w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7132F9E94;
	Sun,  9 Sep 2012 00:40:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C8349E93; Sun,  9 Sep 2012
 00:40:42 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.322.g2c7d289
In-Reply-To: <1347165639-12149-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 835767DE-FA38-11E1-A9AA-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205038>

The (discouraged) -Xours/-Xtheirs modes of merge are supposed to
give a quick and dirty way to come up with a random mixture of
cleanly merged parts and punted conflict resolution to take contents
from one side in conflicting parts.  These options however were only
passed down to the low level merge driver for text.

Teach the built-in binary merge driver to notice them as well.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/merge-strategies.txt |  3 ++-
 ll-merge.c                         | 25 ++++++++++++++++++++-----
 t/t6037-merge-ours-theirs.sh       | 14 +++++++++++++-
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 595a3cf..66db802 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -32,13 +32,14 @@ ours;;
 	This option forces conflicting hunks to be auto-resolved cleanly by
 	favoring 'our' version.  Changes from the other tree that do not
 	conflict with our side are reflected to the merge result.
+	For a binary file, the entire contents are taken from our side.
 +
 This should not be confused with the 'ours' merge strategy, which does not
 even look at what the other tree contains at all.  It discards everything
 the other tree did, declaring 'our' history contains all that happened in it.
 
 theirs;;
-	This is opposite of 'ours'.
+	This is the opposite of 'ours'.
 
 patience;;
 	With this option, 'merge-recursive' spends a little extra time
diff --git a/ll-merge.c b/ll-merge.c
index da59738..8535e2d 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -46,16 +46,31 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
 	assert(opts);
 
 	/*
-	 * The tentative merge result is "ours" for the final round,
-	 * or common ancestor for an internal merge.  Still return
-	 * "conflicted merge" status.
+	 * The tentative merge result is the or common ancestor for an internal merge.
 	 */
-	stolen = opts->virtual_ancestor ? orig : src1;
+	if (opts->virtual_ancestor) {
+		stolen = orig;
+	} else {
+		switch (opts->variant) {
+		default:
+		case XDL_MERGE_FAVOR_OURS:
+			stolen = src1;
+			break;
+		case XDL_MERGE_FAVOR_THEIRS:
+			stolen = src2;
+			break;
+		}
+	}
 
 	result->ptr = stolen->ptr;
 	result->size = stolen->size;
 	stolen->ptr = NULL;
-	return 1;
+
+	/*
+	 * With -Xtheirs or -Xours, we have cleanly merged;
+	 * otherwise we got a conflict.
+	 */
+	return (opts->variant ? 0 : 1);
 }
 
 static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
diff --git a/t/t6037-merge-ours-theirs.sh b/t/t6037-merge-ours-theirs.sh
index 2cf42c7..8d05671 100755
--- a/t/t6037-merge-ours-theirs.sh
+++ b/t/t6037-merge-ours-theirs.sh
@@ -53,7 +53,19 @@ test_expect_success 'recursive favouring ours' '
 	! grep 1 file
 '
 
-test_expect_success 'pull with -X' '
+test_expect_success 'binary file with -Xours/-Xtheirs' '
+	echo "file -merge" >.gitattributes &&
+
+	git reset --hard master &&
+	git merge -s recursive -X theirs side &&
+	git diff --exit-code side HEAD -- file &&
+
+	git reset --hard master &&
+	git merge -s recursive -X ours side &&
+	git diff --exit-code master HEAD -- file
+'
+
+test_expect_success 'pull passes -X to underlying merge' '
 	git reset --hard master && git pull -s recursive -Xours . side &&
 	git reset --hard master && git pull -s recursive -X ours . side &&
 	git reset --hard master && git pull -s recursive -Xtheirs . side &&
-- 
1.7.12.322.g2c7d289
