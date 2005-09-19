From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What to expect after GIT 0.99.7
Date: Sun, 18 Sep 2005 18:30:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509181829310.9106@g5.osdl.org>
References: <7vr7c02zgg.fsf@assigned-by-dhcp.cox.net> <7vwtleyml5.fsf@assigned-by-dhcp.cox.net>
 <7vpsr6ymg3.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 03:31:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHAUu-0005MQ-VH
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 03:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbVISBa5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 21:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbVISBa5
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 21:30:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16619 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932277AbVISBa4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2005 21:30:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8J1UqBo032055
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Sep 2005 18:30:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8J1UoF2005888;
	Sun, 18 Sep 2005 18:30:51 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsr6ymg3.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8826>



On Sun, 18 Sep 2005, Junio C Hamano wrote:
> 
> * Accept patches for more portability.
> 
>   * strcasestr() in mailinfo.  We may need compat/strcasestr.c;
>     this is bugging OpenBSD folks.

Maybe something stupid like this?

Totally untested, of course.

		Linus
---
diff-tree 9b2d397a5d03514bdf3f545e459817c48579830f (from 727132834e6be48a93c1bd6458a29d474ce7d5d5)
Author: Linus Torvalds <torvalds@g5.osdl.org>
Date:   Sun Sep 18 18:29:07 2005 -0700

Add stupid 'strcasestr()' compat routine

Signed-off-by: Linus Torvalds <torvalds@osdl.org>

---
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -9,6 +9,8 @@
 # Define NO_CURL if you do not have curl installed.  git-http-pull is not
 # built, and you cannot use http:// and https:// transports.
 #
+# Define NO_STRCASESTR if you don't have strcasestr.
+#
 # Define PPC_SHA1 environment variable when running make to make use of
 # a bundled SHA1 routine optimized for PowerPC.
 #
@@ -203,6 +205,10 @@ ifdef NEEDS_NSL
 	LIBS += -lnsl
 	SIMPLE_LIB += -lnsl
 endif
+ifdef NO_STRCASESTR
+	DEFINES += -Dstrcasestr=gitstrcasestr
+	LIB_OBJS += compat/strcasestr.o
+endif
 
 DEFINES += '-DSHA1_HEADER=$(SHA1_HEADER)'
 
diff --git a/compat/strcasestr.c b/compat/strcasestr.c
new file mode 100644
--- /dev/null
+++ b/compat/strcasestr.c
@@ -0,0 +1,22 @@
+#include <string.h>
+
+char *gitstrcasestr(const char *haystack, const char *needle)
+{
+	int nlen = strlen(needle);
+	int hlen = strlen(haystack) - nlen;
+	int i;
+
+	for (i = 0; i < hlen; i++) {
+		int j;
+		for (j = 0; j < nlen; j++) {
+			unsigned char c1 = haystack[i+j];
+			unsigned char c2 = needle[j];
+			if (toupper(c1) != toupper(c2))
+				goto next;
+		}
+		return (char *) haystack + i;
+	next:
+		;
+	}
+	return NULL;
+}
