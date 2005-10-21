From: Linus Torvalds <torvalds@osdl.org>
Subject: git-rev-parse: pass on "--" flag when required
Date: Thu, 20 Oct 2005 17:16:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510201711380.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Oct 21 02:17:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESkaZ-0000is-Nt
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 02:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbVJUAQh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 20:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbVJUAQh
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 20:16:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61891 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932559AbVJUAQh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 20:16:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9L0GVFC003244
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 20 Oct 2005 17:16:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9L0GUvW016320;
	Thu, 20 Oct 2005 17:16:30 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10391>


If rev-parse output includes both flags and files, we should pass on any 
"--" marker we see, so that the end result can also tell the difference 
between a flag and a filename that begins with '-'.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/rev-parse.c b/rev-parse.c
index 85230df..9ae2512 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -174,6 +174,9 @@ int main(int argc, char **argv)
 		if (*arg == '-') {
 			if (!strcmp(arg, "--")) {
 				as_is = 1;
+				/* Pass on the "--" if we show anything but files.. */
+				if (filter & (DO_FLAGS | DO_REVS))
+					show_file(arg);
 				continue;
 			}
 			if (!strcmp(arg, "--default")) {
