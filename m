From: Junio C Hamano <gitster@pobox.com>
Subject: Re: shell compatibility issues with SunOS 5.10
Date: Wed, 06 May 2009 18:14:46 -0700
Message-ID: <7vab5pu321.fsf@alter.siamese.dyndns.org>
References: <20090506055913.GA9701@dektop>
	<-ElxRhvpfY_jx1Ps8nJ42rHdrKbR03T1y96WpGK19gM@cipher.nrlssc.navy.mil>
	<fcaeb9bf0905061615v2c1b1b4fmc6ade674aabf9586@mail.gmail.com>
	<vmGwFm-7sqyeL1D7WrJ-qBXW02LwMMHQ7rLy7XbfdUutAtORXrswbw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu May 07 03:14:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1sCP-0001jE-L2
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 03:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755457AbZEGBOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 21:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754773AbZEGBOr
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 21:14:47 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:34313 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386AbZEGBOq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 21:14:46 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090507011447.UDKI17135.fed1rmmtao104.cox.net@fed1rmimpo03.cox.net>;
          Wed, 6 May 2009 21:14:47 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id oREm1b00S4aMwMQ04REmtr; Wed, 06 May 2009 21:14:47 -0400
X-Authority-Analysis: v=1.0 c=1 a=1YscXhk2imAA:10 a=4gGF0mQB7hoA:10
 a=UZKBXp5JM6Qvm_vOxRIA:9 a=XRZrNSzn_K1u-9OPukIA:7
 a=KXEf6l20DVzjyJblFULEjYBvobsA:4
X-CM-Score: 0.00
In-Reply-To: <vmGwFm-7sqyeL1D7WrJ-qBXW02LwMMHQ7rLy7XbfdUutAtORXrswbw@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Wed\, 06 May 2009 19\:22\:08 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118417>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> /usr/xpg*/bin is where Sun puts the POSIX compliant versions of standard
> system utilities.
>
> The binaries in /bin/ retain their historical Solaris behavior.
>
> Check out the XPG4 man page on a sun.
>
> Not sure about the best route to take here.  /usr/xpg4/bin should probably
> be in the user's PATH when git is executed too.

I doubt it is limited to git.

My experience from the days I had to do things on Solaris boxes several
years ago was that it was the only way to have a workable environment to
have /usr/xpg*/bin on my PATH.

If the contents of the stock /usr/bin has been frozen at the historical
state while the outside world made progress, I would imagine that the
situation has gotten worse for people who still use tools from /usr/bin
and expect their scripts to be portable with anybody else.

On Solaris, I expect everybody to build git with SHELL_PATH set to
something other than /bin/sh, and binary packaged one (I do not know
Solaris have such a packaging system, though) would also be set to avoid
the broken /bin/sh.  I suspect you could do something like this...

 Makefile        |   13 +++++++++++++
 git-sh-setup.sh |    2 ++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 6e21643..081f06a 100644
--- a/Makefile
+++ b/Makefile
@@ -3,6 +3,11 @@ all::
 
 # Define V=1 to have a more verbose compile.
 #
+# Define SHELL_PATH to a POSIX shell if your /bin/sh is broken.
+#
+# Define SANE_TOOL_PATH to a colon-separated list of paths to prepend
+# to PATH if your tools in /usr/bin are broken.
+#
 # Define SNPRINTF_RETURNS_BOGUS if your are on a system which snprintf()
 # or vsnprintf() return -1 instead of number of characters which would
 # have been written to the final string if enough space had been available.
@@ -694,6 +699,7 @@ ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
 	NEEDS_NSL = YesPlease
 	SHELL_PATH = /bin/bash
+	SANE_TOOL_PATH = /usr/xpg5/bin:/usr/xpg4/bin
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
 	NO_HSTRERROR = YesPlease
@@ -852,6 +858,12 @@ endif
 -include config.mak.autogen
 -include config.mak
 
+ifdef SANE_TOOL_PATH
+BROKEN_PATH_FIX = s|^. @@PATH@@|PATH=$(SANE_TOOL_PATH)|
+else
+BROKEN_PATH_FIX = d
+endif
+
 ifeq ($(uname_S),Darwin)
 	ifndef NO_FINK
 		ifeq ($(shell test -d /sw/lib && echo y),y)
@@ -1251,6 +1263,7 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
+	    -e '/^# @@PATH@@/$(BROKEN_PATH_FIX)' \
 	    $@.sh >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 8382339..7802581 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -11,6 +11,8 @@
 # exporting it.
 unset CDPATH
 
+# @@PATH@@:$PATH
+
 die() {
 	echo >&2 "$@"
 	exit 1
