From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 01/14] strbuf: introduce strbuf_prefixf()
Date: Tue, 2 Dec 2014 21:10:16 -0800
Message-ID: <20141203051016.GK6527@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 06:10:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xw2Cm-0004Fd-M1
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 06:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbaLCFKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 00:10:20 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:43324 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbaLCFKT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 00:10:19 -0500
Received: by mail-ig0-f182.google.com with SMTP id hn15so12154121igb.15
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 21:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Os/Rv8XkB0ZcINBi0ZV191IWdY+zNybP9wCxz7D/9HI=;
        b=DB3wGIL9VbiLA5dCB9dMeDTq093xaHgVP1MPGgA3EF3FcY0FI6uXYxfjh5DO6So+23
         VcEYkY/xRwpUGawH1MN7EXRc/eLwhZL0yaS/EULuoSwdHMsa8f5rTuJ+QXB3Wf5SdEOX
         gd+9VahBgZ9ABPXM4QhAea2J1ccWucKya4EQoU/Px/go6EfbWDEvk04g+ae13AsGfK4M
         7+I7YulqQgK3e2nEnoWO3TmfoP2Mmk/081JCxyL+E0a0x3Urhg/0V6MXxM9eYMfsCxKE
         /kz0Z0+ggIA3Gpah9n8BPsXTy4lR0lkwxZPjDrNumVrZGULDsvwueR6JLt3mrKj+/7ci
         ehHA==
X-Received: by 10.50.41.103 with SMTP id e7mr16505437igl.20.1417583419184;
        Tue, 02 Dec 2014 21:10:19 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id jn1sm6576366igb.20.2014.12.02.21.10.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Dec 2014 21:10:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141203050217.GJ6527@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260625>

When preparing an error message in a strbuf, it can be convenient
to add a formatted string to the beginning:

	if (transaction_commit(&t, err)) {
		strbuf_prefixf(err, "cannot fetch '%s': ", remotename);
		return -1;
	}

The new strbuf_prefixf is like strbuf_addf, except it writes its
result to the beginning of a strbuf instead of the end.

The current implementation uses strlen(strfmt(fmt, ...)) extra bytes
at the end of the strbuf as temporary scratch space for convenience
and simplicity.  A later patch can optimize if needed.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 strbuf.c | 16 ++++++++++++++++
 strbuf.h |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index 0346e74..3f4aaa3 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -219,6 +219,22 @@ void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
 	va_end(ap);
 }
 
+void strbuf_prefixf(struct strbuf *sb, const char *fmt, ...)
+{
+	va_list ap;
+	size_t pos, len;
+
+	pos = sb->len;
+
+	va_start(ap, fmt);
+	strbuf_vaddf(sb, fmt, ap);
+	va_end(ap);
+
+	len = sb->len - pos;
+	strbuf_insert(sb, 0, sb->buf + pos, len);
+	strbuf_remove(sb, pos + len, len);
+}
+
 static void add_lines(struct strbuf *out,
 			const char *prefix1,
 			const char *prefix2,
diff --git a/strbuf.h b/strbuf.h
index 652b6c4..5dae48e 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -158,6 +158,10 @@ extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
 
 extern void strbuf_add_lines(struct strbuf *sb, const char *prefix, const char *buf, size_t size);
 
+/* Like strbuf_addf but insert at the front of sb instead of appending. */
+__attribute__((format (printf,2,3)))
+extern void strbuf_prefixf(struct strbuf *sb, const char *fmt, ...);
+
 /*
  * Append s to sb, with the characters '<', '>', '&' and '"' converted
  * into XML entities.
