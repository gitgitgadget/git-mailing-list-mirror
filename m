From: Bryan Larsen <bryan.larsen@gmail.com>
Subject: [PATCH] add --no-check option to git-write-tree
Date: Fri, 08 Jul 2005 06:37:48 -0400
Message-ID: <42CE577C.1070404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jul 08 12:56:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqqWZ-0004Hd-Ee
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 12:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbVGHKxR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 06:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbVGHKsG
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 06:48:06 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:64087 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262494AbVGHKrf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 06:47:35 -0400
Received: by zproxy.gmail.com with SMTP id p8so182197nzb
        for <git@vger.kernel.org>; Fri, 08 Jul 2005 03:47:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=iNio1DuX6w4Hrg3JDW53fyS+uyyj6sMyXuHuae0KgGZLysHIWAkBnIXQN2/4xTCPBqG17lwpX7Z/oKevHAVRxdPEbPrNyCLHKvMbatNg4QSGwqr/ndPoyRevifDfNMFRKJc4Bs8fJv5uczqCqY0F9lDn2fq9c/tE5zb8EkjrR1A=
Received: by 10.36.66.5 with SMTP id o5mr666788nza;
        Fri, 08 Jul 2005 03:47:35 -0700 (PDT)
Received: from ?192.168.1.100? ([70.26.43.137])
        by mx.gmail.com with ESMTP id 17sm936059nzo.2005.07.08.03.47.35;
        Fri, 08 Jul 2005 03:47:35 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add --no-check option to git-write-tree.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

  Documentation/git-write-tree.txt |    6 ++++++
  write-tree.c                     |   14 +++++++++++++-
  2 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-write-tree.txt 
b/Documentation/git-write-tree.txt
--- a/Documentation/git-write-tree.txt
+++ b/Documentation/git-write-tree.txt
@@ -10,6 +10,7 @@ git-write-tree - Creates a tree from the
  SYNOPSIS
  --------
  'git-write-tree'
+		[--no-check]

  DESCRIPTION
  -----------
@@ -23,6 +24,11 @@ In order to have that match what is actu
  now, you need to have done a "git-update-cache" phase before you did the
  "git-write-tree".

+OPTIONS
+-------
+--no-check::
+	Normally "git-write-tree" ensures that the objects referenced by the
+	directory exist in the object database.  This option disabled this check.



diff --git a/write-tree.c b/write-tree.c
--- a/write-tree.c
+++ b/write-tree.c
@@ -5,6 +5,8 @@
   */
  #include "cache.h"

+static int no_check = 0;
+
  static int check_valid_sha1(unsigned char *sha1)
  {
  	int ret;
@@ -61,7 +63,7 @@ static int write_tree(struct cache_entry
  			sha1 = subdir_sha1;
  		}

-		if (check_valid_sha1(sha1) < 0)
+		if (!no_check && check_valid_sha1(sha1) < 0)
  			exit(1);

  		entrylen = pathlen - baselen;
@@ -86,6 +88,16 @@ int main(int argc, char **argv)
  	int i, funny;
  	int entries = read_cache();
  	unsigned char sha1[20];
+	
+	if (argc==2) {
+		if (!strcmp(argv[1], "--no-check"))
+			no_check = 1;
+		else
+			die("unknown option %s", argv[1]);
+	}
+	
+	if (argc>2)
+		die("too many options");

  	if (entries < 0)
  		die("git-write-tree: error reading cache");



