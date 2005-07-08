From: Bryan Larsen <bryan.larsen@gmail.com>
Subject: [PATCH] 4/7 Use SHA1 for git-update-cache --refresh
Date: Fri, 08 Jul 2005 06:54:35 -0400
Message-ID: <42CE5B6B.2080308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jul 08 13:05:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqqfC-0005MT-Cs
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 13:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbVGHLEl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 07:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbVGHLEh
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 07:04:37 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:311 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262461AbVGHLES (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 07:04:18 -0400
Received: by zproxy.gmail.com with SMTP id 13so183918nzn
        for <git@vger.kernel.org>; Fri, 08 Jul 2005 04:04:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=K5VlsxglAj6FilBL2FBlkKgRxTQYGH7CuNBTpND+fusO761Na08SE+pLco5I3mspEgY6/gad5wlNz8tg5ZfItnCIOTMyJMq8Cp/7tpRTjRG8FtaY0Gwk3YcIzlCwVTOfkPBX2ysfazWxfdPNXtq+GuaFawE8QvTTbHfS6ffRPeQ=
Received: by 10.36.222.28 with SMTP id u28mr661577nzg;
        Fri, 08 Jul 2005 04:04:16 -0700 (PDT)
Received: from ?192.168.1.100? ([70.26.43.137])
        by mx.gmail.com with ESMTP id 36sm790262nza.2005.07.08.04.04.16;
        Fri, 08 Jul 2005 04:04:16 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



Change git-update-cache --refresh behaviour to use sha1's rather than
comparing byte by byte.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

  update-cache.c |   31 +++++--------------------------
  1 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/update-cache.c b/update-cache.c
--- a/update-cache.c
+++ b/update-cache.c
@@ -93,37 +93,16 @@ static int add_file_to_cache(char *path)
  	return add_cache_entry(ce, option);
  }

-static int match_data(int fd, void *buffer, unsigned long size)
-{
-	while (size) {
-		char compare[1024];
-		int ret = read(fd, compare, sizeof(compare));
-
-		if (ret <= 0 || ret > size || memcmp(buffer, compare, ret))
-			return -1;
-		size -= ret;
-		buffer += ret;
-	}
-	return 0;
-}
-
-static int compare_data(struct cache_entry *ce, unsigned long 
expected_size)
+static int compare_data(struct cache_entry *ce, struct stat *st)
  {
  	int match = -1;
  	int fd = open(ce->name, O_RDONLY);

  	if (fd >= 0) {
-		void *buffer;
-		unsigned long size;
-		char type[20];
-
-		buffer = read_sha1_file(ce->sha1, type, &size);
-		if (buffer) {
-			if (size == expected_size && !strcmp(type, "blob"))
-				match = match_data(fd, buffer, size);
-			free(buffer);
+		unsigned char sha1[20];
+		if(!index_fd(sha1, fd, st, 1)) {
+			match = memcmp(sha1, ce->sha1, 20);
  		}
-		close(fd);
  	}
  	return match;
  }
@@ -188,7 +167,7 @@ static struct cache_entry *refresh_entry

  	switch (st.st_mode & S_IFMT) {
  	case S_IFREG:
-		if (compare_data(ce, st.st_size))
+		if (compare_data(ce, &st))
  			return ERR_PTR(-EINVAL);
  		break;
  	case S_IFLNK:



