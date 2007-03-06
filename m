From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] cvsserver: Use Merged response instead of Update-existing for merged files
Date: Tue,  6 Mar 2007 10:42:24 +0100
Message-ID: <11731741443228-git-send-email-frank@lichtenheld.de>
Cc: Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 11:15:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPFep-0004VD-Ug
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 11:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932985AbXCHKP3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 05:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933012AbXCHKP3
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 05:15:29 -0500
Received: from planck.djpig.de ([85.10.192.180]:55121 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932985AbXCHKP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 05:15:28 -0500
X-Greylist: delayed 1737 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Mar 2007 05:15:28 EST
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 034E188133
	for <git@vger.kernel.org>; Thu,  8 Mar 2007 10:46:30 +0100 (CET)
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (smtp.lichtenheld.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 23257-03 for <git@vger.kernel.org>;
	Thu, 8 Mar 2007 10:46:29 +0100 (CET)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 1D5CD88134; Thu,  8 Mar 2007 10:46:29 +0100 (CET)
X-Original-To: djpig@localhost
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id B9FDD27C1BC
	for <djpig@localhost>; Tue,  6 Mar 2007 10:46:43 +0100 (CET)
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (smtp.lichtenheld.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 21078-10 for <djpig@localhost>;
	Tue, 6 Mar 2007 10:46:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id DA5F927C0E3
	for <djpig@localhost>; Tue,  6 Mar 2007 10:46:39 +0100 (CET)
Received: from pop3.lenk.info [213.239.194.154]
	by localhost with POP3 (fetchmail-6.2.5)
	for djpig@localhost (single-drop); Tue, 06 Mar 2007 10:46:39 +0100 (CET)
Received: from mail.lenk.info ([217.160.134.107])
	by smtp.lenk.info with esmtps 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HOWC5-0004b3-9y
	for <frank@lichtenheld.de>; Tue, 06 Mar 2007 10:42:55 +0100
Received: from host-82-135-33-74.customer.m-online.net ([82.135.33.74] helo=goedel.djpig.de)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HOWG6-0004L8-KP; Tue, 06 Mar 2007 10:47:02 +0100
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <djpig@goedel.djpig.de>)
	id 1HOWBc-00033n-7P; Tue, 06 Mar 2007 10:42:24 +0100
X-Mailer: git-send-email 1.5.0.2
X-Lenk-Relay-ID: 2fcfeb08dec7427ae77acced7b7409b3
X-Resent-For: frank@lichtenheld.de
X-Resent-For: djpig.frank@courier.sorgfalt.info
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lichtenheld.net
X-CRM114-Version: 20050415.BlameTheIRS ( TRE 0.7.2 (GPL) ) MF-DAE15AAC [pR: 22.8865]
X-CRM114-Status: Good  ( pR: 22.8865 )
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lichtenheld.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41734>

Using Update-existing leads to the client forgetting about the "locally
modified" status of the file which can lead to loss of local changes on
later updates.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 git-cvsserver.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 1bf892e..65fcc84 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -957,12 +957,12 @@ sub req_update
             {
                 $log->info("Merged successfully");
                 print "M M $filename\n";
-                $log->debug("Update-existing $dirpart");
+                $log->debug("Merged $dirpart");
 
                 # Don't want to actually _DO_ the update if -n specified
                 unless ( $state->{globaloptions}{-n} )
                 {
-                    print "Update-existing $dirpart\n";
+                    print "Merged $dirpart\n";
                     $log->debug($state->{CVSROOT} . "/$state->{module}/$filename");
                     print $state->{CVSROOT} . "/$state->{module}/$filename\n";
                     my $kopts = kopts_from_path($filepart);
@@ -978,7 +978,7 @@ sub req_update
                 # Don't want to actually _DO_ the update if -n specified
                 unless ( $state->{globaloptions}{-n} )
                 {
-                    print "Update-existing $dirpart\n";
+                    print "Merged $dirpart\n";
                     print $state->{CVSROOT} . "/$state->{module}/$filename\n";
                     my $kopts = kopts_from_path($filepart);
                     print "/$filepart/1.$meta->{revision}/+/$kopts/\n";
-- 
1.5.0.2
