From: Michael Witten <mfwitten@MIT.EDU>
Subject: [PATCH 9/9] send-email: signedoffcc -> signedoffbycc, but handle both
Date: Tue, 30 Sep 2008 07:58:32 -0500
Message-ID: <1222779512-58936-9-git-send-email-mfwitten@mit.edu>
References: <20080929174445.GA6015@coredump.intra.peff.net>
 <1222779512-58936-1-git-send-email-mfwitten@mit.edu>
 <1222779512-58936-2-git-send-email-mfwitten@mit.edu>
 <1222779512-58936-3-git-send-email-mfwitten@mit.edu>
 <1222779512-58936-4-git-send-email-mfwitten@mit.edu>
 <1222779512-58936-5-git-send-email-mfwitten@mit.edu>
 <1222779512-58936-6-git-send-email-mfwitten@mit.edu>
 <1222779512-58936-7-git-send-email-mfwitten@mit.edu>
 <1222779512-58936-8-git-send-email-mfwitten@mit.edu>
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Sep 30 15:12:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkf1q-00011W-7r
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 15:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbYI3NLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 09:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752301AbYI3NLY
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 09:11:24 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:56097 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752446AbYI3NLX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Sep 2008 09:11:23 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8UCwku6010348;
	Tue, 30 Sep 2008 08:58:46 -0400 (EDT)
Received: from localhost.localdomain (97-116-104-2.mpls.qwest.net [97.116.104.2])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8UCwWOS010491
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 30 Sep 2008 08:58:45 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2.304.gdcf23.dirty
In-Reply-To: <1222779512-58936-8-git-send-email-mfwitten@mit.edu>
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97115>

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
