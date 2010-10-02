From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/7] Introduce malloc/strdup/pathdup variants for permanent
 allocations
Date: Sat, 2 Oct 2010 03:38:51 -0500
Message-ID: <20101002083851.GF29638@burratino>
References: <wes62zknmki.fsf@kanis.fr>
 <7v1va760ip.fsf@alter.siamese.dyndns.org>
 <20100810032647.GA2386@burratino>
 <20101002082752.GA29638@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 02 10:42:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1xfT-0004ln-BO
	for gcvg-git-2@lo.gmane.org; Sat, 02 Oct 2010 10:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909Ab0JBImB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Oct 2010 04:42:01 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61630 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654Ab0JBImA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Oct 2010 04:42:00 -0400
Received: by iwn5 with SMTP id 5so4741775iwn.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 01:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=UHLkXNRFHIC/vnznNDXO8S2OpHsXlPE27tphYTQokvE=;
        b=NpELIIsGbaLAFIPfI67VCZKWBLOGq1R8NA8TCXu9HnVNcYXCtIN5sUJKDXzjNu78id
         3sKTOhhENCH398gCgvjm572WTsSpACmq9+d0sJRHGEHx7SumtVg83ixtPO/Nfk0+awL6
         1xE4YSTeg5guiinlCVDY6nnvOjpGW/bvzh0TU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=svRXV68JdQjM2u8+ey8Lpjvk423znwoIYl+Jay+zEz/StK/xFD1z4crjmNiEeW0QrV
         AbpGgmQRLVZzyelPPWNUSKO71CmekpOpVl4ZQ0BY3sppR83gtL+8e2CEQRVBcaPjHKLt
         KcvwfiXmN/k5mIKN2Ig5utAXr8MdMYd6csvUY=
Received: by 10.231.13.139 with SMTP id c11mr6887904iba.188.1286008919560;
        Sat, 02 Oct 2010 01:41:59 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id h8sm2231547ibk.9.2010.10.02.01.41.58
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 Oct 2010 01:41:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101002082752.GA29638@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157800>

In git (option parsing and some other places), we sometimes leak tiny
bits of memory on purpose.  Introduce a way to declare such
allocations, to make the lives of people searching for real memory
leaks easier.

Currently these are thin wrappers around xmalloc and xstrdup.  The
KEEP_WRAPPER attribute avoids a tail call to ensure their stack frame
does not get replaced with the true xmalloc/xstrdup, so tools like
valgrind can easily distinguish them and know that the memory they
return is not meant to be freed.

In the long run it might be nice to tighten the semantics of these
functions and use memory from a large pool that is never freed (to
avoid fragmentation and save some allocation overhead).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 cache.h                 |    2 ++
 git-compat-util.h       |    2 ++
 path.c                  |   10 ++++++++++
 t/valgrind/default.supp |   17 +++++++++++++++++
 wrapper.c               |   14 ++++++++++++++
 5 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 9ee61a2..bbf32ff 100644
--- a/cache.h
+++ b/cache.h
@@ -638,6 +638,8 @@ extern char *git_snpath(char *buf, size_t n, const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
 extern char *git_pathdup(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
+extern char *git_pathdup_permanent(const char *fmt, ...)
+	__attribute__((format (printf, 1, 2)));
 
 /* Return a statically allocated filename matching the sha1 signature */
 extern char *mkpath(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
diff --git a/git-compat-util.h b/git-compat-util.h
index 81883e7..f00ee33 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -380,7 +380,9 @@ typedef void (*try_to_free_t)(size_t);
 extern try_to_free_t set_try_to_free_routine(try_to_free_t);
 
 extern char *xstrdup(const char *str);
+extern char *strdup_permanent(const char *str);
 extern void *xmalloc(size_t size);
+extern void *alloc_permanent(size_t size);
 extern void *xmallocz(size_t size);
 extern void *xmemdupz(const void *data, size_t len);
 extern char *xstrndup(const char *str, size_t len);
diff --git a/path.c b/path.c
index a2c9d1e..332c903 100644
--- a/path.c
+++ b/path.c
@@ -87,6 +87,16 @@ char *git_pathdup(const char *fmt, ...)
 	return xstrdup(path);
 }
 
+char *git_pathdup_permanent(const char *fmt, ...)
+{
+	char path[PATH_MAX];
+	va_list args;
+	va_start(args, fmt);
+	(void)git_vsnpath(path, sizeof(path), fmt, args);
+	va_end(args);
+	return strdup_permanent(path);
+}
+
 char *mkpath(const char *fmt, ...)
 {
 	va_list args;
diff --git a/t/valgrind/default.supp b/t/valgrind/default.supp
index 7789edd..d237210 100644
--- a/t/valgrind/default.supp
+++ b/t/valgrind/default.supp
@@ -45,6 +45,23 @@
 }
 
 {
+	leaky malloc for option parsing and configuration
+	Memcheck:Leak
+	fun:malloc
+	fun:xmalloc
+	fun:alloc_permanent
+}
+
+{
+	leaky strdup for option parsing and configuration
+	Memcheck:Leak
+	fun:malloc
+	fun:strdup
+	fun:xstrdup
+	fun:strdup_permanent
+}
+
+{
 	see api-lockfile.txt
 	Memcheck:Leak
 	fun:calloc
diff --git a/wrapper.c b/wrapper.c
index fd8ead3..88ca3dd 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -3,6 +3,8 @@
  */
 #include "cache.h"
 
+#define KEEP_WRAPPER __attribute__((optimize("-fno-optimize-sibling-calls")))
+
 static void try_to_free_builtin(size_t size)
 {
 	release_pack_memory(size, -1);
@@ -17,6 +19,12 @@ try_to_free_t set_try_to_free_routine(try_to_free_t routine)
 	return old;
 }
 
+KEEP_WRAPPER
+char *strdup_permanent(const char *str)
+{
+	return xstrdup(str);
+}
+
 char *xstrdup(const char *str)
 {
 	char *ret = strdup(str);
@@ -29,6 +37,12 @@ char *xstrdup(const char *str)
 	return ret;
 }
 
+KEEP_WRAPPER
+void *alloc_permanent(size_t size)
+{
+	return xmalloc(size);
+}
+
 void *xmalloc(size_t size)
 {
 	void *ret = malloc(size);
-- 
1.7.2.3
