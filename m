From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: If NEEDS_LIBICONV is set for Solaris 8, it does not build git for
	me
Date: Sun, 22 Jul 2007 12:40:45 +0200
Message-ID: <20070722104045.GF4760@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Riedy <ejr@EECS.Berkeley.EDU>, Paul Jakma <paul@clubi.ie>
To: Junio C Hamano <gitster@pobox.com>, GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 22 12:40:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICYru-0003MW-Gb
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 12:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755957AbXGVKkt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 06:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756154AbXGVKkt
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 06:40:49 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:58580 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754999AbXGVKkr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jul 2007 06:40:47 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id D5CC13F425; Sun, 22 Jul 2007 12:40:45 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53246>

Hello Junio,

     [ Paul and Jason CCed because they touched that section last ]

Patch is appended at the very bottom of the E-Mail. I have a fully
patched Solaris 8 with Forte 11. In order to get git compile I had to
delete the

	NEEDS_LIBICONV = YesPlease

line from the Makefile in the Solaris 8 section. After my patch the
section in the Makefile looks like that:

        ifeq ($(uname_R),5.8)
                NO_UNSETENV = YesPlease
                NO_SETENV = YesPlease
                NO_C99_FORMAT = YesPlease
                NO_STRTOUMAX = YesPlease
        endif
        ifeq ($(uname_R),5.9)
                NO_UNSETENV = YesPlease
                NO_SETENV = YesPlease
                NO_C99_FORMAT = YesPlease
                NO_STRTOUMAX = YesPlease
        endif

As you can see _after_ my patch the secion for 5.8 and 5.9 is the same.
So I wonder if it is possible to merge this two sections. But I have no
idea how to do that in the makefile language. I tried to remove other
flags for 5.8, too but it always resulted in built break so all other
flags are necessary.

----8<---- cut here ----8<---- cut here ----8<---- cut here ----8<----

The following issue as _absolutly_ nothing todo with the above and is
here only for completeness. In order to get git to compile with Forte 11
you have to work around a compiler bug in Forte 11. Forte 11 chokes
sometimes when function arguments are declared as static (I raised this
topic before even on this list). I guess that I will also file a bug
against forte 11 tomorrow. The symptom is:

    CC diff-delta.o
"diff-delta.c", line 248: identifier redeclared: create_delta
        current : function(pointer to const struct delta_index {pointer to const void src_buf, unsigned long src_size, unsigned int hash_mask, array[-1] of pointer to struct index_entry {..} hash}, pointer to const void, unsigned long, pointer to unsigned long, unsigned long) returning pointer to void
        previous: function(pointer to const struct delta_index {pointer to const void src_buf, unsigned long src_size, unsigned int hash_mask, array[-1] of pointer to struct index_entry {..} hash}, pointer to const void, unsigned long, pointer to unsigned long, unsigned long) returning pointer to void : "delta.h", line 37
cc: acomp failed for diff-delta.c
gmake[1]: *** [diff-delta.o] Error 2

As you can see Forte 11 is complaining that the protype is different to
the function. But it is not they absolut identical. And here is the
workaround which should _not_ be commited because it is just wrong. It
removes the const flags from the function arguments which results in lot
of warnings but does compile git with Forte 11.

--- a/diff-delta.c
+++ b/diff-delta.c
@@ -242,8 +242,8 @@
 #define MAX_OP_SIZE	(5 + 5 + 1 + RABIN_WINDOW + 7)
 
 void *
-create_delta(const struct delta_index *index,
-	     const void *trg_buf, unsigned long trg_size,
+create_delta(struct delta_index *index,
+	     void *trg_buf, unsigned long trg_size,
 	     unsigned long *delta_size, unsigned long max_size)
 {
 	unsigned int i, outpos, outsize, val;
--- a/delta.h
+++ b/delta.h
@@ -34,8 +34,8 @@
  * must be freed by the caller.
  */
 extern void *
-create_delta(const struct delta_index *index,
-	     const void *buf, unsigned long bufsize,
+create_delta(struct delta_index *index,
+	     void *buf, unsigned long bufsize,
 	     unsigned long *delta_size, unsigned long max_delta_size);
 
 /*

----8<---- cut here ----8<---- cut here ----8<---- cut here ----8<----

	Thomas

>From 14a4e0245c32c73a8a2dbd1763a23b8b69f8844d Mon Sep 17 00:00:00 2001
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Date: Sun, 22 Jul 2007 12:14:14 +0200
Subject: [PATCH] Don't set NEEDS_LIBICONV for Solaris 8

I use a fully patched Solaris 8 with SUNs Forte 11 Compiler which is also fully
patched. If NEEDS_LIBICONV is set to YesPlease the compile fails for me with:

    AR xdiff/lib.a
    LINK git-convert-objects
ld: fatal: library -liconv: not found
ld: fatal: File processing errors. No output written to git-convert-objects
gmake[1]: *** [git-convert-objects] Error 1

Without the NEEDS_LIBICONV set it simply builds.
---
 Makefile |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 73b487f..1c294ca 100644
--- a/Makefile
+++ b/Makefile
@@ -401,7 +401,6 @@ ifeq ($(uname_S),SunOS)
 	NO_STRCASESTR = YesPlease
 	NO_HSTRERROR = YesPlease
 	ifeq ($(uname_R),5.8)
-		NEEDS_LIBICONV = YesPlease
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
 		NO_C99_FORMAT = YesPlease
-- 
1.5.2.3
