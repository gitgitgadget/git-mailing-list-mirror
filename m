From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 2/4] cleanup: use internal memory allocation wrapper functions everywhere
Date: Wed, 14 Sep 2011 20:59:37 -0500
Message-ID: <1316051979-19671-3-git-send-email-drafnel@gmail.com>
References: <5XXEFw0WjtXKd9dpXSxpkskCcgVyG9Db1_zzVSEBNey-kpXSBbmQfYaxZ2Szg6Pbck6hZZTQ5hHzBwG4rhKYXshrdmveEFLPZ9W0V8P_lw@cipher.nrlssc.navy.mil>
 <1316051979-19671-1-git-send-email-drafnel@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
	bharrosh@panasas.com, trast@student.ethz.ch, zapped@mail.ru,
	Brandon Casey <drafnel@gmail.com>
To: peff@peff.net
X-From: git-owner@vger.kernel.org Thu Sep 15 04:00:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R41G2-0007Q7-Dl
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 04:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418Ab1IOCAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 22:00:49 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54789 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950Ab1IOCAs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 22:00:48 -0400
Received: by yxm8 with SMTP id 8so1886583yxm.19
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 19:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=uZhc8JSHEJTeBV5oUUlA0uaFxwRQa2DnTrXyFelYtU0=;
        b=jkkAH8XHyEetmckhi6DrSk+WvlfMoVh9GOYYj6HeyETiX0ry13EageUaQ2X7DdyKI3
         /zwcle3QupejD9e3uUoGpvQ6oac/b9Zz/vvvYFFAeiPYcRH0RjHAG/1vlZf8+cboUjKS
         wPPG6ENGOb8NUwUl/YEpcnbLbd0VLFifWQE4Y=
Received: by 10.236.187.36 with SMTP id x24mr2949869yhm.74.1316052048084;
        Wed, 14 Sep 2011 19:00:48 -0700 (PDT)
Received: from localhost.localdomain ([96.19.140.155])
        by mx.google.com with ESMTPS id e61sm2291412yhm.2.2011.09.14.19.00.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Sep 2011 19:00:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1316051979-19671-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181423>

The "x"-prefixed versions of strdup, malloc, etc. will check whether the
allocation was successful and terminate the process otherwise.

A few uses of malloc were left alone since they already implemented a
graceful path of failure or were in a quasi external library like xdiff.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 attr.c                |    2 +-
 builtin/mv.c          |    2 +-
 compat/mingw.c        |    2 +-
 compat/qsort.c        |    2 +-
 compat/win32/syslog.c |    2 +-
 remote.c              |    2 +-
 show-index.c          |    2 +-
 transport-helper.c    |    4 ++--
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/attr.c b/attr.c
index 206f233..3359b39 100644
--- a/attr.c
+++ b/attr.c
@@ -533,7 +533,7 @@ static void bootstrap_attr_stack(void)
 
 		if (!is_bare_repository() || direction == GIT_ATTR_INDEX) {
 			elem = read_attr(GITATTRIBUTES_FILE, 1);
-			elem->origin = strdup("");
+			elem->origin = xstrdup("");
 			elem->prev = attr_stack;
 			attr_stack = elem;
 			debug_push(elem);
diff --git a/builtin/mv.c b/builtin/mv.c
index 40f33ca..e9d191f 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -29,7 +29,7 @@ static const char **copy_pathspec(const char *prefix, const char **pathspec,
 			to_copy--;
 		if (to_copy != length || base_name) {
 			char *it = xmemdupz(result[i], to_copy);
-			result[i] = base_name ? strdup(basename(it)) : it;
+			result[i] = base_name ? xstrdup(basename(it)) : it;
 		}
 	}
 	return get_pathspec(prefix, result);
diff --git a/compat/mingw.c b/compat/mingw.c
index 6ef0cc4..8947418 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1183,7 +1183,7 @@ static int WSAAPI getaddrinfo_stub(const char *node, const char *service,
 	}
 	ai->ai_addrlen = sizeof(struct sockaddr_in);
 	if (hints && (hints->ai_flags & AI_CANONNAME))
-		ai->ai_canonname = h ? strdup(h->h_name) : NULL;
+		ai->ai_canonname = h ? xstrdup(h->h_name) : NULL;
 	else
 		ai->ai_canonname = NULL;
 
diff --git a/compat/qsort.c b/compat/qsort.c
index d93dce2..9574d53 100644
--- a/compat/qsort.c
+++ b/compat/qsort.c
@@ -55,7 +55,7 @@ void git_qsort(void *b, size_t n, size_t s,
 		msort_with_tmp(b, n, s, cmp, buf);
 	} else {
 		/* It's somewhat large, so malloc it.  */
-		char *tmp = malloc(size);
+		char *tmp = xmalloc(size);
 		msort_with_tmp(b, n, s, cmp, tmp);
 		free(tmp);
 	}
diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
index 42b95a9..197ab34 100644
--- a/compat/win32/syslog.c
+++ b/compat/win32/syslog.c
@@ -38,7 +38,7 @@ void syslog(int priority, const char *fmt, ...)
 		return;
 	}
 
-	str = malloc(str_len + 1);
+	str = xmalloc(str_len + 1);
 	va_start(ap, fmt);
 	vsnprintf(str, str_len + 1, fmt, ap);
 	va_end(ap);
diff --git a/remote.c b/remote.c
index b8ecfa5..7840d2f 100644
--- a/remote.c
+++ b/remote.c
@@ -840,7 +840,7 @@ char *apply_refspecs(struct refspec *refspecs, int nr_refspec,
 						    refspec->dst, &ret))
 				return ret;
 		} else if (!strcmp(refspec->src, name))
-			return strdup(refspec->dst);
+			return xstrdup(refspec->dst);
 	}
 	return NULL;
 }
diff --git a/show-index.c b/show-index.c
index 4c0ac13..63f9da5 100644
--- a/show-index.c
+++ b/show-index.c
@@ -48,7 +48,7 @@ int main(int argc, char **argv)
 			unsigned char sha1[20];
 			uint32_t crc;
 			uint32_t off;
-		} *entries = malloc(nr * sizeof(entries[0]));
+		} *entries = xmalloc(nr * sizeof(entries[0]));
 		for (i = 0; i < nr; i++)
 			if (fread(entries[i].sha1, 20, 1, stdin) != 1)
 				die("unable to read sha1 %u/%u", i, nr);
diff --git a/transport-helper.c b/transport-helper.c
index 4eab844..0713126 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -183,7 +183,7 @@ static struct child_process *get_helper(struct transport *transport)
 			ALLOC_GROW(refspecs,
 				   refspec_nr + 1,
 				   refspec_alloc);
-			refspecs[refspec_nr++] = strdup(capname + strlen("refspec "));
+			refspecs[refspec_nr++] = xstrdup(capname + strlen("refspec "));
 		} else if (!strcmp(capname, "connect")) {
 			data->connect = 1;
 		} else if (!prefixcmp(capname, "export-marks ")) {
@@ -445,7 +445,7 @@ static int fetch_with_import(struct transport *transport,
 		if (data->refspecs)
 			private = apply_refspecs(data->refspecs, data->refspec_nr, posn->name);
 		else
-			private = strdup(posn->name);
+			private = xstrdup(posn->name);
 		read_ref(private, posn->old_sha1);
 		free(private);
 	}
-- 
1.7.6.2
