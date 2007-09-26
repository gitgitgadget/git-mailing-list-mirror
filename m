From: Jean-Luc Herren <jlh@gmx.ch>
Subject: [PATCH 2/2] git-add--interactive: Improve behavior on bogus input
Date: Wed, 26 Sep 2007 16:05:01 +0200
Message-ID: <46FA670D.1060205@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 26 16:06:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaXWo-0007ar-0f
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 16:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897AbXIZOGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 10:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753705AbXIZOGH
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 10:06:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:33986 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753874AbXIZOGF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 10:06:05 -0400
Received: (qmail invoked by alias); 26 Sep 2007 14:06:02 -0000
Received: from 92-176.1-85.cust.bluewin.ch (EHLO [192.168.123.202]) [85.1.176.92]
  by mail.gmx.net (mp055) with SMTP; 26 Sep 2007 16:06:02 +0200
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX18LGS4VMYcLKaLf51uXwshxG5eqy8l/n1y5uKFblw
	cgPeHL5M1XpTM/
User-Agent: Thunderbird 2.0.0.6 (X11/20070805)
X-Enigmail-Version: 0.95.3
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59232>

1) Previously, any menu would cause a perl error when entered '0',
   which is never a valid option.

2) Entering a bogus choice (like 998 or 4-2) surprisingly caused
   the same behavior as if the user had just hit 'enter', which
   means to carry out the selected action on the selected items.
   Entering such bogus input is now a no-op and the sub-menu
   doesn't exit.

Signed-off-by: Jean-Luc Herren <jlh@gmx.ch>
---
 git-add--interactive.perl |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index f9e9f02..be68814 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -219,7 +219,7 @@ sub list_and_choose {
 			last;
 		}
 		chomp $line;
-		my $donesomething = 0;
+		last if $line eq '';
 		for my $choice (split(/[\s,]+/, $line)) {
 			my $choose = 1;
 			my ($bottom, $top);
@@ -251,12 +251,11 @@ sub list_and_choose {
 				next TOPLOOP;
 			}
 			for ($i = $bottom-1; $i <= $top-1; $i++) {
-				next if (@stuff <= $i);
+				next if (@stuff <= $i || $i < 0);
 				$chosen[$i] = $choose;
-				$donesomething++;
 			}
 		}
-		last if (!$donesomething || $opts->{IMMEDIATE});
+		last if ($opts->{IMMEDIATE});
 	}
 	for ($i = 0; $i < @stuff; $i++) {
 		if ($chosen[$i]) {
-- 
1.5.3
