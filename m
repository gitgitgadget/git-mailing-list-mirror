From: Trent Piepho <xyzzy@speakeasy.org>
Subject: [PATCH v2] send-email: Add config option for sender address
Date: Tue, 12 May 2009 15:48:56 -0700
Message-ID: <1242168536-15057-1-git-send-email-xyzzy@speakeasy.org>
References: <7v1vrxhu8x.fsf@gitster.siamese.dyndns.org>
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Trent Piepho <xyzzy@speakeasy.org>, gitster@pobox.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 13 00:56:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M40u1-0002Tc-Np
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 00:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769AbZELW4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 18:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752224AbZELW4k
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 18:56:40 -0400
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:42907 "EHLO
	mail8.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbZELW4j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 18:56:39 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 May 2009 18:56:39 EDT
Received: (qmail 22769 invoked from network); 12 May 2009 22:50:00 -0000
Received: from 71-36-41-54.tukw.qwest.net (HELO localhost.localdomain) (xyzzy@[71.36.41.54])
          (envelope-sender <xyzzy@speakeasy.org>)
          by mail8.sea5.speakeasy.net (qmail-ldap-1.03) with SMTP
          for <gitster@pobox.com>; 12 May 2009 22:50:00 -0000
X-Mailer: git-send-email 1.5.4.1
In-Reply-To: <7v1vrxhu8x.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118969>

The sender address, as specified with the '--from' command line option,
couldn't be set in the config file.  So add a new config option,
'sendemail.from', which sets it.  One can use 'sendemail.<identity>.from'
as well of course, which is likely the more useful case.

The sender address would default to GIT_AUTHOR_IDENT, which is usually the
right thing, but this doesn't allow switching based on the identity
selected.  It's possible to switch the SMTP server and envelope sender by
using the '--identity' option, in which case one probably wants to use a
different from address as well, but this had to be manually specified.

The documentation for 'from' is also corrected somewhat.  If '--from' is
specified (or the new sendemail.from option is used) then the user isn't
prompted.  The default with no '--from' option (or sendemail.from option)
is GIT_AUTHOR_IDENT first then GIT_COMMITTER_IDENT, not just
GIT_COMMITTER_IDENT.

Signed-off-by: Trent Piepho <xyzzy@speakeasy.org>
---
v2: Updated to latest git

 Documentation/git-send-email.txt |    9 ++++++---
 git-send-email.perl              |    1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 794224b..f940770 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -69,9 +69,12 @@ and In-Reply-To headers will be used unless they are removed.
 Missing From or In-Reply-To headers will be prompted for.
 
 --from=<address>::
-	Specify the sender of the emails.  This will default to
-	the value GIT_COMMITTER_IDENT, as returned by "git var -l".
-	The user will still be prompted to confirm this entry.
+	Specify the sender of the emails.  If not specified on the command line,
+	the value of the 'sendemail.from' configuration option is used.  If
+	neither the command line option nor 'sendemail.from' are set, then the
+	user will be prompted for the value.  The default for the prompt will be
+	the value of GIT_AUTHOR_IDENT, or GIT_COMMITTER_IDENT if that is not
+	set, as returned by "git var -l".
 
 --in-reply-to=<identifier>::
 	Specify the contents of the first In-Reply-To header.
diff --git a/git-send-email.perl b/git-send-email.perl
index cccbf45..d9c7f32 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -210,6 +210,7 @@ my %config_settings = (
     "envelopesender" => \$envelope_sender,
     "multiedit" => \$multiedit,
     "confirm"   => \$confirm,
+    "from" => \$sender,
 );
 
 # Handle Uncouth Termination
-- 
1.5.4.1
