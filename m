From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-log produces no output
Date: Fri, 21 Apr 2006 12:18:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604211214560.3701@g5.osdl.org>
References: <20060421184815.22939.qmail@web60319.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 21 21:19:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FX19i-0000m1-CO
	for gcvg-git@gmane.org; Fri, 21 Apr 2006 21:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWDUTS7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Apr 2006 15:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWDUTS7
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Apr 2006 15:18:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51865 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932106AbWDUTS6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Apr 2006 15:18:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3LJIdtH012469
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 21 Apr 2006 12:18:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3LJIcTA010751;
	Fri, 21 Apr 2006 12:18:38 -0700
To: Bob Portmann <bportmann@yahoo.com>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060421184815.22939.qmail@web60319.mail.yahoo.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19027>



On Fri, 21 Apr 2006, Bob Portmann wrote:
> 
> Yes, this is the problem.  It works when I send it to a file.  It seems
> to be that having any extra options my PAGER command that messes it up
> (see below).  If get-log was a shell script I would imagine that some
> quotes are missing:-)

It's the other way around: it's got "too much" quoting.

"git log" will literally _execute_ the PAGER environment, not pass it to a 
shell, and not interpret any arguments.

So it will look for a program called "more -i" (space and all), and no 
such program exists, so the execve fails, and git log ends up being 
silent.

This patch would have made things a lot more obvious.

Junio?

		Linus
---
diff --git a/pager.c b/pager.c
index b063353..9204641 100644
--- a/pager.c
+++ b/pager.c
@@ -47,5 +47,6 @@ void setup_pager(void)
 
 	setenv("LESS", "-S", 0);
 	run_pager(pager);
+	die("unable to execute pager '%s'", pager);
 	exit(255);
 }
