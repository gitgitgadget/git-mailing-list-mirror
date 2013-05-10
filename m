From: Filipe Cabecinhas <filcab@gmail.com>
Subject: Re: write() _will_ fail on Mac OS X/XNU if nbytes > INT_MAX
Date: Fri, 10 May 2013 15:24:57 -0700
Message-ID: <CAEDE8507jPW4sKW7-xX5-+3YpFgfzkXzeskCNRrD7T6ynxgdNA@mail.gmail.com>
References: <CAEDE852zw9EhmnVaWb_oa_BX_d_--TZoTcs1kgkMPHooM_E6Cw@mail.gmail.com>
	<7v4nffpbct.fsf@alter.siamese.dyndns.org>
	<CAEDE8504Pa_hRcHBLt4S9CL74noqrX3fWGCSf+x45zCr_43+5A@mail.gmail.com>
	<7vbo8j600q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 11 00:25:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uavkb-000898-5h
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 00:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124Ab3EJWZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 18:25:00 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:32997 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955Ab3EJWY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 18:24:59 -0400
Received: by mail-wg0-f49.google.com with SMTP id j13so4401705wgh.28
        for <git@vger.kernel.org>; Fri, 10 May 2013 15:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        bh=DALZfPn5UT7tEp46AIvKC4OpwcmToh6W5X7uURXEToQ=;
        b=QWmXWbW5mZGT0cTXU5SiCJdYaobJIIcHceSOCfMJGGeMiTC556IvGOm2jFw/GpLwev
         wfPtis2U+YKix1qcpdyMS6L0jzleKU7wPvJo+3G+Uxt6+te25j2vNuAeYasCfoypBQDk
         trNYf1a0/SnMqy9VR00bb3oLYgegMBwoUBOPbYXhC7InWScMkMR8G5XvkAbgUveK+CVC
         DthSdJC1kD9M6R37zOEV5SS5SzzPt8b6Ik2ldlqdRuUKMpsPNkLycG07ogdq+nmYkEAm
         kA/0WSapOgPuVNryDghvGRf7xYPR9AEi88qMngvA5XVhWIypE9sFgNFhQ3nR4UAd2D4G
         vq1g==
X-Received: by 10.194.109.198 with SMTP id hu6mr27509329wjb.5.1368224697767;
 Fri, 10 May 2013 15:24:57 -0700 (PDT)
Received: by 10.194.38.233 with HTTP; Fri, 10 May 2013 15:24:57 -0700 (PDT)
In-Reply-To: <7vbo8j600q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223917>

Due to a bug in the Darwin kernel, write() calls have a maximum size of
INT_MAX bytes.

This patch introduces a new compat function: clipped_write
This function behaves the same as write() but will write, at most, INT_MAX
characters.
It may be necessary to include this function on Windows, too.

Signed-off-by: Filipe Cabecinhas <filcab+git@gmail.com>
---
 Makefile               |  5 +++++
 compat/clipped-write.c | 13 +++++++++++++
 config.mak.uname       |  1 +
 git-compat-util.h      |  5 +++++
 4 files changed, 24 insertions(+)
 create mode 100644 compat/clipped-write.c

diff --git a/Makefile b/Makefile
index 0f931a2..ccb8f3f 100644
--- a/Makefile
+++ b/Makefile
@@ -1466,6 +1466,11 @@ ifndef NO_MSGFMT_EXTENDED_OPTIONS
  MSGFMT += --check --statistics
 endif

+ifdef NEEDS_CLIPPED_WRITE
+ BASIC_CFLAGS += -DNEEDS_CLIPPED_WRITE
+ COMPAT_OBJS += compat/clipped-write.o
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
+ if (nbyte > INT_MAX)
+ nbyte = INT_MAX;
+ return write(fildes, buf, nbyte);
+}
diff --git a/config.mak.uname b/config.mak.uname
index d78fd3d..174703b 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -95,6 +95,7 @@ ifeq ($(uname_S),Darwin)
  NO_MEMMEM = YesPlease
  USE_ST_TIMESPEC = YesPlease
  HAVE_DEV_TTY = YesPlease
+ NEEDS_CLIPPED_WRITE = YesPlease
  COMPAT_OBJS += compat/precompose_utf8.o
  BASIC_CFLAGS += -DPRECOMPOSE_UNICODE
 endif
diff --git a/git-compat-util.h b/git-compat-util.h
index e955bb5..a96db23 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -185,6 +185,11 @@ int get_st_mode_bits(const char *path, int *mode);
 #define probe_utf8_pathname_composition(a,b)
 #endif

+#ifdef NEEDS_CLIPPED_WRITE
+ssize_t clipped_write(int fildes, const void *buf, size_t nbyte);
+#define write(x, y, z) clipped_write((x), (y), (z))
+#endif
+
 #ifdef MKDIR_WO_TRAILING_SLASH
 #define mkdir(a,b) compat_mkdir_wo_trailing_slash((a),(b))
 extern int compat_mkdir_wo_trailing_slash(const char*, mode_t);
--
1.8.2.1.343.g13c32df
