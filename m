From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/6] t/diff-lib: check exact object names in compare_diff_raw
Date: Sun, 15 Feb 2015 15:43:43 -0800
Message-ID: <1424043824-25242-6-git-send-email-gitster@pobox.com>
References: <1424043824-25242-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 00:44:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YN8r9-0006H3-Ec
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 00:44:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755041AbbBOXn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2015 18:43:59 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51896 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754955AbbBOXn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2015 18:43:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 469FC39CF8;
	Sun, 15 Feb 2015 18:43:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Sedz
	S2y5sAE5tUPcz6IUYge1Atk=; b=CScjGwJvBzUhSVY+fnJ3XmMs05xTHzDVrK92
	heFUS8A9Rv1u7iGbmL6s8ePOzKf3AI58uPyqmZFJNDDdSfc6QX85V/PFbiL+jmRu
	D+JfBWeYA8MruIBw761qVWNSNxK/lX03WezRPIY2nLJU7/eKhm+ZOGnd7wRr/UYV
	cOVY/GM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Gj7TdS
	mkPKnIH6WanVvcrkg6nwRN7gWzRc5oIt2KhNGGlVE+SfbC8EqU4iFyV2z8fsLfvB
	SpejW5o1EsOiJS4+TzVwrsj5SF8qxW6dHF6ZgacqCa5NrDhPWUY8aK/qyzhbLy7a
	rCaTSn1XV+ZKylPKf+t1c/OQ1H3UrhYSYMTBc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D6D939CF7;
	Sun, 15 Feb 2015 18:43:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7FED339CF0;
	Sun, 15 Feb 2015 18:43:53 -0500 (EST)
X-Mailer: git-send-email 2.3.0-266-g5b48884
In-Reply-To: <1424043824-25242-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 7FEDA828-B56C-11E4-B006-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263859>

The "sanitize" helper wanted to strip the similarity and
dissimilarity scores when making comparison, but it was
stripping away the object names as well.

While we do not want to require the exact object names the tests
expect to be maintained, as it would be seen as an extra burden,
this would have prevented us catching a silly bug such as showing
non 0{40} object name on the preimage side of an addition or on the
postimage side of a deletion, because all [0-9a-f]{40} strings were
considered equally OK.

In the longer term, when a test only wants to see the status of the
change without having to worry about object names, it should be
rewritten not to inspect the raw format.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/diff-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/diff-lib.sh b/t/diff-lib.sh
index 75a35fc..c211dc4 100644
--- a/t/diff-lib.sh
+++ b/t/diff-lib.sh
@@ -1,6 +1,6 @@
 :
 
-sanitize_diff_raw='/^:/s/ '"$_x40"' '"$_x40"' \([A-Z]\)[0-9]*	/ X X \1#	/'
+sanitize_diff_raw='/^:/s/ '"\($_x40\)"' '"\($_x40\)"' \([A-Z]\)[0-9]*	/ \1 \2 \3#	/'
 compare_diff_raw () {
     # When heuristics are improved, the score numbers would change.
     # Ignore them while comparing.
-- 
2.3.0-266-g5b48884
