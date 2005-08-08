From: Junio C Hamano <junkio@cox.net>
Subject: Re: A simple script to do the reverse of git-push
Date: Mon, 08 Aug 2005 15:42:36 -0700
Message-ID: <7vslxk125f.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508082318400.2911@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 00:44:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2GKS-0003Zo-Gw
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 00:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbVHHWmj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 18:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbVHHWmj
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 18:42:39 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:5007 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932324AbVHHWmi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 18:42:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050808224237.HKAV17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 Aug 2005 18:42:37 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508082318400.2911@wgmdd8.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 8 Aug 2005 23:25:49 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> BTW, if you are lazy, like me, you just pull from Junio once in a while 
> and do a "make test". Turns out there is a missing dependency though:
>
> peek-remote.o: cache.h
>
> which in my case lead to a git-peek-remote program which was unable to 
> peek any ref.

You are right.  Thanks for noticing.

    $ (make clean ; make ) >/dev/null 2>/dev/null
    $ touch cache.h
    $ make 2>&1 | grep peek-remote
    cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' -o git-peek-remote peek-remote.o libgit.a -lz -lcrypto

I think recent "depend on object files" Makefile patch broke
some things.

We would need something like this.
---
# - pu: ls-remote: drop storing operation and add documentation.
# + (working tree)
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -172,6 +172,7 @@ init-db.o: init-db.c
 	$(CC) -c $(CFLAGS) -DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir)"' $*.c
 
 $(LIB_OBJS): $(LIB_H)
+$(patsubst git-%,%.o,$(PROG)): $(LIB_H)
 $(DIFF_OBJS): diffcore.h
 
 $(LIB_FILE): $(LIB_OBJS)
