From: Alex Riesen <raa.lkml@gmail.com>
Subject: cygwin-latest: compile errors related to sockaddr_storage, dirent->d_type and dirent->d_ino
Date: Wed, 18 Jan 2006 14:47:00 +0100
Message-ID: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_19720_27216453.1137592020560"
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jan 18 14:47:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzDeU-0002lH-LF
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 14:47:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbWARNrD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 08:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbWARNrD
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 08:47:03 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:31280 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030308AbWARNrD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2006 08:47:03 -0500
Received: by uproxy.gmail.com with SMTP id s2so318398uge
        for <git@vger.kernel.org>; Wed, 18 Jan 2006 05:47:00 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=iA1sNXcmkkiWBQDxZpOuqFWBRrvou09lB1c2+ikB+uEeMrYJaMLJOpHiHpqavxq8pQ1iwrrh82azBXCSHk6tgEkyLY4S203Z5flRtbpy6WuxWYkNplwIVhs5Ja5HGocrvVlJgJ+U6/bJAZ1ldozfwxZnXO5uXvoULL0zG5Lk6Ak=
Received: by 10.48.202.9 with SMTP id z9mr443572nff;
        Wed, 18 Jan 2006 05:47:00 -0800 (PST)
Received: by 10.48.248.4 with HTTP; Wed, 18 Jan 2006 05:47:00 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14823>

------=_Part_19720_27216453.1137592020560
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

For reasons unknown, cygwin decided to use our sockaddr_storage.
As it is redefined to sockaddr_in it'd cause compilation errors in
cygwin headers. Fixed by first patch, which uses a more git-related
name (can we claim rights for the symbol, being first to use it? :-)

For the other, probably unrelated, reasons, they decided to leave
declarations of DT_* macros in dirent.h without providing dirent->d_type.
This is what NO_DTYPE in the 0002-patch is all about.

And on top of that, they removed dirent->d_ino (or probably replaced
it by __ino32, if at all).
BTW, can we somehow avoid using d_ino? It is referenced only in fsck-object=
s.c
Anyway, to workaround this I put

  COMPAT_CFLAGS +=3D -Dd_ino=3D__ino32

It helps, but surely is not the solution.

P.S. For all you poor souls on Win2k, my config.mak contains:

  NO_MMAP =3D YesPlease
  NO_DTYPE =3D YesPlease
  COMPAT_CFLAGS +=3D -Dd_ino=3D__ino32

Just to make it work (at least it's enough for me, even the tests run...)

------=_Part_19720_27216453.1137592020560
Content-Type: text/plain; name=0001-fix-compilation-of-sockaddr_storage.txt; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="0001-fix-compilation-of-sockaddr_storage.txt"

>From nobody Mon Sep 17 00:00:00 2001
From: Alex Riesen <raa.lkml@gmail.com>
Date: Wed Jan 18 14:02:54 2006 +0100
Subject: fix compilation of sockaddr_storage

---

 Makefile |    2 +-
 daemon.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

59379c380a6c2829c5614aadd4a5492abb8d14c8
diff --git a/Makefile b/Makefile
index f6d9e0a..5782e2a 100644
--- a/Makefile
+++ b/Makefile
@@ -342,7 +342,7 @@ ifdef NO_MMAP
 	COMPAT_OBJS += compat/mmap.o
 endif
 ifdef NO_IPV6
-	ALL_CFLAGS += -DNO_IPV6 -Dsockaddr_storage=sockaddr_in
+	ALL_CFLAGS += -DNO_IPV6 -Dsockaddr_stg_git=sockaddr_in
 endif
 
 ifdef PPC_SHA1
diff --git a/daemon.c b/daemon.c
index bb014fa..b424e5e 100644
--- a/daemon.c
+++ b/daemon.c
@@ -277,7 +277,7 @@ static unsigned int children_deleted = 0
 static struct child {
 	pid_t pid;
 	int addrlen;
-	struct sockaddr_storage address;
+	struct sockaddr_stg_git address;
 } live_child[MAX_CHILDREN];
 
 static void add_child(int idx, pid_t pid, struct sockaddr *addr, int addrlen)
@@ -578,7 +578,7 @@ static int service_loop(int socknum, int
 
 		for (i = 0; i < socknum; i++) {
 			if (pfd[i].revents & POLLIN) {
-				struct sockaddr_storage ss;
+				struct sockaddr_stg_git ss;
 				unsigned int sslen = sizeof(ss);
 				int incoming = accept(pfd[i].fd, (struct sockaddr *)&ss, &sslen);
 				if (incoming < 0) {
-- 
1.1.2-ge577




------=_Part_19720_27216453.1137592020560
Content-Type: text/plain; name=0002-fix-compilation-of-dirent-d_type.txt; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="0002-fix-compilation-of-dirent-d_type.txt"

>From nobody Mon Sep 17 00:00:00 2001
From: Alex Riesen <raa.lkml@gmail.com>
Date: Wed Jan 18 14:04:34 2006 +0100
Subject: fix compilation of dirent->d_type

---

 Makefile |    3 +++
 cache.h  |   10 +++++++++-
 2 files changed, 12 insertions(+), 1 deletions(-)

5232f9128ad9d10368525fe709954acc2d6f49b3
diff --git a/Makefile b/Makefile
index 5782e2a..c3bae0f 100644
--- a/Makefile
+++ b/Makefile
@@ -329,6 +329,9 @@ ifdef NEEDS_NSL
 	LIBS += -lnsl
 	SIMPLE_LIB += -lnsl
 endif
+ifdef NO_DTYPE
+	COMPAT_CFLAGS += -DNO_DTYPE
+endif
 ifdef NO_STRCASESTR
 	COMPAT_CFLAGS += -DNO_STRCASESTR
 	COMPAT_OBJS += compat/strcasestr.o
diff --git a/cache.h b/cache.h
index 29c9e81..3846fb9 100644
--- a/cache.h
+++ b/cache.h
@@ -10,13 +10,21 @@
 #define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
 #endif
 
-#ifdef DT_UNKNOWN
+#ifndef NO_DTYPE
 #define DTYPE(de)	((de)->d_type)
 #else
+#ifndef DT_UNKNOWN
 #define DT_UNKNOWN	0
+#endif
+#ifndef DT_DIR
 #define DT_DIR		1
+#endif
+#ifndef DT_REG
 #define DT_REG		2
+#endif
+#ifndef DT_LNK
 #define DT_LNK		3
+#endif
 #define DTYPE(de)	DT_UNKNOWN
 #endif
 
-- 
1.1.2-ge577



------=_Part_19720_27216453.1137592020560--
