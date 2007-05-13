From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] cvsserver: Limit config parser to needed options
Date: Sun, 13 May 2007 02:16:24 +0200
Message-ID: <11790153841188-git-send-email-frank@lichtenheld.de>
References: <7v3b21wtlf.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org, Martin Langhoff <martin.langhoff@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 13 02:16:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hn1lH-0001e7-WF
	for gcvg-git@gmane.org; Sun, 13 May 2007 02:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755470AbXEMAQ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 20:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755569AbXEMAQ0
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 20:16:26 -0400
Received: from mail.lenk.info ([217.160.134.107]:2431 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755470AbXEMAQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 20:16:25 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1Hn1jw-0002v2-VX; Sun, 13 May 2007 02:15:09 +0200
Received: from p3ee3e222.dip.t-dialin.net ([62.227.226.34] helo=localhost)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1Hn1l8-0005LS-65; Sun, 13 May 2007 02:16:22 +0200
Received: from djpig by localhost with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1Hn1lA-0003VE-6D; Sun, 13 May 2007 02:16:24 +0200
X-Mailer: git-send-email 1.5.1.4
In-Reply-To: <7v3b21wtlf.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47114>

Change the configuration parser so that it ignores
everything except for ^gitcvs.((ext|pserver).)?
This greatly reduces the risk of failing while
parsing some unknown and irrelevant config option.

The bug that triggered this change was that the
parsing doesn't handle sections that have a
subsection and a variable with the same name.

While this bug still remains, all remaining
causes can be attributed to user error, since
there are no defined variables gitcvs.ext and
gitcvs.pserver.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 git-cvsserver.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 3e7bf5b..a07c725 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -183,9 +183,9 @@ sub req_Root
     }
     foreach my $line ( @gitvars )
     {
-        next unless ( $line =~ /^(.*?)\.(.*?)(?:\.(.*?))?=(.*)$/ );
-        unless ($3) {
-            $cfg->{$1}{$2} = $4;
+        next unless ( $line =~ /^(gitcvs)\.(?:(ext|pserver)\.)?([\w-]+)=(.*)$/ );
+        unless ($2) {
+            $cfg->{$1}{$3} = $4;
         } else {
             $cfg->{$1}{$2}{$3} = $4;
         }
-- 
1.5.1.4
