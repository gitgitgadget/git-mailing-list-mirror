From: Dennis Stosberg <dennis@stosberg.net>
Subject: Re: [PATCH] Git.pm: Support for perl/ being built by a different compiler
Date: Mon, 26 Jun 2006 10:29:39 +0200
Message-ID: <20060626082939.G215d3ce6@leonov.stosberg.net>
References: <20060625014703.29304.12715.stgit@machine.or.cz> <7vk676orjy.fsf@assigned-by-dhcp.cox.net> <20060626082428.G52c9608e@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 26 10:29:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FumTa-0004vS-7S
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 10:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbWFZI3n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 04:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbWFZI3n
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 04:29:43 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:26069 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S964919AbWFZI3m (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jun 2006 04:29:42 -0400
Received: from leonov.stosberg.net (p213.54.83.220.tisdip.tiscali.de [213.54.83.220])
	by ncs.stosberg.net (Postfix) with ESMTP id EFC42AEBA065;
	Mon, 26 Jun 2006 10:29:37 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id F200C110449; Mon, 26 Jun 2006 10:29:39 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060626082428.G52c9608e@leonov.stosberg.net>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22664>

Sun CC 5.8 fails with a strange error compiling diff-delta.c that
looks like an error in Sun's compiler to me:

$ cc -V
cc: Sun C 5.8 Patch 121015-02 2006/03/29

$ cc -o diff-delta.o -c -I/opt/gnu/include -D__EXTENSIONS__ \
-DSHA1_HEADER='<openssl/sha.h>' -DNO_STRCASESTR -DNO_STRLCPY \
-DNO_SETENV -DNO_UNSETENV diff-delta.c
"diff-delta.c", line 251: identifier redeclared: create_delta
        current : function(pointer to const struct delta_index \
{pointer to const void src_buf, unsigned long src_size, \
unsigned int hash_mask, array[-1] of pointer to struct index_entry {..} hash},\
pointer to const void, unsigned long, pointer to unsigned long, \
unsigned long) returning pointer to void
        previous: function(pointer to const struct delta_index \
{pointer to const void src_buf, unsigned long src_size, \
unsigned int hash_mask, array[-1] of pointer to struct index_entry {..} hash},\
pointer to const void, unsigned long, pointer to unsigned long, \
unsigned long) returning pointer to void : "delta.h", line 37
cc: acomp failed for diff-delta.c
make: *** [diff-delta.o] Error 2

Yes, the two prototypes are identical.  Seems like the compiler has
problems with the opaque struct.  When I played around with it, I
was surprised when I found that Sun CC actually compiled this file
after I removed the const qualifier from the first parameter of the
create_delta() function.  Does anybody have a better explanation
than an error in the compiler?

Regards,
Dennis


diff --git a/delta.h b/delta.h
index 7b3f86d..ec9147c 100644
--- a/delta.h
+++ b/delta.h
@@ -34,11 +34,12 @@ extern void free_delta_index(struct delt
  * must be freed by the caller.
  */
 extern void *
-create_delta(const struct delta_index *index,
+create_delta(struct delta_index *index,
             const void *buf, unsigned long bufsize,
             unsigned long *delta_size, unsigned long max_delta_size);

-/*
+/*l
+
  * diff_delta: create a delta from source buffer to target buffer
  *
  * If max_delta_size is non-zero and the resulting delta is to be larger
diff --git a/diff-delta.c b/diff-delta.c
index 8b9172a..802be76 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -245,7 +245,7 @@ void free_delta_index(struct delta_index
 #define MAX_OP_SIZE    (5 + 5 + 1 + RABIN_WINDOW + 7)

 void *
-create_delta(const struct delta_index *index,
+create_delta(struct delta_index *index,
             const void *trg_buf, unsigned long trg_size,
             unsigned long *delta_size, unsigned long max_size)
 {
