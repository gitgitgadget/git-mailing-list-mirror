From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Under NO_OPENSSL -lssl should not be used
Date: Fri, 29 Jul 2005 22:02:24 -0700
Message-ID: <7vek9g6g4f.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050729085819.GL24895@pasky.ji.cz>
	<20050729155051.GJ21909@pasky.ji.cz>
	<Pine.LNX.4.58.0507292038160.29650@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 07:03:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyjVG-0001xM-Lk
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 07:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262717AbVG3FC2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jul 2005 01:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbVG3FC2
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jul 2005 01:02:28 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:11168 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S262717AbVG3FC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2005 01:02:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050730050227.RRRP7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 30 Jul 2005 01:02:27 -0400
To: Petr Baudis <pasky@suse.cz>, Jon Seymour <jon.seymour@gmail.com>
In-Reply-To: <Pine.LNX.4.58.0507292038160.29650@g5.osdl.org> (Linus Torvalds's message of "Fri, 29 Jul 2005 20:39:56 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> This doesn't work at least in the form that Junio merged it (and from 
> what I can tell, he merged your patch as-is):
>
>   torvalds@shell0:~/src/git> make NO_OPENSSL=1
>   cc -g -O2 -Wall '-DNO_OPENSSL' '-DSHA1_HEADER="mozilla-sha1/sha1.h"' -o git-rev-list rev-list.o libgit.a -lz -lssl
>   /usr/lib/gcc-lib/i586-suse-linux/3.3.4/../../../../i586-suse-linux/bin/ld: cannot find -lssl
>
> it needs to disable the -lssl too..

Would this be OK?  I think it is ugly but it gets the job done.

Jon, do we really need bignum to do the flow computation?  From
a quick glance, it appears to me that the fraction manipulation
part is quite well isolated.  Do you think adding the support
for using other bignum implementation be reasonable (assuming
you do need to use bignum based fraction)?

------------
This is quick and dirty but under NO_OPENSSL we should not
attempt to link with -lssl (nor -lcrypto).

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
cd /opt/packrat/playpen/public/in-place/git/git.junio/
jit-diff
# - pu: Fetch from a packed repository on dumb servers.
# + (working tree)
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -108,9 +108,11 @@ LIBS += -lz
 
 ifndef NO_OPENSSL
 	LIB_OBJS += epoch.o
+	OPENSSL_LIBSSL=-lssl
 else
 	CFLAGS += '-DNO_OPENSSL'
 	MOZILLA_SHA1=1
+	OPENSSL_LIBSSL=
 endif
 ifdef MOZILLA_SHA1
   SHA1_HEADER="mozilla-sha1/sha1.h"
@@ -148,7 +150,7 @@ git-ssh-pull: rsh.o pull.o
 git-ssh-push: rsh.o
 
 git-http-pull: LIBS += -lcurl
-git-rev-list: LIBS += -lssl
+git-rev-list: LIBS += $(OPENSSL_LIBSSL)
 
 $(LIB_OBJS): $(LIB_H)
 $(DIFF_OBJS): diffcore.h

Compilation finished at Fri Jul 29 21:48:01
