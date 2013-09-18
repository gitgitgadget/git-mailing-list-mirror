From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/7] upload-pack.c: do not pass confusing cb_data to mark_our_ref()
Date: Tue, 17 Sep 2013 22:14:18 -0700
Message-ID: <1379481263-29903-3-git-send-email-gitster@pobox.com>
References: <1379481263-29903-1-git-send-email-gitster@pobox.com>
Cc: Andreas Krey <a.krey@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 18 07:14:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMA6L-0006Dp-F5
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 07:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733Ab3IRFOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 01:14:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34520 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359Ab3IRFOa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 01:14:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 059123C93B;
	Wed, 18 Sep 2013 05:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=zv2v
	7RfTjgw4H/SAa1q9zV98v8A=; b=cMaKDqLJHA7MiQTiRNEJb/GtTxMDI4DvuN5H
	bLyojS/sRTRQQesqTR3YJ1NqyZVw/9yxUZC9x4L9PzILKpn6PsgrQjmVOr3y3Hk4
	DwAs+DaRRNV75Gg+kGIk1CTa04xukZKdI24Tw9G7Jorfm6HwxRtP5XjUOerbOHwr
	JGG5rT8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	DyC5paggPPw329lOrzyYE7W71jFyb7XWnCGecNQKAqpD7B3YTAhUc0PIlPP9FxyG
	uxVyaC+Yupa+JhOOlJHsKCewinjJd36SdaKg4KSBwgYe0bYladG1hAV8sCXkuysm
	Bv/OfNLSpx/zv5hZ/vPoz5mCLrcpmTHkU5lngWpdKCY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EED0C3C939;
	Wed, 18 Sep 2013 05:14:29 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 578423C937;
	Wed, 18 Sep 2013 05:14:29 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-585-g8d1dcaf
In-Reply-To: <1379481263-29903-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 31DAB702-2021-11E3-BBE3-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234957>

The callee does not use cb_data, and the caller is an intermediate
function in a callchain that later wants to use the cb_data for its
own use.  Clarify the code by breaking the dataflow explicitly by
not passing cb_data down to mark_our_ref().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 upload-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/upload-pack.c b/upload-pack.c
index 127e59a..a6e107f 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -742,7 +742,7 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	const char *refname_nons = strip_namespace(refname);
 	unsigned char peeled[20];
 
-	if (mark_our_ref(refname, sha1, flag, cb_data))
+	if (mark_our_ref(refname, sha1, flag, NULL))
 		return 0;
 
 	if (capabilities)
-- 
1.8.4-585-g8d1dcaf
