From: Junio C Hamano <gitster@pobox.com>
Subject: Re: write() _will_ fail on Mac OS X/XNU if nbytes > INT_MAX
Date: Fri, 10 May 2013 16:05:02 -0700
Message-ID: <7va9o2zba9.fsf@alter.siamese.dyndns.org>
References: <CAEDE852zw9EhmnVaWb_oa_BX_d_--TZoTcs1kgkMPHooM_E6Cw@mail.gmail.com>
	<7v4nffpbct.fsf@alter.siamese.dyndns.org>
	<CAEDE8504Pa_hRcHBLt4S9CL74noqrX3fWGCSf+x45zCr_43+5A@mail.gmail.com>
	<7vbo8j600q.fsf@alter.siamese.dyndns.org>
	<CAEDE8507jPW4sKW7-xX5-+3YpFgfzkXzeskCNRrD7T6ynxgdNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Filipe Cabecinhas <filcab@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 11 01:05:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UawNH-00058m-15
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 01:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755095Ab3EJXFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 19:05:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48288 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754825Ab3EJXFH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 19:05:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 757061E1C8;
	Fri, 10 May 2013 23:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=05emjP89KuAiw7gvx4OTOHTblxA=; b=sLAnHU
	PxvU5dDcnJKiXFNFPGnQqGy3C/Z+Gt1sSvgk4zpv8jJHZIoLxDw9iNRGkfzdny5l
	N0FMJZPruT2SoDFyvZUbYCuhXkoJtWH5KJjP02Fo9P2kweKSP1vcbHfZc97Q7hm3
	2yf+i/Ie5zxg3gnMJSC3bfqDK9BfNolN7JsXI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W0PKnoqi/xGGBBP0lUpzb9dpGPfR5r6X
	5DI6A8n3sYXguIVcVMj2uPumYl59MkRSVoUs0yZSENdUlNUoU38vSk0d7TomdjQC
	x1PzByFBuR/LN8MsDGTvXwYm8+Jip2dzomI6V+vVUfzA4nMMjQzmgyhbgxdwgIM8
	uU8YDw2Xu2I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D2FC1E1C6;
	Fri, 10 May 2013 23:05:05 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A82AD1E1C5;
	Fri, 10 May 2013 23:05:04 +0000 (UTC)
In-Reply-To: <CAEDE8507jPW4sKW7-xX5-+3YpFgfzkXzeskCNRrD7T6ynxgdNA@mail.gmail.com>
	(Filipe Cabecinhas's message of "Fri, 10 May 2013 15:24:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0CFB6E20-B9C6-11E2-87DA-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223918>

Filipe Cabecinhas <filcab@gmail.com> writes:

> Due to a bug in the Darwin kernel, write() calls have a maximum size of
> INT_MAX bytes.
>
> This patch introduces a new compat function: clipped_write
> This function behaves the same as write() but will write, at most, INT_MAX
> characters.
> It may be necessary to include this function on Windows, too.
>
> Signed-off-by: Filipe Cabecinhas <filcab+git@gmail.com>
> ---

Somehow your MUA seems to have lost _all_ tabs, not just in the new
lines in your patch but also in the existing context lines.

> diff --git a/Makefile b/Makefile
> index 0f931a2..ccb8f3f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1466,6 +1466,11 @@ ifndef NO_MSGFMT_EXTENDED_OPTIONS
>   MSGFMT += --check --statistics
>  endif
>
> +ifdef NEEDS_CLIPPED_WRITE
> + BASIC_CFLAGS += -DNEEDS_CLIPPED_WRITE
> + COMPAT_OBJS += compat/clipped-write.o
> +endif
> +
> ...

Here is what I resurrected and queued. I _think_ I did not make any
silly mistake while transcribing from your whitespace-mangled patch,
but please double check; I do not have any Darwin, so this hasn't
even been compile tested.

Also I have a small suggestion I'd like you to try on top of it,
which I'll be sending in a separate message.

Thanks.

-- >8 --
From: Filipe Cabecinhas <filcab@gmail.com>
Date: Fri, 10 May 2013 15:24:57 -0700
Subject: [PATCH] compate/clipped-write.c: large write(2) fails on Mac OS X/XNU

Due to a bug in the Darwin kernel, write(2) calls have a maximum size
of INT_MAX bytes.

Introduce a new compat function, clipped_write(), that only writes
at most INT_MAX bytes and returns the number of bytes written, as
a substitute for write(2), and allow platforms that need this to
enable it from the build mechanism with NEEDS_CLIPPED_WRITE.

Set it for Mac OS X by default.  It may be necessary to include this
function on Windows, too.

Signed-off-by: Filipe Cabecinhas <filcab+git@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile               |  5 +++++
 compat/clipped-write.c | 13 +++++++++++++
 config.mak.uname       |  1 +
 git-compat-util.h      |  5 +++++
 4 files changed, 24 insertions(+)
 create mode 100644 compat/clipped-write.c

diff --git a/Makefile b/Makefile
index 26d3332..7076b15 100644
--- a/Makefile
+++ b/Makefile
@@ -1463,6 +1463,11 @@ ifndef NO_MSGFMT_EXTENDED_OPTIONS
 	MSGFMT += --check --statistics
 endif
 
+ifdef NEEDS_CLIPPED_WRITE
+	BASIC_CFLAGS += -DNEEDS_CLIPPED_WRITE
+	COMPAT_OBJS += compat/clipped-write.o
+endif
+
 ifneq (,$(XDL_FAST_HASH))
 	BASIC_CFLAGS += -DXDL_FAST_HASH
 endif
diff --git a/compat/clipped-write.c b/compat/clipped-write.c
new file mode 100644
index 0000000..9183698
--- /dev/null
+++ b/compat/clipped-write.c
@@ -0,0 +1,13 @@
+#include <limits.h>
+#include <unistd.h>
+
+/*
+ * Version of write that will write at most INT_MAX bytes.
+ * Workaround a xnu bug on Mac OS X
+ */
+ssize_t clipped_write(int fildes, const void *buf, size_t nbyte)
+{
+	if (nbyte > INT_MAX)
+		nbyte = INT_MAX;
+	return write(fildes, buf, nbyte);
+}
diff --git a/config.mak.uname b/config.mak.uname
index e09af8f..e689a9a 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -95,6 +95,7 @@ ifeq ($(uname_S),Darwin)
 	NO_MEMMEM = YesPlease
 	USE_ST_TIMESPEC = YesPlease
 	HAVE_DEV_TTY = YesPlease
+	NEEDS_CLIPPED_WRITE = YesPlease
 	COMPAT_OBJS += compat/precompose_utf8.o
 	BASIC_CFLAGS += -DPRECOMPOSE_UNICODE
 endif
diff --git a/git-compat-util.h b/git-compat-util.h
index b636e0d..3144b8d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -181,6 +181,11 @@ typedef unsigned long uintptr_t;
 #define probe_utf8_pathname_composition(a,b)
 #endif
 
+#ifdef NEEDS_CLIPPED_WRITE
+ssize_t clipped_write(int fildes, const void *buf, size_t nbyte);
+#define write(x,y,z) clipped_write((x),(y),(z))
+#endif
+
 #ifdef MKDIR_WO_TRAILING_SLASH
 #define mkdir(a,b) compat_mkdir_wo_trailing_slash((a),(b))
 extern int compat_mkdir_wo_trailing_slash(const char*, mode_t);
-- 
1.8.3-rc1-268-g30389da
