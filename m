From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: [PATCH] Do not define _XOPEN_SOURCE on MacOSX as it is too restricting there
Date: Thu, 21 Dec 2006 11:39:38 +0100
Message-ID: <20061221103938.GA7055@fiberbit.xs4all.nl>
References: <86ac1iyyla.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612201502090.3576@woody.osdl.org> <86wt4mximh.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612201524230.3576@woody.osdl.org> <caf068570612201636g75180138r223aef7c42f69a50@mail.gmail.com> <7vtzzq3wo6.fsf@assigned-by-dhcp.cox.net> <caf068570612201654s3949202cl55bd21307ca59453@mail.gmail.com> <7vodpy3vxi.fsf@assigned-by-dhcp.cox.net> <86vek6vyc7.fsf@blue.stonehenge.com> <caf068570612201735o776e01a8he2e9ab90fc2ee4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 11:40:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxLLN-00009N-Rp
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 11:40:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965208AbWLUKj5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 05:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965207AbWLUKj4
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 05:39:56 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:53575 "EHLO
	fiberbit.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965211AbWLUKjz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 05:39:55 -0500
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.63)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1GxLKs-0001xA-Di; Thu, 21 Dec 2006 11:39:38 +0100
To: Terje Sten Bjerkseth <terje@bjerkseth.org>
Content-Disposition: inline
In-Reply-To: <caf068570612201735o776e01a8he2e9ab90fc2ee4f@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35048>

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

Patch from Terje Sten Bjerkseth, only added a comment.

diff --git a/git-compat-util.h b/git-compat-util.h
index bc296b3..f056d20 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -11,7 +11,11 @@
 
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
 
+#if !defined __APPLE__
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
+#else
+			/* On Darwin defining _XOPEN_SOURCE always restricts available functions */
+#endif
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #define _GNU_SOURCE
 #define _BSD_SOURCE
