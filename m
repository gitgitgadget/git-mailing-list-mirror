From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 10/11] sha1_file.c: expose helpers to read loose objects
Date: Sun, 15 May 2011 17:30:30 -0700
Message-ID: <1305505831-31587-11-git-send-email-gitster@pobox.com>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 02:31:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLliV-0004Hp-Q9
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 02:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754828Ab1EPAbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 20:31:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33923 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754487Ab1EPAa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 20:30:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B297B5F97
	for <git@vger.kernel.org>; Sun, 15 May 2011 20:33:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=6LiT
	1sWjzTzIgvpZuSa5ZQXExW4=; b=dE8yGqx/HyhNrfcpLeF778J0PKgvypWgTuiR
	uDN3mmdDWnK9DjsyF/9Qnydl9AyNkc5Lkacwm93jt++oS1xuG7AGCKgK+BapQbyY
	g/sEmSBfv9SLLQc1cIBvY/NzXEq+aIZSZwEux26dWvlEuyKSoJAmbH1p85o8j8vY
	sntHDw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=WsTx4I
	dnbO3HxohMGcuEiI4OLFH5tuAOmLftOxZxxu5m01cRF1yoK+PLLTARfTGqNEBKff
	4rUSZW/mT0tajVS4Zc8qCISYLMYUvz5MGrpGHlW6SZTutdOIuv487RPqRqZX3Ttm
	rGDwP1L2+vZ9NV90zO/1It2TbA3/HpfPhOnqA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AF3765F96
	for <git@vger.kernel.org>; Sun, 15 May 2011 20:33:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 24E7C5F95 for
 <git@vger.kernel.org>; Sun, 15 May 2011 20:33:02 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.365.g32b65
In-Reply-To: <1305505831-31587-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 0F92AE2C-7F54-11E0-8D98-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173693>

Make map_sha1_file() and unpack_sha1_header() available to the streaming
read API by exporting them via cache.h header file.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h     |    2 ++
 sha1_file.c |    4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 39e53c8..3d3d683 100644
--- a/cache.h
+++ b/cache.h
@@ -780,6 +780,8 @@ extern int hash_sha1_file(const void *buf, unsigned long len, const char *type,
 extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
+extern void *map_sha1_file(const unsigned char *sha1, unsigned long *size);
+extern int unpack_sha1_header(z_stream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
 
 /* global flag to enable extra checks when accessing packed objects */
 extern int do_check_packed_object_crc;
diff --git a/sha1_file.c b/sha1_file.c
index b0d82d9..b68a308 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1186,7 +1186,7 @@ static int open_sha1_file(const unsigned char *sha1)
 	return -1;
 }
 
-static void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
+void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
 {
 	void *map;
 	int fd;
@@ -1245,7 +1245,7 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 	return used;
 }
 
-static int unpack_sha1_header(z_stream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz)
+int unpack_sha1_header(z_stream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz)
 {
 	unsigned long size, used;
 	static const char valid_loose_object_type[8] = {
-- 
1.7.5.1.365.g32b65
