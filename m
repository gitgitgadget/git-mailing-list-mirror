From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: Re: [patch] munmap-before-rename, cygwin need
Date: Mon, 8 May 2006 14:47:01 +0000
Message-ID: <f36b08ee0605080747r24668152t20cc406e017454a9@mail.gmail.com>
References: <f36b08ee0605071258s7a0cb085r3f08e9981234255a@mail.gmail.com>
	 <7vslnlk04v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_18596_349121.1147099621698"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 16:48:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fd70y-0005Pv-N7
	for gcvg-git@gmane.org; Mon, 08 May 2006 16:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWEHOrG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 10:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWEHOrG
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 10:47:06 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:60284 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932187AbWEHOrE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 May 2006 10:47:04 -0400
Received: by py-out-1112.google.com with SMTP id f28so1297269pyf
        for <git@vger.kernel.org>; Mon, 08 May 2006 07:47:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=H4d4GLJCUkVFrepG6aR8ck5ElOOocCuAQnk1/mJsnaV8Qdd+7PCP4FBM88Bvtu+6wbcZuY7+hoql8qp8s77v7TwSmF+l6bh35c7UFubXdLUSzg7ExOPnZxFLeY9DsR1OXV1DdHhY0zrjUI1NXNgx7JRwF7y3y/S8Tw8+E49um7k=
Received: by 10.35.15.11 with SMTP id s11mr1243855pyi;
        Mon, 08 May 2006 07:47:01 -0700 (PDT)
Received: by 10.35.96.18 with HTTP; Mon, 8 May 2006 07:47:01 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vslnlk04v.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19767>

------=_Part_18596_349121.1147099621698
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 5/7/06, Junio C Hamano <junkio@cox.net> wrote:
> "Yakov Lerner" <iler.ml@gmail.com> writes:
> > I found that mmap() works on cygwin, but needs a patch.
> > On Cygwin, rename() fails if target file has active mmap().
> > The patch below adds  munmap() before rename().
> This is interesting in three counts.
>
>  - I from time to time test Cygwin version on my day-job machine
>    (W2K) and my wife's machine (XP); on both machines I usually
>    have less than two weeks old Cygwin installation, and I have
>    not seen the breakage.  I wonder how reproducible this is.
>    Also previously people reported mmap() works for some and
>    fake mmap is needed for others.  Would this patch make things
>    work for everybody?
>
>  - The part you patched is commit_index_file().  This typically
>    is called just before program exit, but some callers, like
>    apply.c, may want to still look at the index after calling
>    it, fully aware that the changes after commit_index will not
>    be written out.  Although I haven't traced the codepath fully
>    in apply.c yet, unmapping would break the access to the index
>    (i.e. active_cache[]).  Does apply still work with your
>    patch?

You are right. Apply did not work when I gave it more than one patchfile on
commandline (and --index option). I fixed this by zeroing active_nr and fre=
eing
active_cache in unmap_cache(). Then I got infinite loop in
remove_lock_file (after multiple calls to hold_index_file_for_update
with same cf, cache_file_list points to cf and cf->next points to
cf creating infinite loop.) The fix in index.c is easy.

The patch below works for me. However, it changes internal
working of apply.c in the scenario 'git-apply --index patch1 patch2 ...'.

(1) With the patch below, apply.c repeats mmap() on index after every patch
argument (because index gets unmapped after every patchfile argument).

(2) Current apply.c does single mmap() at the beginning. It modfies index
on disk and cache in memory and it does not repeat mmap. This mmap
is to original (now deleted) index, if i understand correctly (the
no-name inode).

But (2) this does not work in cygwin. The end results of (1) and
(2) are the same, I think. (2) looks to me bit faster (I didn't do
measurements).

It's up to you whether to make it under #ifdef MUNMAP_BEFORE_RENAME
of not. The changes are now bigger that in original patch.

The fix to index.c prevents circular list. I got infinite loop in
cache_file_list
every time I tried more than 1 patch on commandline of git-apply. I tried
other solution with the function below, but what I put in the atached patch
is shorter than the alternative below.

Yakov

P.S. I am attaching not inlining bacause
gmail totally removes leading tabs from inline text.

P.P.S.
Alternate fix for index.c:

static void clean_cache_file_list(struct cache_file *cf)
{
        struct cache_file *ppcf =3D &cache_file_list;
        cf->lockfile[0] =3D 0;
        while( *ppcf ) {
            if(*ppcf =3D=3D cf ) {
                *ppcf =3D cf->next;
            } else
                ppcf =3D &(cf->next);
        }
}
-         cf->lockfile[0] =3D 0;
+        clean_cache_file_list(cf);
-         cf->lockfile[0] =3D 0;
+        clean_cache_file_list(cf);

------=_Part_18596_349121.1147099621698
Content-Type: application/octet-stream; name=patch2-unmap-before-rename
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_emz3nbg7
Content-Disposition: attachment; filename="patch2-unmap-before-rename"

--- cache.h.000	2006-05-08 16:59:09.000000000 +0000
+++ cache.h	2006-05-08 16:42:15.000000000 +0000
@@ -141,6 +141,7 @@
 
 /* Initialize and use the cache information */
 extern int read_cache(void);
+extern void unmap_cache(void);
 extern int write_cache(int newfd, struct cache_entry **cache, int entries);
 extern int cache_name_pos(const char *name, int namelen);
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
@@ -161,6 +162,7 @@
 struct cache_file {
 	struct cache_file *next;
 	char lockfile[PATH_MAX];
+	int enlisted;
 };
 extern int hold_index_file_for_update(struct cache_file *, const char *path);
 extern int commit_index_file(struct cache_file *);
--- index.c.000	2006-05-08 16:19:22.000000000 +0000
+++ index.c	2006-05-08 16:57:14.000000000 +0000
@@ -5,6 +5,7 @@
 #include "cache.h"
 
 static struct cache_file *cache_file_list;
+static int cleanup_installed = 0;
 
 static void remove_lock_file(void)
 {
@@ -27,11 +28,17 @@
 	int fd;
 	sprintf(cf->lockfile, "%s.lock", path);
 	fd = open(cf->lockfile, O_RDWR | O_CREAT | O_EXCL, 0666);
-	if (fd >=0 && !cf->next) {
-		cf->next = cache_file_list;
-		cache_file_list = cf;
-		signal(SIGINT, remove_lock_file_on_signal);
-		atexit(remove_lock_file);
+	if (fd >=0) {
+		if (!cf->enlisted) {
+			cf->next = cache_file_list;
+			cache_file_list = cf;
+			cf->enlisted = 1;
+		}
+		if (!cleanup_installed) {
+			signal(SIGINT, remove_lock_file_on_signal);
+			atexit(remove_lock_file);
+			cleanup_installed = 1;
+		}
 	}
 	return fd;
 }
@@ -43,6 +50,9 @@
 	strcpy(indexfile, cf->lockfile);
 	i = strlen(indexfile) - 5; /* .lock */
 	indexfile[i] = 0;
+//#ifdef MUMNAP_BEFORE_RENAME
+	unmap_cache();
+//#endif
 	i = rename(cf->lockfile, indexfile);
 	cf->lockfile[0] = 0;
 	return i;
--- read-cache.c.000	2006-05-08 17:01:28.000000000 +0000
+++ read-cache.c	2006-05-08 17:02:24.000000000 +0000
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
@@ -565,10 +570,23 @@
 
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
+	active_cache_changed = 0;
+	active_nr = 0;
+	free(active_cache);
+	active_cache = NULL;
+}
+
 #define WRITE_BUFFER_SIZE 8192
 static unsigned char write_buffer[WRITE_BUFFER_SIZE];
 static unsigned long write_buffer_len;








------=_Part_18596_349121.1147099621698--
