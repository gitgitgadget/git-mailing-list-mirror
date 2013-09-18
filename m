From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/6] upload-pack.c: do not pass confusing cb_data to mark_our_ref()
Date: Tue, 17 Sep 2013 19:31:24 -0700
Message-ID: <1379471489-26280-2-git-send-email-gitster@pobox.com>
References: <20130906155608.GF12966@inner.h.apk.li>
 <1379471489-26280-1-git-send-email-gitster@pobox.com>
Cc: Andreas Krey <a.krey@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 18 04:31:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM7YI-00066A-N9
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 04:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647Ab3IRCbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 22:31:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59693 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751546Ab3IRCbf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 22:31:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 953A63915B;
	Wed, 18 Sep 2013 02:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=zv2v
	7RfTjgw4H/SAa1q9zV98v8A=; b=xDUBy66fvZQDJWoa6bbR7X9BJByp5GYKl4lg
	XhPd+UrEAcpIBtzDDGj8m4pcu/JVtk/AGZQuNYyS17T2sj4BeKyY0OOqCENrfRJJ
	aNhr/q/0xWXsqlVo+lG7KvGWtHyLtoNyldpzeEwJJ7qnTkFJ7cCfH5HrgYhHBloX
	bBL3ge8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	lIGg7A5F9TxKgOYZS+r1Ir0tRDZyfKdghte7d2jNL/IwqeMKLpgrWRZuKE4lule7
	R4GTUiTrzLTHqrES83VLWnnHnTd4CaAZ1Wvby0lm2/WONDMOhWQ3FIiMGamAVi3O
	WX0xVctr4XUQiOQeTkjhg9wKZreCKz+GmFU1YD9VT6c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A91B39158;
	Wed, 18 Sep 2013 02:31:34 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3DFA39151;
	Wed, 18 Sep 2013 02:31:33 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-585-g8d1dcaf
In-Reply-To: <1379471489-26280-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6F3F0952-200A-11E3-A9CE-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234942>

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
