From: Junio C Hamano <junkio@cox.net>
Subject: Re: /bin/sh portability question
Date: Fri, 23 Sep 2005 02:07:07 -0700
Message-ID: <7vmzm4duf8.fsf@assigned-by-dhcp.cox.net>
References: <20050923075058.GA25473@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Patrick Mauritz <oxygene@studentenbude.ath.cx>
X-From: git-owner@vger.kernel.org Fri Sep 23 11:09:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIjWU-0000Je-6V
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 11:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbVIWJHL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 05:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbVIWJHK
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 05:07:10 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:23704 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750829AbVIWJHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 05:07:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050923090708.QWIJ1974.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Sep 2005 05:07:08 -0400
To: "Peter Eriksen" <s022018@student.dtu.dk>
In-Reply-To: <20050923075058.GA25473@bohr.gbar.dtu.dk> (Peter Eriksen's
	message of "Fri, 23 Sep 2005 09:50:58 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9167>

"Peter Eriksen" <s022018@student.dtu.dk> writes:

> It seems things are progressing nicely with regard to
> Solaris portability.

Good to have a Solaris user.  I have one patch that I've been
keeping in the proposed updates branch, waiting for a
comfirmation or 'not-good-enough-for-me' answer from people that
have cURL installed in nonstandard places.

------------
Subject: [PATCH] CURLDIR in Makefile
From: Patrick Mauritz <oxygene@studentenbude.ath.cx>
Date: 1127139079 +0200

Support systems that do not install curl headers and libraries
in /usr/{include,lib}.

Signed-off-by: Patrick Mauritz <oxygene@studentenbude.ath.cx>
Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Makefile |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

a5ebfc164f8380eb4c1c2ff92082687c3cb0b39d
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -9,6 +9,9 @@
 # Define NO_CURL if you do not have curl installed.  git-http-pull is not
 # built, and you cannot use http:// and https:// transports.
 #
+# Define CURLDIR=/foo/bar if your curl header and library files are in
+# /foo/bar/include and /foo/bar/lib directories.
+#
 # Define NO_STRCASESTR if you don't have strcasestr.
 #
 # Define PPC_SHA1 environment variable when running make to make use of
@@ -131,6 +134,13 @@ ifdef WITH_SEND_EMAIL
 endif
 
 ifndef NO_CURL
+	ifdef CURLDIR
+		# This is still problematic -- gcc does not want -R.
+		CFLAGS += -I$(CURLDIR)/include
+		CURL_LIBCURL = -L$(CURLDIR)/lib -R$(CURLDIR)/lib -lcurl
+	else
+		CURL_LIBCURL = -lcurl
+	endif
 	PROGRAMS += git-http-fetch
 endif
 
@@ -285,7 +295,7 @@ git-ssh-upload: rsh.o
 git-ssh-pull: rsh.o fetch.o
 git-ssh-push: rsh.o
 
-git-http-fetch: LIBS += -lcurl
+git-http-fetch: LIBS += $(CURL_LIBCURL)
 git-rev-list: LIBS += $(OPENSSL_LIBSSL)
 
 init-db.o: init-db.c
