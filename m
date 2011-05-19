From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/11] unpack_object_header(): make it public
Date: Thu, 19 May 2011 14:33:39 -0700
Message-ID: <1305840826-7783-5-git-send-email-gitster@pobox.com>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
 <1305840826-7783-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 23:36:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNAtM-0007ki-DM
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 23:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934829Ab1ESVd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 17:33:59 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33400 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934814Ab1ESVd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 17:33:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 028A652A9
	for <git@vger.kernel.org>; Thu, 19 May 2011 17:36:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=fHsh
	DaOWXw4K52D+WNFJmlYIQVk=; b=e1kooEUH5X5JyO7oYYtbUhGZvc59q1TZggtf
	79fXNF5jqjqpHgoyMr9xtgFM3h4/sRSQD2B2HgACD8nwJ2PyoLe00JVJfQi6o6O0
	eC2oZU6md79ar/Q5VIHKxlmEHIfbl+k/NdKuJw7A6tRWDF3reVSVEbuqhJrPkjyl
	bJiT0Vs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=hbLq7C
	RvnPFN/ZdlL71HDx69JqdjRWc68a+GizX3kLZqCA3zYxMzJRgQ2vMot9OZmF1InA
	ci2t7sHHwmIjfaAYOUJvJj7GX9lfmVk/aEhdlCxKsbSKllD2lqKiC7qWi8IupiSq
	5deDkS9QoWHl+Xyn1mEN56rddEMXxIWHJbp5A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E08A852A8
	for <git@vger.kernel.org>; Thu, 19 May 2011 17:36:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 452ED52A7 for
 <git@vger.kernel.org>; Thu, 19 May 2011 17:36:04 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.416.gac10c8
In-Reply-To: <1305840826-7783-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 00867A12-8260-11E0-9C1F-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174025>

This function is used to read and skip over the per-object header
in a packfile.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h     |    1 +
 sha1_file.c |    8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index e3f235f..38e14b2 100644
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
1.7.5.1.416.gac10c8
