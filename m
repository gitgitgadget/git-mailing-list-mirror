From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] use "git init-db" in tests
Date: Fri, 09 Dec 2005 00:52:27 -0800
Message-ID: <7vvexy4ppw.fsf@assigned-by-dhcp.cox.net>
References: <20051208202555.GA3046@steel.home>
	<7vu0dje2oi.fsf@assigned-by-dhcp.cox.net>
	<20051208210251.GB19423@steel.home>
	<7v7jafcmev.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0512082336i674932bapd631d559e80cad79@mail.gmail.com>
	<7vlkyu7l05.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 09 09:53:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ekdzi-0007E9-08
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 09:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbVLIIw3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Dec 2005 03:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbVLIIw3
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Dec 2005 03:52:29 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:61932 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751231AbVLIIw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2005 03:52:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051209085112.HKUM17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 9 Dec 2005 03:51:12 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <7vlkyu7l05.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 09 Dec 2005 00:06:02 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13419>

Junio C Hamano <junkio@cox.net> writes:

> Linkage error of git-init-db (or git wrapper) may leave the file
> created but leave that in unexecutable form, which could be a
> valid concern, but that would signal an error to the make during
> the build stage, and "test" target depends on "all" target.

BTW, I sometimes wished if it were easier to disable that "test:
all" dependency and run tests without building things first,
i.e. deliberately using the already installed binaries, so that
I can make sure that updated or new tests reproduce and catch
problems with the existing code first and then make sure the
binaries built from the updated sources fix the problem.

Of course that is a very specialized application so a makefile
variable "make NO_BUILD_BEFORE_TEST=YesPlease test" would not
make much sense, but I could have done something like this:

---
diff --git a/Makefile b/Makefile
index 01b6643..8dd7be7 100644
--- a/Makefile
+++ b/Makefile
@@ -439,7 +439,13 @@ doc:
 
 ### Testing rules
 
-test: all
+ifdef NO_BUILD_BEFORE_TEST
+test_depends = 
+else
+test_depends = all
+endif
+
+test: $(test_depends)
 	$(MAKE) -C t/ all
 
 test-date$X: test-date.c date.o ctype.o
