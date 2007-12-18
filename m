From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] HP-UX does not have select.h
Date: Mon, 17 Dec 2007 21:29:31 -0800
Message-ID: <7vbq8o370k.fsf@gitster.siamese.dyndns.org>
References: <20071217192306.5da48540@pc09.procura.nl>
	<7v8x3t6nq1.fsf@gitster.siamese.dyndns.org>
	<20071217232259.0b41a3bf@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Dec 18 06:30:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4V1t-0002Mq-R9
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 06:30:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbXLRF3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 00:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbXLRF3p
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 00:29:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46782 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbXLRF3p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 00:29:45 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 181FD2D10;
	Tue, 18 Dec 2007 00:29:39 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 51E832D0E;
	Tue, 18 Dec 2007 00:29:34 -0500 (EST)
In-Reply-To: <20071217232259.0b41a3bf@pc09.procura.nl> (H. Merijn Brand's
	message of "Mon, 17 Dec 2007 23:22:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68700>

"H.Merijn Brand" <h.m.brand@xs4all.nl> writes:

> On Mon, 17 Dec 2007 13:00:22 -0800, Junio C Hamano <gitster@pobox.com> wrote:
>
>> "H.Merijn Brand" <h.m.brand@xs4all.nl> writes:
>> 
>> > HP-UX does not have select.h, but it offers all select () functionality.
>> > The defines are in <sys/types.h> and <X11/fd.h>
>> 
>> Will apply the patch as-is for now, only because I do not want major
>> surgery during rc period, but I think is can be improved.
> ...
>> Besides, isn't _HPUX_SOURCE a feature-test macro?  Feature test macros
>
> That is defined in GNU gcc. I did not pass it with -D...

Actually I changed my mind.  I won't be applying this as is.

For the selective inclusion of <sys/select.h>, I would prefer it see it
done like the attached.

The main point is to limit the "platform" dependency to configure and
Makefile, and keep #ifdef in the actual header files expressed in more
generic terms (e.g. "do we need to (and can we) include sys/select.h
here?").

I am fuzzy about the uname_S part, so I won't be applying the attached
patch either; the attached is for demonstration purposes only.

diff --git a/Makefile b/Makefile
index 617e5f5..f9f724a 100644
--- a/Makefile
+++ b/Makefile
@@ -100,6 +100,9 @@ all::
 #
 # Define NO_DEFLATE_BOUND if your zlib does not have deflateBound.
 #
+# Define NO_SYS_SELECT_H if your C library header files do not have <sys/select.h>
+# but you do have select(2) (pre POSIX.1-2001 systems, e.g. HP-UX before 11.23).
+#
 # Define NO_R_TO_GCC_LINKER if your gcc does not like "-R/path/lib"
 # that tells runtime paths to dynamic libraries;
 # "-Wl,-rpath=/path/lib" is used instead.
@@ -504,6 +507,9 @@ endif
 ifneq (,$(findstring arm,$(uname_M)))
 	ARM_SHA1 = YesPlease
 endif
+ifeq ($(uname_S),HP-UX)
+	NO_SYS_SELECT_H = YesPlease
+endif
 
 -include config.mak.autogen
 -include config.mak
@@ -676,6 +682,10 @@ ifdef NO_DEFLATE_BOUND
 	BASIC_CFLAGS += -DNO_DEFLATE_BOUND
 endif
 
+ifdef NO_SYS_SELECT_H
+	BASIC_CFLAGS += -DNO_SYS_SELECT_H
+endif
+
 ifdef PPC_SHA1
 	SHA1_HEADER = "ppc/sha1.h"
 	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
diff --git a/config.mak.in b/config.mak.in
index 15fb26c..e8890e0 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -44,3 +44,4 @@ NO_MKDTEMP=@NO_MKDTEMP@
 NO_ICONV=@NO_ICONV@
 OLD_ICONV=@OLD_ICONV@
 NO_DEFLATE_BOUND=@NO_DEFLATE_BOUND@
+NO_SYS_SELECT_H=@NO_SYS_SELECT_H@
diff --git a/configure.ac b/configure.ac
index 6f641e3..3bfd0b6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -256,6 +256,8 @@ AC_COMPILE_IFELSE(OLDICONVTEST_SRC,
 	OLD_ICONV=UnfortunatelyYes])
 AC_SUBST(OLD_ICONV)
 
+AC_CHECK_HEADER([sys/select.h], [], [NO_SYS_SELECT_H=YesPlease])
+AC_SUBST(NO_SYS_SELECT_H)
 
 ## Checks for typedefs, structures, and compiler characteristics.
 AC_MSG_NOTICE([CHECKS for typedefs, structures, and compiler characteristics])
diff --git a/git-compat-util.h b/git-compat-util.h
index 79eb10e..ec3585e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -68,7 +68,9 @@
 #include <sys/poll.h>
 #include <sys/socket.h>
 #include <sys/ioctl.h>
+#ifndef NO_SYS_SELECT_H
 #include <sys/select.h>
+#endif
 #include <assert.h>
 #include <regex.h>
 #include <netinet/in.h>
