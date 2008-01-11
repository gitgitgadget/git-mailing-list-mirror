From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH 5/6] Convert builtin-pack/unpack
Date: Fri, 11 Jan 2008 19:58:56 +0100
Message-ID: <e5bfff550801111058t42b289e9w4fe6b48a57024701@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 19:59:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDP6E-0003KS-76
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 19:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761244AbYAKS67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 13:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761296AbYAKS66
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 13:58:58 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:37900 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761201AbYAKS66 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 13:58:58 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1021812rvb.1
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 10:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=io+w8pF6umbiy3klQTXlEy2I93hxJvMEc0fdKBhfg04=;
        b=oo3IHY+q1AlWUtSh1XMwyOH3yTOmcfnA7iDjXghnmkadtkrRIMpYv1yNqjwjcwAs6W5fBihtDvg1sfcAwaJhShbc584x3er/nZJGkJZnYhvaKTow5hNQo8tB7eL1hMCjf4aKwZ15+2b1kUU3kdHIMtmfc1+TkVMJJdmYojlHNk4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DWBrO4xXMeUwqUBmyjRdMydvi9tM3T4OydZeyRWybnA1o0aehdMUB8o4yONVbPlPAStyOCkdBibfkkSLnnrZRaMEtU5GJtbWi+hfyUH1JYz6R4Nn4SuCt03XUQNwcSCLdqt6yE/64h6KtYsYhZvMRr6xtiBwcrq/mM7EoFl7F+I=
Received: by 10.141.145.11 with SMTP id x11mr2204797rvn.264.1200077936296;
        Fri, 11 Jan 2008 10:58:56 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Fri, 11 Jan 2008 10:58:56 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70189>

Also in this case decompression helper conversion
is quite similar and not too complex, so they go
together.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 builtin-pack-objects.c   |   14 ++++++--------
 builtin-unpack-objects.c |   20 +++++++-------------
 2 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 66dedf9..d2865fe 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -302,19 +302,17 @@ static int check_pack_inflate(struct
 {
 	z_stream stream;
 	unsigned char fakebuf[4096], *in;
+	unsigned int in_size = 0;
 	int st;

-	memset(&stream, 0, sizeof(stream));
-	inflateInit(&stream);
+	decompress_alloc(&stream);
 	do {
-		in = use_pack(p, w_curs, offset, &stream.avail_in);
-		stream.next_in = in;
-		stream.next_out = fakebuf;
-		stream.avail_out = sizeof(fakebuf);
-		st = inflate(&stream, Z_FINISH);
+		decompress_into(&stream, fakebuf, sizeof(fakebuf));
+		in = use_pack(p, w_curs, offset, &in_size);
+		st = decompress_next_from(&stream, in, in_size, Z_FINISH);
 		offset += stream.next_in - in;
 	} while (st == Z_OK || st == Z_BUF_ERROR);
-	inflateEnd(&stream);
+	decompress_free(&stream);
 	return (st == Z_STREAM_END &&
 		stream.total_out == expect &&
 		stream.total_in == len) ? 0 : -1;
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 1e51865..f1a4883 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "compress.h"
 #include "object.h"
 #include "delta.h"
 #include "pack.h"
@@ -61,23 +62,18 @@ static void use(int bytes)
 static void *get_data(unsigned long size)
 {
 	z_stream stream;
-	void *buf = xmalloc(size);
+	unsigned char *buf = xmalloc(size);;

-	memset(&stream, 0, sizeof(stream));
-
-	stream.next_out = buf;
-	stream.avail_out = size;
-	stream.next_in = fill(1);
-	stream.avail_in = len;
-	inflateInit(&stream);
+	decompress_alloc(&stream);
+	decompress_into(&stream, buf, size);

 	for (;;) {
-		int ret = inflate(&stream, 0);
+		int ret = decompress_next_from(&stream, fill(1), len, Z_NO_FLUSH);
 		use(len - stream.avail_in);
 		if (stream.total_out == size && ret == Z_STREAM_END)
 			break;
 		if (ret != Z_OK) {
-			error("inflate returned %d\n", ret);
+			error("decompress returned %d\n", ret);
 			free(buf);
 			buf = NULL;
 			if (!recover)
@@ -85,10 +81,8 @@ static void *get_data(unsigned long size)
 			has_errors = 1;
 			break;
 		}
-		stream.next_in = fill(1);
-		stream.avail_in = len;
 	}
-	inflateEnd(&stream);
+	decompress_free(&stream);
 	return buf;
 }

-- 
1.5.4.rc2.90.gf158-dirty
