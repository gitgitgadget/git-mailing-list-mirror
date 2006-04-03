From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Cygwin can't handle huge packfiles?
Date: Mon, 3 Apr 2006 16:38:32 +0200
Message-ID: <81b0412b0604030738w3f61f34u8a56b1a6b0b5ef88@mail.gmail.com>
References: <fa0b6e200604030246q21fccb9ar93004ac67d8b28b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_8951_4085989.1144075112417"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 16:38:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQQCV-00085a-Vz
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 16:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbWDCOih (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 10:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbWDCOih
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 10:38:37 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:16803 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751613AbWDCOig (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 10:38:36 -0400
Received: by zproxy.gmail.com with SMTP id o37so1855362nzf
        for <git@vger.kernel.org>; Mon, 03 Apr 2006 07:38:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=XjEmrq2DleMzwONuiuIeg5WS/xGebz2oocdyTNUTu3KdifyS2rcdhRh/i3G/hFUDnq8RdjihJvLka9vi7tYid9ecoK/xUJuyYAYqZjxlSXH+va+4ZvXafHq50CUYsYgvqq70o78kEmyc9DgCdhKHUnz3AGllMD4gWXiw0bGueoo=
Received: by 10.35.78.9 with SMTP id f9mr1017225pyl;
        Mon, 03 Apr 2006 07:38:32 -0700 (PDT)
Received: by 10.35.41.18 with HTTP; Mon, 3 Apr 2006 07:38:32 -0700 (PDT)
To: "Kees-Jan Dijkzeul" <k.j.dijkzeul@gmail.com>
In-Reply-To: <fa0b6e200604030246q21fccb9ar93004ac67d8b28b3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18335>

------=_Part_8951_4085989.1144075112417
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 4/3/06, Kees-Jan Dijkzeul <k.j.dijkzeul@gmail.com> wrote:
> I'm trying to get Git to manage a 5Gb source tree. Under linux, this
> works like a charm. Under cygwin, however, I run in to difficulties.
> For example:
>
> $ git-clone sgp-wa/ sgp-wa.clone
> fatal: packfile
> ./objects/pack/pack-56aa013a0234e198467ed37ae5db925764a6ee98.pack
> cannot be mapped.
> fatal: unexpected EOF
> fetch-pack from '/cygdrive/e/Projects/sgp-wa/.git' failed.
>
> To figure out what is happening, I printed the value of errno, which
> turns out to be 12 (Cannot allocate memory). I'm not sure how mmap is

mmap in git on cygwin does not mmaps anything,
but just reads the whole file in memory.

> I'm not sure how to approach this problem. Any tips would be greatly
> appreciated.

I ended up hacking gitfakemmap like in the attached patches (sorry for mime=
).
It's very ugly and unsafe hack, and it's actually exactly the reason why it=
 was
never submitted. Still, it helps me (it speedups revlist, for
instance), and maybe
it'll help you.
It is a really good example what stupid windows restrictions can do to
a program.

The patch is against git as of 3-Apr-2005, ~10 CET

------=_Part_8951_4085989.1144075112417
Content-Type: text/x-patch; name=cygmmap.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_elkwr1kx
Content-Disposition: attachment; filename="cygmmap.patch"

diff --git a/Makefile b/Makefile
index c79d646..8a46436
--- a/Makefile
+++ b/Makefile
@@ -389,7 +389,7 @@ ifdef NO_SETENV
 endif
 ifdef NO_MMAP
 	COMPAT_CFLAGS += -DNO_MMAP
-	COMPAT_OBJS += compat/mmap.o
+	COMPAT_OBJS += compat/mmap.o compat/realmmap.o
 endif
 ifdef NO_IPV6
 	ALL_CFLAGS += -DNO_IPV6
diff --git a/compat/realmmap.c b/compat/realmmap.c
new file mode 100644
index 0000000..8f26641
--- /dev/null
+++ b/compat/realmmap.c
@@ -0,0 +1,26 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/mman.h>
+#include "../git-compat-util.h"
+
+#undef mmap
+#undef munmap
+
+void *realmmap(void *start, size_t length, int prot , int flags, int fd, off_t offset)
+{
+	if (start != NULL || !(flags & MAP_PRIVATE)) {
+		errno = ENOTSUP;
+		return MAP_FAILED;
+	}
+	start = mmap(start, length, prot, flags, fd, offset);
+	return start;
+}
+
+int realmunmap(void *start, size_t length)
+{
+	return munmap(start, length);
+}
+
+
diff --git a/diff.c b/diff.c
index e496905..f1a2cf0 100644
--- a/diff.c
+++ b/diff.c
@@ -450,7 +450,7 @@ int diff_populate_filespec(struct diff_f
 		fd = open(s->path, O_RDONLY);
 		if (fd < 0)
 			goto err_empty;
-		s->data = mmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
+		s->data = realmmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
 		close(fd);
 		if (s->data == MAP_FAILED)
 			goto err_empty;
@@ -482,7 +482,7 @@ void diff_free_filespec_data(struct diff
 	if (s->should_free)
 		free(s->data);
 	else if (s->should_munmap)
-		munmap(s->data, s->size);
+		realmunmap(s->data, s->size);
 	s->should_free = s->should_munmap = 0;
 	s->data = NULL;
 	free(s->cnt_data);
diff --git a/git-compat-util.h b/git-compat-util.h
index 5d543d2..85150f8 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -42,22 +42,28 @@ extern int error(const char *err, ...) _
 
 #ifdef NO_MMAP
 
-#ifndef PROT_READ
+#include <sys/mman.h>
+/*#ifndef PROT_READ
 #define PROT_READ 1
 #define PROT_WRITE 2
 #define MAP_PRIVATE 1
 #define MAP_FAILED ((void*)-1)
-#endif
+#endif*/
 
 #define mmap gitfakemmap
 #define munmap gitfakemunmap
 extern void *gitfakemmap(void *start, size_t length, int prot , int flags, int fd, off_t offset);
 extern int gitfakemunmap(void *start, size_t length);
 
+extern void *realmmap(void *start, size_t length, int prot , int flags, int fd, off_t offset);
+extern int realmunmap(void *start, size_t length);
+
 #else /* NO_MMAP */
 
 #include <sys/mman.h>
 
+#define realmmap mmap
+#define realmunmap munmap
 #endif /* NO_MMAP */
 
 #ifdef NO_SETENV
diff --git a/sha1_file.c b/sha1_file.c
index 58edec0..712a068 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -330,14 +330,14 @@ void prepare_alt_odb(void)
 		close(fd);
 		return;
 	}
-	map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	map = realmmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
 	if (map == MAP_FAILED)
 		return;
 
 	link_alt_odb_entries(map, map + st.st_size, '\n',
 			     get_object_directory());
-	munmap(map, st.st_size);
+	realmunmap(map, st.st_size);
 }
 
 static char *find_sha1_file(const unsigned char *sha1, struct stat *st)
@@ -378,7 +378,7 @@ static int check_packed_git_idx(const ch
 		return -1;
 	}
 	idx_size = st.st_size;
-	idx_map = mmap(NULL, idx_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	idx_map = realmmap(NULL, idx_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
 	if (idx_map == MAP_FAILED)
 		return -1;
@@ -423,7 +423,7 @@ static int unuse_one_packed_git(void)
 	}
 	if (!lru)
 		return 0;
-	munmap(lru->pack_base, lru->pack_size);
+	realmunmap(lru->pack_base, lru->pack_size);
 	lru->pack_base = NULL;
 	return 1;
 }
@@ -460,7 +460,7 @@ int use_packed_git(struct packed_git *p)
 		}
 		if (st.st_size != p->pack_size)
 			die("packfile %s size mismatch.", p->pack_name);
-		map = mmap(NULL, p->pack_size, PROT_READ, MAP_PRIVATE, fd, 0);
+		map = realmmap(NULL, p->pack_size, PROT_READ, MAP_PRIVATE, fd, 0);
 		close(fd);
 		if (map == MAP_FAILED)
 			die("packfile %s cannot be mapped.", p->pack_name);
@@ -494,7 +494,7 @@ struct packed_git *add_packed_git(char *
 	/* do we have a corresponding .pack file? */
 	strcpy(path + path_len - 4, ".pack");
 	if (stat(path, &st) || !S_ISREG(st.st_mode)) {
-		munmap(idx_map, idx_size);
+		realmunmap(idx_map, idx_size);
 		return NULL;
 	}
 	/* ok, it looks sane as far as we can check without
@@ -647,7 +647,7 @@ static void *map_sha1_file_internal(cons
 		 */
 		sha1_file_open_flag = 0;
 	}
-	map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	map = realmmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
 	if (map == MAP_FAILED)
 		return NULL;
@@ -1184,7 +1184,7 @@ int sha1_object_info(const unsigned char
 			*sizep = size;
 	}
 	inflateEnd(&stream);
-	munmap(map, mapsize);
+	realmunmap(map, mapsize);
 	return status;
 }
 
@@ -1210,7 +1210,7 @@ void * read_sha1_file(const unsigned cha
 	map = map_sha1_file_internal(sha1, &mapsize);
 	if (map) {
 		buf = unpack_sha1_file(map, mapsize, type, size);
-		munmap(map, mapsize);
+		realmunmap(map, mapsize);
 		return buf;
 	}
 	return NULL;
@@ -1493,7 +1493,7 @@ int write_sha1_to_fd(int fd, const unsig
 	} while (posn < objsize);
 
 	if (map)
-		munmap(map, objsize);
+		realmunmap(map, objsize);
 	if (temp_obj)
 		free(temp_obj);
 
@@ -1646,7 +1646,7 @@ int index_fd(unsigned char *sha1, int fd
 
 	buf = "";
 	if (size)
-		buf = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+		buf = realmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
 	if (buf == MAP_FAILED)
 		return -1;
@@ -1660,7 +1660,7 @@ int index_fd(unsigned char *sha1, int fd
 		ret = 0;
 	}
 	if (size)
-		munmap(buf, size);
+		realmunmap(buf, size);
 	return ret;
 }
 


------=_Part_8951_4085989.1144075112417--
