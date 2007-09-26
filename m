From: Jean-Luc Herren <jlh@gmx.ch>
Subject: [PATCH 1/2] git-add--interactive: Allow Ctrl-D to exit
Date: Wed, 26 Sep 2007 15:56:19 +0200
Message-ID: <46FA6503.5040708@gmx.ch>
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
	id 1IaXWn-0007ar-AA
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 16:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754662AbXIZOGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 10:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754878AbXIZOGG
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 10:06:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:48886 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753054AbXIZOGC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 10:06:02 -0400
Received: (qmail invoked by alias); 26 Sep 2007 14:06:00 -0000
Received: from 92-176.1-85.cust.bluewin.ch (EHLO [192.168.123.202]) [85.1.176.92]
  by mail.gmx.net (mp058) with SMTP; 26 Sep 2007 16:06:00 +0200
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX18QBGlcxw0QKODuB66u5Z/9dBV6oXaOfAm6o2/E4U
	txO1LR4Gp//IoW
User-Agent: Thunderbird 2.0.0.6 (X11/20070805)
X-Enigmail-Version: 0.95.3
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59231>

Hitting Ctrl-D (EOF) is a common way to exit shell-like tools.
When in a sub-menu it will still behave as if an empty line had
been entered, carrying out the action on the selected items and
returning to the previous menu.

Signed-off-by: Jean-Luc Herren <jlh@gmx.ch>
---
 git-add--interactive.perl |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 7921cde..f9e9f02 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -213,7 +213,11 @@ sub list_and_choose {
 			print ">> ";
 		}
 		my $line = <STDIN>;
-		last if (!$line);
+		if (!$line) {
+			print "\n";
+			$opts->{ON_EOF}->() if $opts->{ON_EOF};
+			last;
+		}
 		chomp $line;
 		my $donesomething = 0;
 		for my $choice (split(/[\s,]+/, $line)) {
@@ -791,6 +795,7 @@ sub main_loop {
 					     SINGLETON => 1,
 					     LIST_FLAT => 4,
 					     HEADER => '*** Commands ***',
+					     ON_EOF => \&quit_cmd,
 					     IMMEDIATE => 1 }, @cmd);
 		if ($it) {
 			eval {
-- 
1.5.3
