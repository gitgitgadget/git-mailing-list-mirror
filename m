From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 12/16] vcs-svn: Learn to parse variable-length integers
Date: Sun, 10 Oct 2010 21:55:56 -0500
Message-ID: <20101011025556.GL1553@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
 <20100810125317.GB3921@kytes>
 <20101011023435.GA706@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 04:59:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P58be-0006s2-NH
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 04:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903Ab0JKC7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 22:59:13 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:62445 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab0JKC7N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 22:59:13 -0400
Received: by gxk9 with SMTP id 9so843119gxk.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 19:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uMbF0jPch0Y1WV6nzgyhR5KefFrMEcp5Rrhuo2E3ERA=;
        b=F8wQDV+EQDM2fBrAAb3yJLuZEtcrlfKJjMxSPRsslVCYL/+ndzDMcLyE/FA+ttnhGx
         bwV4GZRyDWk/MSlQN4FAPX0qsIIFUkm9h3s/7M3h1ATyZmUQL5TOfoFD/szwYk1/elB2
         kURku+m5h4/CuHCZqR+f9WtRKnhQAAwD0BO3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=w3gZjVN+npkTk6R9apCDzeJ5WCiGxeEZG0HzIs2j+0Y3re7HWteSefeOIA6aXQMPOU
         8Hy5vCrZbzTWGGd6tY2U9mRZxRxEJnygM4d6LwEYw9EukNmRqsPORWKWRiXZ80cRFpoc
         9jRS0uowrSqq3JBkfxs7WxItda3/fnAXRUwH8=
Received: by 10.236.110.133 with SMTP id u5mr10605942yhg.83.1286765950962;
        Sun, 10 Oct 2010 19:59:10 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id i9sm3707262yha.42.2010.10.10.19.59.09
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 19:59:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101011023435.GA706@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158742>

The humble beginnings of the svn-format delta applier.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Maybe this should be squashed with patch 16.

Ideas for eliminating the code duplication?

 vcs-svn/svndiff.c |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)
 create mode 100644 vcs-svn/svndiff.c

diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
new file mode 100644
index 0000000..4d122a5
--- /dev/null
+++ b/vcs-svn/svndiff.c
@@ -0,0 +1,59 @@
+/*
+ * Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#include "git-compat-util.h"
+#include "line_buffer.h"
+
+/*
+ * svndiff0 applier
+ *
+ * See http://svn.apache.org/repos/asf/subversion/trunk/notes/svndiff.
+ *
+ * int ::= highdigit* lowdigit;
+ * highdigit ::= # binary 1000 0000 OR-ed with 7 bit value;
+ * lowdigit ::= # 7 bit value;
+ */
+
+#define VLI_CONTINUE	0x80
+#define VLI_DIGIT_MASK	0x7f
+#define VLI_BITS_PER_DIGIT 7
+
+static int read_int(struct line_buffer *in, uintmax_t *result, off_t *len)
+{
+	off_t sz = *len;
+	uintmax_t rv = 0;
+	while (sz) {
+		int ch = buffer_read_char(in);
+		if (ch == EOF)
+			break;
+		sz--;
+		rv <<= VLI_BITS_PER_DIGIT;
+		rv += (ch & VLI_DIGIT_MASK);
+		if (!(ch & VLI_CONTINUE)) {
+			*result = rv;
+			*len = sz;
+			return 0;
+		}
+	}
+	return error("Invalid delta: incomplete integer %"PRIuMAX, rv);
+}
+
+static int parse_int(const char **buf, size_t *result, const char *end)
+{
+	const char *pos;
+	size_t rv = 0;
+	for (pos = *buf; pos != end; pos++) {
+		unsigned char ch = *pos;
+		rv <<= VLI_BITS_PER_DIGIT;
+		rv += (ch & VLI_DIGIT_MASK);
+		if (!(ch & VLI_CONTINUE)) {
+			*result = rv;
+			*buf = pos + 1;
+			return 0;
+		}
+	}
+	return error("Invalid instruction: incomplete integer %"PRIu64,
+		     (uint64_t) rv);
+}
-- 
1.7.2.3
