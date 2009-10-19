From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] Teach --wrap to only indent without wrapping
Date: Mon, 19 Oct 2009 00:30:14 -0700
Message-ID: <1255937414-10043-4-git-send-email-gitster@pobox.com>
References: <1255937414-10043-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:30:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzmhX-0001Sz-AR
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 09:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755395AbZJSHaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 03:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755383AbZJSHaY
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 03:30:24 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755019AbZJSHaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 03:30:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 516DA7D939
	for <git@vger.kernel.org>; Mon, 19 Oct 2009 03:30:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=+2bG
	tg6OSGWDX6AUSg5mfwZyhmg=; b=xD4aIduk2CwfK1VDVBsUsYAi2SPyWDHXY16d
	mtS6FenPOQh7jsNskZNCYeI5DPsX7RlF7gDTtXCgws+mKXYXSdkPfFcpQ4207Hgi
	AiUtJVcUtzr0tUy7JEY2CsMXs62OgTJUC6xujB2Lt9MK8qFszt76n9U15SBxcN4r
	sl5RocQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=c6g9e7
	4pYsUioKr1aYykaLplJGuVQMMTLtnpv1rXxliaWSZu+gG0ExmJR2lsSojGRuzh8g
	6VESjEsKqk2SyMqjn0YS7R321nmQ4GbLNA1xZ5AXKA4GfPbS5Ah/aeisBF3M+9oX
	N8cSADQm5428Ttw6AaYgiJbJx4rTaA7wqE2jQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4E5CF7D938
	for <git@vger.kernel.org>; Mon, 19 Oct 2009 03:30:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CFE267D937 for
 <git@vger.kernel.org>; Mon, 19 Oct 2009 03:30:20 -0400 (EDT)
X-Mailer: git-send-email 1.6.5.1.95.g09fbd
In-Reply-To: <1255937414-10043-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 420EC116-BC81-11DE-9AB4-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130668>

When a zero or negative width is given to "shortlog -w<width>,<in1>,<in2>"
and --format=%[wrap(w,in1,in2)...%], just indent the text by in1 without
wrapping.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 utf8.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/utf8.c b/utf8.c
index da99669..5c18f0c 100644
--- a/utf8.c
+++ b/utf8.c
@@ -310,6 +310,19 @@ int strbuf_add_wrapped_text(struct strbuf *buf,
 	int w = indent, assume_utf8 = is_utf8(text);
 	const char *bol = text, *space = NULL;
 
+	if (width <= 0) {
+		/* just indent */
+		while (*text) {
+			const char *eol = strchrnul(text, '\n');
+			if (*eol == '\n')
+				eol++;
+			print_spaces(buf, indent);
+			strbuf_write(buf, text, eol-text);
+			text = eol;
+		}
+		return 1;
+	}
+
 	if (indent < 0) {
 		w = -indent;
 		space = text;
-- 
1.6.5.1.95.g09fbd
