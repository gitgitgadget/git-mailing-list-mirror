From: Junio C Hamano <gitster@pobox.com>
Subject: [PREVIEW v3 6/9] check-ignore: there are only two line terminators
Date: Wed, 13 Jan 2016 19:03:06 -0800
Message-ID: <1452740590-16827-7-git-send-email-gitster@pobox.com>
References: <1450303398-25900-1-git-send-email-gitster@pobox.com>
 <1452740590-16827-1-git-send-email-gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 04:03:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJYCG-0007cE-MK
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 04:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916AbcANDDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 22:03:32 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56155 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752833AbcANDDW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 22:03:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 269F23C43C;
	Wed, 13 Jan 2016 22:03:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Vuaj
	04Z4668MiG+7v4OD2bYSIDo=; b=a8SbXSLEBD6iSBF7W9mUl9zfG5y/aiEjc+UJ
	FOoZNyYMo9s8xjA/5G0xHqhaWmgmo92QBfruHHTXB83f0Vf5Bt2zPTvboKB7MeWO
	oUekowuARF5yvc5dNYgXyToxWFSM4R/Q6Nwkeut6Qn47VrAZpR4HGPMAAm5dSZxv
	IAmI3Jk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	bxWiDHODirzMw5TJGfXCblV3xJy5VulgUrTeBJi+Kc0LJd57n9BkFIm6LnOJueXv
	C5cdsI9htBbG52rNPlMH9ibHKUKXP2vdZGAJqO24UoO4p35wovVtNY5Qj6EB19OD
	9QbEIJTxiUf2xT7uZlmPmKjSHDKngwCN3Po+msJjfqU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1D21D3C43B;
	Wed, 13 Jan 2016 22:03:22 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7F02D3C43A;
	Wed, 13 Jan 2016 22:03:21 -0500 (EST)
X-Mailer: git-send-email 2.7.0-242-gdd583c7
In-Reply-To: <1452740590-16827-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5E8E3FD0-BA6B-11E5-9115-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284007>

The program by default works on LF terminated lines, with an option
to use NUL terminated records.  Instead of using line_termination
that happens to take LF or NUL, use the value of nul_term_line and
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
2.7.0-242-gdd583c7
