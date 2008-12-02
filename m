From: Liu Yubao <yubao.liu@gmail.com>
Subject: [PATCH 1/5] avoid parse_sha1_header() accessing memory out of bound
Date: Tue, 02 Dec 2008 09:51:23 +0800
Message-ID: <4934949B.70307@gmail.com>
References: <493399B7.5000505@gmail.com> <7voczws3np.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 02:52:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7KRR-0004Vb-Re
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 02:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbYLBBv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 20:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752075AbYLBBv3
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 20:51:29 -0500
Received: from ti-out-0910.google.com ([209.85.142.188]:54730 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309AbYLBBv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 20:51:29 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1744314tic.23
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 17:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=BYT8KGsT0EFPsLFYCdNF504NTEpkeWCazIzLn8oS4kE=;
        b=cS6zXYrCfpqWQp3LzviJWgjbRyJZeDmSfYSQh/Z5U+BJCYvybvaJQXJgHVc0uTCBLi
         hkYcgIVrcn0k1DJ96IDZo1swUQeQpdJDeSLxDHoX9phe27vLUBTG7wM50+CUUaRfJH7d
         JdZn4Ht/jjEOgfzR/dKsYQ//fUUyYv4f8cFyo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=k1cLYjXvQ6h+I/vDzfoJjLA6/BiEBKqC3n2aYeOhEnJuj6x4SaegPQeRR7jO7kg9vB
         WQ7b43OdQkHMv7gO6rcdd361yjR/LBTR9bsG+GWYXHESw4G6FMxVUoJyth+seJJukt0M
         lzTbq+XJojX/f+eV3RRmJb/7z/er3T0HG2+5I=
Received: by 10.110.21.17 with SMTP id 17mr1457453tiu.59.1228182687475;
        Mon, 01 Dec 2008 17:51:27 -0800 (PST)
Received: from ?10.64.1.142? ([211.157.41.194])
        by mx.google.com with ESMTPS id a14sm2740827tia.12.2008.12.01.17.51.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Dec 2008 17:51:26 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <7voczws3np.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102095>


Signed-off-by: Liu Yubao <yubao.liu@gmail.com>
---
 sha1_file.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 6c0e251..efe6967 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1245,8 +1245,9 @@ static void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long size
  * too permissive for what we want to check. So do an anal
  * object header parse by hand.
  */
-static int parse_sha1_header(const char *hdr, unsigned long *sizep)
+static int parse_sha1_header(const char *hdr, unsigned long length, unsigned long *sizep)
 {
+	const char *hdr_end = hdr + length;
 	char type[10];
 	int i;
 	unsigned long size;
@@ -1254,10 +1255,10 @@ static int parse_sha1_header(const char *hdr, unsigned long *sizep)
 	/*
 	 * The type can be at most ten bytes (including the
 	 * terminating '\0' that we add), and is followed by
-	 * a space.
+	 * a space, at least one byte for size, and a '\0'.
 	 */
 	i = 0;
-	for (;;) {
+	while (hdr < hdr_end - 2) {
 		char c = *hdr++;
 		if (c == ' ')
 			break;
@@ -1265,6 +1266,8 @@ static int parse_sha1_header(const char *hdr, unsigned long *sizep)
 		if (i >= sizeof(type))
 			return -1;
 	}
+	if (' ' != *(hdr - 1))
+		return -1;
 	type[i] = 0;
 
 	/*
@@ -1275,7 +1278,7 @@ static int parse_sha1_header(const char *hdr, unsigned long *sizep)
 	if (size > 9)
 		return -1;
 	if (size) {
-		for (;;) {
+		while (hdr < hdr_end - 1) {
 			unsigned long c = *hdr - '0';
 			if (c > 9)
 				break;
@@ -1298,7 +1301,7 @@ static void *unpack_sha1_file(void *map, unsigned long mapsize, enum object_type
 	char hdr[8192];
 
 	ret = unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr));
-	if (ret < Z_OK || (*type = parse_sha1_header(hdr, size)) < 0)
+	if (ret < Z_OK || (*type = parse_sha1_header(hdr, stream.total_out, size)) < 0)
 		return NULL;
 
 	return unpack_sha1_rest(&stream, hdr, *size, sha1);
@@ -1982,7 +1985,7 @@ static int sha1_loose_object_info(const unsigned char *sha1, unsigned long *size
 	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
 		status = error("unable to unpack %s header",
 			       sha1_to_hex(sha1));
-	else if ((status = parse_sha1_header(hdr, &size)) < 0)
+	else if ((status = parse_sha1_header(hdr, stream.total_out, &size)) < 0)
 		status = error("unable to parse %s header", sha1_to_hex(sha1));
 	else if (sizep)
 		*sizep = size;
-- 
1.6.1.rc1.5.gde86c
