From: Bryan Larsen <bryan.larsen@gmail.com>
Subject: [PATCH] 3/7 Add --info-only option to git-update-cache.
Date: Fri, 08 Jul 2005 06:54:24 -0400
Message-ID: <42CE5B60.8050500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jul 08 13:04:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dqqf5-0005M3-K6
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 13:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbVGHLEV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 07:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbVGHLEU
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 07:04:20 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:34003 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262499AbVGHLEG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 07:04:06 -0400
Received: by zproxy.gmail.com with SMTP id s18so184667nze
        for <git@vger.kernel.org>; Fri, 08 Jul 2005 04:04:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=SasVmcOsco/dugvFECg5TAN4F6EGmfLSQ7e+WUHPsILOv1W1jNTfB14yW2GafgDlZAFW8R5CGgH3ZLP2v5Ao6Dkn5xy/nEu6BsMFMddixH4fUfFh7UjLN8cNL1HrJ+StOmNgrbyVUZed8nyseKChDwuYfJXVjZog1ncaFBROlgE=
Received: by 10.36.222.33 with SMTP id u33mr643477nzg;
        Fri, 08 Jul 2005 04:04:04 -0700 (PDT)
Received: from ?192.168.1.100? ([70.26.43.137])
        by mx.gmail.com with ESMTP id 23sm754054nzn.2005.07.08.04.04.04;
        Fri, 08 Jul 2005 04:04:04 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



Add --info-only option to git-update-cache.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

  Documentation/git-update-cache.txt |   23 +++++++++++++++++++----
  update-cache.c                     |   14 +++++++++++---
  2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-update-cache.txt 
b/Documentation/git-update-cache.txt
--- a/Documentation/git-update-cache.txt
+++ b/Documentation/git-update-cache.txt
@@ -14,6 +14,7 @@ SYNOPSIS
  	     [--ignore-missing]
  	     [--force-remove]
  	     [--cacheinfo <mode> <object> <file>]\*
+	     [--info-only]
  	     [--] [<file>]\*

  DESCRIPTION
@@ -47,6 +48,9 @@ OPTIONS
  --cacheinfo <mode> <object> <path>::
  	Directly insert the specified info into the cache.
  	
+--info-only::
+	All <file> arguments behave like --cacheinfo.
+	
  --force-remove::
  	Remove the file from the index even when the working directory
  	still has such a file. (Implies --remove.)
@@ -80,15 +84,26 @@ the stat entry is out of date.
  For example, you'd want to do this after doing a "git-read-tree", to link
  up the stat cache details with the proper files.

-Using --cacheinfo
------------------
-'--cacheinfo' is used to register a file that is not in the current
-working directory.  This is useful for minimum-checkout merging.
+Using --cacheinfo or --info-only
+--------------------------------
+'--cacheinfo' is used to register a file that is not in the current 
working
+directory.  This is useful for minimum-checkout merging.

  To pretend you have a file with mode and sha1 at path, say:

   $ git-update-cache --cacheinfo mode sha1 path
+
+'--info-only' is used to register a file without placing it in the object
+database.  This is useful for status-only repositories.
+
+Both '--cacheinfo' and '--info-only' behave similarly: the index is updated
+but the object database isn't.  '--cacheinfo' is useful when the object is
+in the database but the file isn't available locally.  '--info-only' is
+useful when the file is available, but you do not wish to update the 
object
+database.

+Examples
+--------
  To update and refresh only the files already checked out:

     git-checkout-cache -n -f -a && git-update-cache --ignore-missing 
--refresh
diff --git a/update-cache.c b/update-cache.c
--- a/update-cache.c
+++ b/update-cache.c
@@ -12,7 +12,7 @@
   * like "git-update-cache *" and suddenly having all the object
   * files be revision controlled.
   */
-static int allow_add = 0, allow_remove = 0, allow_replace = 0, not_new 
= 0, quiet = 0;
+static int allow_add = 0, allow_remove = 0, allow_replace = 0, not_new 
= 0, quiet = 0, info_only = 0;
  static int force_remove;

  /* Three functions to allow overloaded pointer return; see linux/err.h */
@@ -68,7 +68,7 @@ static int add_file_to_cache(char *path)
  		fd = open(path, O_RDONLY);
  		if (fd < 0)
  			return -1;
-		if (index_fd(ce->sha1, fd, &st, 0) < 0)
+		if (index_fd(ce->sha1, fd, &st, info_only) < 0)
  			return -1;
  		break;
  	case S_IFLNK:
@@ -77,7 +77,11 @@ static int add_file_to_cache(char *path)
  			free(target);
  			return -1;
  		}
-		if (write_sha1_file(target, st.st_size, "blob", ce->sha1))
+		if (info_only) {
+			unsigned char hdr[50];
+			int hdrlen;
+			write_sha1_file_prepare(target, st.st_size, "blob", ce->sha1, hdr, 
&hdrlen);
+		} else if (write_sha1_file(target, st.st_size, "blob", ce->sha1))
  			return -1;
  		free(target);
  		break;
@@ -382,6 +386,10 @@ int main(int argc, char **argv)
  				i += 3;
  				continue;
  			}
+			if (!strcmp(path, "--info-only")) {
+				info_only = 1;
+				continue;
+			}
  			if (!strcmp(path, "--force-remove")) {
  				force_remove = 1;
  				continue;



