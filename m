From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/15] merge: small leakfix and code simplification
Date: Wed, 29 Apr 2015 14:29:25 -0700
Message-ID: <1430342973-30344-8-git-send-email-gitster@pobox.com>
References: <1430025967-24479-1-git-send-email-gitster@pobox.com>
 <1430342973-30344-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 23:30:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnZYQ-0006XY-7v
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 23:30:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbbD2V3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 17:29:54 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62843 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751059AbbD2V3s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 17:29:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BAD484DAB8;
	Wed, 29 Apr 2015 17:29:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=rX78
	wEiQ5uuzL0OE0wjBA7NHP+E=; b=jboJJHmqDC/YEcRxwCA+Qn1bWDicEGRRpDtu
	5eIEx7NQBLkPpTqdvdRidBFBt+Wox2F1zrEF3kNGNP/9RaZ6JSVeBxE7pG7a6TLy
	PXSvwkyYEQ4nXnOczSBGg/1p3ZIHfCrez8QcvWmHvaNFgv+liI2+T6xLApqmYkr0
	VspcQg0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=N6jDc7
	LUCUZEvqf+v1A/Lo9/sWFK3YHhwxBw1x8zkaWAo36xRgFf8NhUSFcPUZLetfnus7
	zIxXI4G0mFfsqQTU0oi5FbB8JRakmpwhR61eGi7w5IV/afE2HDeu0UUzcv1IvxQK
	Qz75meovcF2efoHaBtXPoc0XWS4iokqqT1nd8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B36EA4DAB7;
	Wed, 29 Apr 2015 17:29:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 359B24DAB2;
	Wed, 29 Apr 2015 17:29:46 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc3-300-g052d062
In-Reply-To: <1430342973-30344-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DB84759E-EEB6-11E4-AC7E-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268017>

When parsing a merged object name like "foo~20" to formulate a merge
summary "Merge branch foo (early part)", a temporary strbuf is used,
but we forgot to deallocate it when we failed to find the named
branch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 1d4fbd3..b2d0332 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -491,8 +491,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	}
 	if (len) {
 		struct strbuf truname = STRBUF_INIT;
-		strbuf_addstr(&truname, "refs/heads/");
-		strbuf_addstr(&truname, remote);
+		strbuf_addf(&truname, "refs/heads/%s", remote);
 		strbuf_setlen(&truname, truname.len - len);
 		if (ref_exists(truname.buf)) {
 			strbuf_addf(msg,
@@ -503,6 +502,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 			strbuf_release(&truname);
 			goto cleanup;
 		}
+		strbuf_release(&truname);
 	}
 
 	if (!strcmp(remote, "FETCH_HEAD") &&
-- 
2.4.0-rc3-300-g052d062
