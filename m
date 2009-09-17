From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 04/15] Set _O_BINARY as default fmode for both MinGW and MSVC
Date: Thu, 17 Sep 2009 13:04:29 +0200
Message-ID: <6e9b7c953e20a984bb519f3fe374cef03ca144a7.1253185334.git.mstormo@gmail.com>
References: <4AB212FA.9080102@viscovery.net>
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com,
	raa.lkml@gmail.com, snaury@gmail.com,
	Marius Storm-Olsen <mstormo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 13:04:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoEnG-0002R2-Kc
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 13:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760AbZIQLEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 07:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbZIQLEp
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 07:04:45 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:58268 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbZIQLEo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 07:04:44 -0400
Received: by ewy2 with SMTP id 2so272881ewy.17
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 04:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=lrEJvuSEfrvxE8oJ2OgrHk+u14nTvwQb7HeCyUsr5Zg=;
        b=NHPz7sTFRnviaTbp4EuwVFcTI2OWQmYbROj2nEbX2GXzxUYJQ/aQU98kjV9GsF9obH
         30WfjCiX2FeUIlNvUjoZlgcsv6Q2X1pmQfYVSM3y7YLtPpLelILyUtEm/LAkBM8SmfIK
         IxUvzph5PFa4JLm2UhUEpoZLCuOeYG9iD/vXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Yi6kJRgKx+8Wxf17mqTYJ84tinNGvt1kDrfIg9HVQQqcka23wEgS0TpzaX/4uVb4+G
         PqM4xYrkpEuc3DB59gy3D+u+1LF7JWjltaKOkKUuyc48MDFC0ZiwSW0pB7i7OcUvsaux
         ixYZ3oBRc3GSUV8HgjEeoElSGvRkYh7uKux9U=
Received: by 10.211.146.9 with SMTP id y9mr3491672ebn.94.1253185486848;
        Thu, 17 Sep 2009 04:04:46 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104])
        by mx.google.com with ESMTPS id 24sm1470876eyx.39.2009.09.17.04.04.45
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 17 Sep 2009 04:04:46 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <4AB212FA.9080102@viscovery.netm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128743>

MinGW set the _CRT_fmode to set both the default fmode and
_O_BINARY on stdin/stdout/stderr. Rather use the main()
define in mingw.h to set this for both MinGW and MSVC.

This will ensure that a MinGW and MSVC build will handle
input and output identically.

Alexey Borzenkov:
Include git-compat-util.h from the test-genrandom.c so
that the application also will use the main() define,
and thus the stdout mode is set correctly and generated
data stays the same.

Johannes Sixt:
Before, since the test-genrandom application would link
against libgit.a, the MinGW process initialization code
would pick up the definition of _CRT_fmode from mingw.c
that is initialized to _O_BINARY. After this patch,
however, the _CRT_fmode symbol is no longer present in
libgit.a, so MinGWs process initialization code will not
set the correct std(in|out|err) mode. So, the include is
needed to override main() and explicitly set the mode.

Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 Gaaaaah! Sorry for not reading Alexey's patch properly.
 Multitasking is not working to my advantage these days..

 compat/mingw.c   |    2 --
 compat/mingw.h   |    5 +++++
 test-genrandom.c |    3 +--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 5478b74..5a8fae8 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -3,8 +3,6 @@
 #include <conio.h>
 #include "../strbuf.h"
 
-unsigned int _CRT_fmode = _O_BINARY;
-
 static int err_win_to_posix(DWORD winerr)
 {
 	int error = ENOSYS;
diff --git a/compat/mingw.h b/compat/mingw.h
index c43917c..bcd23b0 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -227,12 +227,17 @@ void free_environ(char **env);
 
 /*
  * A replacement of main() that ensures that argv[0] has a path
+ * and that default fmode and std(in|out|err) are in binary mode
  */
 
 #define main(c,v) dummy_decl_mingw_main(); \
 static int mingw_main(); \
 int main(int argc, const char **argv) \
 { \
+	_fmode = _O_BINARY; \
+	_setmode(_fileno(stdin), _O_BINARY); \
+	_setmode(_fileno(stdout), _O_BINARY); \
+	_setmode(_fileno(stderr), _O_BINARY); \
 	argv[0] = xstrdup(_pgmptr); \
 	return mingw_main(argc, argv); \
 } \
diff --git a/test-genrandom.c b/test-genrandom.c
index 8ad276d..b3c28d9 100644
--- a/test-genrandom.c
+++ b/test-genrandom.c
@@ -4,8 +4,7 @@
  * Copyright (C) 2007 by Nicolas Pitre, licensed under the GPL version 2.
  */
 
-#include <stdio.h>
-#include <stdlib.h>
+#include "git-compat-util.h"
 
 int main(int argc, char *argv[])
 {
-- 
1.6.2.1.418.g33d56.dirty
