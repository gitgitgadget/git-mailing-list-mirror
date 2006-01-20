From: Junio C Hamano <junkio@cox.net>
Subject: Re: cygwin-latest: compile errors related to sockaddr_storage, dirent->d_type and dirent->d_ino
Date: Thu, 19 Jan 2006 17:13:32 -0800
Message-ID: <7vzmlr7lc3.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christopher Faylor <me@cgf.cx>
X-From: git-owner@vger.kernel.org Fri Jan 20 02:13:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzkqZ-0001TU-Kv
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 02:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbWATBNo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 20:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030438AbWATBNo
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 20:13:44 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:31168 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1030374AbWATBNn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 20:13:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060120011143.THZO17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 Jan 2006 20:11:43 -0500
To: Alex Riesen <raa.lkml@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14947>

Alex Riesen <raa.lkml@gmail.com> writes:

> For reasons unknown, cygwin decided to use our sockaddr_storage.
> As it is redefined to sockaddr_in it'd cause compilation errors in
> cygwin headers.

Just removing "-Dsockaddr_storage=sockaddr_in" from ALL_CFLAGS
seems to solve the problem for new Cygwin.

I doubt that -Dsockaddr_storage=sockaddr_in should be tied to
NO_IPV6.  Maybe a better approach would be something like the
attached patch.

Although /usr/include/cygwin/in.h seems to have struct sockaddr_in6,
getaddrinfo() and friends still do not seem to be there, so
NO_IPV6 still remains in effect on Cygwin.

Comments?

-- >8 --
[PATCH] Makefile: do not assume lack of IPV6 means no sockaddr_storage.

Noticed first by Alex, that the latest Cygwin now properly has
sockaddr_storage.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Makefile |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

0b61a10bb258ae0971bce3e01e40a5a9e5d9537f
diff --git a/Makefile b/Makefile
index f6d9e0a..e8f4b24 100644
--- a/Makefile
+++ b/Makefile
@@ -42,6 +42,9 @@ all:
 #
 # Define NO_IPV6 if you lack IPv6 support and getaddrinfo().
 #
+# Define NO_SOCKADDR_STORAGE if your platform does not have struct
+# sockaddr_storage.
+#
 # Define COLLISION_CHECK below if you believe that SHA1's
 # 1461501637330902918203684832716283019655932542976 hashes do not give you
 # sufficient guarantee that no collisions between objects will ever happen.
@@ -342,7 +345,14 @@ ifdef NO_MMAP
 	COMPAT_OBJS += compat/mmap.o
 endif
 ifdef NO_IPV6
-	ALL_CFLAGS += -DNO_IPV6 -Dsockaddr_storage=sockaddr_in
+	ALL_CFLAGS += -DNO_IPV6
+endif
+ifdef NO_SOCKADDR_STORAGE
+ifdef NO_IPV6
+	ALL_CFLAGS += -Dsockaddr_storage=sockaddr_in
+else
+	ALL_CFLAGS += -Dsockaddr_storage=sockaddr_in6
+endif
 endif
 
 ifdef PPC_SHA1
-- 
1.1.3-gacdd
