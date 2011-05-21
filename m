From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 11/12] sha1_file.c: expose helpers to read loose objects
Date: Fri, 20 May 2011 23:56:34 -0700
Message-ID: <1305960995-25738-12-git-send-email-gitster@pobox.com>
References: <1305960995-25738-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 08:58:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNg8X-0006Q2-HY
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 08:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489Ab1EUG6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2011 02:58:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55253 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372Ab1EUG6C (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 02:58:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1D5E35DD5
	for <git@vger.kernel.org>; Sat, 21 May 2011 03:00:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=v/pQ
	7FL4/T/U83UY9dpVZmF3HlA=; b=KYIePZw/22MTjl7k1wxPHdkiQ6r0AqkUmVU+
	335RdjvXtywzQaroOzrAN+zRza+LWmH11NCzgnvijPOg32ZZ5bBK7kFiN1ZyZauQ
	ZHW41jzrAaCDDDkpucigDbG76qw2pbw0cAkiuQwZTsmJc7aHPqoN9OwgzmdRjf51
	iIUfEfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=lq02rV
	BKo5zHNblOZZbRCHoC71bLnjeFNAKd8DBQ8fEgRAK6pAmC9wgYJ0nGmlpwykxbEb
	NkTMRT/0yRlmYXAOexFESSTDftW9hT0ek/tL8udySx5jGwrLn17lRFtMjNGYTUh6
	lCzUQgwc40ek08uHT0hCNKsVNh7Rbz/vjkpHs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 19EB45DD4
	for <git@vger.kernel.org>; Sat, 21 May 2011 03:00:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5441F5DD3 for
 <git@vger.kernel.org>; Sat, 21 May 2011 03:00:07 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.2.369.g8fc017
In-Reply-To: <1305960995-25738-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: F6736CE2-8377-11E0-ADB3-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174105>

Make map_sha1_file(), parse_sha1_header() and unpack_sha1_header()
available to the streaming read API by exporting them via cache.h header
file.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h     |    3 +++
 sha1_file.c |    6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 2a7a77f..a5067ba 100644
--- a/cache.h
+++ b/cache.h
@@ -780,6 +780,9 @@ extern int hash_sha1_file(const void *buf, unsigned long len, const char *type,
 extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
+extern void *map_sha1_file(const unsigned char *sha1, unsigned long *size);
+extern int unpack_sha1_header(z_stream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
+extern int parse_sha1_header(const char *hdr, unsigned long *sizep);
 
 /* global flag to enable extra checks when accessing packed objects */
 extern int do_check_packed_object_crc;
diff --git a/sha1_file.c b/sha1_file.c
index a28683a..5fc877f 100644
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
@@ -1342,7 +1342,7 @@ static void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long size
  * too permissive for what we want to check. So do an anal
  * object header parse by hand.
  */
-static int parse_sha1_header(const char *hdr, unsigned long *sizep)
+int parse_sha1_header(const char *hdr, unsigned long *sizep)
 {
 	char type[10];
 	int i;
-- 
1.7.5.2.369.g8fc017
