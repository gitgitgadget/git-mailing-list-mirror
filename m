From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2] commit: fix memory-leak
Date: Mon,  7 Feb 2011 21:21:51 +0100
Message-ID: <1297110111-7620-1-git-send-email-kusmabite@gmail.com>
References: <AANLkTikKZ+2qUMF1T5pP60cUd9Ya3n2mfhTkX6L32zmn@mail.gmail.com>
Cc: matthieu.moy@grenoble-inp.fr, msysgit@googlegroups.com,
	blees@dcon.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 07 21:22:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmXbK-0004Ty-4H
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 21:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291Ab1BGUWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 15:22:17 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53575 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428Ab1BGUWR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 15:22:17 -0500
Received: by bwz15 with SMTP id 15so5291804bwz.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 12:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=8SHQA3X23Fpgg7ZFEhBka6Vq5XYv/3D4wE2DS4Tf5+s=;
        b=x0njWqHuJe/E+0ABmhduETOHcrUAjTJaDIiLBpU+8HcHkPRy9e6nPLWDEAZFIHfjkx
         ModXHbYPy/ptktryWS3uy/7yhi/R3oUQXVFL+EkQD03Hdfp9BPW/Pk7R4s1aEZJZQ4pH
         1kM3QRCfjcU0ehrcaFcdHoSt3JdX24II2hINM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PtaSbI544bJfP3HGP2WsInjI/13JCjL53xcLP0IifIyfmDhM1CAOfRd1OqI/MLZySe
         rc2im8DRVHjgrcKD3hXMTIHSysoBAZViqcoFWYPJ6xZYvwUvfvRNil1n6gPswYaDVDHe
         bEwKeMe1QsJg+Yy2UpYdX2mHLj4kS7wM39/ow=
Received: by 10.204.81.72 with SMTP id w8mr4483205bkk.205.1297110134329;
        Mon, 07 Feb 2011 12:22:14 -0800 (PST)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id u23sm2291883bkw.9.2011.02.07.12.22.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Feb 2011 12:22:13 -0800 (PST)
X-Mailer: git-send-email 1.7.4.msysgit.0
In-Reply-To: <AANLkTikKZ+2qUMF1T5pP60cUd9Ya3n2mfhTkX6L32zmn@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166278>

The name, email and date strings are some times allocated on the
heap, but not free'd. Fix this by making sure they are allways
heap-allocated, so we can safely free the memory.

At the same time, this fixes a problem with strict-POSIX getenv
implementations. POSIX says "The return value from getenv() may
point to static data which may be overwritten by subsequent calls
to getenv()", so not duplicating the strings is a potential bug.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
Fixed typo in commit message, as pointed out by Matthieu Moy.

 builtin/commit.c  |    9 ++++++---
 git-compat-util.h |    1 +
 wrapper.c         |    6 ++++++
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 03cff5a..e5a649e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -465,9 +465,9 @@ static void determine_author_info(struct strbuf *author_ident)
 {
 	char *name, *email, *date;
 
-	name = getenv("GIT_AUTHOR_NAME");
-	email = getenv("GIT_AUTHOR_EMAIL");
-	date = getenv("GIT_AUTHOR_DATE");
+	name = xgetenv("GIT_AUTHOR_NAME");
+	email = xgetenv("GIT_AUTHOR_EMAIL");
+	date = xgetenv("GIT_AUTHOR_DATE");
 
 	if (use_message && !renew_authorship) {
 		const char *a, *lb, *rb, *eol;
@@ -507,6 +507,9 @@ static void determine_author_info(struct strbuf *author_ident)
 		date = force_date;
 	strbuf_addstr(author_ident, fmt_ident(name, email, date,
 					      IDENT_ERROR_ON_NO_NAME));
+	free(name);
+	free(email);
+	free(date);
 }
 
 static int ends_rfc2822_footer(struct strbuf *sb)
diff --git a/git-compat-util.h b/git-compat-util.h
index d6d269f..12f111f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -409,6 +409,7 @@ typedef void (*try_to_free_t)(size_t);
 extern try_to_free_t set_try_to_free_routine(try_to_free_t);
 
 extern char *xstrdup(const char *str);
+extern char *xgetenv(const char *name);
 extern void *xmalloc(size_t size);
 extern void *xmallocz(size_t size);
 extern void *xmemdupz(const void *data, size_t len);
diff --git a/wrapper.c b/wrapper.c
index 8d7dd31..e6173c4 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -30,6 +30,12 @@ char *xstrdup(const char *str)
 	return ret;
 }
 
+char *xgetenv(const char *name)
+{
+	char *tmp = getenv(name);
+	return tmp ? xstrdup(tmp) : NULL;
+}
+
 void *xmalloc(size_t size)
 {
 	void *ret = malloc(size);
-- 
1.7.4.msysgit.0
