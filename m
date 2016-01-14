From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 20/21] grep: read -f file with strbuf_getline()
Date: Thu, 14 Jan 2016 15:58:35 -0800
Message-ID: <1452815916-6447-21-git-send-email-gitster@pobox.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 00:59:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJrnd-0003fe-TN
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 00:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbcANX7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 18:59:25 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54372 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932153AbcANX7M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 18:59:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9DD483CDAE;
	Thu, 14 Jan 2016 18:59:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=HbzE
	f7npWeRERn0UoC75fLi/YAk=; b=qU7K+gDQ0Ae3OJqeGkVNcCz/heLR4er3ujkW
	Kdts62zTO3Gaf/gNIdWmqs3mhiRO2jJR1Df+1s3QPEMDsyAkRDHSe0sjLsnb8K8F
	yivL9I5EUhFcB76g6uPuf6zb2zhcC1x1QqZfMBinQMSXnXg4e+IWkExwNQlcx17o
	Xncu0jY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	QORqL8wHu0GFzj2QkVvDuUm9UIPdNsaZC6GrQC3psPFMe1oBIbP0r+cNH1k3po6w
	waJ1FLVCbs4AN7Wo69kIXZqRNzouLrLTblfjSEaKMYVLnBO+8u5dLNhD87aUT5fr
	srZpvyzm7xUnsWt+4szbm/1/twxXc3c1CKZUx2AILZs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 966343CDAD;
	Thu, 14 Jan 2016 18:59:11 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1D74B3CDAC;
	Thu, 14 Jan 2016 18:59:11 -0500 (EST)
X-Mailer: git-send-email 2.7.0-250-ge1b5ba3
In-Reply-To: <1452815916-6447-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CE6AD50C-BB1A-11E5-8066-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284116>

List of patterns file could come from a DOS editor.

This is iffy; you may actually be trying to find a line with ^M in
it on a system whose line ending is LF.  You can of course work it
around by having a line that has "^M^M^J", let the strbuf_getline()
eat the last "^M^J", leaving just the single "^M" as the pattern.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 5a5beb8..801ce60 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -562,7 +562,7 @@ static int file_callback(const struct option *opt, const char *arg, int unset)
 	patterns = from_stdin ? stdin : fopen(arg, "r");
 	if (!patterns)
 		die_errno(_("cannot open '%s'"), arg);
-	while (strbuf_getline_lf(&sb, patterns) == 0) {
+	while (strbuf_getline(&sb, patterns) == 0) {
 		/* ignore empty line like grep does */
 		if (sb.len == 0)
 			continue;
-- 
2.7.0-250-ge1b5ba3
