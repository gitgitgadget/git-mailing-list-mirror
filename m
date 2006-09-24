From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: builtin-upload-archive.c broken on openbsd
Date: 23 Sep 2006 17:20:45 -0700
Message-ID: <864puyglnm.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Sep 24 02:21:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRHjo-0003KI-Sz
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 02:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWIXAUt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 20:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWIXAUt
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 20:20:49 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:64589 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751296AbWIXAUs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Sep 2006 20:20:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 230AC8F9AC
	for <git@vger.kernel.org>; Sat, 23 Sep 2006 17:20:48 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 27406-02-9 for <git@vger.kernel.org>;
 Sat, 23 Sep 2006 17:20:45 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id C6B908F9AD; Sat, 23 Sep 2006 17:20:45 -0700 (PDT)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.13.11.19; tzolkin = 11 Cauac; haab = 12 Chen
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27642>


Looks like ctype again. Gotta be careful with that on BSD releases:

    $ gmake prefix=/opt/git all
    GIT_VERSION = 1.4.2.GIT
    gcc -o builtin-upload-archive.o -c -g -O2 -Wall -I/usr/local/include -DSHA1_HEADER='<openssl/sha.h>' -DNO_STRCASESTR builtin-upload-archive.c
    In file included from /usr/include/sys/poll.h:54,
                     from builtin-upload-archive.c:11:
    /usr/include/ctype.h:68: error: syntax error before ']' token
    /usr/include/ctype.h:69: error: syntax error before ']' token
    /usr/include/ctype.h:71: error: syntax error before ']' token
    /usr/include/ctype.h:76: error: syntax error before ']' token
    /usr/include/ctype.h:79: error: syntax error before '(' token
    /usr/include/ctype.h:80: error: syntax error before '(' token
    /usr/include/ctype.h:98: error: syntax error before "c"
    In file included from /usr/include/sys/poll.h:54,
                     from builtin-upload-archive.c:11:
    /usr/include/ctype.h:96:1: unterminated #if  
    /usr/include/ctype.h:40:1: unterminated #ifndef
    In file included from builtin-upload-archive.c:11:
    /usr/include/sys/poll.h:53:1: unterminated #ifndef
    /usr/include/sys/poll.h:28:1: unterminated #ifndef
    gmake: *** [builtin-upload-archive.o] Error 1

This fixes it:

>From 5a7951c5294fc05e2754a1b6f503e36cd7b2a2f0 Mon Sep 17 00:00:00 2001
From: Charlie <root@blue.stonehenge.com>
Date: Sat, 23 Sep 2006 17:19:53 -0700
Subject: [PATCH] local patch for openbsd

---
 builtin-upload-archive.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-upload-archive.c b/builtin-upload-archive.c
index 0596865..45c92e1 100644
--- a/builtin-upload-archive.c
+++ b/builtin-upload-archive.c
@@ -2,13 +2,13 @@
  * Copyright (c) 2006 Franck Bui-Huu
  */
 #include <time.h>
+#include <sys/wait.h>
+#include <sys/poll.h>
 #include "cache.h"
 #include "builtin.h"
 #include "archive.h"
 #include "pkt-line.h"
 #include "sideband.h"
-#include <sys/wait.h>
-#include <sys/poll.h>

 static const char upload_archive_usage[] =
        "git-upload-archive <repo>";
--
1.4.2.1.g3d5c-dirty



-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
