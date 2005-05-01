From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: update-cache ./test.c
Date: Sun, 1 May 2005 10:59:22 +0200
Message-ID: <20050501085922.GC30692@xi.wantstofly.org>
References: <20050501084145.GA30692@xi.wantstofly.org> <20050501084710.GJ26663@cip.informatik.uni-erlangen.de> <20050501085427.GB30692@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 01 10:53:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSACn-0007Dx-DT
	for gcvg-git@gmane.org; Sun, 01 May 2005 10:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVEAI71 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 04:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVEAI71
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 04:59:27 -0400
Received: from alephnull.demon.nl ([212.238.201.82]:15248 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S261563AbVEAI7W
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 1 May 2005 04:59:22 -0400
Received: by xi.wantstofly.org (Postfix, from userid 500)
	id 344552B0EC; Sun,  1 May 2005 10:59:22 +0200 (MEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050501085427.GB30692@xi.wantstofly.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, May 01, 2005 at 10:54:27AM +0200, Lennert Buytenhek wrote:

> But that wasn't quite the point :)  It makes sense that update-cache
> doesn't like ambiguous path names, but it's easier for update-cache to
> detect and strip "^./" than for me to remember to type sed "s#^./##"
> every time.

Something like this:

--- git/update-cache.c.orig	2005-05-01 10:56:17.859313581 +0200
+++ git/update-cache.c	2005-05-01 10:57:31.634897508 +0200
@@ -328,6 +328,7 @@
 
 	for (i = 1 ; i < argc; i++) {
 		char *path = argv[i];
+		char *_path;
 
 		if (allow_options && *path == '-') {
 			if (!strcmp(path, "--")) {
@@ -358,12 +359,15 @@
 			}
 			die("unknown option %s", path);
 		}
-		if (!verify_path(path)) {
+		_path = path;
+		if (!strncmp(_path, "./", 2))
+			_path += 2;
+		if (!verify_path(_path)) {
 			fprintf(stderr, "Ignoring path %s\n", argv[i]);
 			continue;
 		}
-		if (add_file_to_cache(path))
-			die("Unable to add %s to database", path);
+		if (add_file_to_cache(_path))
+			die("Unable to add %s to database", _path);
 	}
 	if (write_cache(newfd, active_cache, active_nr) || rename(lockfile, indexfile))
 		die("Unable to write new cachefile");


