From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Build on Debian GNU/Hurd
Date: Fri, 15 Sep 2006 22:35:57 -0700
Message-ID: <7vr6yce5ky.fsf@assigned-by-dhcp.cox.net>
References: <20060915125846.10469.qmail@ccc765dd61a02d.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 16 07:36:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOSqj-000806-ST
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 07:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWIPFf7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 01:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWIPFf7
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 01:35:59 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:62656 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932179AbWIPFf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Sep 2006 01:35:58 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060916053558.PURQ2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Sat, 16 Sep 2006 01:35:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Ntbz1V00A1kojtg0000000
	Sat, 16 Sep 2006 01:35:59 -0400
To: Gerrit Pape <pape@smarden.org>
In-Reply-To: <20060915125846.10469.qmail@ccc765dd61a02d.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Fri, 15 Sep 2006 12:58:46 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27108>

Gerrit Pape <pape@smarden.org> writes:

> Patch from Cyril Brulebois to make the build process detect and support the
> Debian GNU/Hurd architecture, see
>  http://bugs.debian.org/379841
>
> Signed-off-by: Gerrit Pape <pape@smarden.org>
>
> +ifeq ($(uname_S),GNU)
> +       # GNU stands for GNU/Hurd
> +       NO_STRLCPY = YesPlease
> +       ALL_CFLAGS += -DPATH_MAX=4096
> +endif

Two questions come to mind. (1) Does GNU stand for GNU/Hurd and
nobody else? (2) Does everybody else have PATH_MAX?

Adding NO_STRLCPY I do not have much problems with, but
something like the attached may be cleaner to deal with PATH_MAX;
of course now there is an issue of what the appropriate value
for that symbol should be.

Would including git-compat-util.h in builtin.h break somebody?

-- >8 --
Define fallback PATH_MAX on systems that do not define one in <limits.h>

Notably GNU/Hurd, as reported by Gerrit Pape.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/git-compat-util.h b/git-compat-util.h
index 552b8ec..0272d04 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -26,6 +26,13 @@ #include <netinet/in.h>
 #include <sys/types.h>
 #include <dirent.h>
 
+/* On most systems <limits.h> would have given us this, but
+ * not on some systems (e.g. GNU/Hurd).
+ */
+#ifndef PATH_MAX
+#define PATH_MAX 4096
+#endif
+
 #ifdef __GNUC__
 #define NORETURN __attribute__((__noreturn__))
 #else
diff --git a/builtin.h b/builtin.h
index 34ed7b9..1d41f83 100644
--- a/builtin.h
+++ b/builtin.h
@@ -1,8 +1,7 @@
 #ifndef BUILTIN_H
 #define BUILTIN_H
 
-#include <stdio.h>
-#include <limits.h>
+#include "git-compat-util.h"
 
 extern const char git_version_string[];
 extern const char git_usage_string[];
