From: Trent Piepho <xyzzy@speakeasy.org>
Subject: [PATCH] send-email: Add config option for sender address
Date: Wed, 18 Feb 2009 17:00:38 -0800
Message-ID: <1235005238-15500-1-git-send-email-xyzzy@speakeasy.org>
Cc: Trent Piepho <xyzzy@speakeasy.org>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 02:09:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZxPK-00009p-QA
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 02:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbZBSBH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 20:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbZBSBH0
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 20:07:26 -0500
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:47097 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbZBSBH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 20:07:26 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Feb 2009 20:07:25 EST
Received: (qmail 15944 invoked from network); 19 Feb 2009 01:00:44 -0000
Received: from 71-37-2-240.tukw.qwest.net (HELO localhost.localdomain) (xyzzy@[71.37.2.240])
          (envelope-sender <xyzzy@speakeasy.org>)
          by mail6.sea5.speakeasy.net (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 19 Feb 2009 01:00:44 -0000
X-Mailer: git-send-email 1.5.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110603>

The sender address, as specified with the '--from' command line option,
couldn't be set in the config file.  So add a new config option,
'sendemail.from', which sets it.  One can use 'sendemail.<identity>.from'
as well of course, which is likely the more useful case.

The sender address would default to GIT_AUTHOR_IDENT, which is usually the
right thing, but this doesn't allow switching based on the identity
selected.  It's possible to switch the SMTP server and envelope sender by
using the '--identity' option, in which case one probably wants to use a
different from address as well, but this had to be manually specified.

The docs are also fixed up somewhat.  If '--from' is specified (or the new
sendemail.from option is used) then the user isn't prompted.  The default
with no '--from' option (or sendemail.from option) is GIT_AUTHOR_IDENT
first then GIT_COMMITTER_IDENT, not just GIT_COMMITTER_IDENT.

Signed-off-by: Trent Piepho <xyzzy@speakeasy.org>
---
 Documentation/git-send-email.txt |    9 ++++++---
 git-send-email.perl              |    1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index ff4aeff..8345df2 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -57,9 +57,12 @@ If it wasn't able to see a header in the summary it will ask you about it
 interactively after quitting your editor.
 
 --from::
-	Specify the sender of the emails.  This will default to
-	the value GIT_COMMITTER_IDENT, as returned by "git var -l".
-	The user will still be prompted to confirm this entry.
+	Specify the sender of the emails.  If not specified on the command line,
+	the value of the 'sendemail.from' configuration option is used.  If
+	neither the command line option nor 'sendemail.from' are set, then the
+	user will be prompted for the value.  The default for the prompt will be
+	the value of GIT_AUTHOR_IDENT, or GIT_COMMITTER_IDENT if that is not
+	set, as returned by "git var -l".
 
 --in-reply-to::
 	Specify the contents of the first In-Reply-To header.
diff --git a/git-send-email.perl b/git-send-email.perl
index 77ca8fe..ec58f12 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -207,6 +207,7 @@ my %config_settings = (
     "suppresscc" => \@suppress_cc,
     "envelopesender" => \$envelope_sender,
     "multiedit" => \$multiedit,
+    "from" => \$sender,
 );
 
 # Handle Uncouth Termination
-- 
1.5.4.1
