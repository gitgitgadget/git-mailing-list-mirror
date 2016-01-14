From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 05/21] check-attr: there are only two possible line terminations
Date: Thu, 14 Jan 2016 15:58:20 -0800
Message-ID: <1452815916-6447-6-git-send-email-gitster@pobox.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 00:59:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJro4-00040V-N0
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 00:59:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbcANX7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 18:59:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59220 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755389AbcANX6r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 18:58:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 704F03CD69;
	Thu, 14 Jan 2016 18:58:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=S96M
	h70nWQf1XL/lnrB1lKA7JfA=; b=NtxoFxR5B4vU+m/UB1I1gzPBRP/rOY7sIYrB
	WLsFfX8uJIxR9Hy8eyaJX0K/zlntMPNT38GoqERrhJU5UwS465o+vjQRJAjtX6r3
	Obj/nIV7b/8txldFCHdSiPUyZejEgA7aPvCrsInTIuVC+fXGUl8WMLmOyqvjz4iq
	HmjEuD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	ZHdcCjQwQW+tMYD7/8oZdb77cMf0ELSvVrxrV8ZUhX9o+u9dM5kyFFqFop7Cw+Oy
	k39uZXECX2nOEyxQDGoIVxig786xp1udwQ3BqrCaHzTb7VP84nA5n+4aWSZGuPl1
	1Jn1+AJZhqR5ulRshEQdjp7r3qUgr25rmIx/RJQtu3w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 67AF73CD68;
	Thu, 14 Jan 2016 18:58:46 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CF6243CD67;
	Thu, 14 Jan 2016 18:58:45 -0500 (EST)
X-Mailer: git-send-email 2.7.0-250-ge1b5ba3
In-Reply-To: <1452815916-6447-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: BF5AEF3E-BB1A-11E5-B41E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284123>

The program by default reads LF terminated lines, with an option to
use NUL terminated records.  Instead of pretending that there can be
other useful values for line_termination, use a boolean variable,
nul_term_line, to tell if NUL terminated records are used, and
switch between strbuf_getline_{lf,nul} based on it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/check-attr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 265c9ba..087325e 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -73,12 +73,13 @@ static void check_attr_stdin_paths(const char *prefix, int cnt,
 	struct git_attr_check *check)
 {
 	struct strbuf buf, nbuf;
-	int line_termination = nul_term_line ? 0 : '\n';
+	strbuf_getline_fn getline_fn;
 
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
