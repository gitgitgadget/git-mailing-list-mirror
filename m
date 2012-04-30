From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 9a/5] archive-zip: streaming for deflated files
Date: Tue, 01 May 2012 00:12:27 +0200
Message-ID: <4F9F0E4B.40206@lsrfire.ath.cx>
References: <1335761837-12482-1-git-send-email-pclouds@gmail.com> <1335761837-12482-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 00:12:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOypf-0006NU-O3
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 00:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757225Ab2D3WMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 18:12:30 -0400
Received: from india601.server4you.de ([85.25.151.105]:57808 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756755Ab2D3WM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 18:12:29 -0400
Received: from [192.168.2.105] (p4FFDA315.dip.t-dialin.net [79.253.163.21])
	by india601.server4you.de (Postfix) with ESMTPSA id 8C5182F805D;
	Tue,  1 May 2012 00:12:27 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120420 Thunderbird/12.0
In-Reply-To: <1335761837-12482-6-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196621>

After an entry has been streamed out, its CRC and sizes are written as
part of a data descriptor.

For simplicity, we make the buffer for the compressed chunks twice as
big as for the uncompressed ones, to be sure the result fit in even
if deflate makes them bigger.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive-zip.c    |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 t/t1050-large.sh |    4 ++++
 2 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/archive-zip.c b/archive-zip.c
index 1c6c39d..f5af81f 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -211,7 +211,7 @@ static int write_zip_entry(struct archiver_args *args,
 		compressed_size = size;
 
 		if (S_ISREG(mode) && type == OBJ_BLOB && !args->convert &&
-		    size > big_file_threshold && method == 0) {
+		    size > big_file_threshold) {
 			stream = open_istream(sha1, &type, &size, NULL);
 			if (!stream)
 				return error("cannot stream blob %s",
@@ -308,6 +308,68 @@ static int write_zip_entry(struct archiver_args *args,
 		zip_offset += ZIP_DATA_DESC_SIZE;
 
 		set_zip_dir_data_desc(&dirent, size, compressed_size, crc);
+	} else if (stream && method == 8) {
+		unsigned char buf[STREAM_BUFFER_SIZE];
+		ssize_t readlen;
+		git_zstream zstream;
+		int result;
+		size_t out_len;
+		unsigned char compressed[STREAM_BUFFER_SIZE * 2];
+
+		memset(&zstream, 0, sizeof(zstream));
+		git_deflate_init(&zstream, args->compression_level);
+
+		compressed_size = 0;
+		zstream.next_out = compressed;
+		zstream.avail_out = sizeof(compressed);
+
+		for (;;) {
+			readlen = read_istream(stream, buf, sizeof(buf));
+			if (readlen <= 0)
+				break;
+			crc = crc32(crc, buf, readlen);
+
+			zstream.next_in = buf;
+			zstream.avail_in = readlen;
+			result = git_deflate(&zstream, 0);
+			if (result != Z_OK)
+				die("deflate error (%d)", result);
+			out = compressed;
+			if (!compressed_size)
+				out += 2;
+			out_len = zstream.next_out - out;
+
+			if (out_len > 0) {
+				write_or_die(1, out, out_len);
+				compressed_size += out_len;
+				zstream.next_out = compressed;
+				zstream.avail_out = sizeof(compressed);
+			}
+
+		}
+		close_istream(stream);
+		if (readlen)
+			return readlen;
+
+		zstream.next_in = buf;
+		zstream.avail_in = 0;
+		result = git_deflate(&zstream, Z_FINISH);
+		if (result != Z_STREAM_END)
+			die("deflate error (%d)", result);
+
+		git_deflate_end(&zstream);
+		out = compressed;
+		if (!compressed_size)
+			out += 2;
+		out_len = zstream.next_out - out - 4;
+		write_or_die(1, out, out_len);
+		compressed_size += out_len;
+		zip_offset += compressed_size;
+
+		write_zip_data_desc(size, compressed_size, crc);
+		zip_offset += ZIP_DATA_DESC_SIZE;
+
+		set_zip_dir_data_desc(&dirent, size, compressed_size, crc);
 	} else if (compressed_size > 0) {
 		write_or_die(1, out, compressed_size);
 		zip_offset += compressed_size;
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 9db54b5..55ed955 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -142,4 +142,8 @@ test_expect_success 'zip achiving, store only' '
 	git archive --format=zip -0 HEAD >/dev/null
 '
 
+test_expect_success 'zip achiving, deflate' '
+	git archive --format=zip HEAD >/dev/null
+'
+
 test_done
-- 
1.7.10
