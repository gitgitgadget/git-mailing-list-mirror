From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 12/17] transport-helper: read helper response with strbuf_gets()
Date: Wed, 28 Oct 2015 15:25:56 -0700
Message-ID: <1446071161-15610-13-git-send-email-gitster@pobox.com>
References: <xmqqtws5o4lp.fsf@gitster.dls.corp.google.com>
 <1446071161-15610-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 23:34:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrZIL-0000sm-W0
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 23:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbbJ1WeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 18:34:09 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51276 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754513AbbJ1Wd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 18:33:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1EE8B26A42;
	Wed, 28 Oct 2015 18:26:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ZlAA
	tCyNXQ5O437NYDX6ylGDR4U=; b=ThfciueXu5maXYZb072LOrz54O6WRUejRIrp
	PXNFnqQIzoXFhw2Zy9SaDUo1YEKTt85q8qToJn1xqyzCsEazgkPIzF3Hu4nk6kpA
	OsF/vqyMLvP1JwAoG/raclQxye5tAFieu108R3ypGJ13wYl0lVdn9Vxt5Z3pqbHP
	PbScSHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=xIY6X/
	NpI1HkNMaO6mnMIxovXpxqOE5V4UehZXDk6Lw930gPOO7Bm3fjOj7tLo5E6tDhH9
	TdLBJL1DUhR5ITe7B7opJLm/6hjIBS77IqQ6CS9DbVyGifykYvyKfNxTRmMceVH3
	j/tU6iEQK6M1gJyFnS64CDB4R9Ams9zx7Rzug=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 15C7126A41;
	Wed, 28 Oct 2015 18:26:21 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 931C226A40;
	Wed, 28 Oct 2015 18:26:20 -0400 (EDT)
X-Mailer: git-send-email 2.6.2-423-g5314b62
In-Reply-To: <1446071161-15610-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E9E8F588-7DC2-11E5-AC07-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280410>

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
index 63d5427..e0e1c9c 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -54,7 +54,7 @@ static int recvline_fh(FILE *helper, struct strbuf *buffer, const char *name)
 	strbuf_reset(buffer);
 	if (debug)
 		fprintf(stderr, "Debug: Remote helper: Waiting...\n");
-	if (strbuf_getline(buffer, helper, '\n') == EOF) {
+	if (strbuf_gets(buffer, helper) == EOF) {
 		if (debug)
 			fprintf(stderr, "Debug: Remote helper quit.\n");
 		return 1;
-- 
2.6.2-423-g5314b62
