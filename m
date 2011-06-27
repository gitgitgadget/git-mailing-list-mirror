From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] fsck: minor typofix
Date: Mon, 27 Jun 2011 10:50:57 -0700
Message-ID: <1309197059-7177-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 27 19:53:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbG02-00007z-E2
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 19:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938Ab1F0Rw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jun 2011 13:52:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45585 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752874Ab1F0RvC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 13:51:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A8CD46577
	for <git@vger.kernel.org>; Mon, 27 Jun 2011 13:53:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=6NewUHyiA4eksAkOgyBiVNViGQM
	=; b=fKdm4xj868tZzfA1ffBho/BGGsbDeGvJxKuq9x2CVVP4l6oSBG6zOoy8j5c
	7VrnLNFPUg9075Cw7SkE8uUxFdoe8+4+/zcmmL2QQJ/s3w0c7AKgiK7nCJV4mZoZ
	TjfD394Idzh/lirrf5g2zLx4GJzcrs1pLGc+MeRL3Cc8uHg0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=r93sLg5onj2PLwGz76toQ3LhrsRLB
	zxsPYWShr+uENVnbZzl+uavwPLtJwrMDq8WEycbQsgbhOKzr21jl4uwkBBQbNbfS
	JtM8lMnM6idPy+eYvVVYGUpmAWmouLww+nOcjJzg/jKb00725KVXb1Ti8b6uQS6T
	VAE/o8nIcbxKhg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 929186576
	for <git@vger.kernel.org>; Mon, 27 Jun 2011 13:53:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D3BCE6575 for
 <git@vger.kernel.org>; Mon, 27 Jun 2011 13:53:12 -0400 (EDT)
X-Mailer: git-send-email 1.7.6
X-Pobox-Relay-ID: 53BA216C-A0E6-11E0-A9E9-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176354>

There are two places that diagnose the same kind of error in mark_object(),
that receives an object, the type the object is expected to be, and the
object that refers to it (IOW, the reason why we want to make sure that
the first object is in a good order). When the object that is referred to
is missing, we report "broken link from X; broken link to Y".

However, one of the two places, that is used much less often, said "broken
link from X; broken link from Y".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 This rarely used codepath is triggered only when fsck_walk() calls this
 function that is set as a callback in traverse_one_object() from one of
 the type specific scanners, e.g. fsck_walk_tree(), and an object that is
 referred to is of a wrong type, e.g. a tree entry with mode 100644 is
 looked up with lookup_blob(), and the type of the named object is already
 known to us to be something different. The look-up code issues an unrelated
 error message in such a case, but then this codepath does not know what the
 object name of the offending object was.
---
 builtin/fsck.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 5ae0366..64f30d4 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -83,7 +83,7 @@ static int mark_object(struct object *obj, int type, void *data)
 		/* ... these references to parent->fld are safe here */
 		printf("broken link from %7s %s\n",
 			   typename(parent->type), sha1_to_hex(parent->sha1));
-		printf("broken link from %7s %s\n",
+		printf("broken link to %7s %s\n",
 			   (type == OBJ_ANY ? "unknown" : typename(type)), "unknown");
 		errors_found |= ERROR_REACHABLE;
 		return 1;
-- 
1.7.6
