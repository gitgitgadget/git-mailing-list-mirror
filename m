From: Michael Witten <mfwitten@MIT.EDU>
Subject: [RFC2 9/9] send-email: signedoffcc -> signedoffbycc, but handle both
Date: Mon, 29 Sep 2008 12:41:06 -0500
Message-ID: <1222710066-57768-2-git-send-email-mfwitten@mit.edu>
References: <20080929162935.GA2628@coredump.intra.peff.net>
 <1222710066-57768-1-git-send-email-mfwitten@mit.edu>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 29 19:42:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkMlP-0000bk-1N
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 19:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbYI2RlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 13:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbYI2RlR
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 13:41:17 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:48360 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750855AbYI2RlQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Sep 2008 13:41:16 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8THfCGe023797;
	Mon, 29 Sep 2008 13:41:12 -0400 (EDT)
Received: from localhost.localdomain (97-116-104-112.mpls.qwest.net [97.116.104.112])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8THf69D009404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 29 Sep 2008 13:41:11 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2.304.gdcf23.dirty
In-Reply-To: <1222710066-57768-1-git-send-email-mfwitten@mit.edu>
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97036>

The documentation now mentions sendemail.signedoffbycc instead
of sendemail.signedoffcc in order to match with the options
--signed-off-by-cc; the code has been updated to reflect this
as well, but sendemail.signedoffcc is still handled.

Signed-off-by: Michael Witten <mfwitten@mit.edu>
---
 Documentation/git-send-email.txt |    2 +-
 git-send-email.perl              |    9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index d566c34..82f5056 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -144,7 +144,7 @@ Automating
 
 --[no-]signed-off-by-cc::
 	If this is set, add emails found in Signed-off-by: or Cc: lines to the
-	cc list. Default is the value of 'sendemail.signedoffcc' configuration
+	cc list. Default is the value of 'sendemail.signedoffbycc' configuration
 	value; if that is unspecified, default to --signed-off-by-cc.
 
 --suppress-cc::
diff --git a/git-send-email.perl b/git-send-email.perl
index 80dae88..bdbfac6 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -151,7 +151,7 @@ if ($@) {
 my ($quiet, $dry_run) = (0, 0);
 
 # Variables with corresponding config settings
-my ($thread, $chain_reply_to, $suppress_from, $signed_off_cc, $cc_cmd);
+my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc, $cc_cmd);
 my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_encryption);
 my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
 my ($validate);
@@ -161,7 +161,8 @@ my %config_bool_settings = (
     "thread" => [\$thread, 1],
     "chainreplyto" => [\$chain_reply_to, 1],
     "suppressfrom" => [\$suppress_from, undef],
-    "signedoffcc" => [\$signed_off_cc, undef],
+    "signedoffbycc" => [\$signed_off_by_cc, undef],
+    "signedoffcc" => [\$signed_off_by_cc, undef],      # Deprecated
     "validate" => [\$validate, 1],
 );
 
@@ -225,7 +226,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "cc-cmd=s" => \$cc_cmd,
 		    "suppress-from!" => \$suppress_from,
 		    "suppress-cc=s" => \@suppress_cc,
-		    "signed-off-cc|signed-off-by-cc!" => \$signed_off_cc,
+		    "signed-off-cc|signed-off-by-cc!" => \$signed_off_by_cc,
 		    "dry-run" => \$dry_run,
 		    "envelope-sender=s" => \$envelope_sender,
 		    "thread!" => \$thread,
@@ -301,7 +302,7 @@ if ($suppress_cc{'all'}) {
 
 # If explicit old-style ones are specified, they trump --suppress-cc.
 $suppress_cc{'self'} = $suppress_from if defined $suppress_from;
-$suppress_cc{'sob'} = !$signed_off_cc if defined $signed_off_cc;
+$suppress_cc{'sob'} = !$signed_off_by_cc if defined $signed_off_by_cc;
 
 # Debugging, print out the suppressions.
 if (0) {
-- 
1.6.0.2.304.gdcf23.dirty
