From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Following renames
Date: Sun, 26 Mar 2006 08:43:10 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603260836050.15714@g5.osdl.org>
References: <20060326014946.GB18185@pasky.or.cz> <7virq1sywj.fsf@assigned-by-dhcp.cox.net>
 <20060326190836.dbe95a72.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, pasky@ucw.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 18:43:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNYKn-0002z9-Oh
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 18:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWCZQnS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 11:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWCZQnS
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 11:43:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17586 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751474AbWCZQnS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 11:43:18 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2QGhBDZ024435
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 26 Mar 2006 08:43:11 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2QGhA0X010676;
	Sun, 26 Mar 2006 08:43:10 -0800
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060326190836.dbe95a72.tihirvon@gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18045>



On Sun, 26 Mar 2006, Timo Hirvonen wrote:
>
> $ git-whatchanged old-file.c
> fatal: 'old-file.c': No such file or directory
> 
> $ touch old-file.c
> $ git-whatchanged old-file.c
> 
> Hah, it worked!

It worked even before:

	git-whatchanged -- old-file.c

always works.

If you think of the "filename spec" as _always_ having to have a "--" to 
separate the filenames from the other arguments, you're thinking the right 
way. Then, there's a _shorthand_ for existing files, where we allow users 
being lazy (because _I_ am very lazy indeed), which allows dropping of the 
"--", but then the code requires that the filenames are real filenames as 
of now.

> Hmm... this works too without the touch-hack:
> 
> $ git-whatchanged file.c old-file.c
> 
> I wish I had known this before.

Actually, it -shouldn't- work. It's just that "git-rev-parse" isn't as 
anal as it should be.

Here's a fix.

		Linus
----
diff --git a/rev-parse.c b/rev-parse.c
index f90e999..104b1e2 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -172,7 +172,9 @@ int main(int argc, char **argv)
 		char *dotdot;
 	
 		if (as_is) {
-			show_file(arg);
+			if (show_file(arg) && as_is < 2)
+				if (lstat(arg, &st) < 0)
+					die("'%s': %s", arg, strerror(errno));
 			continue;
 		}
 		if (!strcmp(arg,"-n")) {
@@ -192,7 +194,7 @@ int main(int argc, char **argv)
 
 		if (*arg == '-') {
 			if (!strcmp(arg, "--")) {
-				as_is = 1;
+				as_is = 2;
 				/* Pass on the "--" if we show anything but files.. */
 				if (filter & (DO_FLAGS | DO_REVS))
 					show_file(arg);
