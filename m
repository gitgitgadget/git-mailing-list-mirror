From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Do not use GUID on dir in git init --shared=all on FreeBSD
Date: Wed, 5 Mar 2008 00:15:39 +0100
Message-ID: <20080304231539.GA8085@limbo.localdomain>
References: <20080303234406.GA28158@steel.home> <7v1w6rfhyn.fsf@gitster.siamese.dyndns.org> <20080304072519.GA3070@steel.home> <7vir02ap3b.fsf@gitster.siamese.dyndns.org> <20080304202047.GC3295@steel.home> <7vr6eq43te.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 00:48:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWgs6-0003mu-0v
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 00:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761907AbYCDXrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 18:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754506AbYCDXrz
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 18:47:55 -0500
Received: from mo-p07-fb.rzone.de ([81.169.146.191]:26427 "EHLO
	mo-p07-fb.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754030AbYCDXry (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 18:47:54 -0500
X-Greylist: delayed 1935 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Mar 2008 18:47:54 EST
Received: from mo-p07-ob.rzone.de (klopstock-mo-p07-ob.mail [192.168.63.178])
	by charnel-fb-04.store (RZmta 16.9) with ESMTP id R043e5k24LBfbH
	for <git@vger.kernel.org>; Wed, 5 Mar 2008 00:17:04 +0100 (MET)
	(envelope-from: <fork0@users.sourceforge.net>)
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtoAegw==
Received: from tigra.home (Faa57.f.strato-dslnet.de [195.4.170.87])
	by post.webmailer.de (klopstock mo10) (RZmta 16.8)
	with ESMTP id 903f14k24JQrVJ ; Wed, 5 Mar 2008 00:15:37 +0100 (MET)
	(envelope-from: <fork0@users.sourceforge.net>)
Received: from limbo (unknown [192.168.0.1])
	by tigra.home (Postfix) with ESMTP id F05B9277BD;
	Wed,  5 Mar 2008 00:15:36 +0100 (CET)
Received: by limbo (Postfix, from userid 1000)
	id 841C417A5C; Wed,  5 Mar 2008 00:15:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vr6eq43te.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76156>

It does not allow changing the bit to a non-root user.
This fixes t1301-shared-repo.sh on the platform.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Junio C Hamano, Tue, Mar 04, 2008 21:44:29 +0100:
> (2) In Makefile (and configure.in perhaps)

Just the configure.ac is a bit too much for today.

>     ifeq ($(uname_S),FreeBSD)
>     	MKDIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
>     endif
>     ...
>     ifdef MKDIR_HAS_BSD_GROUP_SEMANTICS
>         COMPAT_CFLAGS += -DMKDIR_HAS_BSD_GROUP_SEMANTICS
>     endif

I tweaked the names a bit.

 Makefile          |    4 ++++
 git-compat-util.h |    6 ++++++
 path.c            |    2 +-
 3 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index ca5aad9..6e857e6 100644
--- a/Makefile
+++ b/Makefile
@@ -478,6 +478,7 @@ ifeq ($(uname_S),FreeBSD)
 	NO_MEMMEM = YesPlease
 	BASIC_CFLAGS += -I/usr/local/include
 	BASIC_LDFLAGS += -L/usr/local/lib
+	DIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
 endif
 ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR = YesPlease
@@ -747,6 +748,9 @@ ifdef THREADED_DELTA_SEARCH
 	EXTLIBS += -lpthread
 	LIB_OBJS += thread-utils.o
 endif
+ifdef DIR_HAS_BSD_GROUP_SEMANTICS
+	COMPAT_CFLAGS += -DDIR_HAS_BSD_GROUP_SEMANTICS
+endif
 
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK=NoThanks
diff --git a/git-compat-util.h b/git-compat-util.h
index 2a40703..5912443 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -437,4 +437,10 @@ void git_qsort(void *base, size_t nmemb, size_t size,
 #define qsort git_qsort
 #endif
 
+#ifndef DIR_HAS_BSD_GROUP_SEMANTICS
+# define FORCE_DIR_SET_GID S_ISGID
+#else
+# define FORCE_DIR_SET_GID 0
+#endif
+
 #endif
diff --git a/path.c b/path.c
index af27161..f4ed979 100644
--- a/path.c
+++ b/path.c
@@ -283,7 +283,7 @@ int adjust_shared_perm(const char *path)
 			    ? (S_IXGRP|S_IXOTH)
 			    : 0));
 	if (S_ISDIR(mode))
-		mode |= S_ISGID;
+		mode |= FORCE_DIR_SET_GID;
 	if ((mode & st.st_mode) != mode && chmod(path, mode) < 0)
 		return -2;
 	return 0;
-- 
1.5.4.3.272.gf0c3

