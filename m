From: Bryan Larsen <bryan.larsen@gmail.com>
Subject: [PATCH] 2/7 Prepare for the next two patches
Date: Fri, 08 Jul 2005 06:54:14 -0400
Message-ID: <42CE5B56.5090602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jul 08 13:09:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dqqj0-0005vH-Ct
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 13:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbVGHLHS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 07:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbVGHLEa
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 07:04:30 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:55073 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262494AbVGHLD7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 07:03:59 -0400
Received: by zproxy.gmail.com with SMTP id 9so187603nzo
        for <git@vger.kernel.org>; Fri, 08 Jul 2005 04:03:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=EMVsU4kpcxm4KxyNn6zfQUIIv0oLfbrGyC7VN5/6NO2oLLuqobUHMhY4NSeslh7av6SzZa0TT9DtrdxpY0cYcfFngDrfwbxqaWAx1bLecpWwnjfQlhkffPNfEoGlMj8D00COlDiJ3plAxlEkGRheWhO0DKhD8Axxp6QJ32/p9R4=
Received: by 10.36.88.10 with SMTP id l10mr549744nzb;
        Fri, 08 Jul 2005 04:03:56 -0700 (PDT)
Received: from ?192.168.1.100? ([70.26.43.137])
        by mx.gmail.com with ESMTP id r15sm241113nza.2005.07.08.04.03.54;
        Fri, 08 Jul 2005 04:03:56 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



Prepare for the next two patches.  This patch makes the first half of
write_sha1_file() and index_fd() externally visible.  The first half of
these two functions is basically just an SHA1 calculation, so there is
probably a better way to do this.  However, doing things this way makes
this patch and the subsequent patches minimally intrusive.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

  cache.h        |    3 ++-
  sha1_file.c    |   13 +++++++++----
  update-cache.c |    2 +-
  write-blob.c   |    2 +-
  4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -139,7 +139,7 @@ extern int remove_cache_entry_at(int pos
  extern int remove_file_from_cache(char *path);
  extern int ce_same_name(struct cache_entry *a, struct cache_entry *b);
  extern int ce_match_stat(struct cache_entry *ce, struct stat *st);
-extern int index_fd(unsigned char *sha1, int fd, struct stat *st);
+extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int 
info_only);
  extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);

  struct cache_file {
@@ -169,6 +169,7 @@ extern int sha1_object_info(const unsign
  extern void * unpack_sha1_file(void *map, unsigned long mapsize, char 
*type, unsigned long *size);
  extern void * read_sha1_file(const unsigned char *sha1, char *type, 
unsigned long *size);
  extern int write_sha1_file(void *buf, unsigned long len, const char 
*type, unsigned char *return_sha1);
+extern char *write_sha1_file_prepare(void *buf, unsigned long len, 
const char *type, unsigned char *sha1, unsigned char *hdr, int *hdrlen);

  extern int check_sha1_signature(const unsigned char *sha1, void *buf, 
unsigned long size, const char *type);

diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1084,7 +1084,7 @@ void *read_object_with_reference(const u
  	}
  }

-static char *write_sha1_file_prepare(void *buf,
+char *write_sha1_file_prepare(void *buf,
  				     unsigned long len,
  				     const char *type,
  				     unsigned char *sha1,
@@ -1283,12 +1283,14 @@ int has_sha1_file(const unsigned char *s
  	return find_pack_entry(sha1, &e);
  }

-int index_fd(unsigned char *sha1, int fd, struct stat *st)
+int index_fd(unsigned char *sha1, int fd, struct stat *st, int info_only)
  {
  	unsigned long size = st->st_size;
  	void *buf;
  	int ret;
-
+	unsigned char hdr[50];
+	int hdrlen;
+	
  	buf = "";
  	if (size)
  		buf = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
@@ -1296,7 +1298,10 @@ int index_fd(unsigned char *sha1, int fd
  	if ((int)(long)buf == -1)
  		return -1;

-	ret = write_sha1_file(buf, size, "blob", sha1);
+	if (info_only) {
+		(void) write_sha1_file_prepare(buf, size, "blob", sha1, hdr, &hdrlen);
+		ret = 0;
+	} else ret = write_sha1_file(buf, size, "blob", sha1);
  	if (size)
  		munmap(buf, size);
  	return ret;
diff --git a/update-cache.c b/update-cache.c
--- a/update-cache.c
+++ b/update-cache.c
@@ -68,7 +68,7 @@ static int add_file_to_cache(char *path)
  		fd = open(path, O_RDONLY);
  		if (fd < 0)
  			return -1;
-		if (index_fd(ce->sha1, fd, &st) < 0)
+		if (index_fd(ce->sha1, fd, &st, 0) < 0)
  			return -1;
  		break;
  	case S_IFLNK:
diff --git a/write-blob.c b/write-blob.c
--- a/write-blob.c
+++ b/write-blob.c
@@ -17,7 +17,7 @@ int main(int argc, char **argv)
  		fd = open(path, O_RDONLY);
  		if (fd < 0 ||
  		    fstat(fd, &st) < 0 ||
-		    index_fd(sha1, fd, &st) < 0)
+		    index_fd(sha1, fd, &st, 0) < 0)
  			die("Unable to add blob %s to database", path);
  		printf("%s\n", sha1_to_hex(sha1));
  	}



