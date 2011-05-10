From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/9] get_pathspec(): an empty ':' pathspec should stand alone
Date: Mon,  9 May 2011 22:51:11 -0700
Message-ID: <1305006678-4051-3-git-send-email-gitster@pobox.com>
References: <1304852906-29272-1-git-send-email-pclouds@gmail.com>
 <1305006678-4051-1-git-send-email-gitster@pobox.com>
Cc: pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 07:51:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJfrA-0001Bh-OZ
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 07:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889Ab1EJFvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 01:51:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53099 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818Ab1EJFva (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 01:51:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D67745C8B;
	Tue, 10 May 2011 01:53:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=kAxL
	1Ohcj1/gLJj8Uz3ou6wec9E=; b=VMfeyJ7t1/xcM8g4QKFlGBaRTljQR6Q9KxBg
	eaxZ/UVaBgVy2irLC1uRCxcTQmlK1IKhta8x4IbROgXzdLEm76YtoFLacqdroGBm
	gjgEZhN6Mw9cNTjWwlj+yVa1A/q2t4JYIHguuOeSXkGijXvd5nIkAHsxTtKSfOP5
	Gx1l/0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	M714y29V3z0fGnOVkeV8n0NgB2IVYp2+9BOZ79mEUm6/IDP11Cz+Dxreh6H6Ah7T
	RS7S1rWJsBru+NLqMj2FdI4xzBVm4ofDOBYHLy4nR8jKyaBDsaECwQY8i17ruCQX
	Dmkelu1jqBuesQLz/wstOGAsrrUdElV+me94fDJAAeY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C2E355C89;
	Tue, 10 May 2011 01:53:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0C28A5C87; Tue, 10 May 2011
 01:53:31 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.290.g1b565
In-Reply-To: <1305006678-4051-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D71D98F6-7AC9-11E0-A73E-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173305>

"git cmd foo :" is a user error; diagnose it as such.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 setup.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/setup.c b/setup.c
index 51e354c..c1be388 100644
--- a/setup.c
+++ b/setup.c
@@ -256,6 +256,7 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
 	const char *entry = *pathspec;
 	const char **src, **dst;
 	int prefixlen;
+	int has_root_widen = 0;
 
 	if (!prefix && !entry)
 		return NULL;
@@ -272,10 +273,15 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
 	dst = pathspec;
 	prefixlen = prefix ? strlen(prefix) : 0;
 	while (*src) {
-		*(dst++) = prefix_pathspec(prefix, prefixlen, *src);
+		const char *elem = prefix_pathspec(prefix, prefixlen, *src);
+		*(dst++) = elem;
+		if (!elem)
+			has_root_widen = 1;
 		src++;
 	}
 	*dst = NULL;
+	if (has_root_widen && src != pathspec + 1)
+		die("an empty ':' pathspec with other pathspecs");
 	if (!*pathspec)
 		return NULL;
 	return pathspec;
-- 
1.7.5.1.290.g1b565
