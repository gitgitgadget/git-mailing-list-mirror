From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 08/17] rev-parse: read parseopt spec with strbuf_gets()
Date: Wed, 28 Oct 2015 15:25:52 -0700
Message-ID: <1446071161-15610-9-git-send-email-gitster@pobox.com>
References: <xmqqtws5o4lp.fsf@gitster.dls.corp.google.com>
 <1446071161-15610-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 23:34:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrZI7-0000ek-0z
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 23:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617AbbJ1Wdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 18:33:51 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755905AbbJ1Wd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 18:33:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 29D2E26A32;
	Wed, 28 Oct 2015 18:26:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=SdkI
	QOrhZ4AECqEi8ZI2f5dE1Gc=; b=GcymnXFk2EnWMUG3zMnB/dJ/W2FZxa9i5OvB
	xWdEhlXFCYPp58BKgw854LKG0nHrQg49jaUlwPZpymXyth25OZhSiu7dx8zZBymj
	bk2UvImabsr6RCqCD2dvxgEYdMWQaXV9e8YHtCGdPKxNdxoPrVG/3T0pqyDocTuV
	g6kirYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=oqOVCX
	fj71t0nVq105BYu9j4Z5YIl5oEIVzirCORz9MzhKQPz6NdTA8eKlfhudac6+Jqh3
	E0CpKlwlFlG+v68j4GbuMZUrs5hMzDtLzbzHKt6MJnVaZod6UUdEHWhKOtBDque1
	WM3CC26Z0gW71IrxZueg7D/dqkzL+ZWObLZKw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2280726A31;
	Wed, 28 Oct 2015 18:26:15 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9E3D526A30;
	Wed, 28 Oct 2015 18:26:14 -0400 (EDT)
X-Mailer: git-send-email 2.6.2-423-g5314b62
In-Reply-To: <1446071161-15610-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E65C241C-7DC2-11E5-924C-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280407>

"rev-parse --parseopt" specification is clearly text and we
should anticipate that we may be fed CRLF lines.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/rev-parse.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 02d747d..5317389 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -386,7 +386,7 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 
 	/* get the usage up to the first line with a -- on it */
 	for (;;) {
-		if (strbuf_getline(&sb, stdin, '\n') == EOF)
+		if (strbuf_gets(&sb, stdin) == EOF)
 			die("premature end of input");
 		ALLOC_GROW(usage, unb + 1, usz);
 		if (!strcmp("--", sb.buf)) {
@@ -399,7 +399,7 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 	}
 
 	/* parse: (<short>|<short>,<long>|<long>)[*=?!]*<arghint>? SP+ <help> */
-	while (strbuf_getline(&sb, stdin, '\n') != EOF) {
+	while (strbuf_gets(&sb, stdin) != EOF) {
 		const char *s;
 		const char *help;
 		struct option *o;
-- 
2.6.2-423-g5314b62
