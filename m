From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/17] ident.c: read /etc/mailname with strbuf_getline_crlf()
Date: Wed, 16 Dec 2015 14:03:10 -0800
Message-ID: <1450303398-25900-10-git-send-email-gitster@pobox.com>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com>
 <1450303398-25900-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 23:03:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9KAk-00014Y-G4
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 23:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967079AbbLPWDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 17:03:37 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61758 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965979AbbLPWDe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 17:03:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 82572325CE;
	Wed, 16 Dec 2015 17:03:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=4Bof
	5wO8SYhsG9vbIXyk+zXEuHs=; b=c3ah9yJaIhL3WGjf3w+GTIH3+zg1B+o+kYWb
	BcA9MgxgtTiaPpdqfD+J1KBSldreIs0MFqR1BYc2aU7LieNzb6qznLbwfcQ9iiRv
	18JQq7/wCCOQR1qCWvyGWNF3VlezUCx8Lc4yejhAV7uYxYhPh9XRiTjWRBCs5g6y
	iFsK4pc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=ibePs8
	O4Qt9+l8MoK3zkyw+9E+IOdZdaaAfxlkZG4WJmLvAVGYjrsgbhJ3F/ShaoDFk5Ht
	g7vS6MyOAiQBiwnqAlMTkZOjmnLfYEB3uQCkHaa1kXmrnRni9KmdqnRyLCnMVbUv
	doyvw4y1eSPlbF/wXpZqE0WUy9euEuTPnqlq8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7A1F6325CC;
	Wed, 16 Dec 2015 17:03:34 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E0ECE325CB;
	Wed, 16 Dec 2015 17:03:33 -0500 (EST)
X-Mailer: git-send-email 2.7.0-rc1-83-ga8b6b9e
In-Reply-To: <1450303398-25900-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D98BDDA0-A440-11E5-9DA8-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282603>

Just in case /etc/mailname file was edited with a DOS editor,
read it with strbuf_getline_crlf() so that a stray CR is not included
as the last character of the mail hostname.

We _might_ want to more aggressively discard whitespace characters
around the line with strbuf_trim(), but that is a bit outside the
scope of this series.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ident.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ident.c b/ident.c
index 5ff1aad..9018df0 100644
--- a/ident.c
+++ b/ident.c
@@ -55,7 +55,7 @@ static int add_mailname_host(struct strbuf *buf)
 				strerror(errno));
 		return -1;
 	}
-	if (strbuf_getline(&mailnamebuf, mailname, '\n') == EOF) {
+	if (strbuf_getline_crlf(&mailnamebuf, mailname) == EOF) {
 		if (ferror(mailname))
 			warning("cannot read /etc/mailname: %s",
 				strerror(errno));
-- 
2.7.0-rc1-83-ga8b6b9e
