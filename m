From: fork0@t-online.de (Alex Riesen)
Subject: Re: comparing file contents in is_exact_match?
Date: Mon, 17 Jul 2006 22:20:46 +0200
Message-ID: <20060717202046.GA8119@steel.home>
References: <87k66p8jee.fsf@mid.deneb.enyo.de> <Pine.LNX.4.63.0607080450100.29667@wbgn013.biozentrum.uni-wuerzburg.de> <87fyh1ncm0.fsf@mid.deneb.enyo.de> <f36b08ee0607160803s27dac6a6k476e3dd7742346fc@mail.gmail.com> <20060716223607.GA6023@steel.home> <87d5c4ajlu.fsf@mid.deneb.enyo.de> <Pine.LNX.4.63.0607171439270.29667@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0607170840280.15611@evo.osdl.org> <Pine.LNX.4.63.0607171804030.29667@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0607171055230.15611@evo.osdl.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 17 22:22:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2Zaq-0005s8-MN
	for gcvg-git@gmane.org; Mon, 17 Jul 2006 22:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWGQUVY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Jul 2006 16:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWGQUVX
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Jul 2006 16:21:23 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:16038 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751180AbWGQUVX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jul 2006 16:21:23 -0400
Received: from fwd30.aul.t-online.de 
	by mailout07.sul.t-online.com with smtp 
	id 1G2ZaY-0000oZ-00; Mon, 17 Jul 2006 22:21:10 +0200
Received: from tigra.home (r49i7sZ1Zeozj-suUCeUD5rc+tzdw6hwuUo8N4USD4tiGRJf4xOCwt@[84.160.93.96]) by fwd30.sul.t-online.de
	with esmtp id 1G2ZaI-2AWlSS0; Mon, 17 Jul 2006 22:20:54 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id EE7C2277AF;
	Mon, 17 Jul 2006 22:20:48 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1G2ZaC-0008JX-0G; Mon, 17 Jul 2006 22:20:48 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607171055230.15611@evo.osdl.org>
User-Agent: Mutt/1.5.6i
X-ID: r49i7sZ1Zeozj-suUCeUD5rc+tzdw6hwuUo8N4USD4tiGRJf4xOCwt
X-TOI-MSGID: 548dcb76-f494-4c18-8427-6af44f0302e7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23983>

Linus Torvalds, Mon, Jul 17, 2006 19:56:04 +0200:
> > So we could introduce a second mmap() which is normally the same as 
> > mmap(), except for windows, where it is a rename() and unlink() safe 
> > version of mmap() by reading the thing into RAM. Not very pretty.
> 
> Well, not too ugly either.
> 
> Imagine having a "map_packfile()" interface, and letting different targets 
> just implement their own version. That doesn't sound too bad, does it?
> 

Maybe the patch below will at least help to identify the place where
the interface could be used. It's a bit more than packfiles.
I use it since march (I really meant to post it, but probably forgot).
But careful, it has an ugly piece in git-compat-util.h, which probably
makes the patch only useful on cygwin and nowhere else (is there any
other platform which has NO_MMAP defined?).

---
 Makefile          |    2 +-
 compat/realmmap.c |   26 ++++++++++++++++++++++++++
 diff.c            |    4 ++--
 git-compat-util.h |   10 ++++++++--
 sha1_file.c       |   24 ++++++++++++------------
 5 files changed, 49 insertions(+), 17 deletions(-)

diff --git a/Makefile b/Makefile
index 01fb9cf..f16b466 100644
--- a/Makefile
+++ b/Makefile
@@ -432,7 +432,7 @@ ifdef NO_SETENV
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
index 8b44756..831bf82 100644
--- a/diff.c
+++ b/diff.c
@@ -1094,7 +1094,7 @@ int diff_populate_filespec(struct diff_f
 		fd = open(s->path, O_RDONLY);
 		if (fd < 0)
 			goto err_empty;
-		s->data = mmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
+		s->data = realmmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
 		close(fd);
 		if (s->data == MAP_FAILED)
 			goto err_empty;
@@ -1126,7 +1126,7 @@ void diff_free_filespec_data(struct diff
 	if (s->should_free)
 		free(s->data);
 	else if (s->should_munmap)
-		munmap(s->data, s->size);
+		realmunmap(s->data, s->size);
 	s->should_free = s->should_munmap = 0;
 	s->data = NULL;
 	free(s->cnt_data);
diff --git a/git-compat-util.h b/git-compat-util.h
index 93f5580..503b8e4 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -46,22 +46,28 @@ extern void set_error_routine(void (*rou
 
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
index e666aec..38ab710 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -331,14 +331,14 @@ static void read_info_alternates(const c
 		close(fd);
 		return;
 	}
-	map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	map = realmmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
 	if (map == MAP_FAILED)
 		return;
 
 	link_alt_odb_entries(map, map + st.st_size, '\n', relative_base, depth);
 
-	munmap(map, st.st_size);
+	realmunmap(map, st.st_size);
 }
 
 void prepare_alt_odb(void)
@@ -394,7 +394,7 @@ static int check_packed_git_idx(const ch
 		return -1;
 	}
 	idx_size = st.st_size;
-	idx_map = mmap(NULL, idx_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	idx_map = realmmap(NULL, idx_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
 	if (idx_map == MAP_FAILED)
 		return -1;
@@ -439,7 +439,7 @@ static int unuse_one_packed_git(void)
 	}
 	if (!lru)
 		return 0;
-	munmap(lru->pack_base, lru->pack_size);
+	realmunmap(lru->pack_base, lru->pack_size);
 	lru->pack_base = NULL;
 	return 1;
 }
@@ -476,7 +476,7 @@ int use_packed_git(struct packed_git *p)
 		}
 		if (st.st_size != p->pack_size)
 			die("packfile %s size mismatch.", p->pack_name);
-		map = mmap(NULL, p->pack_size, PROT_READ, MAP_PRIVATE, fd, 0);
+		map = realmmap(NULL, p->pack_size, PROT_READ, MAP_PRIVATE, fd, 0);
 		close(fd);
 		if (map == MAP_FAILED)
 			die("packfile %s cannot be mapped.", p->pack_name);
@@ -511,7 +511,7 @@ struct packed_git *add_packed_git(char *
 	/* do we have a corresponding .pack file? */
 	strcpy(path + path_len - 4, ".pack");
 	if (stat(path, &st) || !S_ISREG(st.st_mode)) {
-		munmap(idx_map, idx_size);
+		realmunmap(idx_map, idx_size);
 		return NULL;
 	}
 	/* ok, it looks sane as far as we can check without
@@ -676,7 +676,7 @@ static void *map_sha1_file_internal(cons
 		 */
 		sha1_file_open_flag = 0;
 	}
-	map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	map = realmmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
 	if (map == MAP_FAILED)
 		return NULL;
@@ -1220,7 +1220,7 @@ int sha1_object_info(const unsigned char
 			*sizep = size;
 	}
 	inflateEnd(&stream);
-	munmap(map, mapsize);
+	realmunmap(map, mapsize);
 	return status;
 }
 
@@ -1246,7 +1246,7 @@ void * read_sha1_file(const unsigned cha
 	map = map_sha1_file_internal(sha1, &mapsize);
 	if (map) {
 		buf = unpack_sha1_file(map, mapsize, type, size);
-		munmap(map, mapsize);
+		realmunmap(map, mapsize);
 		return buf;
 	}
 	reprepare_packed_git();
@@ -1543,7 +1543,7 @@ int write_sha1_to_fd(int fd, const unsig
 
 	if (buf) {
 		retval = write_buffer(fd, buf, objsize);
-		munmap(buf, objsize);
+		realmunmap(buf, objsize);
 		return retval;
 	}
 
@@ -1726,7 +1726,7 @@ int index_fd(unsigned char *sha1, int fd
 
 	buf = "";
 	if (size)
-		buf = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+		buf = realmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
 	if (buf == MAP_FAILED)
 		return -1;
@@ -1740,7 +1740,7 @@ int index_fd(unsigned char *sha1, int fd
 		ret = 0;
 	}
 	if (size)
-		munmap(buf, size);
+		realmunmap(buf, size);
 	return ret;
 }
 
-- 
1.4.1.gb944
