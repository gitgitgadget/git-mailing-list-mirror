From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 13/21] ident.c: read /etc/mailname with strbuf_getline()
Date: Thu, 14 Jan 2016 15:58:28 -0800
Message-ID: <1452815916-6447-14-git-send-email-gitster@pobox.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 00:59:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJrnK-0003PK-F6
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 00:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbcANX7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 18:59:03 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64337 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932108AbcANX7A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 18:59:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B7B693CD89;
	Thu, 14 Jan 2016 18:58:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=3dZT
	mdXf87svTHAjDidJzM62puY=; b=EVOFuYsPaWgCcndsDxaaeMpHi+b4O6T4QG9N
	jBBfFUTv1V5kmIFQzTbLEB8Qum/BJ3guYc6pc6OVHHv650Jp7KJ/0vh2q1NOcyx8
	qBgF5BC7BCBw2JjRg3sZuAnmKCpMSkyF2Q96eSAcIt5bN5Lrkwk7UE19WsoJMPQv
	DSnHbLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	MeGO27iQrIWTbmGeK4jdPnJ4dZWlEAGZ568OJWQp1wtb0sq05n4QtcGvZEXcWTq5
	n0FN+Af4HXH8laEkPogImrhAIGihmDeTGKUyIvpe6bQ0+Bl9LcllmuJ5LAegqzjq
	CYtKcE5J0c+cjdWJISnaZF84pF4f0Uoe0XktvwzBg5E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AFB713CD88;
	Thu, 14 Jan 2016 18:58:59 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2DC4D3CD85;
	Thu, 14 Jan 2016 18:58:59 -0500 (EST)
X-Mailer: git-send-email 2.7.0-250-ge1b5ba3
In-Reply-To: <1452815916-6447-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C74E1784-BB1A-11E5-987B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284111>

Just in case /etc/mailname file was edited with a DOS editor,
read it with strbuf_getline() so that a stray CR is not included
as the last character of the mail hostname.

We _might_ want to more aggressively discard whitespace characters
around the line with strbuf_trim(), but that is a bit outside the
scope of this series.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ident.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ident.c b/ident.c
index 9dd3ae3..3da5556 100644
--- a/ident.c
+++ b/ident.c
@@ -76,7 +76,7 @@ static int add_mailname_host(struct strbuf *buf)
 				strerror(errno));
 		return -1;
 	}
-	if (strbuf_getline_lf(&mailnamebuf, mailname) == EOF) {
+	if (strbuf_getline(&mailnamebuf, mailname) == EOF) {
 		if (ferror(mailname))
 			warning("cannot read /etc/mailname: %s",
 				strerror(errno));
-- 
2.7.0-250-ge1b5ba3
