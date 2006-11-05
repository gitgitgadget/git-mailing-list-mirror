X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/2] Remove SIMPLE_PROGRAMS and make git-daemon a normal program.
Date: Sun, 5 Nov 2006 02:28:25 -0500
Message-ID: <20061105072825.GB4579@spearce.org>
References: <7vveluuzzi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 07:28:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vveluuzzi.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30955>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgcQi-0007Zz-Gp for gcvg-git@gmane.org; Sun, 05 Nov
 2006 08:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161205AbWKEH23 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 02:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161208AbWKEH23
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 02:28:29 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51410 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1161205AbWKEH22
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 02:28:28 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GgcQb-0002Fq-Dh; Sun, 05 Nov 2006 02:28:25 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 5E4EF20E491; Sun,  5 Nov 2006 02:28:25 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Some platforms (Solaris in particular) appear to require -lz as
part of the link line for git-daemon, due to it linking against
sha1_file.o and that module requiring inflate/deflate support.

So its time to retire SIMPLE_PROGRAMS and move its last remaining
member into the standard PROGRAMS list, allowing it to link against
all libraries used by the rest of Git.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 My earlier git-daemon -lz fix, but rewritten to address
 Junio's suggestion of just removing SIMPLE_PROGRAMS...

 Makefile |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index 1cc9f58..7c3860a 100644
--- a/Makefile
+++ b/Makefile
@@ -187,15 +187,12 @@ SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)
 	  $(patsubst %.py,%,$(SCRIPT_PYTHON)) \
 	  git-cherry-pick git-status git-instaweb
 
-# The ones that do not have to link with lcrypto, lz nor xdiff.
-SIMPLE_PROGRAMS = \
-	git-daemon$X
-
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS = \
 	git-convert-objects$X git-fetch-pack$X git-fsck-objects$X \
 	git-hash-object$X git-index-pack$X git-local-fetch$X \
 	git-merge-base$X \
+	git-daemon$X \
 	git-merge-index$X git-mktag$X git-mktree$X git-patch-id$X \
 	git-peek-remote$X git-receive-pack$X \
 	git-send-pack$X git-shell$X \
@@ -217,7 +214,7 @@ BUILT_INS = \
 	$(patsubst builtin-%.o,git-%$X,$(BUILTIN_OBJS))
 
 # what 'all' will build and 'install' will install, in gitexecdir
-ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS) \
+ALL_PROGRAMS = $(PROGRAMS) $(SCRIPTS) \
 	git-merge-recur$X
 
 # Backward compatibility -- to be removed after 1.0
@@ -486,11 +483,9 @@ ifdef NEEDS_LIBICONV
 endif
 ifdef NEEDS_SOCKET
 	EXTLIBS += -lsocket
-	SIMPLE_LIB += -lsocket
 endif
 ifdef NEEDS_NSL
 	EXTLIBS += -lnsl
-	SIMPLE_LIB += -lnsl
 endif
 ifdef NO_D_TYPE_IN_DIRENT
 	BASIC_CFLAGS += -DNO_D_TYPE_IN_DIRENT
@@ -737,11 +732,6 @@ endif
 git-%$X: %.o $(GITLIBS)
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
-$(SIMPLE_PROGRAMS) : $(LIB_FILE)
-$(SIMPLE_PROGRAMS) : git-%$X : %.o
-	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(LIB_FILE) $(SIMPLE_LIB)
-
 ssh-pull.o: ssh-fetch.c
 ssh-push.o: ssh-upload.c
 git-local-fetch$X: fetch.o
-- 
