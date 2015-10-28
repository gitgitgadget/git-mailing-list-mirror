From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 09/17] ident.c: read /etc/mailname with strbuf_gets()
Date: Wed, 28 Oct 2015 15:25:53 -0700
Message-ID: <1446071161-15610-10-git-send-email-gitster@pobox.com>
References: <xmqqtws5o4lp.fsf@gitster.dls.corp.google.com>
 <1446071161-15610-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 23:33:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrZHv-0000Um-6o
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 23:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbbJ1Wdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 18:33:32 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58616 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753785AbbJ1WdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 18:33:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9750526A36;
	Wed, 28 Oct 2015 18:26:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=4b77
	4e2CGkk+4M+Kslt9UTS518E=; b=TKKhm7QDpxe1NUsXI9gefamVdY7iLiQ+WduX
	/hnULdFJYkWjxyJKUkC01hXNN1l0KY9ikvWrd0l6jKmHeP7laE0Xo+TZLYna+mYu
	lMqADYX/lFwB32jsFvN2ld2hHxQJcXwcUhFynOgITYh2adlbZ7eKxtSUum48itIG
	hyqo5qc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=oeqpsV
	QkS3qmLSj00OWWg/fNtUwWbWZWIDeUSTWpEb+l1xfQ+T7fjBQqsFXUEUV/BdYbAn
	z2ff9zzJvCAxFxq3kYRvzdmTYt0XisAiMvMOrNN2MOBtk5lICGSXY0t3/4Kr0GuH
	RKNuF1tXm61Y+PEhiMsQad6CXtXxGczixKBkk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8F45326A35;
	Wed, 28 Oct 2015 18:26:16 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 19FBE26A34;
	Wed, 28 Oct 2015 18:26:16 -0400 (EDT)
X-Mailer: git-send-email 2.6.2-423-g5314b62
In-Reply-To: <1446071161-15610-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E73AFD9A-7DC2-11E5-AC59-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280403>

Just in case /etc/mailname file was edited with a DOS editor,
read it with strbuf_gets() so that a stray CR is not included
as the last character of the mail hostname.

We _might_ want to more aggressively discard whitespace characters
around the line with strbuf_trim(), but that is a bit outside the
scope of this series.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ident.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ident.c b/ident.c
index 5ff1aad..c377f2b 100644
--- a/ident.c
+++ b/ident.c
@@ -55,7 +55,7 @@ static int add_mailname_host(struct strbuf *buf)
 				strerror(errno));
 		return -1;
 	}
-	if (strbuf_getline(&mailnamebuf, mailname, '\n') == EOF) {
+	if (strbuf_gets(&mailnamebuf, mailname) == EOF) {
 		if (ferror(mailname))
 			warning("cannot read /etc/mailname: %s",
 				strerror(errno));
-- 
2.6.2-423-g5314b62
