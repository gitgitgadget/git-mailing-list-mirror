From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 00/11] saving and replaying multiple variants with rerere
Date: Wed,  6 Apr 2016 16:05:24 -0700
Message-ID: <1459983935-25267-1-git-send-email-gitster@pobox.com>
References: <1459204942-26601-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 01:05:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anwW7-0008J8-TQ
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 01:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169AbcDFXFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 19:05:39 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:61289 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752574AbcDFXFi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 19:05:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2FD255370C;
	Wed,  6 Apr 2016 19:05:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=EAnK
	PwznFFmokbvx9hHizOOhP34=; b=w0BneYo4bw6xXTL7FnbVyuigukPSfrPtEn2W
	udRQovk+kMEtZus1Q9B9qhlTAcZnEMquaSqbdesST5NK0VblJuIbS3TpokAkfZCv
	DFDefH/JtrFh9/kvoVuiegtm6Vb1HBUwLhxa7j4WmFGSgVLpH9x3xkITdX3sp+ak
	uT2apFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=P9oiLz
	O/vDiGP6MSNIn2XI0tj6q5/MyCmJenptD47xSPQU6Bdq1pKAWHxQ9dRzj6VVGfL9
	VsgzuNUlwCTGOT5UKTYtt8e7t6SOfIQPiZ4882drqFT2xTqA8dLRrP6i+Z5kVVm0
	BJxWiPh9+RzsZhrcKcEk4iTgC4efNk3fLODJ4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 25CAC5370B;
	Wed,  6 Apr 2016 19:05:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9B80F53709;
	Wed,  6 Apr 2016 19:05:36 -0400 (EDT)
X-Mailer: git-send-email 2.3.8-32-g0ce02b3
In-Reply-To: <1459204942-26601-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 12B92192-FC4C-11E5-BE2C-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290888>

This adds only finishing touches compared to the previous one, which
starts at the message this is a response to and is found at
http://thread.gmane.org/gmane.comp.version-control.git/290068.

Namely, the last patch is different in that it not just adjusts
'forget', but also has a new test for 'rerere forget'.

Junio C Hamano (11):
  rerere: split conflict ID further
  rerere: scan $GIT_DIR/rr-cache/$ID when instantiating a rerere_id
  rerere: handle leftover rr-cache/$ID directory and postimage files
  rerere: delay the recording of preimage
  rerere: allow multiple variants to exist
  t4200: rerere a merge with two identical conflicts
  rerere: do use multiple variants
  rerere: gc and clear
  rerere: move code related to "forget" together
  rerere: split code to call ll_merge() further
  rerere: adjust 'forget' to multi-variant world order

 rerere.c          | 626 +++++++++++++++++++++++++++++++++++++-----------------
 rerere.h          |   4 +-
 t/t4200-rerere.sh | 170 ++++++++++++++-
 3 files changed, 604 insertions(+), 196 deletions(-)

-- 
2.8.1-273-ga2cd0f9


 t/t4200-rerere.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 647ea6f..1a080e7 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -477,6 +477,7 @@ test_expect_success 'multiple identical conflicts' '
 	merge_conflict_resolve &&
 
 	# Check that rerere knows that file1 and file2 have conflicts
+
 	printf "%s\n" file1 file2 >expect &&
 	git ls-files -u | sed -e "s/^.*	//" | sort -u >actual &&
 	test_cmp expect actual &&
@@ -535,7 +536,17 @@ test_expect_success 'multiple identical conflicts' '
 	test_cmp file1.expect file1 &&
 	test_cmp file2.expect file2 &&
 
-	# Pretend again
+	# Forget resolution for file2
+	git rerere forget file2 &&
+	echo file2 >expect &&
+	git rerere status >actual &&
+	test_cmp expect actual &&
+	count_pre_post 2 1 &&
+
+	# file2 already has correct resolution, so record it again
+	git rerere &&
+
+	# Pretend that the resolutions are old again
 	find .git/rr-cache/ -type f | xargs test-chmtime -172800 &&
 
 	# Resolved entries have not expired yet
