From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: [PATCH] Don't define _XOPEN_SOURCE on MacOSX and FreeBSD as it is too restricting
Date: Thu, 21 Dec 2006 12:28:35 +0100
Message-ID: <20061221112835.GA7713@fiberbit.xs4all.nl>
References: <Pine.LNX.4.64.0612201502090.3576@woody.osdl.org> <86wt4mximh.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612201524230.3576@woody.osdl.org> <caf068570612201636g75180138r223aef7c42f69a50@mail.gmail.com> <7vtzzq3wo6.fsf@assigned-by-dhcp.cox.net> <caf068570612201654s3949202cl55bd21307ca59453@mail.gmail.com> <7vodpy3vxi.fsf@assigned-by-dhcp.cox.net> <86vek6vyc7.fsf@blue.stonehenge.com> <caf068570612201735o776e01a8he2e9ab90fc2ee4f@mail.gmail.com> <20061221103938.GA7055@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Terje Sten Bjerkseth <terje@bjerkseth.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, Rocco Rutte <pdmef@gmx.net>
X-From: git-owner@vger.kernel.org Thu Dec 21 12:28:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxM6M-0007wN-Bc
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 12:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWLUL2j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 06:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWLUL2j
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 06:28:39 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:49857 "EHLO
	fiberbit.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964845AbWLUL2i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 06:28:38 -0500
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.63)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1GxM6F-000230-Rx; Thu, 21 Dec 2006 12:28:35 +0100
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20061221103938.GA7055@fiberbit.xs4all.nl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35053>

Defining _XOPEN_SOURCE on Darwin always leads to a restricted set of
available functions and symbols. This can not be cured by adding extra
defines in any way. So there really is only the choice between _not_
defining this symbol on Mac OS X or restricting our usage of functions
and symbols to the POSIX sets that are in term implied by _XOPEN_SOURCE.
The first seems better.

Note the last three lines from this following literal code snippet in
/usr/include/sys/cdefs.h from the Apple Darwin sources:

 * By default newly complied code will actually get the same symbols
 * that the old code did.  Defining any of _APPLE_C_SOURCE, _XOPEN_SOURCE,
 * or _POSIX_C_SOURCE will give you the new symbols.  Defining _XOPEN_SOURCE
 * or _POSIX_C_SOURCE also restricts the avilable symbols to a subset of
 * Apple's APIs.

We want our symbols "avilable" so lets not use _XOPEN_SOURCE on Darwin!

The preferred way of checking specific Apple specific issues is by using
the __APPLE__ predefined macro.

The extra define _XOPEN_SOURCE_EXTENDED does only affect some headers
(like the /usr/include/curses.h header) and can stay.

FreeBSD 6 requires the __BSD_VISIBLE flag for fchmod(), IPPROTO_IPV6 and
more which is only properly set by <sys/cdefs.h> if _POSIX_C_SOURCE
isn't present. However, _POSIX_C_SOURCE is defined if _XOPEN_SOURCE is
defined and >=500.

As a solution, simply don't define _XOPEN_SOURCE for FreeBSD and continue
with its defaults.

Author: Terje Sten Bjerkseth <terje@bjerkseth.org>
Signed-off-by: Rocco Rutte <pdmef@gmx.net>
Signed-off-by: Marco Roeland <marco.roeland@xs4all.nl>
---
 git-compat-util.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index bc296b3..6f46f36 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -11,7 +11,14 @@
 
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
 
+#if !defined(__APPLE__) && !defined(__FreeBSD)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
+#else
+			/*
+			 * On Darwin and FreeBSD defining _XOPEN_SOURCE always restricts available
+			 * functions and symbols.
+			 */
+#endif
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #define _GNU_SOURCE
 #define _BSD_SOURCE
-- 
1.4.4.2.g81597-dirty
