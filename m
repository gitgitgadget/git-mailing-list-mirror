From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix spurious compile error
Date: Tue, 16 Jan 2007 22:10:54 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701162210060.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Jan 16 22:12:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6vaM-0003LT-W3
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 22:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbXAPVK5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 16:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbXAPVK5
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 16:10:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:40769 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751650AbXAPVK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 16:10:56 -0500
Received: (qmail invoked by alias); 16 Jan 2007 21:10:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 16 Jan 2007 22:10:54 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36964>


>From time to time, I would get this error:

[...]
sed: -e expression #8, char 41: Unterminated `s' command
make: *** [git-add--interactive] Error 1

Turns out that the function WriteMakefile() called in Makefile.PL
outputs the message "Writing perl.mak for Git" to stdout! Thus,
the output of "make -C perl -s --no-print-directory instlibdir"
would be prefixed by that message whenever Makefile.PL was newer
than perl.mak.

This is fixed by redirecting stdout to stderr in Makefile.PL.

Signed-off-by: Johannes E. Schindelin <johannes.schindelin@gmx.de>
---
 perl/Makefile.PL |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index 4168775..9b117fd 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -20,6 +20,10 @@ if ($@) {
 my %extra;
 $extra{DESTDIR} = $ENV{DESTDIR} if $ENV{DESTDIR};
 
+# redirect stdout, otherwise the message "Writing perl.mak for Git"
+# disrupts the output for the target 'instlibdir'
+open STDOUT, ">&STDERR";
+
 WriteMakefile(
 	NAME            => 'Git',
 	VERSION_FROM    => 'Git.pm',
-- 
1.3.3.g79f3
