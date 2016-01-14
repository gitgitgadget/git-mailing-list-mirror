From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 06/21] check-ignore: there are only two possible line terminations
Date: Thu, 14 Jan 2016 15:58:21 -0800
Message-ID: <1452815916-6447-7-git-send-email-gitster@pobox.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 00:59:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJrn5-0003Dl-9W
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 00:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755708AbcANX6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 18:58:51 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64118 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755579AbcANX6s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 18:58:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2C33A3CD6C;
	Thu, 14 Jan 2016 18:58:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=K40d
	zEr2h8+05I9bRkJaO6DehMM=; b=WYvgDfR2uTDJHN7X4F5Xerxan86Qqq1oADGS
	dkphY08bwuF+3axh2nSxJ6RO/kN0NWjez2J8EtTkDmgfZkC/4aVW/Z6fDtTBOujM
	tQLK1ez6ZEco59Owcq3IJ2D77BFAnxU4QkMIESsfWCqCovu2gryRVjhOZcaDuWu7
	3446Arc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	aa+E9Ip84dUF0c/LAg+0TgmG53U1HAjm8T7z1NKpanyKXmnLrJD9CX//CmghpktI
	ulCHAv2cCLikMQFRSScTbxhmBaShGnS/4j+VpIumPtPh1s7dD4P76Hel22spEPyd
	+NIBnS46I8qAzK8aBQ3IvUDxDoZQ7ICv2yAHiDC2jKs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 248B73CD6B;
	Thu, 14 Jan 2016 18:58:48 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 945DB3CD6A;
	Thu, 14 Jan 2016 18:58:47 -0500 (EST)
X-Mailer: git-send-email 2.7.0-250-ge1b5ba3
In-Reply-To: <1452815916-6447-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C0673AB8-BB1A-11E5-B24A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284107>

The program by default reads LF terminated lines, with an option to
use NUL terminated records.  Instead of pretending that there can be
other useful values for line_termination, use a boolean variable,
nul_term_line, to tell if NUL terminated records are used, and
switch between strbuf_getline_{lf,nul} based on it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/check-ignore.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 43f3617..4f0b09e 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -117,13 +117,14 @@ static int check_ignore_stdin_paths(struct dir_struct *dir, const char *prefix)
 {
 	struct strbuf buf, nbuf;
 	char *pathspec[2] = { NULL, NULL };
-	int line_termination = nul_term_line ? 0 : '\n';
+	strbuf_getline_fn getline_fn;
 	int num_ignored = 0;
 
+	getline_fn = nul_term_line ? strbuf_getline_nul : strbuf_getline_lf;
 	strbuf_init(&buf, 0);
 	strbuf_init(&nbuf, 0);
-	while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
-		if (line_termination && buf.buf[0] == '"') {
+	while (getline_fn(&buf, stdin) != EOF) {
+		if (!nul_term_line && buf.buf[0] == '"') {
 			strbuf_reset(&nbuf);
 			if (unquote_c_style(&nbuf, buf.buf, NULL))
 				die("line is badly quoted");
-- 
2.7.0-250-ge1b5ba3
