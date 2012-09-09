From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] attr: "binary" attribute should choose built-in "binary"
 merge driver
Date: Sat,  8 Sep 2012 21:40:39 -0700
Message-ID: <1347165639-12149-3-git-send-email-gitster@pobox.com>
References: <7v392twlnm.fsf@alter.siamese.dyndns.org>
 <1347165639-12149-1-git-send-email-gitster@pobox.com>
Cc: Stephen Bash <bash@genarts.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 09 06:42:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAZLR-0006em-Ep
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 06:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475Ab2IIEld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 00:41:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39485 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411Ab2IIEkp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 00:40:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 709AD9E98;
	Sun,  9 Sep 2012 00:40:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=zOvl
	HXIGkmDfyIpksolqmH8seJc=; b=Xad37PCE35mXGaDKZExuhsdrzjkifsslg0zt
	TR4uX1TvIB/WuufKfHMLPHI4ez7bbPPQ2FGKWLmWl2rgsRVTp9W5Wa3BF42BeO95
	opZPwB8phcOk3UDidX7dsly4Ustb71ejIYvCn9nSWN6GeF/SRiGae0reC5xPDxKF
	TmnEHdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	kiN126mYfJADe6+jk9g6vUw2qbKvSP3yek61tYA4wFqVbtKa04CHegZfQU/UyHhS
	a+vst0PXRxPREv6gqlkvOscVX+TT/5Sc7ZhVzlTA0Gn0WchfaL5MRVrTvBeG42aX
	hgQGpa9L2eYYic3OB7QrkL+J5gbq8JOiV2VoxCTTxKY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D6519E97;
	Sun,  9 Sep 2012 00:40:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3E989E96; Sun,  9 Sep 2012
 00:40:44 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.322.g2c7d289
In-Reply-To: <1347165639-12149-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 84972ADA-FA38-11E1-9BF9-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205039>

The built-in "binary" attribute macro expands to "-diff -text", so
that textual diff is not produced, and the contents will not go
through any CR/LF conversion ever.  During a merge, it should also
choose the "binary" low-level merge driver, but it didn't.

Make it expand to "-diff -merge -text".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitattributes.txt | 2 +-
 attr.c                          | 2 +-
 t/t6037-merge-ours-theirs.sh    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index a85b187..ead7254 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -904,7 +904,7 @@ file at the toplevel (i.e. not in any subdirectory).  The built-in
 macro attribute "binary" is equivalent to:
 
 ------------
-[attr]binary -diff -text
+[attr]binary -diff -merge -text
 ------------
 
 
diff --git a/attr.c b/attr.c
index 303751f..3f581b3 100644
--- a/attr.c
+++ b/attr.c
@@ -306,7 +306,7 @@ static void free_attr_elem(struct attr_stack *e)
 }
 
 static const char *builtin_attr[] = {
-	"[attr]binary -diff -text",
+	"[attr]binary -diff -merge -text",
 	NULL,
 };
 
diff --git a/t/t6037-merge-ours-theirs.sh b/t/t6037-merge-ours-theirs.sh
index 8d05671..3889eca 100755
--- a/t/t6037-merge-ours-theirs.sh
+++ b/t/t6037-merge-ours-theirs.sh
@@ -54,7 +54,7 @@ test_expect_success 'recursive favouring ours' '
 '
 
 test_expect_success 'binary file with -Xours/-Xtheirs' '
-	echo "file -merge" >.gitattributes &&
+	echo file binary >.gitattributes &&
 
 	git reset --hard master &&
 	git merge -s recursive -X theirs side &&
-- 
1.7.12.322.g2c7d289
