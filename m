From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] compat: helper for detecting unsigned overflow
Date: Thu, 10 Feb 2011 03:35:51 -0600
Message-ID: <20110210093536.GB365@elie>
References: <1286263450-5372-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@fluxnic.net>,
	Pierre Habouzit <madcoder@debian.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 10 10:36:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnSwY-0001v8-Fb
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 10:36:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647Ab1BJJf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 04:35:59 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:52791 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123Ab1BJJf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 04:35:58 -0500
Received: by yib18 with SMTP id 18so492771yib.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 01:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=NbH2tc0wVFT/MdZvnvNKst1e8tLOZRw1MwTO5sR59Ks=;
        b=dscsYgUjI4dGFjXpthvYFHVT6XtIM8dVFDPldcK/I4CxwZ21VSVH1kjz8dzelm8ZuV
         Ox5LpOvWiDzOOiz6xgF6IGE4rjYMQr9oQvvJy2t2vPfeIpg3bI3VZm910tzcknGTfn2n
         SZzlNWc/6Qj8EwCGU7vOQwL0OfyIsBMQEnmvY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nTIrHCAjGBhcILKJwNnbGXwLpeiHfVqF6KPWJoMZLs08zrSq7V0AcAjbE6tFUUQ+J5
         tMWGFm1PIAlghYMlr/M2hawtHRsox5A5dCbp1PtZVPjRhys1780SqJ5uRYUcUIruJegl
         dsHMwNIN14d6uf3vWqxyAJktG63IYoaRPYXbE=
Received: by 10.236.108.41 with SMTP id p29mr1300112yhg.54.1297330557935;
        Thu, 10 Feb 2011 01:35:57 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id z70sm859879yhc.34.2011.02.10.01.35.55
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 10 Feb 2011 01:35:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1286263450-5372-1-git-send-email-kusmabite@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166478>

Date: Sun, 10 Oct 2010 21:59:26 -0500

The idiom (a + b < a) works fine for detecting that an unsigned
integer has overflowed, but a more explicit

	unsigned_add_overflows(a, b)

might be easier to read.

Define such a macro, expanding roughly to ((a) < UINT_MAX - (b)).
Because the expansion uses each argument only once outside of sizeof()
expressions, it is safe to use with arguments that have side effects.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
From the svn remote helper project.  Sane?

 git-compat-util.h |    6 ++++++
 patch-delta.c     |    2 +-
 strbuf.c          |    5 +++--
 wrapper.c         |    2 +-
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index d6d269f..9c23622 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -31,6 +31,9 @@
 #define maximum_signed_value_of_type(a) \
     (INTMAX_MAX >> (bitsizeof(intmax_t) - bitsizeof(a)))
 
+#define maximum_unsigned_value_of_type(a) \
+    (UINTMAX_MAX >> (bitsizeof(uintmax_t) - bitsizeof(a)))
+
 /*
  * Signed integer overflow is undefined in C, so here's a helper macro
  * to detect if the sum of two integers will overflow.
@@ -40,6 +43,9 @@
 #define signed_add_overflows(a, b) \
     ((b) > maximum_signed_value_of_type(a) - (a))
 
+#define unsigned_add_overflows(a, b) \
+    ((b) > maximum_unsigned_value_of_type(a) - (a))
+
 #ifdef __GNUC__
 #define TYPEOF(x) (__typeof__(x))
 #else
diff --git a/patch-delta.c b/patch-delta.c
index d218faa..56e0a5e 100644
--- a/patch-delta.c
+++ b/patch-delta.c
@@ -48,7 +48,7 @@ void *patch_delta(const void *src_buf, unsigned long src_size,
 			if (cmd & 0x20) cp_size |= (*data++ << 8);
 			if (cmd & 0x40) cp_size |= (*data++ << 16);
 			if (cp_size == 0) cp_size = 0x10000;
-			if (cp_off + cp_size < cp_size ||
+			if (unsigned_add_overflows(cp_off, cp_size) ||
 			    cp_off + cp_size > src_size ||
 			    cp_size > size)
 				break;
diff --git a/strbuf.c b/strbuf.c
index 9b3c445..07e8883 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -63,7 +63,8 @@ void strbuf_attach(struct strbuf *sb, void *buf, size_t len, size_t alloc)
 
 void strbuf_grow(struct strbuf *sb, size_t extra)
 {
-	if (sb->len + extra + 1 <= sb->len)
+	if (unsigned_add_overflows(extra, 1) ||
+	    unsigned_add_overflows(sb->len, extra + 1))
 		die("you want to use way too much memory");
 	if (!sb->alloc)
 		sb->buf = NULL;
@@ -152,7 +153,7 @@ int strbuf_cmp(const struct strbuf *a, const struct strbuf *b)
 void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
 				   const void *data, size_t dlen)
 {
-	if (pos + len < pos)
+	if (unsigned_add_overflows(pos, len))
 		die("you want to use way too much memory");
 	if (pos > sb->len)
 		die("`pos' is too far after the end of the buffer");
diff --git a/wrapper.c b/wrapper.c
index 55b074e..4c147d6 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -53,7 +53,7 @@ void *xmalloc(size_t size)
 void *xmallocz(size_t size)
 {
 	void *ret;
-	if (size + 1 < size)
+	if (unsigned_add_overflows(size, 1))
 		die("Data too large to fit into virtual memory space.");
 	ret = xmalloc(size + 1);
 	((char*)ret)[size] = 0;
-- 
1.7.4
