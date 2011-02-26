From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/5] compat: provide a fallback va_copy definition
Date: Fri, 25 Feb 2011 23:08:25 -0600
Message-ID: <20110226050825.GA27887@elie>
References: <20110226050723.GA27864@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 26 06:08:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtCOY-0007MB-3O
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 06:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923Ab1BZFIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 00:08:37 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42591 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701Ab1BZFIg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 00:08:36 -0500
Received: by vws12 with SMTP id 12so1956872vws.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 21:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=aZeFzRRGSp0d0QzcBFm7z0vKiPxoN0Q91a/B1cwWQzA=;
        b=Jv1GWet5a16AJYMdggaxiYQPD6ALSRzAA/2YhJRqr97r73NRPEWVIXs+0AvKcMIlo0
         Ux+d7Ap0wH9YV6J9ngkaf2AXJYwvJWXOIQc4TQQUnQZWF/NjhwgIWdiJm0qXj/ZdjTpx
         gG+l2uApSmDEjeV7k3JgyXb0yX8w5ZL/Kvh8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=m5OsWOXPxmnrZQ6eTf+7IAnoQ5wMxB+UaYH0s7HEOF6/BsyyvbkciaKVL6CPqikyg7
         vbE/1HhsU1U71wM8MqXOMosdZfWk9vhlnqT6GK9f3vmxWlftt9FekcVhkRTRy0td+YLj
         0rk0/OOlgTQHnty2UAeBOs1Kb1xwRDfZNv6/c=
Received: by 10.220.177.196 with SMTP id bj4mr800724vcb.128.1298696915799;
        Fri, 25 Feb 2011 21:08:35 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id y15sm716566vch.29.2011.02.25.21.08.33
        (version=SSLv3 cipher=OTHER);
        Fri, 25 Feb 2011 21:08:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110226050723.GA27864@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167955>

From: Jeff King <peff@peff.net>

va_copy is C99.  We have avoided using va_copy many times in the past,
which has led to a bunch of cut-and-paste.  From everything I found
searching the web, implementations have historically either provided
va_copy or just let your code assume that simple assignment of worked.

So my guess is that this will be sufficient, though we won't really
know for sure until somebody reports a problem.

Signed-off-by: Jeff King <peff@peff.net>
Improved-by: Erik Faye-Lund <kusmabite@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 compat/msvc.h     |    1 -
 git-compat-util.h |    4 ++++
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/compat/msvc.h b/compat/msvc.h
index 023aba0..a33b01c 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -9,7 +9,6 @@
 #define inline __inline
 #define __inline__ __inline
 #define __attribute__(x)
-#define va_copy(dst, src)     ((dst) = (src))
 #define strncasecmp  _strnicmp
 #define ftruncate    _chsize
 
diff --git a/git-compat-util.h b/git-compat-util.h
index 9c23622..00d41e4 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -535,6 +535,10 @@ void git_qsort(void *base, size_t nmemb, size_t size,
 #define fstat_is_reliable() 1
 #endif
 
+#ifndef va_copy
+#define va_copy(dst,src) (dst) = (src)
+#endif
+
 /*
  * Preserves errno, prints a message, but gives no warning for ENOENT.
  * Always returns the return value of unlink(2).
-- 
1.7.4.1
