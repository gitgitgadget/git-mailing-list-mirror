From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 12/17] transport-helper: read helper response with strbuf_getline_crlf()
Date: Wed, 16 Dec 2015 14:03:13 -0800
Message-ID: <1450303398-25900-13-git-send-email-gitster@pobox.com>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com>
 <1450303398-25900-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 23:03:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9KAl-00014Y-L3
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 23:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967092AbbLPWDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 17:03:44 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53424 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S967083AbbLPWDk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 17:03:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AD7DD325DE;
	Wed, 16 Dec 2015 17:03:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=rqZJ
	k7QUtlVQa4B/TrLZM7gSALI=; b=jOxifsFKfwt6e/o0KamTGlYXxmRgYgWN++mn
	JKtuRMwf403fsyz3dvn64Vh/64iLhyoDG+IYOiHivzaZHNE8o62TyOsl7bppsKdm
	LbUFavxllkvbG4JQ/A1oak3olOw6VnxTRprpC6FXRO6Y8xuG9OSaHd+vmSXMWNKd
	2ZRs4tI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=kuhJOG
	81W/W3Julc0pqVfxUWgviubhujCAiwM8ESzfq0cnQbKfe1T3EjYsVlakBC0iBSqw
	RhV2q3OZq647My9Vh6zMrrbqpfqGbosBf0THCb30Uk+2/2bJgGo21u0eaQChi9ZC
	n7w5J2KUEPLtEdqQae+86RbvJuSIlrAyw1cfI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A622B325DD;
	Wed, 16 Dec 2015 17:03:39 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 20E72325DC;
	Wed, 16 Dec 2015 17:03:39 -0500 (EST)
X-Mailer: git-send-email 2.7.0-rc1-83-ga8b6b9e
In-Reply-To: <1450303398-25900-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DCA7727E-A440-11E5-A322-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282605>

Our implementation of helpers never use CRLF line endings, and they
do not depend on the ability to place a CR as payload at the end of
the line, so this is essentially a no-op for in-tree users.  However,
this allows third-party implementation of helpers to give us their
line with CRLF line ending (they cannot expect us to feed CRLF to
them, though).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 transport-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 63d5427..7de52e1 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -54,7 +54,7 @@ static int recvline_fh(FILE *helper, struct strbuf *buffer, const char *name)
 	strbuf_reset(buffer);
 	if (debug)
 		fprintf(stderr, "Debug: Remote helper: Waiting...\n");
-	if (strbuf_getline(buffer, helper, '\n') == EOF) {
+	if (strbuf_getline_crlf(buffer, helper) == EOF) {
 		if (debug)
 			fprintf(stderr, "Debug: Remote helper quit.\n");
 		return 1;
-- 
2.7.0-rc1-83-ga8b6b9e
