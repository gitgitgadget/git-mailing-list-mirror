From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 04/11] unpack_object_header(): make it public
Date: Sun, 15 May 2011 17:30:24 -0700
Message-ID: <1305505831-31587-5-git-send-email-gitster@pobox.com>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 02:30:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLli1-00047D-9b
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 02:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440Ab1EPAao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 20:30:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33766 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab1EPAan (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 20:30:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F3EF75F7B
	for <git@vger.kernel.org>; Sun, 15 May 2011 20:32:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=0Ps7
	wH/YtAmqe2HCh5gXHCctrlU=; b=dGl7SYyG8NlL4yrPNkRZ9vi8VD+qur5h7tDM
	tPa2FJYRFZdfErASGMtyd2/HI0VBgpFDS8toh4YwAdzIuYmsLXyq04gJ9Jf18nNy
	akND/xkLVnA7GQniTR7a+pDeFUmrbZP0i6EZ6wmvySvzifMAGXDVkQr/D7/H2ONy
	dhmXYD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=us44Mz
	gKq/7R7kfIm5zSqQsktOdh+xDX8ISf+wkospxRfMtLnj23pw2NVz6Ap3GRwGV87U
	pHHkfUVPy4inZ5CerbhyTdo4hyTwapexFdRkKvik6vjdsbTuToJBtTpvhXuslFHT
	wDf2F+grBv+uJFeE78dwcBMB6kEyVY3xgpRj4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F101A5F7A
	for <git@vger.kernel.org>; Sun, 15 May 2011 20:32:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 68EA15F79 for
 <git@vger.kernel.org>; Sun, 15 May 2011 20:32:49 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.365.g32b65
In-Reply-To: <1305505831-31587-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 0762F0EA-7F54-11E0-B451-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173687>

This function is used to read and skip over the per-object header
in a packfile.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h     |    1 +
 sha1_file.c |    8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 7511b07..39c09b2 100644
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
index 4d1d3ef..b0d82d9 100644
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
1.7.5.1.365.g32b65
