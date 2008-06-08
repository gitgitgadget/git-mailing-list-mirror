From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: [PATCH] Port to 12 other Platforms.
Date: Sun, 8 Jun 2008 14:47:54 -0600
Message-ID: <Pine.LNX.4.64.0806081443130.18454@xenau.zenez.com>
References: <Pine.LNX.4.64.0806080926240.18454@xenau.zenez.com>
 <m3prqsvsiq.fsf@localhost.localdomain> <Pine.LNX.4.64.0806080959390.18454@xenau.zenez.com>
 <7vhcc3kbdw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 22:48:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5Ron-00020F-Az
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 22:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511AbYFHUr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 16:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754490AbYFHUr4
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 16:47:56 -0400
Received: from zenez.com ([166.70.62.2]:28296 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754478AbYFHUrz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 16:47:55 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id 91A8DE6048; Sun,  8 Jun 2008 14:47:54 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id 80919E6045;
	Sun,  8 Jun 2008 14:47:54 -0600 (MDT)
In-Reply-To: <7vhcc3kbdw.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84317>

On Sun, 8 Jun 2008, Junio C Hamano wrote:
>  * Justification for the patch.  When anybody views with "git show" the
>    change after it gets committed, "how" the patch changes can be seen,
>    but what cannot be easily seen is "why", and the commit message is the
>    place to describe it.  This takes various forms, depending on the
>    nature of the patch:
> 
>    * For a fix, describe how the status-quo is broken, what the desired
>      behaviour should be, and discuss and defend why you chose this
>      specific approach to fix among other possible avenues.  E.g. "If you
>      use this and that option together, the command does this, which is
>      not correct.  It should do that instead.  For that, we introduce
>      helper function X and Y use them in each codepaths.  We could instead
>      use a single helper that does X or Y depending on an option but these
>      two codepaths are likely to evolve into doing even more different
>      things, and using separate functions would be cleaner."
> 
>    * For an enhancement, describe in what situation the new feature is
>      useful, defend why that use case is worth supporting, state how
>      awkward (or perhaps impossible) to do the same thing is with the
>      current set of features, and discuss and defend why you chose this
>      specific approach to fix the awkwardness among other possibilities.
>      E.g. "This adds a new feature X that works like this.  When you have
>      Y and want to arrive at Z, with the current set of commands you would
>      need to do W, but...".
...
> "..., both of these shouldn't have" however could even be more helpful if
> it was stated like "On these platforms, defining _XOPEN_SOURCE hides
> definitions of X, Y and Z that we use, which is not what we want.", for
> people who would want to know what specific breakage the change addresses.
> 
> It would change "Ok, somebody with SCO systems says this patch fixes
> things for him" to "I see, if _XOPEN_SOURCE over there makes *that*
> function unavailable, then we definitely shouldn't have _XOPEN_SOURCE
> defined at this point of the header file".  IOW, it makes "Ok, I trust the
> guy's judgement, even though the details are fuzzy to me" into "Ok, I
> agree with his judgement".

So the patch should be

From: Boyd Lynn Gerber <gerberb@zenez.com>
Date: Sun, 8 Jun 2008 11:41:46 -0600
[PATCH] Port to 12 other Platforms.

This patch adds support to compile and run git on 12 additional platforms.
The platforms are based on UNIX Systems Labs (USL)/Novell/SYS V code base.
The most common are Novell UnixWare 2.X.X, SCO UnixWare 7.X.X,
OpenServer 5.0.X, OpenServer 6.0.X, and SCO pre OSR 5 platforms.

This is from

# 1 "/usr/include/netinet/tcp_f.h"

The problem is that git source  has blocked some typedefs
by excluding certain <sys/types.h> content.

Looking at the the various platform header, I see around line 450

#if defined(_KERNEL) || !defined(_POSIX_SOURCE) \
     && !defined(_POSIX_C_SOURCE) && !defined(_XOPEN_SOURCE)

The git source is covering the u_short typedef line and other typedefs
are also covered in the platforms.  They all lead back to the above
which comes from

git-compat-util.h

about line 66.  I had to make the following changes

#if !defined(__APPLE__) && !defined(__FreeBSD__)  && !defined(__USLC__) && !defined(_M_UNIX)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif

The _XOPEN_SOURCE hides many typedefs.

__USLC__ indicates UNIX System Labs Corperation (USLC), or a Novell-derived
compiler and/or some SysV based OS's.

__M_UNIX indicates XENIX/SCO UNIX/OpenServer 5.0.7 and prior releases
of the SCO OS's.  It is used just like Apple and BSD, both of these
shouldn't have _XOPEN_SOURCE defined.

This is with suggestions and modifications from

Daniel Barkalow <barkalow@iabervon.org>
Junio C Hamano <gitster@pobox.com>
Thomas Harning <harningt@gmail.com>
Jeremy Maitin-Shepard <jbms@cmu.edu>

Signed-off-by: Boyd Lynn Gerber <gerberb@zenez.com>

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047

---
        Developer's Certificate of Origin 1.1

        By making a contribution to this project, I certify that:

        (a) The contribution was created in whole or in part by me and I
            have the right to submit it under the open source license
            indicated in the file; or

        (b) The contribution is based upon previous work that, to the best
            of my knowledge, is covered under an appropriate open source
            license and I have the right under that license to submit that
            work with modifications, whether created in whole or in part
            by me, under the same open source license (unless I am
            permitted to submit under a different license), as indicated
            in the file; or

        (c) The contribution was provided directly to me by some other
            person who certified (a), (b) or (c) and I have not modified
            it.

        (d) I understand and agree that this project and the contribution
            are public and that a record of the contribution (including all
            personal information I submit with it, including my sign-off) is
            maintained indefinitely and may be redistributed consistent with
            this project or the open source license(s) involved.

---
git-compat-util.h

__USLC__ indicates UNIX System Labs Corperation (USLC), or a Novell-derived
compiler and/or some SysV based OS's.

__M_UNIX indicates XENIX/SCO UNIX/OpenServer 5.0.7 and prior releases
of the SCO OS's.  It is used just like Apple and BSD, both of these
shouldn't have _XOPEN_SOURCE defined.

diff --git a/Makefile b/Makefile
index cce5a6e..026de2f 100644
--- a/Makefile
+++ b/Makefile
@@ -564,6 +564,45 @@ endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	NO_STRLCPY = YesPlease
 endif
+ifeq ($(uname_S),UnixWare)
+	CC=cc
+	NEEDS_SOCKET = YesPlease
+	NEEDS_NSL = YesPlease
+	NEEDS_SSL_WITH_CRYPTO = YesPlease
+	NEEDS_LIBICONV = YesPlease
+	SHELL_PATH = /usr/local/bin/bash
+	NO_IPV6 = YesPlease
+	NO_HSTRERROR = YesPlease
+	BASIC_CFLAGS += -Kthread
+	BASIC_CFLAGS += -I/usr/local/include
+	BASIC_LDFLAGS += -L/usr/local/lib
+	INSTALL = ginstall
+	TAR = gtar
+	NO_STRCASESTR = YesPlease
+	NO_MEMMEM = YesPlease
+endif
+ifeq ($(uname_S),SCO_SV)
+	ifeq ($(uname_R),3.2)
+		CFLAGS = -O2
+	endif
+	ifeq ($(uname_R),5)
+		CC=cc
+		BASIC_CFLAGS += -Kthread
+	endif
+	NEEDS_SOCKET = YesPlease
+	NEEDS_NSL = YesPlease
+	NEEDS_SSL_WITH_CRYPTO = YesPlease
+	NEEDS_LIBICONV = YesPlease
+	SHELL_PATH = /usr/bin/bash
+	NO_IPV6 = YesPlease
+	NO_HSTRERROR = YesPlease
+	BASIC_CFLAGS += -I/usr/local/include
+	BASIC_LDFLAGS += -L/usr/local/lib
+	NO_STRCASESTR = YesPlease
+	NO_MEMMEM = YesPlease
+	INSTALL = ginstall
+	TAR = gtar
+endif
 ifeq ($(uname_S),Darwin)
 	NEEDS_SSL_WITH_CRYPTO = YesPlease
 	NEEDS_LIBICONV = YesPlease
diff --git a/git-compat-util.h b/git-compat-util.h
index 01c4045..c04e8ba 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -39,7 +39,7 @@
 /* Approximation of the length of the decimal representation of this type. */
 #define decimal_length(x)	((int)(sizeof(x) * 2.56 + 0.5) + 1)
 
-#if !defined(__APPLE__) && !defined(__FreeBSD__)
+#if !defined(__APPLE__) && !defined(__FreeBSD__)  && !defined(__USLC__) && !defined(_M_UNIX)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
-- 
1.5.2.4
