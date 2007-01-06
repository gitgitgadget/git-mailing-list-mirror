From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: problem with git clone on cygwin
Date: Sat, 6 Jan 2007 18:03:30 +0100
Organization: -no organization-
Message-ID: <20070106170330.GA8041@scotty.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
X-From: git-owner@vger.kernel.org Sat Jan 06 18:08:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3F2G-0007TP-Q8
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 18:08:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbXAFRIl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 12:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbXAFRIl
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 12:08:41 -0500
Received: from moutng.kundenserver.de ([212.227.126.174]:65043 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbXAFRIj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 12:08:39 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Jan 2007 12:08:39 EST
Received: from [84.134.58.103] (helo=scotty.home)
	by mrelayeu.kundenserver.de (node=mrelayeu5) with ESMTP (Nemesis),
	id 0ML25U-1H3ExA317H-0001PH; Sat, 06 Jan 2007 18:03:33 +0100
Received: from scotty.home (localhost [127.0.0.1])
	by scotty.home (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l06H3Udh024396
	for <git@vger.kernel.org>; Sat, 6 Jan 2007 18:03:31 +0100
Received: (from hs@localhost)
	by scotty.home (8.13.4/8.13.4/Submit) id l06H3Ull024393
	for git@vger.kernel.org; Sat, 6 Jan 2007 18:03:30 +0100
X-Authentication-Warning: scotty.home: hs set sender to stefan.hahn@s-hahn.de using -f
To: git@vger.kernel.org
Content-Disposition: inline
X-Mailer: Mutt 1.5.6 http://www.mutt.org/
X-Editor: GNU Emacs 21.4.1 http://www.gnu.org/
X-Accept-Language: de en
X-Location: Europe, Germany, Wolfenbuettel
X-GPG-Public-Key: http://www.s-hahn.de/gpg-public-stefan.asc
X-GPG-key-ID/Fingerprint: 0xE4FCD563 / EF09 97BB 3731 7DC7 25BA 5C39 185C F986 E4FC D563
User-Agent: Mutt/1.5.9i
X-Spam-Status: No, score=-0.0 required=5.0 tests=ALL_TRUSTED,
	UNWANTED_LANGUAGE_BODY autolearn=failed version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on scotty.home
X-Virus-Scanned: ClamAV 0.88.7/2416/Sat Jan  6 05:54:14 2007 on scotty.home
X-Virus-Status: Clean
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:77aa76da759ebc9bab1cc524fc813130
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36091>


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

running git on Cygwin I have a problem with git clone on local disk,
while packing data. 

The problem comes with v1.5.0-rc0. I bisected the problem down to
commit 6d2fa7 as the first bad commit.

It seems to be a problem with cygwin.dll prior v1.5.22 and pread(), if
using an offset!=0. (I'm running cygwin.dll v1.5.21 build date
2006-07-27 and I can't update because of other compatibility problems).

So I tried:
- not to set NO_MMAP to use real mmap
- changing get_data_from_pack() from index-pack.c to used mmap() as
  in 042aea8. (I did this because it directly uses pread().)
This solved the problem for my testcase.

The added testcase also succeeds on Linux but just with v1.4.4 or my
patch on Cygwin.

Is there anybody else having the same problem in git universe?

-- 
Stefan-W. Hahn                          It is easy to make things.
/ mailto:stefan.hahn@s-hahn.de /        It is hard to make things simple.			


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ppp.diff"

diff --git a/Makefile b/Makefile
index 180e1e0..afa5d08 100644
--- a/Makefile
+++ b/Makefile
@@ -368,7 +368,7 @@ ifeq ($(uname_O),Cygwin)
 	# There are conflicting reports about this.
 	# On some boxes NO_MMAP is needed, and not so elsewhere.
 	# Try commenting this out if you suspect MMAP is more efficient
-	NO_MMAP = YesPlease
+	#NO_MMAP = YesPlease
 	NO_IPV6 = YesPlease
 	X = .exe
 endif
diff --git a/index-pack.c b/index-pack.c
index 5f6d128..f1d11a0 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -277,25 +277,27 @@ static void *get_data_from_pack(struct object_entry *obj)
 {
 	unsigned long from = obj[0].offset + obj[0].hdr_size;
 	unsigned long len = obj[1].offset - from;
-	unsigned char *src, *data;
+	unsigned pg_offset = from % getpagesize();
+	unsigned char *map, *data;
 	z_stream stream;
 	int st;
 
-	src = xmalloc(len);
-	if (pread(pack_fd, src, len, from) != len)
-		die("cannot pread pack file: %s", strerror(errno));
+	map = mmap(NULL, len + pg_offset, PROT_READ, MAP_PRIVATE,
+		   pack_fd, from - pg_offset);
+	if (map == MAP_FAILED)
+		die("cannot mmap pack file: %s", strerror(errno));
 	data = xmalloc(obj->size);
 	memset(&stream, 0, sizeof(stream));
 	stream.next_out = data;
 	stream.avail_out = obj->size;
-	stream.next_in = src;
+	stream.next_in = map + pg_offset;
 	stream.avail_in = len;
 	inflateInit(&stream);
 	while ((st = inflate(&stream, Z_FINISH)) == Z_OK);
 	inflateEnd(&stream);
 	if (st != Z_STREAM_END || stream.total_out != obj->size)
 		die("serious inflate inconsistency");
-	free(src);
+	munmap(map, len + pg_offset);
 	return data;
 }
 
diff --git a/t/t5610-clone-fail.sh b/t/t5610-clone-fail.sh
new file mode 100755
index 0000000..d46c255
--- /dev/null
+++ b/t/t5610-clone-fail.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+#
+
+test_description='test git-clone failure on cygwin using pread()
+'
+
+. ./test-lib.sh
+
+# Need a repo to clone
+test_create_repo foo2
+
+GIT_AUTHOR_EMAIL=xxxxxxxx@yyyyyyyy.yyyyy.yyyyyyy.yyy
+GIT_COMMITTER_EMAIL=xxxxxxxx@yyyyyyyy.yyyyy.yyyyyyy.yyy
+export GIT_AUTHOR_EMAIL
+export GIT_COMMITTER_EMAIL
+
+(cd foo2 && echo "Hello" > file && git add file && git commit -m 'add file' >/dev/null 2>&1)
+(cd foo2 && echo "Hello2" >> file && git commit -a -m 'test' >/dev/null 2>&1)
+
+test_expect_success \
+    'clone with resolving' \
+    'git-clone foo2 bar2'
+
+test_done

--h31gzZEtNLTqOjlF--
