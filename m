From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH 1/6] Better error handling in compress_all()
Date: Fri, 11 Jan 2008 19:53:02 +0100
Message-ID: <e5bfff550801111053v55fd2fc3ice97e6ae10c8f942@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 19:54:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDP15-0001RL-CZ
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 19:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761867AbYAKSxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 13:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761861AbYAKSxH
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 13:53:07 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:62732 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758179AbYAKSxE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 13:53:04 -0500
Received: by py-out-1112.google.com with SMTP id u52so1782632pyb.10
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 10:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=h5BexNq+PCC0Ap/qmvwjGpG0UDBhEfDG++jP2i68dHw=;
        b=peAUpHcHsATz5bFp1hFutKDGukirBW0UBbdgVCsYA/pzneWlKnEtCasIhqnbiVn8K8ZYOKI1+ySmHeso1S8Frzn8CYHdqlQPPcgDbj2SZhOcbQO4c6MJQeB1OdeOclNQxWT1WRs1kQEPL03I4xsgI6976TYYRCZRPuK15ujiYCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Z5dBndA184wrdggUjqmOUA2udXVwJ/soeUezohPGx/0eQdUC2pT9jKVqkbiXbDagzFCSmAwjtJqC3DyC5TT5GeHeqfM1z+DMy2Gfs1os6bVxWJH09H8o8fILefWyNUHlgjgxS2XcOXrFbCSjpJioypwbyX6auNSfdroSjdEnzuQ=
Received: by 10.141.15.19 with SMTP id s19mr2198059rvi.269.1200077582619;
        Fri, 11 Jan 2008 10:53:02 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Fri, 11 Jan 2008 10:53:02 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70185>

Also let the caller to xmalloc() the buffer
int compress_start()

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---

This patch belong to the previous compression series,
not the decompression one that I'm publishing right now.

Anyhow next patches depends on this, so that's the reason
why is the first.


 compress.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/compress.c b/compress.c
index be771a9..a8f46d5 100644
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
@@ -36,19 +36,18 @@ unsigned long compress_free(z_stream
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
1.5.4.rc2.90.gf158-dirty
