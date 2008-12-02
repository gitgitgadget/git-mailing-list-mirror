From: Liu Yubao <yubao.liu@gmail.com>
Subject: [PATCH 5/5] support writing uncompressed loose object
Date: Tue, 02 Dec 2008 10:03:10 +0800
Message-ID: <4934975E.2010601@gmail.com>
References: <493399B7.5000505@gmail.com> <7voczws3np.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 03:06:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7Ke5-0007G9-3R
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 03:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824AbYLBCEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 21:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752332AbYLBCEH
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 21:04:07 -0500
Received: from ti-out-0910.google.com ([209.85.142.189]:64430 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbYLBCEE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 21:04:04 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1746975tic.23
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 18:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=2M0VN2Wh290u8yzvUYlr3dvDLgxyz8tXYGtRRy9yfyg=;
        b=tFcU1oQu7n4/M2vLWzyQdA63JBqpSfxXCszAL16Ghk7+5P4x/bsPg0YtJ74IBuzzeD
         8kZAuKgxT2/RG0gbJ8qPt8VSpT4IKbiPk3vvRARkPCsx3KCbMNY7IGglcnY1STpfm6t3
         nPOzqAttBZA0wA83dwaOFJUNjG273HX7M2Hsw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=eF5Ep368TiBs40NvZylPUnl9nZrGhHNuE6u/120tJN4R7nVDW0Ha7ljgnu7ATcgN5i
         8bejNh+IkZ2oqCBQ8kGc2MRBMvB0md/0cRDmWv8jZBvVCvhvgBgkDqRThhXlM/ViUQDt
         5svs3dJe/wggTWbDl1oUSDuQ+6239TpnJlaRg=
Received: by 10.110.47.9 with SMTP id u9mr17285022tiu.47.1228183443074;
        Mon, 01 Dec 2008 18:04:03 -0800 (PST)
Received: from ?10.64.1.142? ([211.157.41.194])
        by mx.google.com with ESMTPS id 2sm2871474tif.0.2008.12.01.18.03.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Dec 2008 18:03:30 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <7voczws3np.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102101>



Signed-off-by: Liu Yubao <yubao.liu@gmail.com>
---
 sha1_file.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 05a9fa3..053b564 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2328,7 +2328,7 @@ static int create_tmpfile(char *buffer, size_t bufsiz, const char *filename)
 }
 
 static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
-			      void *buf, unsigned long len, time_t mtime)
+			      void *buf, unsigned long len, time_t mtime, int dont_deflate)
 {
 	int fd, size, ret;
 	unsigned char *compressed;
@@ -2345,6 +2345,12 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 			return error("unable to create temporary sha1 filename %s: %s\n", tmpfile, strerror(errno));
 	}
 
+	if (dont_deflate) {
+		if (write_buffer(fd, hdr, hdrlen) < 0 || write_buffer(fd, buf, len) < 0)
+			die("unable to write sha1 file");
+		goto L_close_file;
+	}
+
 	/* Set it up */
 	memset(&stream, 0, sizeof(stream));
 	deflateInit(&stream, zlib_compression_level);
@@ -2376,9 +2382,11 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 
 	if (write_buffer(fd, compressed, size) < 0)
 		die("unable to write sha1 file");
-	close_sha1_file(fd);
 	free(compressed);
 
+L_close_file:
+	close_sha1_file(fd);
+
 	if (mtime) {
 		struct utimbuf utb;
 		utb.actime = mtime;
@@ -2405,7 +2413,7 @@ int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned cha
 		hashcpy(returnsha1, sha1);
 	if (has_sha1_file(sha1))
 		return 0;
-	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
+	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0, 1);
 }
 
 int force_object_loose(const unsigned char *sha1, time_t mtime)
@@ -2423,7 +2431,7 @@ int force_object_loose(const unsigned char *sha1, time_t mtime)
 	if (!buf)
 		return error("cannot read sha1_file for %s", sha1_to_hex(sha1));
 	hdrlen = sprintf(hdr, "%s %lu", typename(type), len) + 1;
-	ret = write_loose_object(sha1, hdr, hdrlen, buf, len, mtime);
+	ret = write_loose_object(sha1, hdr, hdrlen, buf, len, mtime, 1);
 	free(buf);
 
 	return ret;
-- 
1.6.1.rc1.5.gde86c
