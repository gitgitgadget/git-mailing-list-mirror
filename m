From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH/RFC] commit: fix memory-leak
Date: Mon,  7 Feb 2011 19:40:44 +0100
Message-ID: <1297104044-4684-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, blees@dcon.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 07 19:40:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmW18-0005g4-MO
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 19:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468Ab1BGSkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 13:40:49 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60845 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754310Ab1BGSkt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 13:40:49 -0500
Received: by ewy5 with SMTP id 5so2505915ewy.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 10:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=iqOMXywSt43/B2sT1Mkflo2X3WNWoAGfWjNf9adVa20=;
        b=bhgFHyRFnqCSWF67vU5w9ypfdk8dhTUtfb82SRVJT/pK+qpLctpmedFSf40DkjhLZr
         6210JNUMAmqqsDjttXGazYFFL82N/voOaV28qhgYgcB6zQA9FzCN5kjhrf8g9YxKDTyM
         gj1VTrUaFzR+7vCVxpQB2dly2pjQOz87DPXlM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=So5xK0hp0Pe2+GInFxrs+9lDd7b2BRqMT63wycvPYdW6Grxw5FHkpghQv1sIU5PNyF
         clrnwE1VZly64iD1MXXEGEF8mdPdlNPUMbpQzNBCmwEGhKzIIqpBccchO6nJ0JGafa92
         03V33tYkgCrgQbNIY6NsVrGSxTAyL/nQUeLug=
Received: by 10.14.0.133 with SMTP id 5mr5761481eeb.10.1297104047647;
        Mon, 07 Feb 2011 10:40:47 -0800 (PST)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id u1sm3336443eeh.4.2011.02.07.10.40.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Feb 2011 10:40:47 -0800 (PST)
X-Mailer: git-send-email 1.7.4.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166268>

The name, email and date strings are some times allocated on the
heap, but not free'd. Fix this by making sure they are allways
heap-allocated, so we can safely free the memory.

At the same time, this fixes a problem with strict-POSIX getenv
implementations. POSIX says "The return value from getenv() may
point to static data which may be overwritten by subsequent calls
to getenv()", so duplicating the strings is a potential bug.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

This was found when investigating how to fix UTF-8 support in
getenv on Windows. I introduced the xgetenv-function (that returns
a pointer that can be passed to free) because I suspect we'll find
other similar code-paths.

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
