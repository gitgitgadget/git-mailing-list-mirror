From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 04/12] unpack_object_header(): make it public
Date: Fri, 20 May 2011 23:56:27 -0700
Message-ID: <1305960995-25738-5-git-send-email-gitster@pobox.com>
References: <1305960995-25738-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 08:57:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNg7q-00068H-DZ
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 08:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113Ab1EUG5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2011 02:57:22 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54660 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009Ab1EUG5U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 02:57:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D1BDB5DB3
	for <git@vger.kernel.org>; Sat, 21 May 2011 02:59:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=zgYs
	ytOwen03FumHCECfe6nXE98=; b=OAQZx3SBT1Nnd5xMnPDXROF9DLtdI/oNzdc3
	ymBfe7uWtfW85v+uFF/fDd5I++2If2MlBJF0Ua5p1Q29ucWxvZSADYsqfZiwFPpz
	mUGzMZbTxdiVnMXNEl7yh/uZJqPOroTXoCTwDMfhaMQbBx5FwVhZexnsBbcbLFHV
	6mCDluA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=wV1/4c
	QzQ0yhBMmvesc+a7NwdQlsp9ZBJ02clTfIwVblmsJN6hvTwWA/ChyPgZ4Y0C1wI1
	ISD1q6jcqAobx1LWHzBDtrK8rIjNo5YJsKDejAr4Dkx0LL2hpBcmHUnYLklQA8Sd
	5WxefGBKwdlBLItIJnhvErCg5necyghI1WxMQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C93E55DB2
	for <git@vger.kernel.org>; Sat, 21 May 2011 02:59:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C8AC05DAD for
 <git@vger.kernel.org>; Sat, 21 May 2011 02:59:25 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.2.369.g8fc017
In-Reply-To: <1305960995-25738-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DDD4EB8E-8377-11E0-A3A1-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174098>

This function is used to read and skip over the per-object header
in a packfile.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h     |    1 +
 sha1_file.c |    8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 3a1af9d..7650d2e 100644
--- a/cache.h
+++ b/cache.h
@@ -1021,6 +1021,7 @@ extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsign
 extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 extern int packed_object_info_detail(struct packed_git *, off_t, unsigned long *, unsigned long *, unsigned int *, unsigned char *);
+extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
 
 struct object_info {
 	/* Request */
diff --git a/sha1_file.c b/sha1_file.c
index 1d6f93d..a28683a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1523,10 +1523,10 @@ static int packed_delta_info(struct packed_git *p,
 	return type;
 }
 
-static int unpack_object_header(struct packed_git *p,
-				struct pack_window **w_curs,
-				off_t *curpos,
-				unsigned long *sizep)
+int unpack_object_header(struct packed_git *p,
+			 struct pack_window **w_curs,
+			 off_t *curpos,
+			 unsigned long *sizep)
 {
 	unsigned char *base;
 	unsigned int left;
-- 
1.7.5.2.369.g8fc017
