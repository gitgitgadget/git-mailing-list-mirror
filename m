From: Fredrik Kuivinen <frekui@gmail.com>
Subject: [PATCH 2/2] Make sha1_to_hex thread-safe
Date: Tue, 23 Mar 2010 18:31:30 +0100
Message-ID: <20100323173130.GC4218@fredrik-laptop>
References: <20100323161713.3183.57927.stgit@fredrik-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 23 18:31:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu7x5-0004DJ-Uh
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 18:31:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369Ab0CWRbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 13:31:34 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:55461 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180Ab0CWRbe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 13:31:34 -0400
Received: by mail-ew0-f216.google.com with SMTP id 8so702013ewy.28
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 10:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=yYl+euRaaYKN307U97UEFdS6VImZxH2C1nH8dbJmFbk=;
        b=SoVyK7AtRNcKP/YDzTf4Eq/BXVxe46qaug0e7Ut8Utvh7H50tUsK1elU/e+MuzfZ/0
         GtYmrCU/Po/pLuH38g+KJoIUyWfamFGp/pOQW2L/NaiCGx4ZmIh07uba3tTsi+hWnqTM
         RU0fiLnourB7/Nq/KkpnlUSZQYKbr1z5hhORc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cQMUt50JEXKgSRFlLKQYsw/rRuYPLBdpp4FCz4L+9r5pzY6EDu/iLm9ZPsX4+rRK0+
         tlInfmmaPXECCOcv/D2it3nn5GwAOn7hp7bocHzE1xTYwJfECV/glwIaQZh2Yq6i2OLV
         wt3Hp3PVPjpVxxN/S/LLF+12Zer5+NOl/CEms=
Received: by 10.213.70.10 with SMTP id b10mr1807046ebj.27.1269365493317;
        Tue, 23 Mar 2010 10:31:33 -0700 (PDT)
Received: from fredrik-laptop (c83-250-159-169.bredband.comhem.se [83.250.159.169])
        by mx.google.com with ESMTPS id 15sm3927068ewy.8.2010.03.23.10.31.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Mar 2010 10:31:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100323161713.3183.57927.stgit@fredrik-laptop>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143034>


Signed-off-by: Fredrik Kuivinen <frekui@gmail.com>
---

 hex.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/hex.c b/hex.c
index bb402fb..fe1d302 100644
--- a/hex.c
+++ b/hex.c
@@ -1,5 +1,9 @@
 #include "cache.h"
 
+#ifndef NO_PTHREADS
+#include <pthread.h>
+#endif
+
 const signed char hexval_table[256] = {
 	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 00-07 */
 	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 08-0f */
@@ -48,6 +52,7 @@ int get_sha1_hex(const char *hex, unsigned char *sha1)
 	return 0;
 }
 
+#ifdef NO_PTHREADS
 char *sha1_to_hex(const unsigned char *sha1)
 {
 	static int bufno;
@@ -65,3 +70,51 @@ char *sha1_to_hex(const unsigned char *sha1)
 
 	return buffer;
 }
+#else
+static pthread_once_t sha1_to_hex_once = PTHREAD_ONCE_INIT;
+static pthread_key_t sha1_to_hex_key;
+
+static void sha1_to_hex_init(void)
+{
+	int err = pthread_key_create(&sha1_to_hex_key, free);
+	if (err)
+		die("pthread_key_create failed: %s", strerror(err));
+}
+
+struct sha1_to_hex_buf
+{
+	int no;
+	char hex[4][50];
+};
+
+char *sha1_to_hex(const unsigned char *sha1)
+{
+	static const char hex[] = "0123456789abcdef";
+	struct sha1_to_hex_buf *hexbuf;
+	int i;
+	char *buffer, *buf;
+
+	pthread_once(&sha1_to_hex_once, sha1_to_hex_init);
+
+	hexbuf = pthread_getspecific(sha1_to_hex_key);
+	if (!hexbuf) {
+		int err;
+		hexbuf = xmalloc(sizeof(struct sha1_to_hex_buf));
+		hexbuf->no = 0;
+		err = pthread_setspecific(sha1_to_hex_key, hexbuf);
+		if (err)
+			die("pthread_getspecific failed: %s", strerror(err));
+	}
+
+	buffer = hexbuf->hex[3 & ++hexbuf->no], buf = buffer;
+
+	for (i = 0; i < 20; i++) {
+		unsigned int val = *sha1++;
+		*buf++ = hex[val >> 4];
+		*buf++ = hex[val & 0xf];
+	}
+	*buf = '\0';
+
+	return buffer;
+}
+#endif
