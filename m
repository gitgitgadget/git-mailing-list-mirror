From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH 2/2] remove NORETURN from function pointers
Date: Mon, 14 Sep 2009 12:16:10 +0200
Message-ID: <1252923370-5768-2-git-send-email-kusmabite@gmail.com>
References: <1252923370-5768-1-git-send-email-kusmabite@gmail.com>
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 14 12:17:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mn8cI-0001zG-Bb
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 12:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbZINKQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 06:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbZINKQx
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 06:16:53 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:56666 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbZINKQw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 06:16:52 -0400
Received: by mail-ew0-f206.google.com with SMTP id 2so519082ewy.17
        for <git@vger.kernel.org>; Mon, 14 Sep 2009 03:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2aTLkvjhdXcCRYzwAzbFzo4UCg0ov5yv3AJM4dO5gE4=;
        b=o6bP7zkSpSHdBRVU4mXluYWxTW9wtAfWi1o3NLFPIzG3vZtalouI1QNjf0+ZRBH4dp
         1FueU5xDzyBz5sj34Gd4KJG3/4ZJnXDb0uxlI3aw09Y93cOXM4YVrj13QefR8N5b/XQH
         JgmJZIXT/lIG1RdWcf8vAQaM346ZW6mw/yufo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FQvvBGKrBX6y+R7yFk1Wq9Tle6ndh/bsW51vlM7mYyJ4gaJvBJgC8QEXqfiJIoTm+0
         jquuiFF2f88rOefen9CWxMmJvtUv8DDNjjWDrR+yzX/fPCNnh40PdmTpZDxsb9DUE4+d
         /XzGHvAU4vIJc4DSTG4eXKVg7QOd+Spu2WImk=
Received: by 10.216.53.21 with SMTP id f21mr1241772wec.48.1252923415330;
        Mon, 14 Sep 2009 03:16:55 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id 24sm3875946eyx.4.2009.09.14.03.16.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Sep 2009 03:16:54 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1252923370-5768-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128443>

From: Erik Faye-Lund <kusmabite@googlemail.com>

Some compilers (including at least MSVC and ARM RVDS) supports
NORETURN on function declarations, but not on function pointers.

This patch makes it possible to define NORETURN for these compilers.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

__attribute__((noreturn)) is, according to the GCC documentation, about
two things: code generation (performance, really) and warnings.

On the warnings-side, we need to keep the code warning-free for
compilers who doesn't support noreturn anyway, so hiding potential
warnings through this mechanism is probably not a good idea in the
first place.

We still want the performance-side of it, though. However, the only
place this really makes a difference is to die and it's variants, since
they can potentially be called many times (or so it seems from the
compiler's point of view without a noreturn declaration).

The function pointers are only called once we're already exiting, and
they have only one potential call-site.

I hope this all makes sense ;)

 git-compat-util.h |    2 +-
 usage.c           |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 5876d91..15fe08e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -183,7 +183,7 @@ extern NORETURN void die_errno(const char *err, ...) __attribute__((format (prin
 extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
-extern void set_die_routine(void (*routine)(const char *err, va_list params) NORETURN);
+extern void set_die_routine(void (*routine)(const char *err, va_list params));
 
 extern int prefixcmp(const char *str, const char *prefix);
 extern time_t tm_to_time_t(const struct tm *tm);
diff --git a/usage.c b/usage.c
index b6aea45..18d7f43 100644
--- a/usage.c
+++ b/usage.c
@@ -36,12 +36,12 @@ static void warn_builtin(const char *warn, va_list params)
 
 /* If we are in a dlopen()ed .so write to a global variable would segfault
  * (ugh), so keep things static. */
-static void (*usage_routine)(const char *err) NORETURN = usage_builtin;
-static void (*die_routine)(const char *err, va_list params) NORETURN = die_builtin;
+static void (*usage_routine)(const char *err) = usage_builtin;
+static void (*die_routine)(const char *err, va_list params) = die_builtin;
 static void (*error_routine)(const char *err, va_list params) = error_builtin;
 static void (*warn_routine)(const char *err, va_list params) = warn_builtin;
 
-void set_die_routine(void (*routine)(const char *err, va_list params) NORETURN)
+void set_die_routine(void (*routine)(const char *err, va_list params))
 {
 	die_routine = routine;
 }
-- 
1.6.4.msysgit.0.16.gd92d4.dirty
