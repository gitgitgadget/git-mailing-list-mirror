From: Faiz Kothari <faiz.off93@gmail.com>
Subject: [PATCH v3 1/2] Introduce strbuf_write_or_die()
Date: Sun,  2 Mar 2014 13:04:23 +0530
Message-ID: <1393745664-21077-1-git-send-email-faiz.off93@gmail.com>
References: <CAPig+cR0gTeB1oUUPQ=W_wWGPMDaY4gkG7+531HT-ktnwn5L-Q@mail.gmail.com>
Cc: Faiz Kothari <faiz.off93@gmail.com>
To: git@vger.kernel.org, j6t@kdbg.org, sunshine@sunshineco.com,
	mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Sun Mar 02 08:34:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WK0vB-0001Ds-DA
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 08:34:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbaCBHeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 02:34:46 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:46424 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbaCBHep (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2014 02:34:45 -0500
Received: by mail-pa0-f46.google.com with SMTP id kp14so2466460pab.33
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 23:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ixV4eQkjFkCjbtWP4Rdvi7qIh0megYcGz1DL0LbeojY=;
        b=d9Sk2qxTdr7qCiHQokSWxgcHm8ceoVqMjWzBsCijxYb3x7XevJ4d4RqDw5ZchyADxq
         pUmbRN9ychXjb2QmtKvEkT9+angknzZxzhWboE4Z/Ezmd62Uz6WED6wkDBLiyu/zoEY9
         /v2lcU9dyMd5EssTHkT9VrYeIOFnBaNLfy329GY/qf+9l9WjVni6QUwL0Th5CXQ73puf
         09BZVS2yUi97tNJPFDyJbZhRl5E1N6gE3gLQmHZAiolcFgORmZVZJrPq7XWnnjujSv7K
         pO6IxodRA2Chu27rqw+xl5iuuwjTZgd6opFKMUwZ/p/PdQGF4SiEhaBIdKbeNm4BBf1Q
         VtNQ==
X-Received: by 10.68.163.197 with SMTP id yk5mr12899806pbb.57.1393745685147;
        Sat, 01 Mar 2014 23:34:45 -0800 (PST)
Received: from dj-pc.bits-goa.ac.in ([115.248.130.148])
        by mx.google.com with ESMTPSA id xs1sm55608874pac.7.2014.03.01.23.34.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 23:34:44 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <CAPig+cR0gTeB1oUUPQ=W_wWGPMDaY4gkG7+531HT-ktnwn5L-Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243136>

Signed-off-by: Faiz Kothari <faiz.off93@gmail.com>

Introduced a new function strbuf.c:strbuf_write_or_die()
to the strbuf family of functions. Now use this API instead
of write_or_die.c:write_or_die()
---
Hi,
Thanks for the suggestions and feedbacks.
As Johannes Sixt  pointed out, the function is now defined
in strbuf.c and prototype added to strbuf.h
Also, replaced if(!sbuf) with assert(sbuf) and split the patch into two 
as pointed out by Eric Sunshine.

As far as justification is concerned, I am not able to come up with
a satisfactory justification. Apart from, that it makes life of the
programmer a little easier and if we add a few more functions
to thestrbuf API, we can make strbuf completely opaque. I am open
to views and since I haven't used this API extensively, I cannot
comment for what is missing and what is required. But I am going through it.
Also, once this patch is OK, I'll add documentation for the API.

Thanks again for the feedback.

 strbuf.c |    6 ++++++
 strbuf.h |    1 +
 2 files changed, 7 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index 83caf4a..337a70c 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -477,6 +477,12 @@ int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
 	return len;
 }
 
+void strbuf_write_or_die(const struct strbuf *sb, int fd)
+{
+	assert(sb);
+	write_or_die(fd, sb->buf, sb->len);
+}
+
 void strbuf_add_lines(struct strbuf *out, const char *prefix,
 		      const char *buf, size_t size)
 {
diff --git a/strbuf.h b/strbuf.h
index 73e80ce..6aadb6d 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -156,6 +156,7 @@ extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
 /* XXX: if read fails, any partial read is undone */
 extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
 extern int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint);
+extern void strbuf_write_or_die(const struct strbuf *sb, int fd);
 extern int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
 
 extern int strbuf_getwholeline(struct strbuf *, FILE *, int);
-- 
1.7.9.5
