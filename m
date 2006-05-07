From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: [patch] munmap-before-rename, cygwin need
Date: Sun, 7 May 2006 22:58:48 +0300
Message-ID: <f36b08ee0605071258s7a0cb085r3f08e9981234255a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_5139_29028306.1147031928919"
X-From: git-owner@vger.kernel.org Sun May 07 21:59:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcpPb-0000Ms-70
	for gcvg-git@gmane.org; Sun, 07 May 2006 21:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWEGT6u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 15:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWEGT6u
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 15:58:50 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:36464 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932220AbWEGT6t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 May 2006 15:58:49 -0400
Received: by py-out-1112.google.com with SMTP id x31so1289314pye
        for <git@vger.kernel.org>; Sun, 07 May 2006 12:58:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=HoC5vdU01m7kusDsvx7t4F53Sat/1/kT9+mav6mshy5e+YxsAzeKaZMyBNAwcP6grL4UPZVQYG5GVf3ZasFN0NbAT4vgLxP8DeGYILbQwoILGI9w5pH5irbTZisZ0l1uVxOfbCN9TasvudM0eh6WSmsEaqQZ6VHZPDM9xKX1KqY=
Received: by 10.35.78.13 with SMTP id f13mr1917633pyl;
        Sun, 07 May 2006 12:58:48 -0700 (PDT)
Received: by 10.35.96.18 with HTTP; Sun, 7 May 2006 12:58:48 -0700 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19716>

------=_Part_5139_29028306.1147031928919
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I found that mmap() works on cygwin, but needs a patch.
On Cygwin, rename() fails if target file has active mmap().
The patch below adds  munmap() before rename().

If you excuse me for posting not in git-generated format
(I did not yet completely make git working on my cygwin).
I'm adding the copy as attachment, I'm afraid the mailer
may interfere with spaces ?

Yakov Lerner

Makefile     |    5 +++++
cache.h      |    1 +
index.c      |    3 +++
read-cache.c |   14 ++++++++++++++

--- Makefile.000 2006-05-07 22:32:04.000000000 +0300
+++ Makefile 2006-05-07 22:30:38.000000000 +0300
@@ -46,6 +46,9 @@
#
# Define NO_MMAP if you want to avoid mmap.
#
+# Define MUMNAP_BEFORE_RENAME if munmap() on target file is required
+# before rename().
+#
# Define WITH_OWN_SUBPROCESS_PY if you want to use with python 2.3.
#
# Define NO_IPV6 if you lack IPv6 support and getaddrinfo().
@@ -270,6 +273,8 @@
# NO_MMAP =3D YesPlease
NO_IPV6 =3D YesPlease
X =3D .exe
+ MUMNAP_BEFORE_RENAME =3D YesPlease
+ NO_SOCKADDR_STORAGE =3D YesPlease
endif
ifeq ($(uname_S),FreeBSD)
NEEDS_LIBICONV =3D YesPlease
--- cache.h.000 2006-05-02 11:35:50.000000000 +0300
+++ cache.h 2006-05-02 11:33:34.000000000 +0300
@@ -140,6 +140,7 @@

/* Initialize and use the cache information */
extern int read_cache(void);
+extern void unmap_cache(void);
extern int write_cache(int newfd, struct cache_entry **cache, int entries);
extern int cache_name_pos(const char *name, int namelen);
#define ADD_CACHE_OK_TO_ADD 1 /* Ok to add */
--- read-cache.c.000 2006-05-07 22:33:42.000000000 +0300
+++ read-cache.c 2006-05-02 11:32:56.000000000 +0300
@@ -513,6 +513,9 @@
return 0;
}

+static void *mapaddr =3D MAP_FAILED;
+static unsigned long mapsize;
+
int read_cache(void)
{
int fd, i;
@@ -541,6 +544,8 @@
errno =3D EINVAL;
if (size >=3D sizeof(struct cache_header) + 20)
map =3D mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+ mapaddr =3D map;
+ mapsize =3D size;
}
close(fd);
if (map =3D=3D MAP_FAILED)
@@ -565,10 +570,19 @@

unmap:
munmap(map, size);
+ mapaddr =3D MAP_FAILED;
errno =3D EINVAL;
die("index file corrupt");
}

+void unmap_cache(void)
+{
+ if ( mapaddr !=3D MAP_FAILED ) {
+ munmap(mapaddr, mapsize);
+ mapaddr =3D MAP_FAILED;
+ }
+}
+
#define WRITE_BUFFER_SIZE 8192
static unsigned char write_buffer[WRITE_BUFFER_SIZE];
static unsigned long write_buffer_len;
--- index.c.000 2006-05-07 22:36:04.000000000 +0300
+++ index.c 2006-05-07 22:36:40.000000000 +0300
@@ -43,6 +43,9 @@
strcpy(indexfile, cf->lockfile);
i =3D strlen(indexfile) - 5; /* .lock */
indexfile[i] =3D 0;
+#ifdef MUMNAP_BEFORE_RENAME
+ unmap_cache();
+#endif
i =3D rename(cf->lockfile, indexfile);
cf->lockfile[0] =3D 0;
return i;

------=_Part_5139_29028306.1147031928919
Content-Type: text/plain; name=patch-munmap-before-rename; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_emxt3uqx
Content-Disposition: attachment; filename="patch-munmap-before-rename"

--- Makefile.000	2006-05-07 22:32:04.000000000 +0300
+++ Makefile	2006-05-07 22:30:38.000000000 +0300
@@ -46,6 +46,9 @@
 #
 # Define NO_MMAP if you want to avoid mmap.
 #
+# Define MUMNAP_BEFORE_RENAME if munmap() on target file is required
+# before rename().
+#
 # Define WITH_OWN_SUBPROCESS_PY if you want to use with python 2.3.
 #
 # Define NO_IPV6 if you lack IPv6 support and getaddrinfo().
@@ -270,6 +273,8 @@
 	# NO_MMAP = YesPlease
 	NO_IPV6 = YesPlease
 	X = .exe
+	MUMNAP_BEFORE_RENAME = YesPlease
+	NO_SOCKADDR_STORAGE = YesPlease
 endif
 ifeq ($(uname_S),FreeBSD)
 	NEEDS_LIBICONV = YesPlease
--- cache.h.000	2006-05-02 11:35:50.000000000 +0300
+++ cache.h	2006-05-02 11:33:34.000000000 +0300
@@ -140,6 +140,7 @@
 
 /* Initialize and use the cache information */
 extern int read_cache(void);
+extern void unmap_cache(void);
 extern int write_cache(int newfd, struct cache_entry **cache, int entries);
 extern int cache_name_pos(const char *name, int namelen);
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
--- read-cache.c.000	2006-05-07 22:33:42.000000000 +0300
+++ read-cache.c	2006-05-02 11:32:56.000000000 +0300
@@ -513,6 +513,9 @@
 	return 0;
 }
 
+static void *mapaddr = MAP_FAILED;
+static unsigned long mapsize;
+
 int read_cache(void)
 {
 	int fd, i;
@@ -541,6 +544,8 @@
 		errno = EINVAL;
 		if (size >= sizeof(struct cache_header) + 20)
 			map = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+		mapaddr = map;
+		mapsize = size;
 	}
 	close(fd);
 	if (map == MAP_FAILED)
@@ -565,10 +570,19 @@
 
 unmap:
 	munmap(map, size);
+	mapaddr = MAP_FAILED;
 	errno = EINVAL;
 	die("index file corrupt");
 }
 
+void unmap_cache(void)
+{
+	if ( mapaddr != MAP_FAILED ) {
+		munmap(mapaddr, mapsize);
+		mapaddr = MAP_FAILED;
+	}
+}
+
 #define WRITE_BUFFER_SIZE 8192
 static unsigned char write_buffer[WRITE_BUFFER_SIZE];
 static unsigned long write_buffer_len;
--- index.c.000	2006-05-07 22:36:04.000000000 +0300
+++ index.c	2006-05-07 22:36:40.000000000 +0300
@@ -43,6 +43,9 @@
 	strcpy(indexfile, cf->lockfile);
 	i = strlen(indexfile) - 5; /* .lock */
 	indexfile[i] = 0;
+#ifdef MUMNAP_BEFORE_RENAME
+	unmap_cache();
+#endif
 	i = rename(cf->lockfile, indexfile);
 	cf->lockfile[0] = 0;
 	return i;

------=_Part_5139_29028306.1147031928919--
