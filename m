From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 7/8] wrapper: expose try_to_free_pack_memory()
Date: Sat, 6 Nov 2010 06:48:17 -0500
Message-ID: <20101106114817.GG27641@burratino>
References: <20101106113905.GA27405@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 06 12:48:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEhG2-0003DS-TB
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 12:48:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971Ab0KFLsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Nov 2010 07:48:25 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36569 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753851Ab0KFLsY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Nov 2010 07:48:24 -0400
Received: by mail-iw0-f174.google.com with SMTP id 41so1928499iwn.19
        for <git@vger.kernel.org>; Sat, 06 Nov 2010 04:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=K4Dcpv0E4cSkuRbAIn4/hxdR6qDKBcdq7hbumtTS5Kk=;
        b=F+6j4o4VCqkFOfPNJX1XMvaLnYXKfVQUhtYIDsufVfZMkQORar90nKn2Z2yYVNcyR5
         12LI/Yn+M7gzaaHE3w/Kn3NWwyKhwU/yt7/yoZKRZSmZJrK15TnhWGrkf27upA+E6qW+
         XWvJgMYzeM73yvncTpt0W3dVzhO7lzXUyrOLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UlFBpJEbKhSVx2A/+6Vntr8kPJGB+FN7Xd+0r33svLdMxa1CXNC8Y0rNruHfhc7knC
         NW+kMwg6VwyZ+olIMZ6cgZawIxhgUJBzFsz51k9KE6ys8IwHY5JR/7hPslGFY49b1BH9
         wkZk/QnM1FgTpYbEhOsop61w65An3hTyp1OMM=
Received: by 10.42.175.4 with SMTP id ay4mr310765icb.316.1289044104453;
        Sat, 06 Nov 2010 04:48:24 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id fw4sm2823695ibb.13.2010.11.06.04.48.23
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 06 Nov 2010 04:48:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101106113905.GA27405@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160849>

As v1.7.0-rc0~43 (slim down "git show-index", 2010-01-21) explains,
xmalloc() is dependent on zlib, the sha1 lib, and the rest of git's
object file access machinery via try_to_free_pack_memory.  That is
overkill when xmalloc() is only being used to print a message and exit
on memory exhaustion.

So let each caller decide whether the "discard pack windows" logic is
needed.  Programs using the sha1_file library should request that
xmalloc discard stale windows when an allocation fails, by calling

	set_try_to_free_handler(try_to_free_pack_memory);

A later patch will stop setting up that handler except in response to
such explicit requests, allowing wrapper.o to be used without adding a
sha1_file.o dependency by programs that do not access the object db.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-compat-util.h |    1 +
 sha1_file.c       |    5 +++++
 wrapper.c         |    7 +------
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 029162e..07ee75e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -387,6 +387,7 @@ static inline void *gitmempcpy(void *dest, const void *src, size_t n)
 #endif
 
 extern void release_pack_memory(size_t, int);
+extern void try_to_free_pack_memory(size_t size);
 
 typedef void (*try_to_free_t)(size_t);
 extern try_to_free_t set_try_to_free_routine(try_to_free_t);
diff --git a/sha1_file.c b/sha1_file.c
index 8e299ae..c48baaa 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -576,6 +576,11 @@ void release_pack_memory(size_t need, int fd)
 		; /* nothing */
 }
 
+void try_to_free_pack_memory(size_t size)
+{
+	release_pack_memory(size, -1);
+}
+
 void *xmmap(void *start, size_t length,
 	int prot, int flags, int fd, off_t offset)
 {
diff --git a/wrapper.c b/wrapper.c
index 185dfbc..6c6579b 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -3,12 +3,7 @@
  */
 #include "cache.h"
 
-static void try_to_free_builtin(size_t size)
-{
-	release_pack_memory(size, -1);
-}
-
-static void (*try_to_free_routine)(size_t size) = try_to_free_builtin;
+static void (*try_to_free_routine)(size_t size) = try_to_free_pack_memory;
 
 try_to_free_t set_try_to_free_routine(try_to_free_t routine)
 {
-- 
1.7.2.3.557.gab647.dirty
