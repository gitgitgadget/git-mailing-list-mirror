From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 16/21] transport-helper: read helper response with strbuf_getline()
Date: Thu, 14 Jan 2016 15:58:31 -0800
Message-ID: <1452815916-6447-17-git-send-email-gitster@pobox.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 00:59:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJrnn-0003mX-H5
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 00:59:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbcANX7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 18:59:34 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54749 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932142AbcANX7F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 18:59:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E7C8B3CD9A;
	Thu, 14 Jan 2016 18:59:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=R7x7
	rE7n7n3+B1C7PG8lUC6Yyy4=; b=TOy0QbOHYx/p97v8XwEeh3itTErxgw1IRqpJ
	s4mWs1v5XC8zIZknvYNIcw/ltVK3bkUQBkLw2gQ6g0ZRKri9knrAniNXTytjpmxF
	OuwecMJmU3C6CLPXBjZEf0+nQ54XsieY1XXD6Ur3Xhsz4+1tvSmX00V9Ytgxpl0O
	LJ3TRt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	V92ocHMWZ4c78T9IprGtsFSUzPQJYyUUS7CHt4q5OaJf6hNzYvWEio3y58Mq6OvY
	jHxeMedniWAUDRNnBsWRRkhhRlwZ0LDZysre+vKvu9WYpip5nu6MbEaTupyIBbD1
	WJt1Qh0Zxb/AGZUhy19ABx6kweWefU0w7CfvKCuUJIk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DE50A3CD99;
	Thu, 14 Jan 2016 18:59:04 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 440AB3CD94;
	Thu, 14 Jan 2016 18:59:04 -0500 (EST)
X-Mailer: git-send-email 2.7.0-250-ge1b5ba3
In-Reply-To: <1452815916-6447-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CA56DC2C-BB1A-11E5-A72F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284119>

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
index e45d88f..a6bff8b 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -54,7 +54,7 @@ static int recvline_fh(FILE *helper, struct strbuf *buffer, const char *name)
 	strbuf_reset(buffer);
 	if (debug)
 		fprintf(stderr, "Debug: Remote helper: Waiting...\n");
-	if (strbuf_getline_lf(buffer, helper) == EOF) {
+	if (strbuf_getline(buffer, helper) == EOF) {
 		if (debug)
 			fprintf(stderr, "Debug: Remote helper quit.\n");
 		return 1;
-- 
2.7.0-250-ge1b5ba3
