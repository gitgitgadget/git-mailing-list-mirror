From: Marco Costalba <mcostalba@gmail.com>
Subject: [PATCH 06/11] Better error handling in compress_all()
Date: Sat,  2 Feb 2008 12:35:51 +0100
Message-ID: <1201952156-6764-6-git-send-email-mcostalba@gmail.com>
References: <1201952156-6764-1-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-2-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-3-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-4-git-send-email-mcostalba@gmail.com>
 <1201952156-6764-5-git-send-email-mcostalba@gmail.com>
Cc: git@vger.kernel.org, Marco Costalba <mcostalba@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 02 12:38:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLGhj-0000Z5-UZ
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 12:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756603AbYBBLhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 06:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756578AbYBBLhE
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 06:37:04 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:7036 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756061AbYBBLgw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 06:36:52 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1278311fga.17
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 03:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=rNsmRimEZtFkuqFmlKbADu2T71YapQQvY+lJUWVG9Sk=;
        b=qL9y09vvY3AuyNZI+KnZWI9mIzfNwlpfHLhsFcgnqn6yoAnYi8aLziPX5qu070K3avK8gUVLX9m4IcIaQvvZQ21VPbDz3AaAkmqbYzt67SKjYwBJ8hdacpeBUEb86QybGesTZBj++PPfQ5mmX2FSH9nCgpZLvFpqB8lDrqMilmI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KfW3OtMGAMxv/NnU/xe8QsYQfGe6MHAoBfP4lKJ2UGVVPmjKzkloHM0G3jAolEihKV6lN67Q0sTGGG/7nJskDIhqvNp+cCWTAjcKRD8f7+nHfvU+C76pC805ed/4AVs8Qgf0hF0OA8jRVUf6DCBWmiAjyccOb0MH2rOGAB4ikMI=
Received: by 10.86.71.1 with SMTP id t1mr4247676fga.69.1201952212129;
        Sat, 02 Feb 2008 03:36:52 -0800 (PST)
Received: from localhost.localdomain ( [151.70.66.144])
        by mx.google.com with ESMTPS id d6sm6069171fga.9.2008.02.02.03.36.50
        (version=SSLv3 cipher=OTHER);
        Sat, 02 Feb 2008 03:36:51 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc4.39.g524a
In-Reply-To: <1201952156-6764-5-git-send-email-mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72270>

Also let the caller to xmalloc() the buffer
int compress_start()

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 compress.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/compress.c b/compress.c
index f6986c3..0d0b9d9 100644
--- a/compress.c
+++ b/compress.c
@@ -12,7 +12,7 @@ int compress_start(z_stream *stream,
                    unsigned char *in, unsigned long in_size,
                    unsigned char *out, unsigned long out_size)
 {
-	stream->next_out = (out ? out : xmalloc(out_size));
+	stream->next_out = out;
 	stream->avail_out = out_size;
 	stream->next_in = in;
 	stream->avail_in = in_size;
@@ -36,19 +36,18 @@ unsigned long compress_free(z_stream *stream)
 	return stream->total_out;
 }
 
-unsigned long compress_all(int level, unsigned char *data,
-                           unsigned long size, unsigned char **out)
+unsigned long compress_all(int level, unsigned char *in,
+                           unsigned long in_size, unsigned char **out)
 {
-	int bound, result;
+	unsigned long out_size;
 	z_stream stream;
 
-	bound = compress_alloc(&stream, level, size);
-	compress_start(&stream, data, size, NULL, bound);
+	out_size = compress_alloc(&stream, level, in_size);
+	*out = xmalloc(out_size);
 
-	*out = stream.next_out;
-	result = compress_next(&stream, Z_FINISH);
-
-	if (result != Z_STREAM_END) {
+	if (   compress_start(&stream, in, in_size, *out, out_size) != Z_OK
+	    || compress_next(&stream, Z_FINISH) != Z_STREAM_END)
+	{
 		compress_free(&stream);
 		free(*out);
 		*out = NULL;
-- 
1.5.4.rc4.39.g524a
