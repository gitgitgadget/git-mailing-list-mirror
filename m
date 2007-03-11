From: Avi Kivity <avi@qumranet.com>
Subject: [PATCH 2/2] git-send-email: configurable bcc and chain-reply-to
Date: Sun, 11 Mar 2007 19:19:44 +0200
Message-ID: <11736335842187-git-send-email-avi@qumranet.com>
References: <11736335842565-git-send-email-avi@qumranet.com>
Cc: Avi Kivity <avi@qumranet.com>
To: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 18:41:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQS2p-0000wJ-QQ
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 18:41:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933877AbXCKRlP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 13:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933885AbXCKRlP
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 13:41:15 -0400
Received: from il.qumranet.com ([82.166.9.18]:41887 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933880AbXCKRlM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 13:41:12 -0400
Received: by il.qumranet.com (Postfix, from userid 500)
	id B9182A00B9; Sun, 11 Mar 2007 19:19:44 +0200 (IST)
X-Mailer: git-send-email 1.5.0.2
In-Reply-To: <11736335842565-git-send-email-avi@qumranet.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41949>

Chain-reply-to is a personal perference, and is unlikely to change from
patchset to patchset.  Similarly, bcc is likely to have the same values
every invocation is one likes to bcc oneself.

So, allow both to be set via configuration variables.

Signed-off-by: Avi Kivity <avi@qumranet.com>
---
 Documentation/git-send-email.txt |   10 +++++++++-
 git-send-email.perl              |   10 ++++++++++
 2 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 367646e..9b3aabb 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -40,7 +40,8 @@ The --cc option must be repeated for each user you want on the cc list.
 	the first will be sent as replies to the first email sent.  When using
 	this, it is recommended that the first file given be an overview of the
 	entire patch series.
-	Default is --chain-reply-to
+	Default is the value of the 'sendemail.chainreplyto' configuration
+	value; if that is unspecified, default to --chain-reply-to.
 
 --compose::
 	Use $EDITOR to edit an introductory message for the
@@ -101,6 +102,13 @@ sendemail.aliasfiletype::
 	Format of the file(s) specified in sendemail.aliasesfile. Must be
 	one of 'mutt', 'mailrc', 'pine', or 'gnus'.
 
+sendemail.bcc::
+	Email address (or alias) to always bcc.
+
+sendemail.chainreplyto::
+	Boolean value specifying the default to the '--chain_reply_to'
+	parameter.
+
 sendemail.smtpserver::
 	Default smtp server to use.
 
diff --git a/git-send-email.perl b/git-send-email.perl
index a71a192..6989c02 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -149,6 +149,16 @@ if ($@) {
 	$term = new FakeTerm "$@: going non-interactive";
 }
 
+my $def_chain = $repo->config_boolean('sendemail.chainreplyto');
+if ($def_chain and $def_chain eq 'false') {
+    $chain_reply_to = 0;
+}
+
+@bcclist = $repo->config('sendemail.bcc');
+if (!@bcclist or !$bcclist[0]) {
+    @bcclist = ();
+}
+
 # Begin by accumulating all the variables (defined above), that we will end up
 # needing, first, from the command line:
 
-- 
1.5.0.2
