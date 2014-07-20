From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH v2 1/4] strbuf: add strbuf_getcwd()
Date: Sun, 20 Jul 2014 18:49:21 +0200
Message-ID: <53CBF311.2000407@web.de>
References: <53CBF277.3090101@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 20 18:49:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8uJ2-00044B-5s
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jul 2014 18:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbaGTQtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2014 12:49:45 -0400
Received: from mout.web.de ([212.227.15.3]:63196 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752177AbaGTQto (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2014 12:49:44 -0400
Received: from [192.168.178.27] ([79.253.172.97]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0LiCbT-1WltLy3aXz-00nMtv; Sun, 20 Jul 2014 18:49:41
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <53CBF277.3090101@web.de>
X-Provags-ID: V03:K0:7uxRQmh5KWGOX5N34TiwsobAauSYb6XD7Y//ehwwaYCOZz2WATo
 buGucSxK2mQ02XISBCirAQYMvx0niV3XHxzqq2hlASy5OxFeEZG3AAMkGFyZS7P5ZWmdyUI
 3SsszjQZbh7K2s13VOFAt3wQdA9qGLuS3nb75KTys139mwxE0fEMUnXsqQhj1MLFi798k7F
 IrjT9sJPEt5HLqOIytpnA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253931>

Add strbuf_getcwd(), which puts the current working directory intto
a strbuf.  Because it doesn't use a fixed-size buffer it supports
arbitrarily long paths, as long as the platform's getcwd() does as
well.  At least on Linux and FreeBSD it handles paths longer than
PATH_MAX just fine.

Suggested-by: Karsten Blees <karsten.blees@gmail.com>
Helped-by: Helped-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 Documentation/technical/api-strbuf.txt |  4 ++++
 strbuf.c                               | 21 +++++++++++++++++++++
 strbuf.h                               |  1 +
 3 files changed, 26 insertions(+)

diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
index f9c06a7..49e477d 100644
--- a/Documentation/technical/api-strbuf.txt
+++ b/Documentation/technical/api-strbuf.txt
@@ -307,6 +307,10 @@ same behaviour as well.
 	use it unless you need the correct position in the file
 	descriptor.
 
+`strbuf_getcwd`::
+
+	Set the buffer to the path of the current working directory.
+
 `stripspace`::
 
 	Strip whitespace from a buffer. The second parameter controls if
diff --git a/strbuf.c b/strbuf.c
index 33018d8..2bf4dfa 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -406,6 +406,27 @@ int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
 	return -1;
 }
 
+int strbuf_getcwd(struct strbuf *sb)
+{
+	size_t oldalloc = sb->alloc;
+	size_t guessed_len = 128;
+
+	for (;; guessed_len *= 2) {
+		strbuf_grow(sb, guessed_len);
+		if (getcwd(sb->buf, sb->alloc)) {
+			strbuf_setlen(sb, strlen(sb->buf));
+			return 0;
+		}
+		if (errno != ERANGE)
+			break;
+	}
+	if (oldalloc == 0)
+		strbuf_release(sb);
+	else
+		strbuf_reset(sb);
+	return -1;
+}
+
 int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 {
 	int ch;
diff --git a/strbuf.h b/strbuf.h
index a7c0192..bc38bb9 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -174,6 +174,7 @@ extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
 extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
 extern int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint);
 extern int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
+extern int strbuf_getcwd(struct strbuf *sb);
 
 extern int strbuf_getwholeline(struct strbuf *, FILE *, int);
 extern int strbuf_getline(struct strbuf *, FILE *, int);
-- 
2.0.2
