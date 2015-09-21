From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 04/13] strbuf: add strbuf_read_once to read without blocking
Date: Mon, 21 Sep 2015 15:39:10 -0700
Message-ID: <1442875159-13027-5-git-send-email-sbeller@google.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 00:39:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze9kM-0006NK-Se
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 00:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933066AbbIUWji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 18:39:38 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:32976 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932647AbbIUWj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 18:39:29 -0400
Received: by pacex6 with SMTP id ex6so128683587pac.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 15:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VVcNCjaLi5A9S/RK/vI+dHxpD8+CITkfq4w4gfp2YfI=;
        b=fxvcM1Phe5xQmDMMQaj0RJ9+/zjhox03ZCfXPt6vnFq5rVIeZHJOsxn89a8dHk/0Ry
         beqsBoXEKYeoX+brdMjepFGiPSWUcgTNXoq4pnZ8+hwvaBqPDMPj5JGNw1H03HntL0N2
         dRMeI7tGFY3QfFCL2Hnza4FNWdFXLtFAU8o4eOReqgIW0Hf9RIRZIlFLcFnx+cwtk0mg
         U9DxaiDsXd+9JlVAIayQuht9tiOtuN6grpmSrK3uIKgDNSi6GLzHC8AcNxukON+4du8R
         nSl8T8pC/6olgecCeEdXXEcHbFoA7I/DsbWbblFfJWXq0FTW8G1AA2PuZ4H5U6DY1DT5
         5tnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VVcNCjaLi5A9S/RK/vI+dHxpD8+CITkfq4w4gfp2YfI=;
        b=MnxO/4hqRIf1meKcKTax67vCbdSniE1W3cmfp2k2XgcTKbFC8HNsNWwGdmJrcUfhwJ
         HuBhKNmZ5uXMyMq5n4LcNYaXtWH3jYG2ztFeuui9dO2btAOvs1IuyZe2AepLo0NSq9Ko
         DuxoCpzFDOKk/FVjslfiWjNWTWWlZFe8tqPehksFAEOi+02lxws76mgVzFfQG9D9dvoj
         4+Wb2jqEfqJdJdyFLS7+EoBr0Fpr8gxLb78UZ7W1JcUSVgE4wXkWjlKzAq7NHd405UuA
         BV1c9Rft9xGOooleBP8GE5jVj/JOD9/IuBRMGLIi2w6kmNnx0k0LEY3evWo/Pt2Id0+f
         BzBg==
X-Gm-Message-State: ALoCoQmBq75yz3Sso+BKHRygk0J3tI8WJ7X9XIkHRWsMBHRsUy77W1DO1K4fquKVO/2JGuWc8pd1
X-Received: by 10.66.163.136 with SMTP id yi8mr27730598pab.124.1442875168753;
        Mon, 21 Sep 2015 15:39:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:a032:5a54:ea65:75ca])
        by smtp.gmail.com with ESMTPSA id mn2sm26461130pbc.75.2015.09.21.15.39.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 21 Sep 2015 15:39:28 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.275.ge015d2a
In-Reply-To: <1442875159-13027-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278340>

The new call will read a fd into a strbuf once. The underlying call
xread_nonblock is meant to execute non blockingly if the fd is set to
O_NONBLOCK.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 strbuf.c | 11 +++++++++++
 strbuf.h |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index cce5eed..35e71b8 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -384,6 +384,17 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
 	return sb->len - oldlen;
 }
 
+ssize_t strbuf_read_once(struct strbuf *sb, int fd, size_t hint)
+{
+	ssize_t cnt;
+
+	strbuf_grow(sb, hint ? hint : 8192);
+	cnt = xread_nonblock(fd, sb->buf + sb->len, sb->alloc - sb->len - 1);
+	if (cnt > 0)
+		strbuf_setlen(sb, sb->len + cnt);
+	return cnt;
+}
+
 #define STRBUF_MAXLINK (2*PATH_MAX)
 
 int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
diff --git a/strbuf.h b/strbuf.h
index aef2794..4d4e5b1 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -367,6 +367,12 @@ extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
 extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
 
 /**
+ * Same as strbuf_read, just returns non-blockingly by ignoring EAGAIN.
+ * The fd must have set O_NONBLOCK.
+ */
+extern ssize_t strbuf_read_once(struct strbuf *, int fd, size_t hint);
+
+/**
  * Read the contents of a file, specified by its path. The third argument
  * can be used to give a hint about the file size, to avoid reallocs.
  */
-- 
2.5.0.275.ge015d2a
