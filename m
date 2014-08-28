From: Jonas 'Sortie' Termansen <sortie@maxsi.org>
Subject: [PATCH 0/9] Use timer_settime for new platforms
Date: Thu, 28 Aug 2014 03:04:13 +0200
Message-ID: <1409187862-21257-1-git-send-email-sortie@maxsi.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 03:11:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMoFP-0001tm-Hp
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 03:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbaH1BL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 21:11:27 -0400
Received: from csmtp7.one.com ([195.47.247.107]:59556 "EHLO csmtp7.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751205AbaH1BLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 21:11:25 -0400
Received: from localhost.localdomain (0133301021.0.fullrate.dk [95.166.189.26])
	by csmtp7.one.com (Postfix) with ESMTPA id 080FE40001D63
	for <git@vger.kernel.org>; Thu, 28 Aug 2014 01:06:13 +0000 (UTC)
X-Mailer: git-send-email 2.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256060>

Hi,

I have ported git to my homemade custom operating system. It implements the
modern core POSIX interface and by design doesn't implement older
obsolescent interfaces that has standardized superior replacements. This
causes some problems here and there, this patch series fixes one of them.

Git uses the setitimer() function to deliver a steady supply of signals,
which cause nice progress bars to show when operations take a long time.
However, this function is part of the XSI option (i.e. not core POSIX) and
has been marked as obsolescent in the latest standard revision (it will
likely be removed in the next revision). Application developers are instead
encouraged to use the timer_settime functions instead as they are more
powerful and are part of core POSIX (added in POSIX 2001).

This patch series transitions git to use the timer_settime function instead
of the setitimer function. The function is widely, but not universally
available on the platforms git current supports, so I need to be careful not
to introduce regressions.

I handle compatibility by checking if setitimer and timer_settime are
available (as well as the structures and types they need). git-compat-util.h
provides stubs for anything that is missing. The real code can then simply
try to use timer_create, and if it fails (such as with ENOSYS on platforms
that has the function, but no real implementation) it falls back on the
older setitimer function.

My first attempt at compatibility was simply adding #ifdef around all the
timer_settime calls, but this proved to be an unmaintainable maze of
preprocessor conditionals. Instead I adopted the approach already used when
setitimer is missing: Just using a preprocessor function macro that expands
calls to nothing, allowing code to pretend it's always there.

To properly pretend timer_settime is available when it's not, I had to stub
the timer_t, struct timespec, struct itimerspec, and struct sigevent types
if they were missing.

I have attempted to properly add make variables for each compatibility case
as well as proper configure tests. Autoconf is not my strong suit, but the
tests appears to be working.

This patch series breaks the build for people using just config.mak.uname
(and not the configure script) on platforms that doesn't have the used types
and functions (timer_t, timespec, itimerspec, sigevent, timer_settime) as
config.mak.uname doesn't yet have NO_FOO cases for those systems. That's
just because I don't have that all of those systems available. It does look
like Cygwin, FreeBSD, Linux, NetBSD, Minix, and OpenBSD have the API at
least. I believe I added the required NO_FOO variables for Darwin, MinGW and
Windows. If you have other systems available, you can help me by telling me
if they need some NO_FOO love in config.mak.uname as well. :-)

Jonas 'Sortie' Termansen
