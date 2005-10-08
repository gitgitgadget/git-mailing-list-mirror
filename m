From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: First cut at git port to Cygwin
Date: Sat, 8 Oct 2005 09:11:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510080900510.31407@g5.osdl.org>
References: <20051005155457.GA30303@trixie.casa.cgf.cx> <20051005191741.GA25493@steel.home>
 <20051005202947.GA6184@trixie.casa.cgf.cx> <81b0412b0510060205v4cd510c9wb4b06a3ed9242c8@mail.gmail.com>
 <81b0412b0510060307q431b64edt4196553bce28346c@mail.gmail.com>
 <81b0412b0510070544v3e7cf0b4n521db8ff7e4e335a@mail.gmail.com>
 <Pine.LNX.4.64.0510070828270.31407@g5.osdl.org> <20051007205450.GA14827@steel.home>
 <20051007212250.GA1423@steel.home> <4346E8AC.5030503@citi.umich.edu>
 <20051007213952.GA8821@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chuck Lever <cel@citi.umich.edu>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Christopher Faylor <me@cgf.cx>,
	"H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sat Oct 08 18:11:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOHI8-000529-5N
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 18:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbVJHQLR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Oct 2005 12:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbVJHQLR
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Oct 2005 12:11:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37263 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932164AbVJHQLQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Oct 2005 12:11:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j98GB54s009061
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 8 Oct 2005 09:11:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j98GB3Nj007186;
	Sat, 8 Oct 2005 09:11:03 -0700
To: Alex Riesen <fork0@users.sourceforge.net>
In-Reply-To: <20051007213952.GA8821@steel.home>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.51__
X-MIMEDefang-Filter: osdl$Revision: 1.122 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9838>



On Fri, 7 Oct 2005, Alex Riesen wrote:
> 
> Make read_cache copy the index into memory, to improve portability on
> other OS's which have mmap too, tend to use it less commonly.

I really think that you should just get rid of the mmap.

As it is, you're just slowing the code down on sane architectures. That's 
not good.

So I'd suggest something like this instead.

Totally untested, of course.

		Linus

----
diff --git a/read-cache.c b/read-cache.c
--- a/read-cache.c
+++ b/read-cache.c
@@ -454,13 +454,39 @@ static int verify_hdr(struct cache_heade
 	return 0;
 }
 
+static void *map_index_file(int fd, size_t size)
+{
+	void *map;
+#ifdef NO_MMAP
+	map = malloc(size);
+	if (!map)
+		die("Unable to allocate index file mapping");
+	if (read(fd, map, size) != size)
+		die("Unable to read %z bytes from inde
+#else
+	map = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	if (map == MAP_FAILED)
+		die("index file mmap failed (%s)", strerror(errno));
+#endif
+	return map;
+}
+
+static void unmap_index_file(void *map, size_t size)
+{
+#ifdef NO_MMAP
+	free(map);
+#else
+	munmap(map, size);
+#endif
+}
+
 int read_cache(void)
 {
 	int fd, i;
 	struct stat st;
 	unsigned long size, offset;
-	void *map;
 	struct cache_header *hdr;
+	void *map;
 
 	errno = EBUSY;
 	if (active_cache)
@@ -475,16 +501,15 @@ int read_cache(void)
 	}
 
 	size = 0; // avoid gcc warning
-	map = MAP_FAILED;
-	if (!fstat(fd, &st)) {
-		size = st.st_size;
-		errno = EINVAL;
-		if (size >= sizeof(struct cache_header) + 20)
-			map = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
-	}
+	if (fstat(fd, &st))
+		die("unable to fstat index file");
+
+	size = st.st_size;
+	errno = EINVAL;
+	if (size < sizeof(struct cache_header) + 20)
+		goto corrupt;
+	map = map_index_file(fd, size);
 	close(fd);
-	if (map == MAP_FAILED)
-		die("index file mmap failed (%s)", strerror(errno));
 
 	hdr = map;
 	if (verify_hdr(hdr, size) < 0)
@@ -503,8 +528,9 @@ int read_cache(void)
 	return active_nr;
 
 unmap:
-	munmap(map, size);
+	unmap_index_file(map, size);
 	errno = EINVAL;
+corrupt:
 	die("index file corrupt");
 }
 
