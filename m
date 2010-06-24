From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/9] Add memory pool library
Date: Thu, 24 Jun 2010 05:53:39 -0500
Message-ID: <20100624105339.GC12376@burratino>
References: <20100624105004.GA12336@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <daniel@shahaf.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 24 12:53:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORk4C-0001ke-4X
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 12:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778Ab0FXKxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 06:53:50 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36711 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559Ab0FXKxt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 06:53:49 -0400
Received: by iwn41 with SMTP id 41so731952iwn.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 03:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uk8myJZqkQw16rG1Xt5u0JnV86G+7bKKhuCvFrDIRVk=;
        b=Inq+fMYfew8ciY1HVAw6cU/g1cnnyrGfJqdekHc/c9yf8jl+7zwFWiDWDLMn+hd4LN
         xY4naCIDHiIAyNfoOfUyXgd2IAvAXLTXkBr37qt328/CkYSYRxq/0/WkfVpULPAHx1FA
         yKflBlAe6kFrbY3XHPLFOPhuxqXWnsDGZqHj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=eYljL+M9uY12WVTQgqldiokIUYpeeVSrOjMrpao8f3I9emywhrhoPNnSZ2ZSpDNyjt
         ASHKmZvUkdfG5np2fnV2D2aCtrBWay9UrIlaWfyJbihf18zUrps0FbeZKHzecdH77EJ/
         +Ev66hc+4BcUued7yty+q5Ua/xnxbNvqP7LoU=
Received: by 10.231.211.134 with SMTP id go6mr9751636ibb.143.1277376828482;
        Thu, 24 Jun 2010 03:53:48 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id b3sm16419345ibf.19.2010.06.24.03.53.47
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 03:53:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100624105004.GA12336@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149574>

From: David Barr <david.barr@cordelta.com>

Add a memory pool library implemented using C macros. The obj_pool_gen()
macro creates a type-specific memory pool API.

The memory pool library is distinguished from the existing specialized
allocators in alloc.c by using a contiguous block for all allocations.
This means that on one hand, long-lived pointers have to be written as
offsets, since the base address changes as the pool grows, but on the
other hand, the entire pool can be easily written to the file system.
This allows the memory pool to persist between runs of an application.

For the svn importer, such a facility is useful because each svn
revision can copy trees and files from any previous revision.  The
relevant information for all revisions has to persist somehow to
support incremental runs, and for now it is simplest to avoid relying
on the target VCS for that.

obj_pool_gen(pre, obj_t, initial_capability)

	pre: Prefix for generated functions (example: string).
	obj_t: Type for treap data structure (example: char).
	initial_capacity: Initial size of the memory pool (example: 4096).

void pre_init(void);

	Read values from a previous run to initialize the pool.
	If this function is not called, the pool begins valid but empty.

uint32_t pre_alloc(uint32_t nmemb);

	Reserve space for a few objects in the pool and return an
	offset to the first one.

uint32_t pre_free(uint32_t nmemb);

	Unreserve the last few objects reserved.

uint32_t pre_offset(obj_t *pointer);
obj_t *pre_pointer(uint32_t offset);

	Convert between pointers into the in-memory pool and offsets
	from the beginning (or ~0 for the NULL pointer).  Pointers are
	not guaranteed to remain valid after a pre_alloc() operation
	or pre_reset() followed by pre_init(), but offsets are.

void pre_commit(void);

	Write the pool to file.  A pre_reset() followed by pre_init()
	(pehaps with exit() in between) will return the pool to the
	last committed state.

void pre_reset(void);

	Deinitialize the pool, freeing any associated memory and
	file handles.

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile           |    3 +-
 vcs-svn/LICENSE    |   26 +++++++++++++++++
 vcs-svn/obj_pool.h |   80 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+), 1 deletions(-)
 create mode 100644 vcs-svn/LICENSE
 create mode 100644 vcs-svn/obj_pool.h

diff --git a/Makefile b/Makefile
index 6441dcb..fc31ee0 100644
--- a/Makefile
+++ b/Makefile
@@ -1863,7 +1863,8 @@ xdiff-interface.o $(XDIFF_OBJS): \
 	xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xtypes.h \
 	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
 
-$(VCSSVN_OBJS):
+$(VCSSVN_OBJS): \
+	vcs-svn/obj_pool.h
 endif
 
 exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
diff --git a/vcs-svn/LICENSE b/vcs-svn/LICENSE
new file mode 100644
index 0000000..6e52372
--- /dev/null
+++ b/vcs-svn/LICENSE
@@ -0,0 +1,26 @@
+Copyright (C) 2010 David Barr <david.barr@cordelta.com>.
+All rights reserved.
+
+Redistribution and use in source and binary forms, with or without
+modification, are permitted provided that the following conditions
+are met:
+1. Redistributions of source code must retain the above copyright
+   notice(s), this list of conditions and the following disclaimer
+   unmodified other than the allowable addition of one or more
+   copyright notices.
+2. Redistributions in binary form must reproduce the above copyright
+   notice(s), this list of conditions and the following disclaimer in
+   the documentation and/or other materials provided with the
+   distribution.
+
+THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER(S) ``AS IS'' AND ANY
+EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
+PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) BE
+LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
+EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
diff --git a/vcs-svn/obj_pool.h b/vcs-svn/obj_pool.h
new file mode 100644
index 0000000..f60c872
--- /dev/null
+++ b/vcs-svn/obj_pool.h
@@ -0,0 +1,80 @@
+/*
+ * Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#ifndef OBJ_POOL_H_
+#define OBJ_POOL_H_
+
+#include "git-compat-util.h"
+
+#define MAYBE_UNUSED __attribute__((__unused__))
+
+#define obj_pool_gen(pre, obj_t, initial_capacity) \
+static struct { \
+	uint32_t committed; \
+	uint32_t size; \
+	uint32_t capacity; \
+	obj_t *base; \
+	FILE *file; \
+} pre##_pool = { 0, 0, 0, NULL, NULL}; \
+static MAYBE_UNUSED void pre##_init(void) \
+{ \
+	struct stat st; \
+	pre##_pool.file = fopen(#pre ".bin", "a+"); \
+	rewind(pre##_pool.file); \
+	fstat(fileno(pre##_pool.file), &st); \
+	pre##_pool.size = st.st_size / sizeof(obj_t); \
+	pre##_pool.committed = pre##_pool.size; \
+	pre##_pool.capacity = pre##_pool.size * 2; \
+	if (pre##_pool.capacity < initial_capacity) \
+		pre##_pool.capacity = initial_capacity; \
+	pre##_pool.base = malloc(pre##_pool.capacity * sizeof(obj_t)); \
+	fread(pre##_pool.base, sizeof(obj_t), pre##_pool.size, pre##_pool.file); \
+} \
+static MAYBE_UNUSED uint32_t pre##_alloc(uint32_t count) \
+{ \
+	uint32_t offset; \
+	if (pre##_pool.size + count > pre##_pool.capacity) { \
+		while (pre##_pool.size + count > pre##_pool.capacity) \
+			if (pre##_pool.capacity) \
+				pre##_pool.capacity *= 2; \
+			else \
+				pre##_pool.capacity = initial_capacity; \
+		pre##_pool.base = realloc(pre##_pool.base, \
+					pre##_pool.capacity * sizeof(obj_t)); \
+	} \
+	offset = pre##_pool.size; \
+	pre##_pool.size += count; \
+	return offset; \
+} \
+static MAYBE_UNUSED void pre##_free(uint32_t count) \
+{ \
+	pre##_pool.size -= count; \
+} \
+static MAYBE_UNUSED uint32_t pre##_offset(obj_t *obj) \
+{ \
+	return obj == NULL ? ~0 : obj - pre##_pool.base; \
+} \
+static MAYBE_UNUSED obj_t *pre##_pointer(uint32_t offset) \
+{ \
+	return offset >= pre##_pool.size ? NULL : &pre##_pool.base[offset]; \
+} \
+static MAYBE_UNUSED void pre##_commit(void) \
+{ \
+	pre##_pool.committed += fwrite(pre##_pool.base + pre##_pool.committed, \
+		sizeof(obj_t), pre##_pool.size - pre##_pool.committed, \
+		pre##_pool.file); \
+} \
+static MAYBE_UNUSED void pre##_reset(void) \
+{ \
+	free(pre##_pool.base); \
+	if (pre##_pool.file) \
+		fclose(pre##_pool.file); \
+	pre##_pool.base = NULL; \
+	pre##_pool.size = 0; \
+	pre##_pool.capacity = 0; \
+	pre##_pool.file = NULL; \
+}
+
+#endif
-- 
1.7.1
