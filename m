From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] fsck-objects: support platforms without d_ino in struct dirent.
Date: Thu, 19 Jan 2006 17:13:51 -0800
Message-ID: <7vu0bz7lbk.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com>
	<20060119052914.GC8121@trixie.casa.cgf.cx>
	<7vlkxciodu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christopher Faylor <me@cgf.cx>
X-From: git-owner@vger.kernel.org Fri Jan 20 02:14:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ezkqm-0001V9-2B
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 02:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422711AbWATBN5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 20:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030445AbWATBN5
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 20:13:57 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:42688 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1030438AbWATBN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 20:13:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060120011157.TICR17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 Jan 2006 20:11:57 -0500
To: Alex Riesen <raa.lkml@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14950>

The d_ino field is only used for performance reasons in
fsck-objects.  On a typical filesystem, i-number tends to have a
strong correlation with where the actual bits sit on the disk
platter, and we sort the entries to allow us scan things that
ought to be close together together.

If the platform lacks support for it, it is not a big deal.
Just do not use d_ino for sorting, and scan them unsorted.

---

    Junio C Hamano <junkio@cox.net> writes:

    > ...  I'll see how we would
    > work this around on the git side to make things more portable.

 Makefile       |    6 ++++++
 fsck-objects.c |   13 +++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

4bec2123116a92fbeae12afc70317dfc85f6087b
diff --git a/Makefile b/Makefile
index e8f4b24..31898f7 100644
--- a/Makefile
+++ b/Makefile
@@ -19,6 +19,8 @@ all:
 # Define NO_EXPAT if you do not have expat installed.  git-http-push is
 # not built, and you cannot push using http:// and https:// transports.
 #
+# Define NO_D_INO_IN_DIRENT if you don't have d_ino in your struct dirent.
+#
 # Define NO_STRCASESTR if you don't have strcasestr.
 #
 # Define NO_SETENV if you don't have setenv in the C library.
@@ -231,6 +233,7 @@ ifeq ($(uname_S),SunOS)
 	ALL_CFLAGS += -D__EXTENSIONS__
 endif
 ifeq ($(uname_O),Cygwin)
+	NO_D_INO_IN_DIRENT = YesPlease
 	NO_STRCASESTR = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	# There are conflicting reports about this.
@@ -332,6 +335,9 @@ ifdef NEEDS_NSL
 	LIBS += -lnsl
 	SIMPLE_LIB += -lnsl
 endif
+ifdef NO_D_INO_IN_DIRENT
+	ALL_CFLAGS += -DNO_D_INO_IN_DIRENT
+endif
 ifdef NO_STRCASESTR
 	COMPAT_CFLAGS += -DNO_STRCASESTR
 	COMPAT_OBJS += compat/strcasestr.o
diff --git a/fsck-objects.c b/fsck-objects.c
index 90e638e..9950be2 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -20,6 +20,13 @@ static int check_strict = 0;
 static int keep_cache_objects = 0; 
 static unsigned char head_sha1[20];
 
+#if NO_D_INO_IN_DIRENT
+#define SORT_DIRENT 0
+#define DIRENT_SORT_HINT(de) 0
+#else
+#define SORT_DIRENT 1
+#define DIRENT_SORT_HINT(de) ((de)->d_ino)
+#endif
 
 static void objreport(struct object *obj, const char *severity,
                       const char *err, va_list params)
@@ -307,7 +314,9 @@ static void fsck_sha1_list(void)
 {
 	int i, nr = sha1_list.nr;
 
-	qsort(sha1_list.entry, nr, sizeof(struct sha1_entry *), ino_compare);
+	if (SORT_DIRENT)
+		qsort(sha1_list.entry, nr,
+		      sizeof(struct sha1_entry *), ino_compare);
 	for (i = 0; i < nr; i++) {
 		struct sha1_entry *entry = sha1_list.entry[i];
 		unsigned char *sha1 = entry->sha1;
@@ -361,7 +370,7 @@ static int fsck_dir(int i, char *path)
 			memcpy(name+2, de->d_name, len+1);
 			if (get_sha1_hex(name, sha1) < 0)
 				break;
-			add_sha1_list(sha1, de->d_ino);
+			add_sha1_list(sha1, DIRENT_SORT_HINT(de));
 			continue;
 		}
 		fprintf(stderr, "bad sha1 file: %s/%s\n", path, de->d_name);
-- 
1.1.3-gacdd
