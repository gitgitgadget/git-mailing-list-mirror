From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git and announcing v1.4.1-rc1
Date: Thu, 22 Jun 2006 15:38:42 -0700
Message-ID: <7vsllwhl3h.fsf@assigned-by-dhcp.cox.net>
References: <7v8xnpj7hg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606221301500.5498@g5.osdl.org>
	<7v7j38j144.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 23 00:38:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtXp0-00019s-Jp
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 00:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWFVWio (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 18:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932660AbWFVWio
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 18:38:44 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:12463 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932181AbWFVWin (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 18:38:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060622223842.ZEFE5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Jun 2006 18:38:42 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v7j38j144.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 22 Jun 2006 15:07:23 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22381>

Junio C Hamano <junkio@cox.net> writes:

> Well, I admit I do not use colorized diffs myself.  As a matter
> of fact, I use specialized terminfo to disable coloring on my
> terminal session, since fontifying in GNUS otherwise gives me
> unreadable screen and I am too lazy to figure out how to turn it
> off.
>
> I do however usually test colored stuff with at least white and
> black backgrounds,

By the way, in the ancient history, in commit 3443546 you did:

--- a/Makefile
+++ b/Makefile
@@ -544,12 +545,18 @@ init-db.o: init-db.c
                -DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"' $*.c

 $(LIB_OBJS): $(LIB_H)
-$(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H)
+$(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIBS)
 $(DIFF_OBJS): diffcore.h

 $(LIB_FILE): $(LIB_OBJS)
        $(AR) rcs $@ $(LIB_OBJS)

which we kept until today.  This causes checkout-index.o and
friends to be recompiled when we touch diff.c (I do not mind
relinking git-checkout-index because libgit.a has changed, but
recompiling checkout-index.c is unneeded).  I think this was
done to make sure anything that includes xdiff/*.h files via
"xdiff-interface.h" are recompiled when xdiff/*.h are changed,
so I am thinking about loosening it a bit to depend on our
headers and xdiff/*.h headers, perhaps like this:

diff --git a/Makefile b/Makefile
index a5b6784..e29e3fa 100644
--- a/Makefile
+++ b/Makefile
@@ -582,7 +582,7 @@ git-http-push$X: revision.o http.o http-
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
-$(patsubst git-%$X,%.o,$(PROGRAMS)): $(GITLIBS)
+$(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H) $(wildcard */*.h)
 $(DIFF_OBJS): diffcore.h
 
 $(LIB_FILE): $(LIB_OBJS)
diff --git a/diff.c b/diff.c
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
