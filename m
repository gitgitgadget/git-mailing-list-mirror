From: Junio C Hamano <junkio@cox.net>
Subject: Re: /bin/sh portability question
Date: Sat, 24 Sep 2005 14:31:15 -0700
Message-ID: <7vll1mup98.fsf@assigned-by-dhcp.cox.net>
References: <20050923075058.GA25473@bohr.gbar.dtu.dk>
	<7vmzm4duf8.fsf@assigned-by-dhcp.cox.net>
	<20050923121705.GA11377@sunq05.gbar.dtu.dk>
	<7vwtl78dyl.fsf@assigned-by-dhcp.cox.net>
	<20050924195029.GA20514@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 24 23:32:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJHcA-0004S3-9E
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 23:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVIXVbS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Sep 2005 17:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbVIXVbS
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Sep 2005 17:31:18 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:23524 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750763AbVIXVbS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2005 17:31:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050924213115.QTIK24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Sep 2005 17:31:15 -0400
To: "Peter Eriksen" <s022018@student.dtu.dk>
In-Reply-To: <20050924195029.GA20514@bohr.gbar.dtu.dk> (Peter Eriksen's
	message of "Sat, 24 Sep 2005 21:50:29 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9247>

"Peter Eriksen" <s022018@student.dtu.dk> writes:

> Here are some small problems to begin with.

Thanks.  Next time, please format your patch according to
Documentation/SubmittingPatches.  Your MUA ate tabs and leading
whitespaces from the diff, and you lack Signed-off-by line.

I think you need to pass down SHELL_PATH, and prepare for people
running 'make' by hand in t/ directory.

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -252,7 +252,7 @@ SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)
 	  $(patsubst %.py,%,$(SCRIPT_PYTHON)) \
 	  gitk
 
-export TAR INSTALL DESTDIR
+export TAR INSTALL DESTDIR SHELL_PATH
 ### Build rules
 
 all: $(PROGRAMS) $(SCRIPTS)
diff --git a/t/Makefile b/t/Makefile
--- a/t/Makefile
+++ b/t/Makefile
@@ -4,8 +4,9 @@
 #
 
 #GIT_TEST_OPTS=--verbose --debug
+SHELL_PATH ?= $(SHELL)
 

BTW, do you have access to a Linux machine to play with?  It
would have caught this fairly easily.

Test of 'tar' timestamp would also fail if you do not use
'gtar', but as far as I know that test is the only place we
really rely on 'tar', so it may not be worth fixing.

'xargs -0' and 'find -print0' is really essential in some of the
git barebone scripts.  I think the one in git-reset can go, by 
unlinking in the Perl script instead of printing the name and
running "xargs -0 rm -f --" on it.

The one in git-commit I am not sure about.  We do want to make
it really generic and keep allowing LF in paths.  Maybe we would
want 'git-update-index --stdin [-z]' to read list of paths from
the standard input.

The one in git-grep I would not worry too much about; we should
rewrite the whole thing in Perl and the problem will disappear.
