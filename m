X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] index-pack usage of mmap() is unacceptably slower on
 many OSes other than Linux
Date: Tue, 19 Dec 2006 11:55:19 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612191148270.3483@woody.osdl.org>
References: <86y7p57y05.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181251020.3479@woody.osdl.org>
 <86r6uw9azn.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181625140.18171@xanadu.home>
 <86hcvs984c.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org>
 <8664c896xv.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181511260.3479@woody.osdl.org>
 <Pine.LNX.4.64.0612181906450.18171@xanadu.home> <20061219051108.GA29405@thunk.org>
 <Pine.LNX.4.64.0612182234260.3479@woody.osdl.org>
 <Pine.LNX.4.63.0612190930460.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v1wmwtfmk.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612191027270.18171@xanadu.home>
 <7vk60npv7x.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612191409500.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 19 Dec 2006 19:55:48 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612191409500.18171@xanadu.home>
X-MIMEDefang-Filter: osdl$Revision: 1.163 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34845>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gwl3q-00012Z-F8 for gcvg-git@gmane.org; Tue, 19 Dec
 2006 20:55:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932910AbWLSTzf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 14:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932912AbWLSTzf
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 14:55:35 -0500
Received: from smtp.osdl.org ([65.172.181.25]:58634 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932910AbWLSTze
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 14:55:34 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBJJtK2J028347
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 19
 Dec 2006 11:55:20 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBJJtJSr008663; Tue, 19 Dec
 2006 11:55:19 -0800
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org



On Tue, 19 Dec 2006, Nicolas Pitre wrote:
> 
> Because _XOPEN_SOURCE must be defined before including unistd.h 
> otherwise pread is not declared and a warning is issued.

May I actually suggest we handle _all_ of these issues in one central 
place, namely "git-compat-util.h"

It's nice to have just one single file that tries to hide the details of 
all the differences between systems.

Sure, that file ends up having to include a lot of standard header files 
that some of the .c files don't actually _need_, but git compiles 
reasonably quickly, so I don't think we need to try to optimize compile 
speed much.

It's the C++ people who tend to have sucky compile times.

So how about something like the appended? And then just have the rule that 
we try to include "cache.h" early, because that brings in ALL the really 
basic system header files?

		Linus

---
diff --git a/convert-objects.c b/convert-objects.c
index 8812583..a630132 100644
--- a/convert-objects.c
+++ b/convert-objects.c
@@ -1,7 +1,3 @@
-#define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
-#define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
-#define _GNU_SOURCE
-#include <time.h>
 #include "cache.h"
 #include "blob.h"
 #include "commit.h"
diff --git a/git-compat-util.h b/git-compat-util.h
index 0272d04..e619e29 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -11,6 +11,10 @@
 
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
 
+#define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
+#define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
+#define _GNU_SOURCE
+
 #include <unistd.h>
 #include <stdio.h>
 #include <sys/stat.h>
@@ -25,6 +29,10 @@
 #include <netinet/in.h>
 #include <sys/types.h>
 #include <dirent.h>
+#include <sys/time.h>
+#include <time.h>
+#include <signal.h>
+#include <sys/wait.h>
 
 /* On most systems <limits.h> would have given us this, but
