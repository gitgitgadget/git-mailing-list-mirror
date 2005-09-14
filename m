From: Linus Torvalds <torvalds@osdl.org>
Subject: Fix alloc_filespec() initialization
Date: Wed, 14 Sep 2005 13:41:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509141334480.26803@g5.osdl.org>
References: <59a6e583050914094777c4fe96@mail.gmail.com> 
 <7vwtljjzc3.fsf@assigned-by-dhcp.cox.net> <59a6e583050914114054b1564d@mail.gmail.com>
 <Pine.LNX.4.58.0509141321180.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 22:44:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFe4g-0003PX-Jn
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 22:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbVINUln (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 16:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbVINUln
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 16:41:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15755 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964996AbVINUlm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 16:41:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8EKfRBo016650
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Sep 2005 13:41:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8EKfOrl024632;
	Wed, 14 Sep 2005 13:41:25 -0700
To: Wayne Scott <wsc9tt@gmail.com>
In-Reply-To: <Pine.LNX.4.58.0509141321180.26803@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8562>


This simplifies and fixes the initialization of a "diff_filespec" when 
allocated.

The old code would not initialize "sha1_valid". Noticed by valgrind.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This does not fix the issue Wayne saw, but I'm not going to look at the 
later valgrind errors before I've fixed the first ones.

On Wed, 14 Sep 2005, Linus Torvalds wrote:
> 
> I get even more, including:
> 
> 	==3234== Use of uninitialised value of size 4
> 	==3234==    at 0x80507C1: alloc_filespec (diff.c:224)
> 	==3234==    by 0x8052387: diff_addremove (diff.c:1144)
> 	==3234==    by 0x8049B74: show_file (diff-tree.c:97)
> 	==3234==    by 0x8049E17: diff_tree (diff-tree.c:118)

diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -214,14 +214,10 @@ struct diff_filespec *alloc_filespec(con
 {
 	int namelen = strlen(path);
 	struct diff_filespec *spec = xmalloc(sizeof(*spec) + namelen + 1);
+
+	memset(spec, 0, sizeof(*spec));
 	spec->path = (char *)(spec + 1);
-	strcpy(spec->path, path);
-	spec->should_free = spec->should_munmap = 0;
-	spec->xfrm_flags = 0;
-	spec->size = 0;
-	spec->data = NULL;
-	spec->mode = 0;
-	memset(spec->sha1, 0, 20);
+	memcpy(spec->path, path, namelen+1);
 	return spec;
 }
 
